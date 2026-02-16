---
title: UBI9 Init
description: Red Hat UBI9 init image with systemd support for multi-service containers.
---

The UBI9 Init image is based on the Red Hat UBI9 Init variant with systemd support. It is designed for containers that need to run multiple services managed by systemd or require init system functionality.

## Quick Pull

```bash
# Pull the latest trusted multi-arch image
docker pull ghcr.io/infrashift/trusted-base-images/trusted/ubi9-init:latest

# Pull a specific architecture by digest (recommended for production)
docker pull ghcr.io/infrashift/trusted-base-images/trusted/ubi9-init@sha256:<digest>
```

## Upstream Source

[registry.access.redhat.com/ubi9-init](https://catalog.redhat.com/software/containers/ubi9-init/6183297e1c1e4d4c8c66ba04) — Red Hat Universal Base Image 9 Init

## Details

| Property | Value |
|----------|-------|
| **Upstream Base** | `registry.access.redhat.com/ubi9-init` |
| **Architectures** | amd64, arm64 |
| **Package Manager** | `dnf` |
| **Default User** | `1001` (non-root) |
| **Hardening** | Cache cleaned (`dnf clean all`) |

:::note
Init images often require root to start systemd. The default user is set to `1001` to maintain the security baseline for non-systemd use cases. Override with `USER root` in your Containerfile if systemd is required.
:::

## OCI Labels

| Label | Value |
|-------|-------|
| `org.opencontainers.image.title` | Trusted UBI9 Init |
| `org.opencontainers.image.vendor` | Infrashift |
| `io.infrashift.image.variant` | init |
| `io.openshift.tags` | ubi9,init,vetted |

## Use Cases

- Containers running multiple services managed by systemd
- Legacy applications that require an init system
- Containers that need cron, logging daemons, or other system services

## Containerfile

```dockerfile
ARG UPSTREAM_BASE
ARG UPSTREAM_DIGEST

FROM ${UPSTREAM_BASE}@${UPSTREAM_DIGEST}

LABEL org.opencontainers.image.title="Trusted UBI9 Init" \
      org.opencontainers.image.vendor="Infrashift" \
      io.infrashift.image.variant="init" \
      io.openshift.tags="ubi9,init,vetted"

# Security Hardening
RUN dnf clean all && rm -rf /var/cache/dnf

USER 1001
```

## Inventory

See the [UBI9 Init inventory](/trusted-base-images/inventory/ubi9-init/) for current tags, digests, and CVE status.
