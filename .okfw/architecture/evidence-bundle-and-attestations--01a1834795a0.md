---
id: "01a18347-95a0-7322-8fa9-2444e3f34111"
title: "Evidence bundle and attestations"
type: "architecture"
tags:
  - "signing"
  - "security"
  - "cve"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:09-05:00"
description: "What the Build Actor records for each triple, how it attaches attestations to the image, and how the GHCR tag scheme affects discovery."
resource: "https://infrashift.github.io/trusted-base-images/security/supply-chain/"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:09-05:00"
---

# Evidence bundle and attestations

## Evidence bundle

For each triple the Build Actor writes, signs and uploads:

| File | Content |
|---|---|
| `sbom.json` | SBOM from syft |
| `cve-report.json` | CVE scan from grype |
| `provenance.json` | SLSA v1.0 provenance |
| `checksums.sha256` | SHA-256 of the files above |

Each file has a `.sig`. The build also uploads `build-matrix.json`. The review and release workflows read the matrix from this file.

## Attestations on the image

The Build Actor attaches the SBOM, CVE and provenance attestations to the development image. The Review Actor attaches the review verdict. The Release Actor attaches the release attestation.

GHCR has no OCI referrers API. So cosign attaches each attestation as a tag `sha256-<digest>.att`. The in-toto subject inside the signed payload still names the exact digest. See [GHCR does not implement the OCI referrers API](/issues/ghcr-does-not-implement-the-oci-referrers-api--01a1834796b3.md).

## Related

- [Signing chain and actor keys](/architecture/signing-chain-and-actor-keys--01a18347958c.md)
- [Decision: scan a local copy of the pushed image](/decisions/decision-scan-a-local-copy-of-the-pushed-image--01a18347964a.md)
- Public guide: <https://infrashift.github.io/trusted-base-images/guides/verify-attestations/>
