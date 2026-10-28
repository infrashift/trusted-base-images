---
id: "01a18347-9583-7908-99ce-df1a3ef87226"
title: "System overview and principles"
type: "architecture"
tags:
  - "governance"
  - "security"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:09-05:00"
description: "What Trusted Base Images is, its mission, and the four principles that every part of the pipeline follows."
resource: "https://infrashift.github.io/trusted-base-images/reference/architecture/"
sources:
  - resource: "https://github.com/infrashift/trusted-base-images/blob/ea1e21e/.ai/PRD.md"
    title: "Original PRD (.ai/PRD.md, removed)"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:09-05:00"
---

# System overview and principles

## Mission

Trusted Base Images gives SLSA Level 3 base images. Each image is cryptographically verified from its build to its use.

## What the repo builds

Six images, each a thin layer over a pinned upstream base. See [versions.json pin model](/images/versions-json-pin-model--01a1834795df.md) and the [images bundle](/images/index.md).

## Principles

1. **One source of truth.** `versions.json` holds every upstream digest. No Containerfile holds a digest. See [versions.json pin model](/images/versions-json-pin-model--01a1834795df.md).
2. **Scan what you push.** The Build Actor scans a local copy of the exact image it pushed. See [Decision: scan a local copy of the pushed image](/decisions/decision-scan-a-local-copy-of-the-pushed-image--01a18347964a.md).
3. **Three signatures.** No image reaches the trusted namespace without the Build, Review and Release signatures. See [Three-actor governance: Build, Review, Release](/architecture/three-actor-governance-build-review-release--01a183479588.md).
4. **Namespace isolation.** Unreviewed builds stay in the development namespace. Only released images go to the trusted namespace. See [Registry namespaces: development, trusted, quarantine](/architecture/registry-namespaces-development-trusted-quarantine--01a183479596.md).

## Parts

| Part | Concept |
|---|---|
| Actors and keys | [Three-actor governance: Build, Review, Release](/architecture/three-actor-governance-build-review-release--01a183479588.md), [Signing chain and actor keys](/architecture/signing-chain-and-actor-keys--01a18347958c.md), [GitHub Environments isolate the actor keys](/architecture/github-environments-isolate-the-actor-keys--01a183479591.md) |
| Registry | [Registry namespaces: development, trusted, quarantine](/architecture/registry-namespaces-development-trusted-quarantine--01a183479596.md) |
| Policy | [Policy decision point: CVE gate and repo gate](/architecture/policy-decision-point-cve-gate-and-repo-gate--01a18347959b.md) |
| Evidence | [Evidence bundle and attestations](/architecture/evidence-bundle-and-attestations--01a1834795a0.md) |
| Change control | [Code owners protect the pipeline](/architecture/code-owners-protect-the-pipeline--01a1834795a5.md) |
| Workflows | [Workflow chain from pull request to release](/pipeline/workflow-chain-from-pull-request-to-release--01a1834795aa.md) |
