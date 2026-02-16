# Skill: Promotion Logic

## Scope
1. **Source:** `ghcr.io/infrashift/trusted-base-images/development/*`
2. **Destination:** `ghcr.io/infrashift/trusted-base-images/*`
3. **Trigger:** Successful merge to `main` AND presence of valid multi-sig attestations.

## Implementation Note
Never rebuild the image during promotion. Use `skopeo copy` or `buildah push` to move the existing, verified layers from the development namespace to the root namespace to maintain the chain of custody.