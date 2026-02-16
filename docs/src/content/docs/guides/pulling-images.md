---
title: Pulling Images
description: How to pull Trusted Base Images using Podman or Docker with digest pinning.
---

All Trusted Base Images are published to the GitHub Container Registry (GHCR) under the `trusted` namespace.

## Registry URL

```
ghcr.io/infrashift/trusted-base-images/trusted/<image-name>
```

## Pull by Tag

The simplest way to pull an image is by tag. Multi-arch manifest lists (`latest`, date tags, and SHA tags) automatically resolve to your platform's architecture.

```bash
# Podman
podman pull ghcr.io/infrashift/trusted-base-images/trusted/ubi9-standard:latest

# Docker
docker pull ghcr.io/infrashift/trusted-base-images/trusted/ubi9-standard:latest
```

### Available Tag Types

| Tag Pattern | Example | Description |
|-------------|---------|-------------|
| `latest` | `latest` | Most recent release (manifest list) |
| `YYYYMMDD` | `20260216` | Date-stamped release (manifest list) |
| `<sha7>` | `0237427` | Git commit short SHA (manifest list) |
| `<sha7>-<arch>` | `0237427-amd64` | Per-architecture image |

## Pull by Digest (Recommended)

For production workloads, always pin to a specific digest. Digests are immutable — unlike tags, they cannot be changed after publishing.

```bash
# Podman
podman pull ghcr.io/infrashift/trusted-base-images/trusted/ubi9-standard@sha256:abc123...

# Docker
docker pull ghcr.io/infrashift/trusted-base-images/trusted/ubi9-standard@sha256:abc123...

# Use in a Containerfile / Dockerfile
FROM ghcr.io/infrashift/trusted-base-images/trusted/ubi9-standard@sha256:abc123...
```

Find current digests on the [inventory pages](/trusted-base-images/inventory/).

## Multi-Architecture Support

Most images are published for both `amd64` and `arm64`. When you pull a manifest list tag (like `latest`), Podman/Docker automatically selects the correct architecture for your platform.

To pull a specific architecture explicitly:

```bash
# Podman
podman pull --platform linux/amd64 ghcr.io/infrashift/trusted-base-images/trusted/ubi9-standard:latest
podman pull --platform linux/arm64 ghcr.io/infrashift/trusted-base-images/trusted/ubi9-standard:latest

# Docker
docker pull --platform linux/amd64 ghcr.io/infrashift/trusted-base-images/trusted/ubi9-standard:latest
docker pull --platform linux/arm64 ghcr.io/infrashift/trusted-base-images/trusted/ubi9-standard:latest
```

:::note
UBI10 Minimal is currently amd64 only. Pulling with `--platform linux/arm64` will fail for that image.
:::

## Authentication

GHCR packages in this repository are public. No authentication is required to pull images. If you need to authenticate for rate-limiting purposes:

```bash
# Podman
podman login ghcr.io -u USERNAME -p $GITHUB_TOKEN

# Docker
echo $GITHUB_TOKEN | docker login ghcr.io -u USERNAME --password-stdin
```

## Next Steps

After pulling an image, verify its integrity:

- [Verify Attestations](/trusted-base-images/guides/verify-attestations/) — check SBOM, CVE, and provenance attestations
- [Verify Signatures](/trusted-base-images/guides/verify-signatures/) — verify the three-layer signing chain
- [Compare Checksums](/trusted-base-images/guides/compare-checksums/) — validate evidence artifact integrity
