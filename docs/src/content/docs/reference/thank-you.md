---
title: Thank You
description: Open source projects that make Trusted Base Images possible.
---

Trusted Base Images is built on the shoulders of outstanding open source projects. We are grateful to the communities and maintainers behind each of them.

## Container Ecosystem

### Red Hat Universal Base Images (UBI)

The upstream base images that we harden and re-publish.

- [Product page](https://www.redhat.com/en/blog/introducing-red-hat-universal-base-image)
- [Red Hat Container Catalog](https://catalog.redhat.com/software/containers/search?q=ubi)

### Buildah

Daemonless container image builder used in our CI pipeline.

- [Product page](https://buildah.io/)
- [GitHub](https://github.com/containers/buildah)

### Podman

Daemonless container engine for running and managing OCI containers.

- [Product page](https://podman.io/)
- [GitHub](https://github.com/containers/podman)

### Skopeo

Utility for copying, inspecting, and signing container images without a daemon.

- [Product page](https://github.com/containers/skopeo)
- [GitHub](https://github.com/containers/skopeo)

## Supply Chain Security

### Sigstore / Cosign

Keyless and key-based signing, verification, and transparency for container images and artifacts.

- [Product page](https://www.sigstore.dev/)
- [GitHub](https://github.com/sigstore/cosign)

### Rekor

Tamper-evident transparency log for supply chain artifact signatures.

- [Product page](https://docs.sigstore.dev/logging/overview/)
- [GitHub](https://github.com/sigstore/rekor)

### Syft

SBOM generator that produces SPDX and CycloneDX software bills of materials.

- [Product page](https://anchore.com/sbom/)
- [GitHub](https://github.com/anchore/syft)

### Grype

Vulnerability scanner for container images and filesystems.

- [Product page](https://anchore.com/scanner/)
- [GitHub](https://github.com/anchore/grype)

### Open Policy Agent (OPA)

Policy engine used to enforce CVE thresholds and security gates in the review pipeline.

- [Product page](https://www.openpolicyagent.org/)
- [GitHub](https://github.com/open-policy-agent/opa)

## CI/CD & Hosting

### GitHub Actions

CI/CD platform that runs the Build, Review, and Release workflows.

- [Product page](https://github.com/features/actions)
- [Documentation](https://docs.github.com/en/actions)

### GitHub Container Registry (GHCR)

OCI-compliant container registry where all Trusted Base Images are published.

- [Documentation](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry)

### GitHub Pages

Static site hosting for this documentation site.

- [Product page](https://pages.github.com/)
- [Documentation](https://docs.github.com/en/pages)

## Documentation

### Astro

The web framework powering this documentation site.

- [Product page](https://astro.build/)
- [GitHub](https://github.com/withastro/astro)

### Starlight

Astro's documentation theme providing search, navigation, and dark mode.

- [Product page](https://starlight.astro.build/)
- [GitHub](https://github.com/withastro/starlight)

### Pagefind

Static search library integrated into Starlight for full-text documentation search.

- [Product page](https://pagefind.app/)
- [GitHub](https://github.com/CloudCannon/pagefind)

## Runtime & Tooling

### Bun

JavaScript runtime and package manager used to build the documentation site.

- [Product page](https://bun.sh/)
- [GitHub](https://github.com/oven-sh/bun)

### Gitleaks

Secret detection tool used in the pre-build OPA policy gate.

- [Product page](https://gitleaks.io/)
- [GitHub](https://github.com/gitleaks/gitleaks)
