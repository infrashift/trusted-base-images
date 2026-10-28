---
id: "01a18347-95c9-77b7-9071-72918ac55c6f"
title: "Update Documentation Inventory (doc-release.yml)"
type: "pipeline"
tags:
  - "pipeline"
  - "docs"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:09-05:00"
description: "The workflow that writes the image inventory after a release and pushes it to a branch that a person must open as a PR."
resource: "https://github.com/infrashift/trusted-base-images/blob/main/.github/workflows/doc-release.yml"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:09-05:00"
---

# Update Documentation Inventory (doc-release.yml)

## Trigger

- `workflow_run` after "Release Images" succeeds.
- Manual: `workflow_dispatch` with input `release_run_id`.

## What it does

1. Downloads the release results and the evidence bundles of the build.
2. Writes `docs/src/data/inventory.json`. It keeps the entries of images that the release did not change.
3. If the file changed, it force-pushes branch `automation/docs-inventory`.
4. It writes a link to open the pull request in the job summary.

## Limit

It cannot open the pull request. See [Decision: automation pushes a branch; a person opens the pull request](/decisions/decision-automation-pushes-a-branch-a-person-opens-the-pull-request--01a183479657.md). A person must open and merge it. See [Runbook: open and merge the docs-inventory pull request](/runbooks/runbook-open-and-merge-the-docs-inventory-pull-request--01a1834796fa.md).

## Related

- [Deploy Documentation (deploy-docs.yml)](/pipeline/deploy-documentation-deploy-docs-yml--01a1834795cf.md)
- [Plan: generate inventory pages from versions.json](/plans/plan-generate-inventory-pages-from-versions-json--01a183479681.md)
