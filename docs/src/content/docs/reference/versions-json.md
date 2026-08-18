---
title: versions.json Schema
description: Field-by-field documentation of the versions.json source of truth for upstream base images.
---

`versions.json` is the single source of truth for upstream base images and their per-architecture digests. Every change to this file triggers the build pipeline.

## Schema

```json
{
  "ubi9": {
    "standard": {
      "base": "registry.access.redhat.com/ubi9",
      "amd64": { "digest": "sha256:7a069592..." },
      "arm64": { "digest": "sha256:1dbdcfbb..." }
    },
    "minimal": {
      "base": "registry.access.redhat.com/ubi9-minimal",
      "amd64": { "digest": "sha256:285fe183..." },
      "arm64": { "digest": "sha256:3aa4da3d..." }
    },
    "updated": "2026-08-17",
    "reason": "Upstream refresh to RHEL 9.8"
  },
  "ubi10": {
    "minimal": {
      "base": "registry.access.redhat.com/ubi10-minimal",
      "amd64": { "digest": "sha256:ca6b9148..." },
      "arm64": { "digest": "sha256:4e47e991..." }
    },
    "updated": "2026-08-17",
    "reason": "Upstream refresh to RHEL 10.2; add arm64"
  },
  "fedora43": {
    "minimal": {
      "base": "registry.fedoraproject.org/fedora-minimal",
      "amd64": { "digest": "sha256:a2f37bd3..." },
      "arm64": { "digest": "sha256:5fd0a767..." }
    },
    "updated": "2026-08-17",
    "reason": "Upstream Fedora 43 rebuild; add arm64"
  }
}
```

## Fields

### Distro Key Level (`ubi9`, `ubi10`, `fedora43`)

The top-level key identifies the distro. For UBI images this is `ubi<version>`. For non-UBI images (e.g., Fedora), use `<distro><version>`.

| Field | Type | Description |
|-------|------|-------------|
| `updated` | `string` | Date of last update (YYYY-MM-DD) |
| `reason` | `string` | Reason for the last update |
| `<variant>` | `object` | Variant definition (see below) |

### Variant Level (`standard`, `minimal`, etc.)

| Field | Type | Description |
|-------|------|-------------|
| `base` | `string` | Upstream registry URL for the base image |
| `<arch>` | `object` | Per-architecture manifest digest (see below) |

### Architecture Level (`amd64`, `arm64`)

| Field | Type | Description |
|-------|------|-------------|
| `digest` | `string` | SHA-256 digest of the per-architecture manifest |

## Key Rules

1. **Digests are per-architecture**, not manifest-list digests. Use `skopeo inspect --raw` to resolve them.
2. **Architecture keys absent = architecture not built**. Every variant currently pins both `amd64` and `arm64`; omitting an arch key is how you exclude a variant from that architecture's build matrix.
3. **The `base` field** is the registry URL without a tag or digest. The build combines it with the arch digest: `${base}@${digest}`.

## Resolving Digests from Upstream

To find per-architecture digests for a new upstream release:

```bash
# UBI example
skopeo inspect --raw docker://registry.access.redhat.com/ubi9 | \
  jq -r '.manifests[] | "\(.platform.architecture): \(.digest)"'

# Fedora example
skopeo inspect --raw docker://registry.fedoraproject.org/fedora-minimal:43 | \
  jq -r '.manifests[] | select(.platform.architecture == "amd64") | .digest'
```

Example output (UBI9):

```
amd64: sha256:7a069592145703a5e202a6e23a0ac3cf89737f89f2b26343b88ca3358a53f5de
arm64: sha256:1dbdcfbbf752d0564eb9a084aa4398e5d3c96dff51f2eb8664c0e5a510465780
```

## Adding a New Image

1. Add a new distro key (or variant under an existing key) to `versions.json`
2. Create a matching Containerfile at `Containerfiles/<distro_key>-<variant>.Containerfile` (e.g., `fedora43-minimal.Containerfile`)
3. The build matrix will automatically pick up the new triple(s)
4. Update the `updated` and `reason` fields

## Adding a New Architecture

1. Add the architecture key with its digest under the variant
2. The build matrix will automatically include the new triple
3. The manifest job will include the new arch in multi-arch manifest lists
