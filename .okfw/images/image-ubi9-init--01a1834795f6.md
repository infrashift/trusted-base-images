---
id: "01a18347-95f6-7805-8dbd-6e0e22ba6389"
title: "Image: ubi9-init"
type: "image"
tags:
  - "ubi9"
  - "ubi9-init"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:10-05:00"
description: "The ubi9-init image: its upstream base, variant, Containerfile and registry path."
resource: "https://github.com/infrashift/trusted-base-images/blob/main/Containerfiles/ubi9-init.Containerfile"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:10-05:00"
---

# Image: ubi9-init

## Facts

| Field | Value |
|---|---|
| Upstream base | `registry.access.redhat.com/ubi9-init` |
| Variant | `init` |
| Architectures | amd64, arm64 |
| Containerfile | `Containerfiles/ubi9-init.Containerfile` |
| Pins | `versions.json` → `ubi9.init` |
| Pull from | `ghcr.io/infrashift/trusted-base-images/trusted/ubi9-init` |

## Notes

UBI 9 with systemd as PID 1, for images that run services.

The Containerfile adds OCI and Infrashift labels, cleans the package cache, and sets `USER 1001`. See [Containerfile policy](/standards/containerfile-policy--01a18347960e.md).

## Related

- [versions.json pin model](/images/versions-json-pin-model--01a1834795df.md)
- Public page: <https://infrashift.github.io/trusted-base-images/images/ubi9-init/>
- Inventory: <https://infrashift.github.io/trusted-base-images/inventory/ubi9-init/>
