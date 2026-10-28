---
id: "01a18347-9623-7440-9afb-dffdf8bae5fd"
title: "Promotion never rebuilds an image"
type: "standard"
tags:
  - "registry"
  - "governance"
  - "signing"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:10-05:00"
description: "The rule that the Release Actor copies the reviewed image by digest and never builds it again."
sources:
  - resource: "https://github.com/infrashift/trusted-base-images/blob/ea1e21e/.ai/skills/promotion-logic.md"
    title: "Rule card .ai/skills/promotion-logic.md (removed)"
  - resource: "https://github.com/infrashift/trusted-base-images/blob/ea1e21e/.ai/skills/release-governance.md"
    title: "Rule card .ai/skills/release-governance.md (removed)"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:10-05:00"
---

# Promotion never rebuilds an image

## Rules

1. Promote by copy: `skopeo copy` from the development namespace to the trusted or quarantine namespace.
2. Do not run a build in `release.yml`.
3. Promote the image only after the Release Actor verifies the build and review attestations.

## Why

A rebuild makes new layers with new digests. The build and review attestations name the old digest. So a rebuild breaks the chain of custody.

## Related

- [Release Images (release.yml): the Release Actor](/pipeline/release-images-release-yml-the-release-actor--01a1834795be.md)
- [Registry namespaces: development, trusted, quarantine](/architecture/registry-namespaces-development-trusted-quarantine--01a183479596.md)
