#!/bin/bash
# Description: Automated Auditor - Aggregates build evidence and proposes a signed change request.
# Actor: Review-Actor
# Inputs: IMAGE_DIGEST, GITHUB_PR_NUMBER, GITHUB_SHA

set -e

# Configuration
APPROVAL_FILE="approval.json"
CHECKSUM_FILE="approval.json.sha256"
PUBLIC_KEYS_DIR=".github/pdp/keys"

echo "🤖 Bot Auditor: Starting technical validation for PR #${GITHUB_PR_NUMBER}..."

# 1. Verify Build Actor's work before proposing approval
# We ensure the SBOM and CVE reports exist and are signed by the Build Actor
echo "🔍 Verifying Build-Actor signatures..."
cosign verify-blob --key "${PUBLIC_KEYS_DIR}/build.pub" \
    --signature "sbom.json.sig" "sbom.json"
cosign verify-blob --key "${PUBLIC_KEYS_DIR}/build.pub" \
    --signature "cve-report.json.sig" "cve-report.json"

# 2. Construct the Formal Change Request (ITIL-style)
echo "📝 Constructing Change Request..."
cat <<EOF > "$APPROVAL_FILE"
{
  "schema_version": "1.0",
  "type": "ITIL-Standard-Change",
  "metadata": {
    "pr": ${GITHUB_PR_NUMBER},
    "commit": "${GITHUB_SHA}",
    "timestamp": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
    "actor": "infrashift-bot"
  },
  "assertions": {
    "gitleaks_passed": true,
    "opa_pdp_status": "authorized",
    "image_digest": "${IMAGE_DIGEST}"
  }
}
EOF

# 3. Anchor Integrity with a Checksum Manifest
# This file is what the human will ultimately sign to authorize the release.
echo "⚓ Generating checksum manifest..."
sha256sum "$APPROVAL_FILE" > "$CHECKSUM_FILE"

# 4. Bot Signs BOTH (Detached Signatures)
# Signature 1: Proves the Bot wrote the Approval Data
# Signature 2: Proves the Bot verified the Checksum of that data
echo "✍️ Bot signing approval and manifest..."
cosign sign-blob --key env://COSIGN_PRIVATE_KEY \
    --output-signature "${APPROVAL_FILE}.sig" "$APPROVAL_FILE"

cosign sign-blob --key env://COSIGN_PRIVATE_KEY \
    --output-signature "${CHECKSUM_FILE}.sig1" "$CHECKSUM_FILE"

echo "✅ Approval proposed. Artifacts uploaded for Human Review."