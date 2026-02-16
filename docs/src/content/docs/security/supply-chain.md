---
title: Supply Chain Security
description: SLSA Level 3 compliance, SBOM generation, CVE scanning, and Sigstore integration.
---

Trusted Base Images implements supply chain security practices aligned with [SLSA Level 3](https://slsa.dev/spec/v1.0/levels) requirements.

## SLSA Level 3

SLSA (Supply-chain Levels for Software Artifacts) defines a set of progressively increasing security guarantees. Our pipeline meets Level 3:

| Requirement | Implementation |
|-------------|---------------|
| **Build as code** | Containerfiles and `versions.json` in version control |
| **Verified build platform** | GitHub Actions hosted runners |
| **Build isolation** | Each job runs in a fresh runner with no shared state |
| **Provenance generation** | SLSA v1.0 provenance generated for every build |
| **Provenance signing** | Sovereign key + keyless OIDC dual signing |
| **Non-falsifiable provenance** | Provenance includes builder ID, invocation ID, source URI, and resolved dependencies |

## SBOM Generation

Every build generates an SPDX SBOM using [Syft](https://github.com/anchore/syft):

```bash
syft <image> -o spdx-json=sbom.json
```

The SBOM is:
- Signed by the Build-Actor as a blob (`sbom.json.sig`)
- Attached to the image as a cosign attestation (type: `spdxjson`)
- Included in the evidence bundle checksum manifest

## CVE Scanning

Every build is scanned for vulnerabilities using [Grype](https://github.com/anchore/grype):

```bash
grype <image> -o json > cve-report.json
```

The CVE report is:
- Signed by the Build-Actor as a blob (`cve-report.json.sig`)
- Attached to the image as a cosign attestation (type: `vuln`)
- Evaluated by OPA policy during review

## Sigstore Integration

### Sovereign Key Signing

Build and Review actors use sovereign ED25519 keys for signing attestations and evidence blobs. These signatures use `--tlog-upload=false` (no transparency log) because they are intermediate artifacts verified within the pipeline.

### Keyless OIDC Signing

The Release-Actor uses [Sigstore keyless signing](https://docs.sigstore.dev/cosign/signing/signing_with_blobs/) with GitHub Actions OIDC identity. These signatures are recorded in the [Rekor](https://docs.sigstore.dev/logging/overview/) transparency log, providing:

- Public verifiability without needing our sovereign keys
- Tamper-evident audit trail
- Time-stamped proof of signing

### Dual Signing

Release attestations and manifest lists are dual-signed:
1. **Sovereign key** — verifiable with `release.pub`
2. **Keyless OIDC** — verifiable via Rekor without any keys

This ensures images can be verified even if sovereign keys are rotated, and sovereign keys provide verification even if Sigstore infrastructure is unavailable.

## Transparency Log

All release signatures are recorded in [Rekor](https://rekor.sigstore.dev/). You can search for entries:

```bash
rekor-cli search --sha <image-digest>
```
