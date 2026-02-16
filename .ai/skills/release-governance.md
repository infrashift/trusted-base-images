# Skill: Release Governance

## Hard Constraints
1. **Immutable Transit:** Never rebuild. Use `skopeo` or `buildah push` from registry-to-registry to maintain the Layer Digests.
2. **Signature Stacking:** The final production image MUST have three layers of signatures: Build, Review (Bot), and Release (Human).
3. **Environment Lock:** The `Release-Actor` GHA environment must have "Required Reviewers" (You) enabled to prevent automated merges from reaching production.