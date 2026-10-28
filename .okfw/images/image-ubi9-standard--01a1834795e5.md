---
id: "01a18347-95e5-72e2-a590-a425cc3e943d"
title: "Image: ubi9-standard"
type: "image"
tags:
  - "ubi9"
  - "ubi9-standard"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:09-05:00"
description: "The ubi9-standard image: its upstream base, variant, Containerfile and registry path."
resource: "https://github.com/infrashift/trusted-base-images/blob/main/Containerfiles/ubi9-standard.Containerfile"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:09-05:00"
---

# Image: ubi9-standard

## Facts

| Field | Value |
|---|---|
| Upstream base | `registry.access.redhat.com/ubi9` |
| Variant | `standard` |
| Architectures | amd64, arm64 |
| Containerfile | `Containerfiles/ubi9-standard.Containerfile` |
| Pins | `versions.json` → `ubi9.standard` |
| Pull from | `ghcr.io/infrashift/trusted-base-images/trusted/ubi9-standard` |

## Notes

The full UBI 9 userspace with dnf. Use it when a build needs the package manager and common tools.

The Containerfile adds OCI and Infrashift labels, cleans the package cache, and sets `USER 1001`. See [Containerfile policy](/standards/containerfile-policy--01a18347960e.md).

## Related

- [versions.json pin model](/images/versions-json-pin-model--01a1834795df.md)
- Public page: <https://infrashift.github.io/trusted-base-images/images/ubi9-standard/>
- Inventory: <https://infrashift.github.io/trusted-base-images/inventory/ubi9-standard/>
