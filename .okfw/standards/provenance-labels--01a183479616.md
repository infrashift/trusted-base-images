---
id: "01a18347-9616-7881-a224-937619947b67"
title: "Provenance labels"
type: "standard"
tags:
  - "security"
  - "registry"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:10-05:00"
description: "The OCI and io.infrashift labels that every image must carry, so consumers can trace it to its upstream digest and commit."
resource: "https://infrashift.github.io/trusted-base-images/security/image-annotations/"
sources:
  - resource: "https://github.com/infrashift/trusted-base-images/blob/ea1e21e/.ai/skills/provenance-labels.md"
    title: "Rule card .ai/skills/provenance-labels.md (removed)"
  - resource: "https://github.com/infrashift/trusted-base-images/blob/ea1e21e/.ai/PRD.md"
    title: "Original PRD (.ai/PRD.md, removed)"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:10-05:00"
---

# Provenance labels

## Rules

Every image must carry these labels.

| Label | Value |
|---|---|
| `org.opencontainers.image.title` | Human name of the image |
| `org.opencontainers.image.vendor` | `Infrashift` |
| `org.opencontainers.image.version` | `IMAGE_VERSION` |
| `org.opencontainers.image.created` | `BUILD_DATE` |
| `org.opencontainers.image.revision` | `GIT_COMMIT` |
| `org.opencontainers.image.architecture` | `TARGETARCH` |
| `io.infrashift.image.upstream.base` | `UPSTREAM_BASE` |
| `io.infrashift.image.upstream.digest` | `UPSTREAM_DIGEST` |
| `io.infrashift.image.variant` | `standard`, `minimal`, `micro` or `init` |
| `io.infrashift.image.distro` | For example `fedora` |
| `io.infrashift.image.distro.version` | For example `43` |

## Why

A consumer reads the upstream digest and the commit from the image. The provenance attestation records the same facts under a signature.

## Note

The earlier rule card named `io.infrashift.image.upstream.source` and `scripts/hydrate-dashboard.ts`. Neither exists. The table above matches the Containerfiles.

## Related

- [Containerfile policy](/standards/containerfile-policy--01a18347960e.md)
- Public page: <https://infrashift.github.io/trusted-base-images/security/image-annotations/>
