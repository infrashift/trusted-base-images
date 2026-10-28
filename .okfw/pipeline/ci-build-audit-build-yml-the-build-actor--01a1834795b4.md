---
id: "01a18347-95b4-7455-9ce4-811f084c0e62"
title: "CI Build & Audit (build.yml): the Build Actor"
type: "pipeline"
tags:
  - "pipeline"
  - "signing"
  - "cve"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:09-05:00"
description: "The Build Actor workflow: which changes trigger it, how it selects triples, and what it builds, scans, signs and pushes."
resource: "https://github.com/infrashift/trusted-base-images/blob/main/.github/workflows/build.yml"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:09-05:00"
---

# CI Build & Audit (build.yml): the Build Actor

## Trigger

A pull request to `main` that changes one of:

- `Containerfiles/**` or `versions.json`
- `.github/pdp/**`, `review.yml` or `release.yml`. A change to the gate re-runs build and review, so the gate is tested against the repo.

## Jobs

**matrix-setup** selects triples from `versions.json`. A Containerfile change selects all architectures of that image. A `versions.json` change selects only the changed triples. It uploads `build-matrix.json`.

**build-and-sign** runs per triple in GitHub Environment `Build-Actor`. arm64 runs on an arm64 runner.

1. Builds with buildah from `UPSTREAM_BASE@UPSTREAM_DIGEST`.
2. Pushes to the development namespace with tag `pr-<N>-<arch>` and records the pushed digest.
3. Exports the same image to a local OCI directory. See [Decision: scan a local copy of the pushed image](/decisions/decision-scan-a-local-copy-of-the-pushed-image--01a18347964a.md).
4. Makes the evidence bundle from the local copy. See [Evidence bundle and attestations](/architecture/evidence-bundle-and-attestations--01a1834795a0.md).
5. Signs the evidence and attaches the attestations.
6. Uploads the evidence bundle.

## Related

- [Review Attestations (review.yml): the Review Actor](/pipeline/review-attestations-review-yml-the-review-actor--01a1834795b9.md)
- [versions.json pin model](/images/versions-json-pin-model--01a1834795df.md)
- [Three-actor governance: Build, Review, Release](/architecture/three-actor-governance-build-review-release--01a183479588.md)
