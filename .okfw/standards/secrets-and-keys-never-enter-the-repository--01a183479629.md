---
id: "01a18347-9629-7df2-9725-83d2808c1fdf"
title: "Secrets and keys never enter the repository"
type: "standard"
tags:
  - "security"
  - "signing"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:10-05:00"
description: "The rules for private keys, public keys and secret scanning, including what to tell a fork that has no keys."
resource: "https://github.com/infrashift/trusted-base-images/blob/main/.gitleaks.toml"
sources:
  - resource: "https://github.com/infrashift/trusted-base-images/blob/ea1e21e/.ai/skills/open-source-standards.md"
    title: "Rule card .ai/skills/open-source-standards.md (removed)"
  - resource: "https://github.com/infrashift/trusted-base-images/blob/ea1e21e/.ai/skills/security-architecture.md"
    title: "Rule card .ai/skills/security-architecture.md (removed)"
  - resource: "https://github.com/infrashift/trusted-base-images/blob/ea1e21e/.ai/skills/policy-compliance.md"
    title: "Rule card .ai/skills/policy-compliance.md (removed)"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:10-05:00"
---

# Secrets and keys never enter the repository

## Rules

1. Do not commit a private key, token or placeholder that looks like one. gitleaks finds it, and the repo gate denies the pull request.
2. Keep each actor key in its GitHub Environment only. See [GitHub Environments isolate the actor keys](/architecture/github-environments-isolate-the-actor-keys--01a183479591.md).
3. Commit the public keys in `.github/pdp/public-keys/`. They are not secret. Downstream users need them to verify.
4. In a script that needs an actor key, fail with a clear message when `COSIGN_PRIVATE_KEY` is missing. A fork has no keys.
5. Do not change `.gitleaks.toml` to an empty file or remove `useDefault = true`. The repo gate denies both.

## How it is enforced

- [PR Review Gate (pr-gate.yml)](/pipeline/pr-review-gate-pr-gate-yml--01a1834795af.md) runs gitleaks through the repo gate. See [Policy decision point: CVE gate and repo gate](/architecture/policy-decision-point-cve-gate-and-repo-gate--01a18347959b.md).
- Code owners review `.github/pdp/`. See [Code owners protect the pipeline](/architecture/code-owners-protect-the-pipeline--01a1834795a5.md).
