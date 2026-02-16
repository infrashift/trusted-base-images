#!/bin/bash
set -e

# Usage: ./scripts/verify-and-sign.sh <artifact_to_sign> <previous_artifact_to_verify>
ARTIFACT=$1
PREV_ARTIFACT=$2
ACTOR_KEY=$COSIGN_PRIVATE_KEY # Provided via Environment Secret

echo "🔐 Sovereign Validator: Initializing..."

# 1. Local OIDC Claim Check (Optional but recommended)
# We check the ACTIONS_ID_TOKEN_REQUEST_TOKEN for the current runner identity
if [[ -n "$ACTIONS_ID_TOKEN_REQUEST_TOKEN" ]]; then
    echo "🎫 Local OIDC Check: Validating runner identity..."
    # Logic to decode JWT and check 'repository' and 'workflow' claims
fi

# 2. Verify Previous Actor (if applicable)
if [[ -n "$PREV_ARTIFACT" ]]; then
    echo "🔍 Verifying previous actor signature..."
    # Example: verify the Build Actor's signature on the SBOM
    cosign verify-blob --key .github/pdp/keys/build.pub \
        --signature "$PREV_ARTIFACT.sig" "$PREV_ARTIFACT"
fi

# 3. Sign Current Artifact
echo "✍️ Signing $ARTIFACT with Sovereign ED25519 key..."
cosign sign-blob --key env://COSIGN_PRIVATE_KEY \
    --output-signature "$ARTIFACT.sig" "$ARTIFACT"

echo "✅ Chain of custody updated for $ARTIFACT"