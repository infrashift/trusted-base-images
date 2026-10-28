---
id: "01a18347-95f0-7a25-809a-d6cc7674f4ac"
title: "Image: ubi9-micro"
type: "image"
tags:
  - "ubi9"
  - "ubi9-micro"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:10-05:00"
description: "The ubi9-micro image: its upstream base, variant, Containerfile and registry path."
resource: "https://github.com/infrashift/trusted-base-images/blob/main/Containerfiles/ubi9-micro.Containerfile"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:10-05:00"
---

# Image: ubi9-micro

## Facts

| Field | Value |
|---|---|
| Upstream base | `registry.access.redhat.com/ubi9-micro` |
| Variant | `micro` |
| Architectures | amd64, arm64 |
| Containerfile | `Containerfiles/ubi9-micro.Containerfile` |
| Pins | `versions.json` → `ubi9.micro` |
| Pull from | `ghcr.io/infrashift/trusted-base-images/trusted/ubi9-micro` |

## Notes

UBI 9 with no package manager. Use it as a final runtime layer.

The Containerfile adds OCI and Infrashift labels, cleans the package cache, and sets `USER 1001`. See [Containerfile policy](/standards/containerfile-policy--01a18347960e.md).

## Related

- [versions.json pin model](/images/versions-json-pin-model--01a1834795df.md)
- Public page: <https://infrashift.github.io/trusted-base-images/images/ubi9-micro/>
- Inventory: <https://infrashift.github.io/trusted-base-images/inventory/ubi9-micro/>
