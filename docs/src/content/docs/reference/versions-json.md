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
      "amd64": { "digest": "sha256:09d0f42e..." },
      "arm64": { "digest": "sha256:2b9be42b..." }
    },
    "minimal": {
      "base": "registry.access.redhat.com/ubi9-minimal",
      "amd64": { "digest": "sha256:42c0bdc0..." },
      "arm64": { "digest": "sha256:680087262..." }
    },
    "updated": "2026-02-15",
    "reason": "Test OPA fix and high CVE policy"
  },
  "ubi10": {
    "minimal": {
      "base": "registry.access.redhat.com/ubi10-minimal",
      "amd64": { "digest": "sha256:84d365ce..." }
    },
    "updated": "2026-02-16",
    "reason": "Test release workflow with ubi10-minimal"
  },
  "fedora43": {
    "minimal": {
      "base": "registry.fedoraproject.org/fedora-minimal",
      "amd64": { "digest": "sha256:6807db66..." }
    },
    "updated": "2026-03-03",
    "reason": "Add Fedora 43 minimal base image"
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
2. **Architecture keys absent = architecture not built**. For example, `ubi10-minimal` has no `arm64` key.
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
amd64: sha256:09d0f42ed3953ff69e1f3d9577633a33ce0f16a577fb3e18ce3cf6b41379386b
arm64: sha256:2b9be42b19836c9056168098102f964a543e8b863af697c86fd83352d23e743a
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
