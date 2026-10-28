---
id: "01a18347-95c4-71aa-8bea-0e1f12ed781e"
title: "Cleanup Development Images (cleanup-dev.yml)"
type: "pipeline"
tags:
  - "pipeline"
  - "registry"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:09-05:00"
description: "The workflow that deletes a pull request's images from the development namespace after a successful release."
resource: "https://github.com/infrashift/trusted-base-images/blob/main/.github/workflows/cleanup-dev.yml"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:09-05:00"
---

# Cleanup Development Images (cleanup-dev.yml)

## Trigger

- `workflow_run` after "Release Images" succeeds.
- Manual: `workflow_dispatch` with input `pr_number`.

## What it does

1. Finds the pull request number of the release.
2. Reads the image list from `versions.json`.
3. Deletes the `pr-<N>-<arch>` versions of each image from the development namespace.

## Related

- [Registry namespaces: development, trusted, quarantine](/architecture/registry-namespaces-development-trusted-quarantine--01a183479596.md)
- [Runbook: list or clean a GHCR namespace](/runbooks/runbook-list-or-clean-a-ghcr-namespace--01a183479702.md)
