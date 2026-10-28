---
id: "01a18347-9591-797f-91ef-ed1d26e989fe"
title: "GitHub Environments isolate the actor keys"
type: "architecture"
tags:
  - "signing"
  - "security"
  - "governance"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:09-05:00"
description: "How GitHub Environments keep each actor key in one job, and the rules a workflow change must obey to keep it so."
resource: "https://github.com/infrashift/trusted-base-images/blob/main/SETUP-ENVIRONMENTS.md"
sources:
  - resource: "https://github.com/infrashift/trusted-base-images/blob/ea1e21e/.ai/skills/environment-isolation.md"
    title: "Rule card .ai/skills/environment-isolation.md (removed)"
  - resource: "https://github.com/infrashift/trusted-base-images/blob/ea1e21e/.ai/skills/environment-security.md"
    title: "Rule card .ai/skills/environment-security.md (removed)"
  - resource: "https://github.com/infrashift/trusted-base-images/blob/ea1e21e/.ai/skills/security-architecture.md"
    title: "Rule card .ai/skills/security-architecture.md (removed)"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:09-05:00"
---

# GitHub Environments isolate the actor keys

## How it works

Each actor key is an environment secret named `COSIGN_PRIVATE_KEY`. GitHub gives the secret to a job only when the job states the matching `environment:`. So the Build Actor job cannot read the review or release key.

## Rules for a workflow change

1. A job that signs must state `environment:` with its actor's GitHub Environment.
2. A script must expect one actor key only, in `COSIGN_PRIVATE_KEY`.
3. Do not pass a private key between jobs. Pass the signature or attestation. The next job verifies it with the public key in `.github/pdp/public-keys/`.
4. Do not add an actor key as a repository secret.

## Protection rules

`SETUP-ENVIRONMENTS.md` describes the protection rules. It does not agree with the earlier rule cards about which environment has required reviewers. See [SETUP-ENVIRONMENTS.md does not match the real setup](/issues/setup-environments-md-does-not-match-the-real-setup--01a1834796da.md).

## Related

- [Signing chain and actor keys](/architecture/signing-chain-and-actor-keys--01a18347958c.md)
- [Secrets and keys never enter the repository](/standards/secrets-and-keys-never-enter-the-repository--01a183479629.md)
- [Runbook: set up GitHub Environments and actor keys](/runbooks/runbook-set-up-github-environments-and-actor-keys--01a18347970a.md)
