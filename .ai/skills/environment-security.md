# Skill: Environment Secret Isolation

## Boundaries
1. **Never Mix Keys:** Scripts must only expect ONE actor key at a time via `env: COSIGN_PRIVATE_KEY`.
2. **Environment Targeting:** Workflows must use the `environment:` keyword to request specific actor identities.
3. **No Cross-Pollination:** If a script needs to verify a previous stage, it must fetch the PUBLIC key from `.github/pdp/keys/`, never the PRIVATE key of the previous actor.

## Verification Logic
Before signing, the actor should verify its own context:
- Build Actor must see `GITHUB_WORKFLOW == "CI Build"`.
- Review Actor must see `GITHUB_EVENT_NAME == "pull_request_review"`.