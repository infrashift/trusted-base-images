---
id: "01a18347-96ea-7625-a2aa-a4fc44ddd6cc"
title: "Runbook: refresh a drifted upstream base"
type: "runbook"
tags:
  - "registry"
  - "pipeline"
  - "cve"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:10-05:00"
description: "The steps to take the daily drift check's refresh branch through build, review, release and docs."
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:10-05:00"
---

# Runbook: refresh a drifted upstream base

## Goal

Release images built from the digests that upstream serves now.

## Prerequisites

- `gh` is logged in with rights to open and merge pull requests.
- The GitHub issue "Upstream base image drift" is open.

## Steps

1. Read the drift issue. Note which images drifted and which findings a refresh clears.
2. Open a pull request from `automation/upstream-refresh` to `main`.

   ```sh
   gh pr create --head automation/upstream-refresh --base main --fill
   ```

3. Wait for [CI Build & Audit (build.yml): the Build Actor](/pipeline/ci-build-audit-build-yml-the-build-actor--01a1834795b4.md) and [Review Attestations (review.yml): the Review Actor](/pipeline/review-attestations-review-yml-the-review-actor--01a1834795b9.md) to complete.
4. Read the review summary comment. Each triple must have verdict PASS.
5. If a GitHub Environment asks for approval, approve it.
6. Merge the pull request.
7. Wait for [Release Images (release.yml): the Release Actor](/pipeline/release-images-release-yml-the-release-actor--01a1834795be.md) to complete. Check that each image went to the trusted namespace.
8. Do [Runbook: open and merge the docs-inventory pull request](/runbooks/runbook-open-and-merge-the-docs-inventory-pull-request--01a1834796fa.md).

## Verify

- The next drift check closes the drift issue, or reports only images with no fix.
- `make -f Ops.mk list-images target_namespace=trusted` shows the new `<sha7>` tags.

## Related

- [Upstream Drift Check (upstream-drift.yml)](/pipeline/upstream-drift-check-upstream-drift-yml--01a1834795d4.md)
- [versions.json pin model](/images/versions-json-pin-model--01a1834795df.md)
- [Decision: pin one upstream digest per architecture](/decisions/decision-pin-one-upstream-digest-per-architecture--01a183479644.md)
