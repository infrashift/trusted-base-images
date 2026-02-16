---
title: Image Catalog
description: Overview of all Trusted Base Images built from Red Hat Universal Base Images.
---

Trusted Base Images provides hardened, SLSA Level 3 compliant variants of Red Hat Universal Base Images (UBI). Each image is built from digest-pinned upstream sources, scanned for vulnerabilities, and cryptographically signed through a three-actor governance chain.

## Available Images

### UBI9 (Red Hat Enterprise Linux 9)

| Image | Variant | Upstream Source | Architectures | Use Case |
|-------|---------|----------------|:-------------:|----------|
| [UBI9 Standard](/trusted-base-oci-images/images/ubi9-standard/) | `standard` | [ubi9](https://catalog.redhat.com/software/containers/ubi9/6183ef5e1c1e4d4c8c66ba2e) | amd64, arm64 | General-purpose applications with full dnf package manager |
| [UBI9 Minimal](/trusted-base-oci-images/images/ubi9-minimal/) | `minimal` | [ubi9-minimal](https://catalog.redhat.com/software/containers/ubi9-minimal/61832888c0d15aff4912fe0d) | amd64, arm64 | Smaller footprint with microdnf for minimal package management |
| [UBI9 Micro](/trusted-base-oci-images/images/ubi9-micro/) | `micro` | [ubi9-micro](https://catalog.redhat.com/software/containers/ubi9-micro/6183fde81c1e4d4c8c66ba00) | amd64, arm64 | Smallest footprint, no package manager — copy binaries in |
| [UBI9 Init](/trusted-base-oci-images/images/ubi9-init/) | `init` | [ubi9-init](https://catalog.redhat.com/software/containers/ubi9-init/6183297e1c1e4d4c8c66ba04) | amd64, arm64 | Systemd-enabled for multi-service containers |

### UBI10 (Red Hat Enterprise Linux 10)

| Image | Variant | Upstream Source | Architectures | Use Case |
|-------|---------|----------------|:-------------:|----------|
| [UBI10 Minimal](/trusted-base-oci-images/images/ubi10-minimal/) | `minimal` | [ubi10-minimal](https://catalog.redhat.com/software/containers/ubi10-minimal/) | amd64 | Early-access UBI10 minimal image |

:::caution
UBI10 images are currently available for amd64 only. arm64 support will be added when upstream provides it.
:::

## Registry

All images are published to the GitHub Container Registry (GHCR):

```
ghcr.io/infrashift/trusted-base-images/trusted/<image-name>
```

## Choosing a Variant

- **Standard**: Start here if you need to install packages with `dnf`. Full RHEL 9 userspace.
- **Minimal**: Use when you need a smaller image but still want `microdnf` for installing a few packages.
- **Micro**: Use for compiled binaries (Go, Rust) that have no runtime dependencies. No shell, no package manager.
- **Init**: Use when your container needs to run systemd services or multiple processes.
