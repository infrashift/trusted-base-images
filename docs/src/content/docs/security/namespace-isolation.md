---
title: Namespace Isolation
description: How the development, trusted, and quarantine GHCR namespaces enforce image promotion gates.
---

Trusted Base Images uses three GHCR namespaces to enforce a strict promotion model. Images progress from `development` through the governance chain and land in either `trusted` or `quarantine` — never skipping a stage.

## Namespaces

### `development`

```
ghcr.io/infrashift/trusted-base-images/development/<image>:pr-<N>-<arch>
```

The Build-Actor pushes every image here during the CI build. Development images are:

- **Unreviewed** — no Review-Actor verdict has been issued
- **Ephemeral** — tied to a PR number, not a merge commit
- **Tagged by PR and architecture** — e.g., `ubi9-standard:pr-7-amd64`
- **Attestation-bearing** — SBOM, CVE, and provenance attestations are attached here by the Build-Actor

Development images are the input to the Review-Actor. They are never intended for production use.

### `trusted`

```
ghcr.io/infrashift/trusted-base-images/trusted/<image>:<sha7>-<arch>
ghcr.io/infrashift/trusted-base-images/trusted/<image>:latest
ghcr.io/infrashift/trusted-base-images/trusted/<image>:<YYYYMMDD>
ghcr.io/infrashift/trusted-base-images/trusted/<image>:<sha7>
```

The Release-Actor promotes images here when the review verdict is `PASS`. Trusted images are:

- **Fully verified** — build attestations, review verdict, upstream digest match, and CVE policy all passed
- **Dual-signed** — release attestation signed with both sovereign key and keyless OIDC (recorded in Rekor)
- **Multi-tagged** — per-arch tags (`<sha7>-<arch>`) plus manifest list tags (`latest`, date, SHA)
- **Production-ready** — this is the only namespace consumers should pull from

### `quarantine`

```
ghcr.io/infrashift/trusted-base-images/quarantine/<image>:pr-<N>-<arch>
```

The Release-Actor sends images here when the review verdict is `FAIL`. Quarantined images are:

- **Policy violators** — failed one or more review checks (typically CVE threshold)
- **Isolated** — separated from trusted images at the registry namespace level
- **No manifest list** — quarantined images do not get multi-arch manifest lists
- **Investigable** — retained for root cause analysis; the review verdict details which checks failed

## Why Three Namespaces?

A single namespace with tags like `unverified-pr-7` and `verified-latest` would be technically possible but fundamentally weaker:

| Risk | Single Namespace | Three Namespaces |
|------|:----------------:|:----------------:|
| Accidental pull of unverified image | Tag confusion possible | Different registry path — impossible to confuse |
| Credential scope | One token accesses everything | Permissions can be scoped per namespace |
| Cleanup and retention | Must filter by tag pattern | Delete entire namespace |
| Policy enforcement | Tag-based, easy to bypass | Namespace-level, structurally enforced |
| Audit trail | Mixed history | Clean separation of verified vs failed images |

The namespace boundary makes the promotion gate **structural** rather than **conventional**. A consumer configured to pull from `trusted/` cannot accidentally receive a development or quarantined image regardless of tag naming.

## Tag Schemes

Each namespace uses a different tagging convention that reflects its purpose:

| Namespace | Tag Pattern | Example | Mutability |
|-----------|-------------|---------|:----------:|
| `development` | `pr-<N>-<arch>` | `pr-7-amd64` | Overwritten on rebuild |
| `trusted` | `<sha7>-<arch>` | `0237427-amd64` | Immutable (unique per release) |
| `trusted` | `latest` | `latest` | Mutable (points to newest) |
| `trusted` | `<YYYYMMDD>` | `20260216` | Mutable (one per day) |
| `trusted` | `<sha7>` | `0237427` | Immutable (manifest list) |
| `quarantine` | `pr-<N>-<arch>` | `pr-7-amd64` | Immutable (no rebuilds) |

For production use, pin to a digest or a `<sha7>-<arch>` tag. See [Digest Pinning](/trusted-base-images/security/digest-pinning/) for details.

## Promotion Flow

```
PR opened
  │
  ▼
development/ubi9-standard:pr-7-amd64     ← Build-Actor pushes here
  │
  ├─ Review-Actor verifies attestations
  │
  ▼
PR merged
  │
  ├─ Verdict: PASS ──► trusted/ubi9-standard:0237427-amd64
  │                     trusted/ubi9-standard:latest  (manifest list)
  │
  └─ Verdict: FAIL ──► quarantine/ubi9-standard:pr-7-amd64
```

## GHCR Package Structure

Each namespace/image combination is a separate GHCR package:

```
infrashift/trusted-base-images/development/ubi9-standard
infrashift/trusted-base-images/trusted/ubi9-standard
infrashift/trusted-base-images/quarantine/ubi9-standard
```

Packages are org-scoped. To list or manage them:

```bash
# List all trusted images
make -f Ops.mk list-images target_namespace=trusted

# List via API (URL-encode the slashes)
gh api orgs/infrashift/packages/container/trusted-base-images%2Ftrusted%2Fubi9-standard/versions
```

See [Ops.mk](https://github.com/infrashift/trusted-base-oci-images/blob/main/Ops.mk) for operational targets.
