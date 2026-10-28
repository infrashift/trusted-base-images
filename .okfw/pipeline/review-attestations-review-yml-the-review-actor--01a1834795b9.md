---
id: "01a18347-95b9-7599-ab46-5737b292729b"
title: "Review Attestations (review.yml): the Review Actor"
type: "pipeline"
tags:
  - "pipeline"
  - "signing"
  - "cve"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:09-05:00"
description: "The Review Actor workflow: what it verifies for each triple, how it applies the CVE gate, and the verdict it signs."
resource: "https://github.com/infrashift/trusted-base-images/blob/main/.github/workflows/review.yml"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:09-05:00"
---

# Review Attestations (review.yml): the Review Actor

## Trigger

`workflow_run` after "CI Build & Audit" completes.

## Jobs

**gate-check** confirms the build succeeded and reads the pull request data.

**matrix-setup** reads `build-matrix.json` from the build run.

**review** runs per triple in GitHub Environment `Review-Actor`:

1. Verifies the build attestation signatures with `build.pub`.
2. Verifies the evidence signatures and checksums.
3. Cross-checks the upstream digest in the provenance against `versions.json`.
4. Evaluates the CVE gate with OPA. See [Policy decision point: CVE gate and repo gate](/architecture/policy-decision-point-cve-gate-and-repo-gate--01a18347959b.md).
5. Writes the review verdict, PASS or FAIL, and signs it.
6. Attaches the verdict as an attestation.

**summary** posts a table to the pull request and publishes the `review/cve-policy` commit status.

## Fail closed

If a review leg leaves no verdict, the status is a failure. See [Decision: every gate fails closed](/decisions/decision-every-gate-fails-closed--01a183479664.md).

## Related

- [CI Build & Audit (build.yml): the Build Actor](/pipeline/ci-build-audit-build-yml-the-build-actor--01a1834795b4.md)
- [Release Images (release.yml): the Release Actor](/pipeline/release-images-release-yml-the-release-actor--01a1834795be.md)
