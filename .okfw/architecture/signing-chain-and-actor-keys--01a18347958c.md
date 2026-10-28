---
id: "01a18347-958c-7cc6-b625-b8ea8f6d8981"
title: "Signing chain and actor keys"
type: "architecture"
tags:
  - "signing"
  - "security"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:09-05:00"
description: "Which key signs what, where the public keys live, and how the Release Actor adds a keyless signature."
resource: "https://github.com/infrashift/trusted-base-images/blob/main/.github/pdp/public-keys/"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:09-05:00"
---

# Signing chain and actor keys

## Keys

| Actor | Private key | Public key |
|---|---|---|
| Build Actor | `COSIGN_PRIVATE_KEY` in GitHub Environment `Build-Actor` | `.github/pdp/public-keys/build.pub` |
| Review Actor | `COSIGN_PRIVATE_KEY` in GitHub Environment `Review-Actor` | `.github/pdp/public-keys/review.pub` |
| Release Actor | `COSIGN_PRIVATE_KEY` in GitHub Environment `Release-Actor` | `.github/pdp/public-keys/release.pub` |

The tool is cosign v2. See [Decision: stay on cosign v2 until the org moves to v3](/decisions/decision-stay-on-cosign-v2-until-the-org-moves-to-v3--01a18347965e.md).

## What each key signs

1. The Build Actor signs each file of the evidence bundle and attaches the SBOM, CVE and provenance attestations.
2. The Review Actor signs the review verdict and attaches it as an attestation.
3. The Release Actor signs the release attestation two times: once with its actor key and once as a keyless signature. The keyless signature uses the workflow's OIDC identity and goes into the Rekor log. It also signs each multi-arch manifest list two times.

## How a later actor verifies an earlier one

A later actor uses the public key of the earlier actor. It never reads the earlier actor's private key.

## Related

- [Three-actor governance: Build, Review, Release](/architecture/three-actor-governance-build-review-release--01a183479588.md)
- [GitHub Environments isolate the actor keys](/architecture/github-environments-isolate-the-actor-keys--01a183479591.md)
- [Evidence bundle and attestations](/architecture/evidence-bundle-and-attestations--01a1834795a0.md)
- Public guide: <https://infrashift.github.io/trusted-base-images/guides/verify-signatures/>
