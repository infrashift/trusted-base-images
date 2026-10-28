---
id: "01a18347-96cb-721c-89b2-7e5e840bd3a6"
title: "The pdp-gate composite action calls a script that does not exist"
type: "issue"
kind: "issue"
tags:
  - "issue"
  - "open"
  - "bug"
  - "pipeline"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:10-05:00"
description: "The composite action .github/actions/pdp-gate runs scripts/run-gatekeeper.sh, which does not exist, and no workflow uses the action."
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:10-05:00"
---

# The pdp-gate composite action calls a script that does not exist

## Description

`.github/actions/pdp-gate/action.yml` runs `scripts/run-gatekeeper.sh`. That file does not exist. No workflow uses the action.

## Context

[PR Review Gate (pr-gate.yml)](/pipeline/pr-review-gate-pr-gate-yml--01a1834795af.md) does this job now with `scripts/repo-gate.sh`.

## Details

**Proposed Solution:** Delete `.github/actions/pdp-gate/`.

**Alternatives Considered:** Point the action at `repo-gate.sh`. Rejected: nothing uses it.

## Acceptance Criteria

- [ ] The action is gone, or a workflow uses it and it works.

## Related

- [GitHub Actions standard](/standards/github-actions-standard--01a18347961c.md)
- [Policy decision point: CVE gate and repo gate](/architecture/policy-decision-point-cve-gate-and-repo-gate--01a18347959b.md)
