---
id: "01a18347-95be-7aed-a00a-74874c749c97"
title: "Release Images (release.yml): the Release Actor"
type: "pipeline"
tags:
  - "pipeline"
  - "signing"
  - "registry"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:09-05:00"
description: "The Release Actor workflow: how it finds the reviewed build, re-verifies it, promotes it, and signs the release."
resource: "https://github.com/infrashift/trusted-base-images/blob/main/.github/workflows/release.yml"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:09-05:00"
---

# Release Images (release.yml): the Release Actor

## Trigger

A pull request to `main` closes. The workflow continues only if someone merged the pull request.

## Jobs

**resolve-review** finds the successful build for the head commit and the review of that build. If no build ran, the release stops. The pull request touched no image path.

**release** runs per triple in GitHub Environment `Release-Actor`:

1. Verifies the build attestations and the review attestation.
2. Reads the review verdict.
3. Promotes with skopeo. PASS goes to the trusted namespace as `<sha7>-<arch>`. FAIL goes to the quarantine namespace as `pr-<N>-<arch>`.
4. Writes the release attestation and signs it with the actor key and as a keyless signature.

**manifest** makes the multi-arch manifest list with tags `latest`, `<YYYYMMDD>` and `<sha7>`. It signs it two times. It skips an image with a quarantined architecture.

**summary** posts a table to the pull request.

## After

[Cleanup Development Images (cleanup-dev.yml)](/pipeline/cleanup-development-images-cleanup-dev-yml--01a1834795c4.md) and [Update Documentation Inventory (doc-release.yml)](/pipeline/update-documentation-inventory-doc-release-yml--01a1834795c9.md) start when this workflow completes.

## Related

- [Registry namespaces: development, trusted, quarantine](/architecture/registry-namespaces-development-trusted-quarantine--01a183479596.md)
- [Promotion never rebuilds an image](/standards/promotion-never-rebuilds-an-image--01a183479623.md)
- [Signing chain and actor keys](/architecture/signing-chain-and-actor-keys--01a18347958c.md)
