---
title: Fedora 43 Minimal
description: Fedora 43 minimal base image for amd64.
---

The Fedora 43 Minimal image is a hardened build of the Fedora Minimal base image from the Fedora Container Registry. It provides a minimal footprint with `microdnf` for package management.

:::caution
Fedora 43 Minimal is currently available for **amd64 only**.
:::

## Quick Pull

```bash
# Podman
podman pull ghcr.io/infrashift/trusted-base-images/trusted/fedora43-minimal:latest
podman pull ghcr.io/infrashift/trusted-base-images/trusted/fedora43-minimal@sha256:<digest>

# Docker
docker pull ghcr.io/infrashift/trusted-base-images/trusted/fedora43-minimal:latest
docker pull ghcr.io/infrashift/trusted-base-images/trusted/fedora43-minimal@sha256:<digest>
```

## Upstream Source

[registry.fedoraproject.org/fedora-minimal](https://fedoraproject.org/containers/) — Fedora Minimal Container Image

## Details

| Property | Value |
|----------|-------|
| **Upstream Base** | `registry.fedoraproject.org/fedora-minimal` |
| **Architectures** | amd64 |
| **Package Manager** | `microdnf` |
| **Default User** | `1001` (non-root) |
| **Hardening** | Cache cleaned (`microdnf clean all`) |

## OCI Labels

| Label | Value |
|-------|-------|
| `org.opencontainers.image.title` | Trusted Fedora 43 Minimal |
| `org.opencontainers.image.vendor` | Infrashift |
| `io.infrashift.image.variant` | minimal |
| `io.infrashift.image.distro` | fedora |
| `io.infrashift.image.distro.version` | 43 |

## Use Cases

- Fedora-based workloads that need a minimal, hardened base
- Applications that depend on Fedora-specific packages
- amd64 workloads that prefer Fedora over RHEL UBI

## Containerfile

```dockerfile
ARG UPSTREAM_BASE
ARG UPSTREAM_DIGEST

FROM ${UPSTREAM_BASE}@${UPSTREAM_DIGEST}

LABEL org.opencontainers.image.title="Trusted Fedora 43 Minimal" \
      org.opencontainers.image.vendor="Infrashift" \
      io.infrashift.image.variant="minimal" \
      io.infrashift.image.distro="fedora" \
      io.infrashift.image.distro.version="43"

# Security Hardening: Fedora Minimal uses microdnf
RUN microdnf clean all && rm -rf /var/cache/dnf /var/cache/yum

USER 1001
```

## Inventory

See the [Fedora 43 Minimal inventory](/trusted-base-images/inventory/fedora43-minimal/) for current tags, digests, and CVE status.
