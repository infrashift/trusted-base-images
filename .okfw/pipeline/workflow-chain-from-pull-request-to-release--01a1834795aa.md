---
id: "01a18347-95aa-73a3-9eea-68abf2eb9c09"
title: "Workflow chain from pull request to release"
type: "pipeline"
tags:
  - "pipeline"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:09-05:00"
description: "The order in which the eight workflows run, from a pull request to a trusted image and published docs."
resource: "https://github.com/infrashift/trusted-base-images/blob/main/.github/workflows/"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:09-05:00"
---

# Workflow chain from pull request to release

## Chain

```
pull request ──► pr-gate.yml  (every PR: repo gate, seeds review/cve-policy)
      │
      └─► build.yml  (image paths changed) ──workflow_run──► review.yml
                                                              │
merge ──► release.yml ──workflow_run──► cleanup-dev.yml        │ sets review/cve-policy
                    └──workflow_run──► doc-release.yml ──► branch automation/docs-inventory
                                                              (a person opens the PR)
push to main under docs/** ──► deploy-docs.yml

daily 07:23 UTC ──► upstream-drift.yml ──► branch automation/upstream-refresh + tracking issue
```

## Workflows

| Workflow | Concept |
|---|---|
| `pr-gate.yml` | [PR Review Gate (pr-gate.yml)](/pipeline/pr-review-gate-pr-gate-yml--01a1834795af.md) |
| `build.yml` | [CI Build & Audit (build.yml): the Build Actor](/pipeline/ci-build-audit-build-yml-the-build-actor--01a1834795b4.md) |
| `review.yml` | [Review Attestations (review.yml): the Review Actor](/pipeline/review-attestations-review-yml-the-review-actor--01a1834795b9.md) |
| `release.yml` | [Release Images (release.yml): the Release Actor](/pipeline/release-images-release-yml-the-release-actor--01a1834795be.md) |
| `cleanup-dev.yml` | [Cleanup Development Images (cleanup-dev.yml)](/pipeline/cleanup-development-images-cleanup-dev-yml--01a1834795c4.md) |
| `doc-release.yml` | [Update Documentation Inventory (doc-release.yml)](/pipeline/update-documentation-inventory-doc-release-yml--01a1834795c9.md) |
| `deploy-docs.yml` | [Deploy Documentation (deploy-docs.yml)](/pipeline/deploy-documentation-deploy-docs-yml--01a1834795cf.md) |
| `upstream-drift.yml` | [Upstream Drift Check (upstream-drift.yml)](/pipeline/upstream-drift-check-upstream-drift-yml--01a1834795d4.md) |

Tools come from [Pinned tools: tools.lock and install-tools.sh](/pipeline/pinned-tools-tools-lock-and-install-tools-sh--01a1834795da.md). Four scripts in `scripts/` are not used by any workflow. See [Four scripts are not used by any workflow](/issues/four-scripts-are-not-used-by-any-workflow--01a1834796c3.md).

## Common rules

Every workflow starts with `permissions: {}`. Each job states its own scopes. See [GitHub Actions standard](/standards/github-actions-standard--01a18347961c.md).
