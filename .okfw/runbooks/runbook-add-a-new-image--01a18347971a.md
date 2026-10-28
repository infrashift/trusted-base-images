---
id: "01a18347-971a-7cd6-acdf-262605fd12ff"
title: "Runbook: add a new image"
type: "runbook"
tags:
  - "registry"
  - "pipeline"
  - "docs"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:10-05:00"
description: "The steps to add a new image: its versions.json entry, Containerfile and docs pages."
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:10-05:00"
---

# Runbook: add a new image

## Goal

Build, review and release a new image through the normal pipeline.

## Prerequisites

- The upstream base publishes amd64 and arm64.
- `skopeo` and `jq` are installed.

## Steps

1. Create a branch from `main`.
2. Read the upstream digest for each architecture. See step 2 of [Runbook: refresh a base to clear a CVE](/runbooks/runbook-refresh-a-base-to-clear-a-cve--01a1834796f2.md).
3. Add the entry to `versions.json` with `base`, `amd64`, `arm64`, `updated` and `reason`. See [versions.json pin model](/images/versions-json-pin-model--01a1834795df.md).
4. Copy a Containerfile of the same distro to `Containerfiles/<image>.Containerfile`.
5. Change the title and the variant and distro labels. Obey [Containerfile policy](/standards/containerfile-policy--01a18347960e.md).
6. Add an image page in `docs/src/content/docs/images/` and an inventory page in `docs/src/content/docs/inventory/`.
7. Add an image concept in the [images bundle](/images/index.md).
8. Open a pull request. Continue from step 3 of [Runbook: refresh a drifted upstream base](/runbooks/runbook-refresh-a-drifted-upstream-base--01a1834796ea.md).

## Verify

- The image is in the trusted namespace with a manifest list.
- Its inventory page shows data after [Runbook: open and merge the docs-inventory pull request](/runbooks/runbook-open-and-merge-the-docs-inventory-pull-request--01a1834796fa.md).

## Related

- [Plan: generate inventory pages from versions.json](/plans/plan-generate-inventory-pages-from-versions-json--01a183479681.md)
- [Plan: add more UBI 10 variants](/plans/plan-add-more-ubi-10-variants--01a183479688.md)
