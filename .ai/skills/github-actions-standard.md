# Skill: GitHub Actions Architecture

## Workflow Hierarchy
1. **PR Gate (`pr-gate.yml`):** Non-destructive. Focuses on OPA PDP results.
2. **CI Build (`ci-build.yml`):** Creates "Unsigned" candidate images in GHCR with a `:pr-<num>` tag.
3. **Release (`release.yml`):** Occurs on merge to main. Performs the "Dual-Trust" signing and promotes images to `:latest` or `:vX.Y`.

## Usage of Composite Actions
- All logic must be encapsulated in `.github/actions/`. 
- Workflows should be "thin" (orchestration only).
- Scripts in `scripts/` should be called by the Composite Actions.