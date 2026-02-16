# Skill: Policy Compliance

## Context
The TBI project uses a deterministic OPA-based PDP in GitHub Actions. Claude cannot bypass this.

## Compliance Requirements
1. **Commit Signatures:** All commits suggested or made by Claude must be signed. If Claude is operating in an environment where it cannot sign (like a web IDE), it must notify the user to sign the commits manually before pushing.
2. **Secret Avoidance:** Claude must never include keys, tokens, or placeholders (like `REPLACE_ME`) that trigger Gitleaks.
3. **Vetting:** Before suggesting a PR, Claude should locally run `scripts/run-gatekeeper.sh` (if the environment permits) to ensure a successful CI pass.