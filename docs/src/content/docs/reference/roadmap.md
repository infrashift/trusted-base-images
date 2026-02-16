---
title: Roadmap
description: Planned features and future enhancements for Trusted Base Images.
---

This roadmap outlines planned features and enhancements. Items are not in strict priority order and timelines are subject to change.

## Planned Features

### Automatic Upstream Version Bump Triggers

Monitor Red Hat registries for new UBI digest publications. When upstream digests change, automatically open PRs to update `versions.json`:

- Scheduled workflow to check upstream manifests via `skopeo inspect --raw`
- Compare current digests in `versions.json` with upstream
- Open a PR with updated digests when changes are detected
- The existing Build/Review pipeline handles the rest

### Automatic CVE Announcement Triggers

When new CVEs are published that affect managed images, trigger re-scans and notify stakeholders:

- Subscribe to CVE feeds for packages in our SBOM
- Trigger rebuild when new Critical/High CVEs affect current images
- Notify via GitHub Issues or Discussions
- Link to the affected inventory page

### Automated Inventory Page Generation

Generate inventory MDX pages from `versions.json` schema instead of maintaining them manually:

- Template-driven page generation during build
- Reduce maintenance burden when adding new variants
- Keep component structure and data separation

### Additional UBI Versions and Variants

Expand coverage as Red Hat releases new UBI versions:

- UBI10 Standard, Micro, Init (when available)
- UBI10 arm64 support (when upstream provides it)
- Potential RHEL-based Node.js, Python, or Java runtime images

### Rekor-Based Audit Trail UI

Build a visual audit trail from Rekor transparency log entries:

- Query Rekor for all entries related to our images
- Display the signing timeline for each image
- Show the complete governance chain from build to release
- Integrate with inventory pages

### GARMR Policy Agent Migration

Replace the current OPA-based PDP with [GARMR](https://infrashift.github.io) Policy Agent for supply-chain-native policy evaluation:

- Drop-in replacement at the Review-Actor enforcement point
- Native SBOM, CVE, provenance, and attestation policy primitives
- Attestation-aware evaluation — consume Sigstore attestations directly as policy input
- Multi-signal correlation in a single policy evaluation
- Continuous policy monitoring when CVE databases update
- Migrate policy definitions from Rego to GARMR policy format

See [PDP Strategy](/trusted-base-images/security/pdp-strategy/) for the current OPA architecture and migration path.

### Commit Signature Enforcement

Re-enable and enhance the OPA commit signature policy:

- Currently commented out in `policies.rego`
- Enforce GPG or SSH commit signatures on PRs
- Verify signer identity against an allowlist

## Completed

- Three-actor governance model (Build, Review, Release)
- SLSA v1.0 provenance generation
- Per-architecture digest pinning
- Dual signing (sovereign + keyless OIDC)
- CVE scanning with OPA policy enforcement
- Multi-architecture manifest lists
- UBI9 all variants (Standard, Minimal, Micro, Init)
- UBI10 Minimal (amd64)
- Documentation site (Astro Starlight)
