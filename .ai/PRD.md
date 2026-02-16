This **Product Requirements Document (PRD)** serves as the authoritative source of truth for the `infrashift/trusted-base-images` architecture. It codifies our lessons learned regarding `buildah` local storage, registry race conditions, and multi-actor sovereign verification.

---

# PRD: Infrashift Trusted Base Images

## 1. Executive Summary

**Project Name:** `infrashift/trusted-base-images`

**Mission:** To provide SLSA Level 3 compliant Red Hat UBI images that are cryptographically verified from the moment of birth (build) to the moment of consumption (production).

## 2. Core Architectural Principles

* **Source of Truth:** `/versions.json` is the sovereign registry of upstream digests. No hardcoded digests are permitted in `Containerfiles`.
* **Deterministic Integrity:** All security scanning must happen against **local storage** to ensure the bits being scanned are identical to the bits being pushed, bypassing registry latency.
* **Cryptographic Multi-Sig:** No image enters production without three distinct signatures: **Build**, **Review (Bot)**, and **Release (Human)**.
* **Namespace Isolation:** Ephemeral PR builds reside in `/development/`; only "Vetted" images reside in the root registry namespace.

---

## 3. The Build Actor (Technical Stack)

| Component | Implementation |
| --- | --- |
| **Builder** | `buildah` (Rootless/Daemonless) |
| **Scanner** | `syft` (SBOM) and `grype` (Vulnerability Scanning) |
| **Signer** | `cosign` (ED25519 Keys) |
| **Promotion** | `skopeo` (Cross-namespace manifest copying) |

### Build Protocol (The "Local Alias" Rule)

To prevent "Unfinished JSON" or "Manifest Unknown" errors:

1. **Tagging:** Images are tagged with a global `tmp-build-image` alias locally.
2. **Scanning:** Tools address `containers-storage:tmp-build-image`.
3. **Anchoring:** The final `image_uri` must include the `sha256:` prefix captured via `buildah inspect`.

---

## 4. The Review Actor (The Governance Bot)

The Review Actor is an automated auditor that performs "Dry-Run" verification.

* **OPA Enforcement:** Validates the Grype JSON against a Rego policy (e.g., Fail if Critical CVEs > 0).
* **Digest Cross-Check:** Ensures the image's base layer matches the digest listed in `versions.json`.
* **Proposal Generation:** Creates a "Trusted Proposal" (a checksum of the SBOM and CVE report) for the human sovereign to sign.

---

## 5. The Release Actor (The Sovereign Gate)

The only actor permitted to move images into the production namespace.

* **Trigger:** Manual approval on a PR merge to `main`.
* **Action:**
1. Verifies the Build Actor's signature.
2. Verifies the Review Actor's (Bot) signature.
3. **Promotion:** Executes a `skopeo copy` from `.../development/image` to `.../image`.
4. **Final Stamp:** Applies the `release.key` signature to the production-tagged image.



---

## 6. Repository Layout & Metadata

```text
/
├── .github/workflows/
│   ├── ci-build.yml       # The Build Actor
│   ├── pr-reviewer.yml    # The Review Actor
│   └── release.yml        # The Release Actor
├── Containerfiles/        # Variant-specific templates
├── versions.json          # Sovereign Source of Truth
├── .ai/skills/            # AI Protocol logic
└── scripts/               # Evidence generation tools

```

### Metadata Labeling Standard

All images must carry the following OCI-compliant labels:

* `io.infrashift.image.upstream.digest`: The original RHEL digest.
* `io.infrashift.image.variant`: (standard/minimal/micro/init).
* `org.opencontainers.image.revision`: Git Commit SHA.

---

## 7. Operational Protocol for Claude

1. **Modification Rule:** Claude shall only propose changes to `versions.json` for base image updates.
2. **Consistency Rule:** If the Matrix changes in `ci-build.yml`, Claude must verify the corresponding entry exists in `versions.json`.
3. **Scanning Rule:** Claude is strictly forbidden from suggesting `registry:` scanning prefixes for initial CI builds; `containers-storage:` is the mandatory standard.

