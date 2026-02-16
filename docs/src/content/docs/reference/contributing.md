---
title: Contributing
description: How to contribute to the Trusted Base Images project.
---

Contributions to Trusted Base Images are welcome. This guide covers the PR workflow, Containerfile conventions, and how to propose changes.

## PR Workflow

1. **Fork and branch**: Create a feature branch from `main`
2. **Make changes**: Edit Containerfiles, `versions.json`, or documentation
3. **Open a PR**: Target the `main` branch
4. **Automated pipeline**:
   - The Build-Actor builds all affected images and generates evidence
   - The Review-Actor verifies attestations and evaluates CVE policy
   - A review summary is posted to the PR
5. **Human review**: A maintainer reviews the code changes and review summary
6. **Merge**: On merge, the Release-Actor promotes images to `trusted` or `quarantine`

## Types of Changes

### Updating Upstream Digests

When Red Hat publishes new UBI images:

1. Resolve per-architecture digests:
   ```bash
   skopeo inspect --raw docker://registry.access.redhat.com/ubi9 | \
     jq -r '.manifests[] | "\(.platform.architecture): \(.digest)"'
   ```
2. Update `versions.json` with the new digests
3. Update the `updated` date and `reason` fields
4. Open a PR — only changed triples will be rebuilt

### Adding a New Image Variant

1. Create `Containerfiles/ubi<version>-<variant>.Containerfile`
2. Add the variant to `versions.json` with base and per-arch digests
3. The build matrix automatically picks up new triples

### Modifying a Containerfile

1. Edit the Containerfile in `Containerfiles/`
2. The pipeline detects the change and rebuilds all architectures for that variant
3. Keep Containerfiles minimal — the security hardening pattern is:
   - `FROM` with digest-pinned upstream
   - `LABEL` with OCI and Infrashift annotations
   - Minimal `RUN` commands (cache cleaning)
   - `USER 1001`

## Containerfile Conventions

- Use `ARG` for `UPSTREAM_BASE`, `UPSTREAM_DIGEST`, `IMAGE_VERSION`, `BUILD_DATE`, `TARGETARCH`, `GIT_COMMIT`
- Include all OCI standard labels and Infrashift custom labels
- Clean package manager caches
- Set `USER 1001` as the default non-root user
- Do not install additional packages unless required for the variant's purpose

## Documentation Changes

Documentation lives in `docs/` and uses [Astro Starlight](https://starlight.astro.build/). To preview locally:

```bash
cd docs
bun install
bun run dev
```

## Code of Conduct

Be respectful and constructive. We welcome contributors of all experience levels.
