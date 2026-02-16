# Skill: Open Source Security Standards

## Asset Distribution
1. **Public Keys:** Store in `.github/pdp/keys/`. These are NOT secrets and are required for downstream verification.
2. **Private Keys:** Store in GitHub Environment Secrets. NEVER commit these or suggest their inclusion in the repo.
3. **Policy Documentation:** Rego files must reference the public keys by their relative path in the repo to ensure portability for forks.

## Fork Compatibility
When modifying scripts, assume the public keys exist in the filesystem. If a script fails because a secret is missing (in a fork), provide a clear error message: "Environment Secret COSIGN_PRIVATE_KEY missing. Please see SETUP.md for fork instructions."