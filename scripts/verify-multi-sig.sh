#!/bin/bash
set -e

# Artifacts
DATA="approval.json"
CHECKSUM_FILE="approval.json.sha256"

echo "🏁 Starting Sovereign Multi-Sig Verification..."

# 1. Verify the Checksum File (The Gatekeeper)
# Proves that both the Bot and the Human agreed on this specific hash
cosign verify-blob --key .github/pdp/keys/review.pub \
    --signature $CHECKSUM_FILE.sig1 $CHECKSUM_FILE

cosign verify-blob --key .github/pdp/keys/human.pub \
    --signature $CHECKSUM_FILE.sig2 $CHECKSUM_FILE

echo "✅ Checksum file signatures verified."

# 2. Verify Data Integrity against the Signed Checksum
sha256sum --check $CHECKSUM_FILE

# 3. Final Content Verification
# Ensures the actual data was also signed by the Review Bot
cosign verify-blob --key .github/pdp/keys/review.pub \
    --signature $DATA.sig $DATA

echo "🛡️ ALL SIGNATURES VALID. Release Authorized."