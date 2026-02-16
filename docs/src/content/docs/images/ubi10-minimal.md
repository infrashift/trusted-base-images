---
title: UBI10 Minimal
description: Early-access Red Hat UBI10 minimal image for amd64.
---

The UBI10 Minimal image is an early-access build of the Red Hat Universal Base Image for RHEL 10. It provides a minimal footprint with `microdnf` for package management.

:::caution
UBI10 Minimal is currently available for **amd64 only**. arm64 support will be added when Red Hat publishes upstream arm64 manifests.
:::

## Quick Pull

```bash
# Podman
podman pull ghcr.io/infrashift/trusted-base-images/trusted/ubi10-minimal:latest
podman pull ghcr.io/infrashift/trusted-base-images/trusted/ubi10-minimal@sha256:<digest>

# Docker
docker pull ghcr.io/infrashift/trusted-base-images/trusted/ubi10-minimal:latest
docker pull ghcr.io/infrashift/trusted-base-images/trusted/ubi10-minimal@sha256:<digest>
```

## Upstream Source

[registry.access.redhat.com/ubi10-minimal](https://catalog.redhat.com/software/containers/ubi10-minimal/) — Red Hat Universal Base Image 10 Minimal

## Details

| Property | Value |
|----------|-------|
| **Upstream Base** | `registry.access.redhat.com/ubi10-minimal` |
| **Architectures** | amd64 |
| **Package Manager** | `microdnf` |
| **Default User** | `1001` (non-root) |
| **Hardening** | Cache cleaned (`microdnf clean all`) |

## OCI Labels

| Label | Value |
|-------|-------|
| `org.opencontainers.image.title` | Trusted UBI10 Minimal |
| `org.opencontainers.image.vendor` | Infrashift |
| `io.infrashift.image.variant` | minimal |
| `io.openshift.tags` | ubi10,minimal,vetted |

## Use Cases

- Early adoption of RHEL 10 base images
- Testing application compatibility with UBI10
- amd64 workloads that want the latest RHEL base

## Containerfile

```dockerfile
ARG UPSTREAM_BASE
ARG UPSTREAM_DIGEST

FROM ${UPSTREAM_BASE}@${UPSTREAM_DIGEST}

LABEL org.opencontainers.image.title="Trusted UBI10 Minimal" \
      org.opencontainers.image.vendor="Infrashift" \
      io.infrashift.image.variant="minimal" \
      io.openshift.tags="ubi10,minimal,vetted"

# Security Hardening: Minimal uses microdnf
RUN microdnf clean all && rm -rf /var/cache/yum

USER 1001
```

## Inventory

See the [UBI10 Minimal inventory](/trusted-base-images/inventory/ubi10-minimal/) for current tags, digests, and CVE status.
