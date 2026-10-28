---
id: "01a18347-9702-7c03-82ba-bd74406fd88e"
title: "Runbook: list or clean a GHCR namespace"
type: "runbook"
tags:
  - "registry"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:10-05:00"
description: "How to list the images in a namespace and how to delete all packages of the development namespace with Ops.mk."
resource: "https://github.com/infrashift/trusted-base-images/blob/main/Ops.mk"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:10-05:00"
---

# Runbook: list or clean a GHCR namespace

## Goal

See what a namespace holds, and remove development images that cleanup missed.

## Prerequisites

- `gh` is logged in with `read:packages` and, to delete, `delete:packages`.
- `jq` is installed.

## Steps

1. List the images and tags in a namespace.

   ```sh
   make -f Ops.mk list-images target_namespace=development
   ```

2. To clean one pull request's images, run [Cleanup Development Images (cleanup-dev.yml)](/pipeline/cleanup-development-images-cleanup-dev-yml--01a1834795c4.md) by hand with its `pr_number`.

   ```sh
   gh workflow run cleanup-dev.yml -f pr_number=<N>
   ```

3. **Warning:** the next step deletes every package in the namespace. Do not use it on `trusted`.
4. To delete all development packages, run:

   ```sh
   make -f Ops.mk clean-ghcr-namespace target_namespace=development
   ```

## Verify

- `list-images` for the namespace shows the expected result.

## Related

- [Registry namespaces: development, trusted, quarantine](/architecture/registry-namespaces-development-trusted-quarantine--01a183479596.md)
