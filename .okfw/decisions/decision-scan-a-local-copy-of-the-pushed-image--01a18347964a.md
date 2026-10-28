---
id: "01a18347-964a-7957-8708-a34e063bef86"
title: "Decision: scan a local copy of the pushed image"
type: "decision"
tags:
  - "cve"
  - "security"
  - "pipeline"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:10-05:00"
description: "Why the Build Actor scans a local OCI export of the exact image it pushed, not the image in the registry."
sources:
  - resource: "https://github.com/infrashift/trusted-base-images/blob/ea1e21e/.ai/PRD.md"
    title: "Original PRD (.ai/PRD.md, removed)"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:10-05:00"
---

# Decision: scan a local copy of the pushed image

**Date:** 2026-02-16

## Context

A scan through the registry right after a push can fail with "manifest unknown" errors. It can also read a different image if a tag moves.

## Decision

Push the image and record the pushed digest. Export the same image to a local OCI directory. Run syft and grype on the local copy. Anchor every attestation to the pushed digest.

## Consequences

- The scanned bits are the pushed bits.
- Registry delay cannot break a build.

## Alternatives

- Scan `registry:` references. Rejected for the reasons above.
- The first design used a `containers-storage:tmp-build-image` alias. The current build uses an OCI directory export.

## Related

- [CI Build & Audit (build.yml): the Build Actor](/pipeline/ci-build-audit-build-yml-the-build-actor--01a1834795b4.md)
- [Evidence bundle and attestations](/architecture/evidence-bundle-and-attestations--01a1834795a0.md)
- [Decision log](/decisions/decision-log--01a183479636.md)
