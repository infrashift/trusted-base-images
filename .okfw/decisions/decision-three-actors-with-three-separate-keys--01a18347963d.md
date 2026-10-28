---
id: "01a18347-963d-77f4-8264-136b72addec7"
title: "Decision: three actors with three separate keys"
type: "decision"
tags:
  - "governance"
  - "signing"
  - "security"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:10-05:00"
description: "Why each of the Build, Review and Release Actors has its own cosign key in its own GitHub Environment."
sources:
  - resource: "https://github.com/infrashift/trusted-base-images/blob/ea1e21e/.ai/PRD.md"
    title: "Original PRD (.ai/PRD.md, removed)"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:10-05:00"
---

# Decision: three actors with three separate keys

**Date:** 2026-02-16

## Context

One key for the whole pipeline lets one compromised job sign and release an image alone.

## Decision

Use three actors. Give each one its own cosign key in its own GitHub Environment. The Release Actor verifies the other two signatures before it promotes.

## Consequences

- An attacker must compromise three jobs to release a bad image.
- Setup needs three key pairs and three GitHub Environments. See [Runbook: set up GitHub Environments and actor keys](/runbooks/runbook-set-up-github-environments-and-actor-keys--01a18347970a.md).

## Alternatives

- One key for all jobs. Rejected: no separation of duty.
- Keyless signing only. Rejected: it shows which workflow signed, not which role.

## Related

- [Three-actor governance: Build, Review, Release](/architecture/three-actor-governance-build-review-release--01a183479588.md)
- [GitHub Environments isolate the actor keys](/architecture/github-environments-isolate-the-actor-keys--01a183479591.md)
- [Decision log](/decisions/decision-log--01a183479636.md)
