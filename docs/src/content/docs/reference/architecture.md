---
title: Architecture
description: End-to-end pipeline architecture for Trusted Base Images.
---

This page describes the complete pipeline architecture from source to production.

## Pipeline Overview

```
┌─────────────┐    workflow_run     ┌──────────────┐    PR merge      ┌───────────────┐
│ Build-Actor  │ ──────────────────> │ Review-Actor  │ ──────────────> │ Release-Actor  │
│ (CI Build &  │                    │ (Review       │                  │ (Release       │
│  Audit)      │                    │  Attestations)│                  │  Images)       │
└──────┬───────┘                    └──────┬────────┘                  └──────┬─────────┘
       │                                   │                                  │
       ▼                                   ▼                                  ▼
  development/                        Review verdict               trusted/ or quarantine/
  ubi9-standard:pr-N-amd64           attached to image             ubi9-standard:sha7-amd64
```

## Workflow Chain

### 1. CI Build & Audit (`build.yml`)

**Trigger**: `pull_request` to `main` when `Containerfiles/**` or `versions.json` change

1. **Matrix Setup**: Derives `{version, variant, arch}` triples from `versions.json`
2. **Selective Detection**: Only builds what changed — Containerfile changes expand to all arches; `versions.json` changes detect at the triple level
3. **Build**: Uses Buildah to build from digest-pinned upstream base
4. **Evidence Generation**: Syft SBOM, Grype CVE scan, SLSA v1.0 provenance
5. **Signing**: Signs all evidence and attaches attestations to the development image
6. **Upload**: Uploads `build-matrix.json` and per-triple evidence bundles

### 2. Review Attestations (`review.yml`)

**Trigger**: `workflow_run` after successful Build

1. **Gate Check**: Verifies the triggering build was successful and extracts PR metadata
2. **Matrix**: Downloads `build-matrix.json` from the build run (single source of truth)
3. **Verification**: For each triple:
   - Verifies all build attestation signatures against `build.pub`
   - Verifies evidence blob signatures and checksums
   - Cross-checks upstream digest between provenance and `versions.json`
   - Evaluates CVE policy with OPA
4. **Verdict**: Generates and signs a review verdict (PASS/FAIL)
5. **Summary**: Posts a review summary table to the PR

### 3. Release Images (`release.yml`)

**Trigger**: `pull_request` closed (merged) to `main`

1. **Gate Check**: Verifies the PR was merged (not just closed)
2. **Resolve Review**: Finds the review run that reviewed the build for the merged commit
3. **Matrix**: Downloads `build-matrix.json` from the original build run
4. **Release**: For each triple:
   - Re-verifies all build and review attestations
   - Checks review verdict and commit freshness
   - Promotes to `trusted` (PASS) or `quarantine` (FAIL) namespace
   - Dual-signs the release attestation (sovereign key + keyless OIDC)
5. **Manifest**: Creates multi-architecture manifest lists with `latest`, date, and SHA tags
6. **Summary**: Posts a release summary table to the PR

## Matrix Derivation

The build matrix is derived from `versions.json` using jq:

```bash
ALL_TRIPLES=$(jq -c '[to_entries[] | .key as $ver | .value | to_entries[] |
  select(.value | type == "object" and has("base")) |
  .key as $var | .value | to_entries[] |
  select(.key != "base" and (.value | type == "object" and has("digest"))) |
  {version: ($ver | ltrimstr("ubi")), variant: $var, arch: .key}]' versions.json)
```

This produces triples like:
```json
[
  {"version": "9", "variant": "standard", "arch": "amd64"},
  {"version": "9", "variant": "standard", "arch": "arm64"},
  {"version": "10", "variant": "minimal", "arch": "amd64"}
]
```

## Artifact Flow

```
Build Run
├── build-matrix.json          (used by Review and Release)
├── evidence-ubi9-standard-amd64/
│   ├── sbom.json + .sig
│   ├── cve-report.json + .sig
│   ├── provenance.json + .sig
│   └── checksums.sha256 + .sig
└── evidence-ubi9-standard-arm64/
    └── ...

Review Run
├── review-ubi9-standard-amd64/
│   ├── review-verdict.json
│   └── review-verdict.json.sig
└── review-ubi9-standard-arm64/
    └── ...

Release Run
├── release-result-ubi9-standard-amd64/
│   └── release-result.json
└── release-result-ubi9-standard-arm64/
    └── ...
```

## Image Namespaces

| Namespace | Pattern | Purpose |
|-----------|---------|---------|
| `development` | `pr-<N>-<arch>` | Build output, unreviewed |
| `trusted` | `<sha7>-<arch>`, `latest`, `<date>`, `<sha7>` | Released, fully verified |
| `quarantine` | `pr-<N>-<arch>` | Failed review, isolated |
