---
id: "01a18347-9606-7a09-8f56-9f3cdb3c9103"
title: "Image: fedora43-minimal"
type: "image"
tags:
  - "fedora43"
  - "fedora43-minimal"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:10-05:00"
description: "The fedora43-minimal image: its upstream base, variant, Containerfile and registry path."
resource: "https://github.com/infrashift/trusted-base-images/blob/main/Containerfiles/fedora43-minimal.Containerfile"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:10-05:00"
---

# Image: fedora43-minimal

## Facts

| Field | Value |
|---|---|
| Upstream base | `registry.fedoraproject.org/fedora-minimal` |
| Variant | `minimal` |
| Architectures | amd64, arm64 |
| Containerfile | `Containerfiles/fedora43-minimal.Containerfile` |
| Pins | `versions.json` → `fedora43.minimal` |
| Pull from | `ghcr.io/infrashift/trusted-base-images/trusted/fedora43-minimal` |

## Notes

Fedora 43 with microdnf. Most downstream devcontainer templates build from this image.

The Containerfile adds OCI and Infrashift labels, cleans the package cache, and sets `USER 1001`. See [Containerfile policy](/standards/containerfile-policy--01a18347960e.md).

## Related

- [versions.json pin model](/images/versions-json-pin-model--01a1834795df.md)
- Public page: <https://infrashift.github.io/trusted-base-images/images/fedora43-minimal/>
- Inventory: <https://infrashift.github.io/trusted-base-images/inventory/fedora43-minimal/>
