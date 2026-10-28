---
id: "01a18347-9596-76d7-b670-a73070bbe70a"
title: "Registry namespaces: development, trusted, quarantine"
type: "architecture"
tags:
  - "registry"
  - "governance"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:09-05:00"
description: "The three GHCR namespaces, their tag schemes, and why a namespace boundary is stronger than a tag convention."
resource: "https://infrashift.github.io/trusted-base-images/security/namespace-isolation/"
sources:
  - resource: "https://github.com/infrashift/trusted-base-images/blob/ea1e21e/.ai/skills/registry-hygiene.md"
    title: "Rule card .ai/skills/registry-hygiene.md (removed)"
  - resource: "https://github.com/infrashift/trusted-base-images/blob/ea1e21e/.ai/skills/promotion-logic.md"
    title: "Rule card .ai/skills/promotion-logic.md (removed)"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:09-05:00"
---

# Registry namespaces: development, trusted, quarantine

## The namespaces

| Namespace | Who writes it | Tags | Consumers pull it? |
|---|---|---|---|
| development | Build Actor | `pr-<N>-<arch>` | No |
| trusted | Release Actor, verdict PASS | `<sha7>-<arch>`, `<sha7>`, `<YYYYMMDD>`, `latest` | Yes |
| quarantine | Release Actor, verdict FAIL | `pr-<N>-<arch>` | No |

Each namespace and image pair is one GHCR package, for example `trusted-base-images/trusted/ubi9-minimal`.

## Rules

1. An image goes to the trusted or quarantine namespace only through the Release Actor.
2. Promotion copies the image. It never rebuilds it. See [Promotion never rebuilds an image](/standards/promotion-never-rebuilds-an-image--01a183479623.md).
3. The image name is the same in each namespace.
4. A quarantined image gets no multi-arch manifest list.
5. [Cleanup Development Images (cleanup-dev.yml)](/pipeline/cleanup-development-images-cleanup-dev-yml--01a1834795c4.md) deletes a pull request's development images after a release.

## Why namespaces, not tags

A consumer that pulls from `trusted/` cannot get a development or quarantined image by mistake. Permissions and cleanup work per namespace.

## Related

- [Three-actor governance: Build, Review, Release](/architecture/three-actor-governance-build-review-release--01a183479588.md)
- [Runbook: list or clean a GHCR namespace](/runbooks/runbook-list-or-clean-a-ghcr-namespace--01a183479702.md)
- Public page: <https://infrashift.github.io/trusted-base-images/security/namespace-isolation/>
