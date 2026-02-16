# Skill: Environment & Secret Isolation

## Context
TBI uses GitHub Environments to isolate actor identities. 

## Logic
1. **Targeting:** When Claude suggests a workflow change, it MUST use the `environment:` key to specify which actor identity is required for the job.
2. **Key Access:** Secrets like `COSIGN_PRIVATE_KEY` are only injected by GitHub when the environment name matches.
3. **Validation:** Claude should never attempt to "pass" a private key between jobs. Instead, pass the digital signature (`.sig`) as a build artifact and verify it in the next job using the public key in `.github/pdp/keys/`.