---
id: "01a18347-969d-790b-92ef-4264033e3605"
title: "Plan: enforce commit signatures"
type: "plan"
tags:
  - "planned"
  - "security"
  - "governance"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:10-05:00"
description: "Planned: enable the commented-out commit-signature rule in the PDP and check signers against an allowlist."
status: "draft"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:10-05:00"
---

# Plan: enforce commit signatures

## Goal

Deny a pull request that has an unsigned commit or a commit from an unknown signer.

## Scope

The `violation_signatures` rule in `policies.rego`.

## Steps

- [ ] Measure commit signature status in `scripts/repo-gate.sh`.
- [ ] Enable the rule and its tests.
- [ ] Add a signer allowlist.

## Risks

- Bot commits on `automation/*` branches are not signed.

## Done when

The repo gate denies an unsigned commit.

## Related

- [Policy decision point: CVE gate and repo gate](/architecture/policy-decision-point-cve-gate-and-repo-gate--01a18347959b.md)
- [Rules for AI agents](/standards/rules-for-ai-agents--01a183479630.md)
- [Roadmap](/plans/roadmap--01a183479672.md)
