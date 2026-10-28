---
id: "01a18347-96c3-765c-b8b4-859507781208"
title: "Four scripts are not used by any workflow"
type: "issue"
kind: "issue"
tags:
  - "issue"
  - "open"
  - "chore"
  - "pipeline"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:10-05:00"
description: "bot-propose-approval.sh, verify-and-sign.sh, verify-multi-sig.sh and execute-release.sh come from the first design and no workflow runs them."
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:10-05:00"
---

# Four scripts are not used by any workflow

## Description

No workflow calls `scripts/bot-propose-approval.sh`, `scripts/verify-and-sign.sh`, `scripts/verify-multi-sig.sh` or `scripts/execute-release.sh`. Some read `.github/pdp/keys/`, which does not exist.

## Context

`bot-propose-approval.sh` wrote `"gitleaks_passed": true` as a literal. The repo gate exists to prevent that. Unused scripts mislead readers and agents.

## Details

**Proposed Solution:** Delete the four scripts. Check that no doc names them.

**Alternatives Considered:** Keep them as history. Rejected: git history keeps them.

## Acceptance Criteria

- [ ] The four scripts are gone.
- [ ] `grep -r` finds no reference to them.

## Related

- [Policy decision point: CVE gate and repo gate](/architecture/policy-decision-point-cve-gate-and-repo-gate--01a18347959b.md)
- [Workflow chain from pull request to release](/pipeline/workflow-chain-from-pull-request-to-release--01a1834795aa.md)
