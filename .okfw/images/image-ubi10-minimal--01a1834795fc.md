---
id: "01a18347-95fc-7689-b9c0-20c7facc992c"
title: "Image: ubi10-minimal"
type: "image"
tags:
  - "ubi10"
  - "ubi10-minimal"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:10-05:00"
description: "The ubi10-minimal image: its upstream base, variant, Containerfile and registry path."
resource: "https://github.com/infrashift/trusted-base-images/blob/main/Containerfiles/ubi10-minimal.Containerfile"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:10-05:00"
---

# Image: ubi10-minimal

## Facts

| Field | Value |
|---|---|
| Upstream base | `registry.access.redhat.com/ubi10-minimal` |
| Variant | `minimal` |
| Architectures | amd64, arm64 |
| Containerfile | `Containerfiles/ubi10-minimal.Containerfile` |
| Pins | `versions.json` → `ubi10.minimal` |
| Pull from | `ghcr.io/infrashift/trusted-base-images/trusted/ubi10-minimal` |

## Notes

UBI 10 with microdnf and a small package set.

The Containerfile adds OCI and Infrashift labels, cleans the package cache, and sets `USER 1001`. See [Containerfile policy](/standards/containerfile-policy--01a18347960e.md).

## Related

- [versions.json pin model](/images/versions-json-pin-model--01a1834795df.md)
- Public page: <https://infrashift.github.io/trusted-base-images/images/ubi10-minimal/>
- Inventory: <https://infrashift.github.io/trusted-base-images/inventory/ubi10-minimal/>
