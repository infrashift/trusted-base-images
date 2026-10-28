---
id: "01a18347-9644-70d9-987d-c0c78273169f"
title: "Decision: pin one upstream digest per architecture"
type: "decision"
tags:
  - "registry"
  - "security"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:10-05:00"
description: "Why versions.json pins a separate upstream digest for amd64 and for arm64, not one multi-arch index digest."
resource: "https://infrashift.github.io/trusted-base-images/security/digest-pinning/"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:10-05:00"
---

# Decision: pin one upstream digest per architecture

**Date:** 2026-02-16

## Context

An upstream tag points to a multi-arch index. The index can change while one architecture stays the same. A single index digest hides which architecture changed.

## Decision

Pin the platform-specific digest for each architecture in `versions.json`.

## Consequences

- The build of each triple is reproducible.
- [CI Build & Audit (build.yml): the Build Actor](/pipeline/ci-build-audit-build-yml-the-build-actor--01a1834795b4.md) rebuilds only the triples whose pin changed.
- A refresh must update both digests. See [Runbook: refresh a drifted upstream base](/runbooks/runbook-refresh-a-drifted-upstream-base--01a1834796ea.md).

## Alternatives

- Pin the index digest. Rejected: it rebuilds all architectures for any change.

## Related

- [versions.json pin model](/images/versions-json-pin-model--01a1834795df.md)
- Public page: <https://infrashift.github.io/trusted-base-images/security/digest-pinning/>
- [Decision log](/decisions/decision-log--01a183479636.md)
