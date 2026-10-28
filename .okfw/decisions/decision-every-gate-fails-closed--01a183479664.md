---
id: "01a18347-9664-7f38-a240-7021d4650d1b"
title: "Decision: every gate fails closed"
type: "decision"
tags:
  - "security"
  - "cve"
  - "governance"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:10-05:00"
description: "Why each PDP rule and each review leg denies when its input is missing, malformed or absent."
resource: "https://github.com/infrashift/trusted-base-images/blob/main/.github/pdp/policies.rego"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:10-05:00"
---

# Decision: every gate fails closed

**Date:** 2026-10-13

## Context

A Rego rule like `count > 0` is undefined when the field is missing. An undefined rule does not fire, so a missing input passed the gate. A test found this for the secret rule.

## Decision

Each rule denies when its input is missing or has the wrong type. A review leg that leaves no verdict fails the `review/cve-policy` status. OPA is pinned.

## Consequences

- A broken scanner or a broken step cannot pass an image.
- A gate can fail for a pipeline fault, not only for a real finding.

## Alternatives

- Trust each tool to report. Rejected: an empty report from a tool that did not run looks like a clean report.

## Related

- [Policy decision point: CVE gate and repo gate](/architecture/policy-decision-point-cve-gate-and-repo-gate--01a18347959b.md)
- [Review Attestations (review.yml): the Review Actor](/pipeline/review-attestations-review-yml-the-review-actor--01a1834795b9.md)
- [Decision log](/decisions/decision-log--01a183479636.md)
