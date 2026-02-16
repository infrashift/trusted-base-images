---
title: UBI9 Standard
description: General-purpose Red Hat UBI9 base image with full dnf package management.
---

The UBI9 Standard image is the full-featured Red Hat Universal Base Image for RHEL 9. It includes the `dnf` package manager, a complete set of base system libraries, and is suitable for most application workloads.

## Quick Pull

```bash
# Pull the latest trusted multi-arch image
docker pull ghcr.io/infrashift/trusted-base-images/trusted/ubi9-standard:latest

# Pull a specific architecture by digest (recommended for production)
docker pull ghcr.io/infrashift/trusted-base-images/trusted/ubi9-standard@sha256:<digest>
```

## Upstream Source

[registry.access.redhat.com/ubi9](https://catalog.redhat.com/software/containers/ubi9/6183ef5e1c1e4d4c8c66ba2e) — Red Hat Universal Base Image 9

## Details

| Property | Value |
|----------|-------|
| **Upstream Base** | `registry.access.redhat.com/ubi9` |
| **Architectures** | amd64, arm64 |
| **Package Manager** | `dnf` |
| **Default User** | `1001` (non-root) |
| **Hardening** | Cache cleaned (`dnf clean all`) |

## OCI Labels

| Label | Value |
|-------|-------|
| `org.opencontainers.image.title` | Trusted UBI9 Standard |
| `org.opencontainers.image.vendor` | Infrashift |
| `io.infrashift.image.variant` | standard |
| `io.openshift.tags` | ubi9,base,vetted |

## Use Cases

- Java / Node.js / Python applications that need runtime dependencies installed via `dnf`
- Applications requiring a full RHEL 9 userspace
- Base image for multi-stage builds where the final stage needs package management

## Containerfile

The image is built with a simple, auditable Containerfile:

```dockerfile
ARG UPSTREAM_BASE
ARG UPSTREAM_DIGEST

FROM ${UPSTREAM_BASE}@${UPSTREAM_DIGEST}

LABEL org.opencontainers.image.title="Trusted UBI9 Standard" \
      org.opencontainers.image.vendor="Infrashift" \
      io.infrashift.image.variant="standard" \
      io.openshift.tags="ubi9,base,vetted"

# Security Hardening
RUN dnf clean all && rm -rf /var/cache/dnf

USER 1001
```

## Inventory

See the [UBI9 Standard inventory](/trusted-base-oci-images/inventory/ubi9-standard/) for current tags, digests, and CVE status.
