---
id: "01a18347-9696-7687-8e26-bf341f3e88b7"
title: "Plan: replace OPA with the GARMR policy agent"
type: "plan"
tags:
  - "planned"
  - "security"
  - "cve"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:10-05:00"
description: "Planned: move the PDP from OPA and Rego to the GARMR policy agent at the Review Actor's enforcement point."
status: "draft"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:10-05:00"
---

# Plan: replace OPA with the GARMR policy agent

## Goal

Evaluate SBOM, CVE, provenance and attestation policy in one supply-chain-native engine.

## Scope

The image-scope rules evaluated by [Review Attestations (review.yml): the Review Actor](/pipeline/review-attestations-review-yml-the-review-actor--01a1834795b9.md). The repo gate can move later.

## Steps

- [ ] Translate the CVE gate rules to GARMR.
- [ ] Keep fail-closed behavior. See [Decision: every gate fails closed](/decisions/decision-every-gate-fails-closed--01a183479664.md).
- [ ] Run both engines and compare verdicts.
- [ ] Switch the Review Actor to GARMR.

## Risks

- A verdict changes during the move without notice.

## Done when

The Review Actor uses GARMR and all policy tests pass.

## Related

- [Policy decision point: CVE gate and repo gate](/architecture/policy-decision-point-cve-gate-and-repo-gate--01a18347959b.md)
- Public page: <https://infrashift.github.io/trusted-base-images/security/pdp-strategy/>
- [Roadmap](/plans/roadmap--01a183479672.md)
