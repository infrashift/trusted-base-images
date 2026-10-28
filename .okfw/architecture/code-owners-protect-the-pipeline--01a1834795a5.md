---
id: "01a18347-95a5-7484-9a3e-5543b192d213"
title: "Code owners protect the pipeline"
type: "architecture"
tags:
  - "governance"
  - "security"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:09-05:00"
description: "Which teams must approve a change to policy, workflows and scripts, as CODEOWNERS sets it."
resource: "https://github.com/infrashift/trusted-base-images/blob/main/.github/CODEOWNERS"
sources:
  - resource: "https://github.com/infrashift/trusted-base-images/blob/ea1e21e/.ai/skills/security-architecture.md"
    title: "Rule card .ai/skills/security-architecture.md (removed)"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:09-05:00"
---

# Code owners protect the pipeline

## Owners

| Path | Owner |
|---|---|
| `*` | `@infrashift/platform-engineers` |
| `.github/pdp/` | `@infrashift/security-admins` |
| `.github/workflows/`, `.github/actions/` | `@infrashift/devops-leads` |
| `/scripts/` | `@infrashift/devops-leads` |

## Why

A change to policy or to the actor-to-environment mapping can weaken every gate. A code owner must approve it.

## Known gap

`CODEOWNERS` also names `.github/pdp/keys/`. That path does not exist. The `.github/pdp/` line covers the public keys. See [CODEOWNERS names a path that does not exist](/issues/codeowners-names-a-path-that-does-not-exist--01a1834796d2.md).

## Related

- [Policy decision point: CVE gate and repo gate](/architecture/policy-decision-point-cve-gate-and-repo-gate--01a18347959b.md)
- [GitHub Actions standard](/standards/github-actions-standard--01a18347961c.md)
