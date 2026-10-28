---
id: "01a18347-965e-7562-8c90-f4ff7361fe13"
title: "Decision: stay on cosign v2 until the org moves to v3"
type: "decision"
tags:
  - "signing"
  - "pipeline"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:10-05:00"
description: "Why tools.lock pins cosign v2.6.1 and why the move to v3 must happen in all repos at once."
resource: "https://github.com/infrashift/trusted-base-images/blob/main/tools.lock"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:10-05:00"
---

# Decision: stay on cosign v2 until the org moves to v3

**Date:** 2026-08-24

## Context

cosign v3 writes attestations as OCI referrers by default. `review.yml` and `release.yml` read the v2 `sha256-<digest>.att` tag layout. The installer had no version pin, so it installed v3.

## Decision

Pin cosign v2.6.1 in `tools.lock`. Move all Infrashift repos to v3 together.

## Consequences

- Verification keeps working.
- The move to v3 is a planned cross-repo task. See [Plan: move to cosign v3 with all Infrashift repos](/plans/plan-move-to-cosign-v3-with-all-infrashift-repos--01a1834796a4.md).

## Alternatives

- Move this repo alone. Rejected: downstream verification would break.

## Related

- [Pinned tools: tools.lock and install-tools.sh](/pipeline/pinned-tools-tools-lock-and-install-tools-sh--01a1834795da.md)
- [GHCR does not implement the OCI referrers API](/issues/ghcr-does-not-implement-the-oci-referrers-api--01a1834796b3.md)
- [Decision log](/decisions/decision-log--01a183479636.md)
