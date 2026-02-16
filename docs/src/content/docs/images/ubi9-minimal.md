---
title: UBI9 Minimal
description: Smaller Red Hat UBI9 base image with microdnf for lightweight package management.
---

The UBI9 Minimal image provides a smaller footprint than the Standard variant while still offering `microdnf` for installing packages. It is suitable for applications that need a few runtime dependencies without the full `dnf` stack.

## Quick Pull

```bash
# Pull the latest trusted multi-arch image
docker pull ghcr.io/infrashift/trusted-base-images/trusted/ubi9-minimal:latest

# Pull a specific architecture by digest (recommended for production)
docker pull ghcr.io/infrashift/trusted-base-images/trusted/ubi9-minimal@sha256:<digest>
```

## Upstream Source

[registry.access.redhat.com/ubi9-minimal](https://catalog.redhat.com/software/containers/ubi9-minimal/61832888c0d15aff4912fe0d) — Red Hat Universal Base Image 9 Minimal

## Details

| Property | Value |
|----------|-------|
| **Upstream Base** | `registry.access.redhat.com/ubi9-minimal` |
| **Architectures** | amd64, arm64 |
| **Package Manager** | `microdnf` |
| **Default User** | `1001` (non-root) |
| **Hardening** | Cache cleaned (`microdnf clean all`) |

## OCI Labels

| Label | Value |
|-------|-------|
| `org.opencontainers.image.title` | Trusted UBI9 Minimal |
| `org.opencontainers.image.vendor` | Infrashift |
| `io.infrashift.image.variant` | minimal |
| `io.openshift.tags` | ubi9,minimal,vetted |

## Use Cases

- Applications that need a small number of runtime packages installed via `microdnf`
- Microservices requiring a smaller attack surface than the Standard image
- Base for multi-stage builds where the final stage needs light package management

## Containerfile

```dockerfile
ARG UPSTREAM_BASE
ARG UPSTREAM_DIGEST

FROM ${UPSTREAM_BASE}@${UPSTREAM_DIGEST}

LABEL org.opencontainers.image.title="Trusted UBI9 Minimal" \
      org.opencontainers.image.vendor="Infrashift" \
      io.infrashift.image.variant="minimal" \
      io.openshift.tags="ubi9,minimal,vetted"

# Security Hardening: Minimal uses microdnf
RUN microdnf clean all && rm -rf /var/cache/yum

USER 1001
```

## Inventory

See the [UBI9 Minimal inventory](/trusted-base-images/inventory/ubi9-minimal/) for current tags, digests, and CVE status.
