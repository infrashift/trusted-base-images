---
title: Digest Pinning
description: Why digest pinning matters and how Trusted Base Images uses per-architecture digests.
---

Digest pinning is the practice of referencing container images by their content-addressable SHA-256 digest instead of mutable tags. Trusted Base Images pins every build to upstream per-architecture manifest digests.

## Why Tags Are Dangerous

Container image tags are mutable pointers. The same tag can point to different content at different times:

```bash
# Today this pulls image A
podman pull registry.example.com/app:v1.0  # or: docker pull

# Tomorrow the publisher pushes a different image with the same tag
# Now this pulls image B — silently different content
podman pull registry.example.com/app:v1.0  # or: docker pull
```

This creates several risks:
- **Silent changes** — A rebuilt upstream image may introduce new vulnerabilities
- **Non-reproducibility** — Builds at different times produce different results
- **Supply chain attacks** — A compromised registry can swap tagged images

## How Digest Pinning Works

A digest is a SHA-256 hash of the image manifest. It is computed from the image content itself and cannot be forged:

```bash
# This always pulls exactly the same image content
podman pull registry.example.com/app@sha256:abc123...  # or: docker pull
```

## Per-Architecture Digests

Trusted Base Images stores per-architecture manifest digests in `versions.json`:

```json
{
  "ubi9": {
    "standard": {
      "base": "registry.access.redhat.com/ubi9",
      "amd64": { "digest": "sha256:09d0f42e..." },
      "arm64": { "digest": "sha256:2b9be42b..." }
    }
  }
}
```

Each architecture has its own digest because:
- Multi-arch manifest lists have a different digest than individual platform manifests
- Pinning the manifest list digest still allows the list entries to change
- Per-arch digests guarantee the exact binary content for each platform

## Build-Time Pinning

The Containerfile uses digest-pinned `FROM`:

```dockerfile
ARG UPSTREAM_BASE
ARG UPSTREAM_DIGEST

FROM ${UPSTREAM_BASE}@${UPSTREAM_DIGEST}
```

The build workflow resolves the digest from `versions.json`:

```bash
BASE=$(jq -r ".ubi9.standard.base" versions.json)
DIGEST=$(jq -r ".ubi9.standard.amd64.digest" versions.json)
# Builds: FROM registry.access.redhat.com/ubi9@sha256:09d0f42e...
```

## Verification

The Review-Actor cross-checks the upstream digest:

1. Reads the digest from the build's provenance attestation
2. Reads the expected digest from `versions.json`
3. Fails the review if they don't match

This ensures the build actually used the declared upstream source.

## Updating Digests

When Red Hat publishes new UBI images, update `versions.json` with the new per-arch digests:

```bash
# Resolve per-architecture digests from the upstream manifest list
skopeo inspect --raw docker://registry.access.redhat.com/ubi9 | \
  jq '.manifests[] | {(.platform.architecture): .digest}'
```

See [versions.json Schema](/trusted-base-images/reference/versions-json/) for the full format.
