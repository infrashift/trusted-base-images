---
title: Image Annotations
description: OCI standard labels and custom Infrashift labels applied to every Trusted Base Image.
---

Every Trusted Base Image includes a comprehensive set of OCI standard labels and custom Infrashift labels. These annotations enable automated tooling discovery, provenance tracing, and integration with container registries and scanners.

## OCI Standard Labels

These follow the [OCI Image Spec annotations](https://github.com/opencontainers/image-spec/blob/main/annotations.md):

| Label | Example | Purpose |
|-------|---------|---------|
| `org.opencontainers.image.title` | `Trusted UBI9 Standard` | Human-readable image name |
| `org.opencontainers.image.maintainer` | `Ryan Craig <ryan.craig@infrashift.io>` | Image maintainer contact |
| `org.opencontainers.image.vendor` | `Infrashift` | Organization that produces the image |
| `org.opencontainers.image.version` | `main` | Image version (branch or tag) |
| `org.opencontainers.image.created` | `2026-02-16T12:00:00Z` | Build timestamp (ISO 8601) |
| `org.opencontainers.image.revision` | `0237427abc...` | Git commit SHA at build time |
| `org.opencontainers.image.architecture` | `amd64` | Target architecture |

## Custom Infrashift Labels

| Label | Example | Purpose |
|-------|---------|---------|
| `io.infrashift.image.upstream.base` | `registry.access.redhat.com/ubi9` | Upstream base registry |
| `io.infrashift.image.upstream.digest` | `sha256:09d0f42e...` | Upstream per-arch digest used in build |
| `io.infrashift.image.variant` | `standard` | Image variant identifier |

## OpenShift Compatibility Labels

| Label | Example | Purpose |
|-------|---------|---------|
| `io.openshift.tags` | `ubi9,base,vetted` | OpenShift image stream tags |

## Inspecting Labels

### Using Podman

```bash
podman inspect ghcr.io/infrashift/trusted-base-images/trusted/ubi9-standard:latest \
  --format '{{json .Config.Labels}}' | jq
```

### Using Docker

```bash
docker inspect ghcr.io/infrashift/trusted-base-images/trusted/ubi9-standard:latest \
  --format '{{json .Config.Labels}}' | jq
```

### Using Skopeo

```bash
skopeo inspect docker://ghcr.io/infrashift/trusted-base-images/trusted/ubi9-standard:latest \
  | jq '.Labels'
```

## Benefits

### Provenance Tracing

The `io.infrashift.image.upstream.base` and `io.infrashift.image.upstream.digest` labels allow you to trace any Trusted Base Image back to the exact upstream source it was built from:

```bash
# Podman
UPSTREAM=$(podman inspect <container> --format '{{index .Config.Labels "io.infrashift.image.upstream.base"}}')
DIGEST=$(podman inspect <container> --format '{{index .Config.Labels "io.infrashift.image.upstream.digest"}}')
echo "Built from: ${UPSTREAM}@${DIGEST}"

# Docker
UPSTREAM=$(docker inspect <container> --format '{{index .Config.Labels "io.infrashift.image.upstream.base"}}')
DIGEST=$(docker inspect <container> --format '{{index .Config.Labels "io.infrashift.image.upstream.digest"}}')
echo "Built from: ${UPSTREAM}@${DIGEST}"
```

### Automated Discovery

Container registries and security scanners that support OCI annotations can automatically:
- Categorize images by vendor and variant
- Track build timestamps and git revisions
- Identify the upstream base for vulnerability correlation

### Build Reproducibility

The combination of `revision` (git SHA) and `upstream.digest` provides enough information to reproduce the build from source:
1. Check out the repository at the declared `revision`
2. Read the Containerfile for the declared `variant`
3. Build using the declared `upstream.base` and `upstream.digest`
