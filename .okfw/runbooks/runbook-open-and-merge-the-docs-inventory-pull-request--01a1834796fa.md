---
id: "01a18347-96fa-7b83-b468-b97e9550a709"
title: "Runbook: open and merge the docs-inventory pull request"
type: "runbook"
tags:
  - "docs"
  - "pipeline"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:10-05:00"
description: "The steps to publish the image inventory after each release, because the workflow cannot open the pull request itself."
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:10-05:00"
---

# Runbook: open and merge the docs-inventory pull request

## Goal

Publish the inventory that [Update Documentation Inventory (doc-release.yml)](/pipeline/update-documentation-inventory-doc-release-yml--01a1834795c9.md) wrote after a release.

## Prerequisites

- A "Release Images" run has succeeded.
- "Update Documentation Inventory" has run after it.

## Steps

1. Check for an open pull request from the branch.

   ```sh
   gh pr list --head automation/docs-inventory --state open
   ```

2. If there is none, open one.

   ```sh
   gh pr create --head automation/docs-inventory --base main --fill
   ```

3. Wait for [PR Review Gate (pr-gate.yml)](/pipeline/pr-review-gate-pr-gate-yml--01a1834795af.md). It sets `review/cve-policy` to success for a docs-only pull request.
4. Merge the pull request.

## Verify

- [Deploy Documentation (deploy-docs.yml)](/pipeline/deploy-documentation-deploy-docs-yml--01a1834795cf.md) runs and succeeds.
- The inventory page of each released image shows the new digest.

## Related

- [Decision: automation pushes a branch; a person opens the pull request](/decisions/decision-automation-pushes-a-branch-a-person-opens-the-pull-request--01a183479657.md)
- [Runbook: refresh a drifted upstream base](/runbooks/runbook-refresh-a-drifted-upstream-base--01a1834796ea.md)
