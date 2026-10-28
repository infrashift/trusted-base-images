---
id: "01a18347-9588-7319-961b-5f9992a8ad6f"
title: "Three-actor governance: Build, Review, Release"
type: "architecture"
tags:
  - "governance"
  - "signing"
  - "security"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:09-05:00"
description: "The three actors that must each sign an image before release, what each one does, and why they are separate."
resource: "https://infrashift.github.io/trusted-base-images/security/governance-model/"
sources:
  - resource: "https://github.com/infrashift/trusted-base-images/blob/ea1e21e/.ai/PRD.md"
    title: "Original PRD (.ai/PRD.md, removed)"
  - resource: "https://github.com/infrashift/trusted-base-images/blob/ea1e21e/.ai/skills/sovereign-approval.md"
    title: "Rule card .ai/skills/sovereign-approval.md (removed)"
  - resource: "https://github.com/infrashift/trusted-base-images/blob/ea1e21e/.ai/skills/release-governance.md"
    title: "Rule card .ai/skills/release-governance.md (removed)"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:09-05:00"
---

# Three-actor governance: Build, Review, Release

## What it is

Three actors handle every image. Each actor is a workflow job in its own GitHub Environment, with its own actor key.

| Actor | Workflow | It does |
|---|---|---|
| Build Actor | [CI Build & Audit (build.yml): the Build Actor](/pipeline/ci-build-audit-build-yml-the-build-actor--01a1834795b4.md) | Builds the image, makes the evidence bundle, signs it, pushes to the development namespace. |
| Review Actor | [Review Attestations (review.yml): the Review Actor](/pipeline/review-attestations-review-yml-the-review-actor--01a1834795b9.md) | Verifies the build signatures, cross-checks the upstream digest, runs the CVE gate, signs a review verdict. |
| Release Actor | [Release Images (release.yml): the Release Actor](/pipeline/release-images-release-yml-the-release-actor--01a1834795be.md) | Verifies the build and review attestations, promotes the image, signs the release attestation two times. |

## Order

The Review Actor signs after the Build Actor. The Release Actor signs last. The Release Actor refuses an image that has no valid review attestation.

## Why

One compromised job cannot release an image alone. Each actor can see only its own actor key. See [GitHub Environments isolate the actor keys](/architecture/github-environments-isolate-the-actor-keys--01a183479591.md) and [Decision: three actors with three separate keys](/decisions/decision-three-actors-with-three-separate-keys--01a18347963d.md).

## Related

- [Signing chain and actor keys](/architecture/signing-chain-and-actor-keys--01a18347958c.md)
- [Registry namespaces: development, trusted, quarantine](/architecture/registry-namespaces-development-trusted-quarantine--01a183479596.md)
- Public page: <https://infrashift.github.io/trusted-base-images/security/governance-model/>
