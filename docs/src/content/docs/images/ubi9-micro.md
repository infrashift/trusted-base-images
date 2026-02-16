---
title: UBI9 Micro
description: Smallest Red Hat UBI9 base image — no shell, no package manager.
---

The UBI9 Micro image is the smallest UBI variant. It has no shell, no package manager, and is designed to have pre-compiled binaries copied into it. This makes it ideal for statically linked Go, Rust, or C applications.

## Quick Pull

```bash
# Podman
podman pull ghcr.io/infrashift/trusted-base-images/trusted/ubi9-micro:latest
podman pull ghcr.io/infrashift/trusted-base-images/trusted/ubi9-micro@sha256:<digest>

# Docker
docker pull ghcr.io/infrashift/trusted-base-images/trusted/ubi9-micro:latest
docker pull ghcr.io/infrashift/trusted-base-images/trusted/ubi9-micro@sha256:<digest>
```

## Upstream Source

[registry.access.redhat.com/ubi9-micro](https://catalog.redhat.com/software/containers/ubi9-micro/6183fde81c1e4d4c8c66ba00) — Red Hat Universal Base Image 9 Micro

## Details

| Property | Value |
|----------|-------|
| **Upstream Base** | `registry.access.redhat.com/ubi9-micro` |
| **Architectures** | amd64, arm64 |
| **Package Manager** | None |
| **Default User** | `1001` (non-root) |
| **Hardening** | No RUN commands (no shell available) |

## OCI Labels

| Label | Value |
|-------|-------|
| `org.opencontainers.image.title` | Trusted UBI9 Micro |
| `org.opencontainers.image.vendor` | Infrashift |
| `io.infrashift.image.variant` | micro |
| `io.openshift.tags` | ubi9,micro,vetted |

## Use Cases

- Statically compiled Go binaries
- Rust applications compiled with `musl` target
- Any compiled binary with no runtime dependencies
- Minimal attack surface for security-sensitive deployments

## Multi-Stage Build Example

```dockerfile
# Build stage
FROM golang:1.22 AS builder
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 go build -o /app/server

# Runtime stage
FROM ghcr.io/infrashift/trusted-base-images/trusted/ubi9-micro:latest
COPY --from=builder /app/server /usr/local/bin/server
USER 1001
ENTRYPOINT ["/usr/local/bin/server"]
```

## Containerfile

```dockerfile
ARG UPSTREAM_BASE
ARG UPSTREAM_DIGEST

FROM ${UPSTREAM_BASE}@${UPSTREAM_DIGEST}

LABEL org.opencontainers.image.title="Trusted UBI9 Micro" \
      org.opencontainers.image.vendor="Infrashift" \
      io.infrashift.image.variant="micro" \
      io.openshift.tags="ubi9,micro,vetted"

# No RUN commands here as Micro has no shell/dnf by default.
# It is designed to have binaries copied into it.

USER 1001
```

## Inventory

See the [UBI9 Micro inventory](/trusted-base-images/inventory/ubi9-micro/) for current tags, digests, and CVE status.
