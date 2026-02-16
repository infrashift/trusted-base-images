# Skill: TBI Security Architecture

## Secret Management
1. **No Hardcoding:** Private keys are NEVER stored in the repo.
2. **Environment Bound:** Secrets are stored as `COSIGN_PRIVATE_KEY` within GitHub Environments (`Build-Actor`, `Review-Actor`, `Release-Actor`).
3. **Identity Verification:** Workflows must use the `environment:` key to access these secrets.

## Ownership Enforcement
- **@infrashift:** The primary organization prefix for all teams.
- **Approvals:** Any change to `.github/` or `/scripts/` requires a pull request and approval from the designated `@infrashift` code owners.