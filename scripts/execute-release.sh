#!/bin/bash
# Description: Final Release Gatekeeper - Verifies the multi-sig chain of custody.
# Actor: Release-Actor
# Inputs: IMAGE_TAG, IMAGE_DIGEST

set -e

# Configuration
KEYS_DIR=".github/pdp/public-keys"
APPROVAL_FILE="approval.json"
MANIFEST_FILE="approval.json.sha256"

echo "🚀 Release Manager: Commencing final multi-party verification..."

# 1. Verify the Bot's Technical Audit (Data & Manifest)
echo "🔍 Verifying Bot Actor signatures..."
cosign verify-blob --key "${KEYS_DIR}/review.pub" \
    --signature "${APPROVAL_FILE}.sig" "$APPROVAL_FILE"

cosign verify-blob --key "${KEYS_DIR}/review.pub" \
    --signature "${MANIFEST_FILE}.sig1" "$MANIFEST_FILE"

# 2. Verify the Human's Sovereign Authorization
echo "👤 Verifying Human Reviewer (PEP) signature..."
cosign verify-blob --key "${KEYS_DIR}/human.pub" \
    --signature "${MANIFEST_FILE}.sig2" "$MANIFEST_FILE"

# 3. Final Integrity Anchor
echo "⚓ Validating manifest checksum..."
sha256sum --check "$MANIFEST_FILE"

# 4. Promote and Sign the OCI Image
# Now that the chain is verified, we apply the final "Trusted" signatures
echo "🖋️ Applying final OCI signatures and pushing to Registry..."

# Keyless OIDC Signature (For public Sigstore/Rekor transparency)
cosign sign --yes "${IMAGE_DIGEST}"

# Sovereign ED25519 Release Signature
cosign sign --key env://COSIGN_PRIVATE_KEY --tlog-upload=false "${IMAGE_DIGEST}"

# 5. Attach the verified Approval as a Referrer
cosign attest --type https://infrashift.io/attestations/release-approval/v1 \
    --predicate "$APPROVAL_FILE" "${IMAGE_DIGEST}"

echo "✅ Release Successful: ${IMAGE_TAG} is now cryptographically verified."