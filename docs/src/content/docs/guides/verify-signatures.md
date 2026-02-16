---
title: Verify Signatures
description: How to verify the three-layer signing chain on Trusted Base Images.
---

Trusted Base Images use a three-layer signing chain. Each actor in the governance model signs with a separate sovereign key, and the Release-Actor additionally signs with keyless OIDC for public transparency.

## Signing Chain

| Layer | Actor | Key | Transparency Log |
|-------|-------|-----|:----------------:|
| 1 | Build-Actor | `build.pub` | No |
| 2 | Review-Actor | `review.pub` | No |
| 3 | Release-Actor | `release.pub` + keyless OIDC | Yes (Rekor) |

## Download Public Keys

```bash
BASE_URL="https://raw.githubusercontent.com/infrashift/trusted-base-images/main/.github/pdp/public-keys"

curl -sSfL -o build.pub "${BASE_URL}/build.pub"
curl -sSfL -o review.pub "${BASE_URL}/review.pub"
curl -sSfL -o release.pub "${BASE_URL}/release.pub"
```

## Verify Build Signatures

The Build-Actor signs all attestations (SBOM, CVE, provenance) attached to the development image:

```bash
cosign verify-attestation \
  --key build.pub \
  --type spdxjson \
  --insecure-ignore-tlog \
  --certificate-identity-regexp='.*' \
  --certificate-oidc-issuer-regexp='.*' \
  ghcr.io/infrashift/trusted-base-images/trusted/ubi9-standard:latest
```

## Verify Review Signatures

The Review-Actor signs the review verdict attestation after verifying all build attestations:

```bash
cosign verify-attestation \
  --key review.pub \
  --type https://infrashift.io/attestation/review/v1 \
  --insecure-ignore-tlog \
  --certificate-identity-regexp='.*' \
  --certificate-oidc-issuer-regexp='.*' \
  ghcr.io/infrashift/trusted-base-images/trusted/ubi9-standard:latest
```

## Verify Release Signatures

The Release-Actor dual-signs the release attestation with both a sovereign key and keyless OIDC:

### Sovereign Key Verification

```bash
cosign verify-attestation \
  --key release.pub \
  --type https://infrashift.io/attestation/release/v1 \
  --certificate-identity-regexp='.*' \
  --certificate-oidc-issuer-regexp='.*' \
  ghcr.io/infrashift/trusted-base-images/trusted/ubi9-standard:latest
```

### Keyless OIDC Verification

```bash
cosign verify-attestation \
  --type https://infrashift.io/attestation/release/v1 \
  --certificate-identity-regexp='.*' \
  --certificate-oidc-issuer-regexp='.*' \
  ghcr.io/infrashift/trusted-base-images/trusted/ubi9-standard:latest
```

## Why Three Layers?

The three-layer signing chain ensures no single actor can push a compromised image:

1. **Build-Actor** proves the artifacts were generated from the declared source
2. **Review-Actor** proves the artifacts passed all policy checks
3. **Release-Actor** proves the image was promoted through the full governance chain

If any key is compromised, the other two layers prevent unauthorized modifications from reaching production. See the [Governance Model](/trusted-base-images/security/governance-model/) for details.
