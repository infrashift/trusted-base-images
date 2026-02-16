---
title: Image Inventory
description: Live inventory of all published Trusted Base Images with tags, digests, and CVE status.
---

The inventory pages show the current state of each published image in the GHCR trusted registry. Data is automatically updated after each successful release.

## How Inventory Works

1. The [Release workflow](/trusted-base-oci-images/reference/architecture/) promotes images to the `trusted` or `quarantine` namespace
2. After a successful release, the `doc-release.yml` workflow queries GHCR for current tags and digests
3. CVE data is extracted from the build evidence artifacts
4. The inventory JSON is updated and committed, triggering a documentation redeploy

## Image Status

Each image in the inventory has one of two statuses:

- **Trusted** — The image passed all review checks (attestation signatures, upstream digest match, CVE policy) and was promoted to the `trusted` namespace
- **Quarantine** — The image failed one or more review checks and was placed in the `quarantine` namespace for investigation

## Inventory Pages

| Image | Status Page |
|-------|------------|
| UBI9 Standard | [Inventory](/trusted-base-oci-images/inventory/ubi9-standard/) |
| UBI9 Minimal | [Inventory](/trusted-base-oci-images/inventory/ubi9-minimal/) |
| UBI9 Micro | [Inventory](/trusted-base-oci-images/inventory/ubi9-micro/) |
| UBI9 Init | [Inventory](/trusted-base-oci-images/inventory/ubi9-init/) |
| UBI10 Minimal | [Inventory](/trusted-base-oci-images/inventory/ubi10-minimal/) |
