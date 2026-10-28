---
id: "01a18347-96da-78d2-93bb-5f059fbabcea"
title: "SETUP-ENVIRONMENTS.md does not match the real setup"
type: "issue"
kind: "issue"
tags:
  - "issue"
  - "open"
  - "chore"
  - "governance"
  - "docs"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:10-05:00"
description: "The setup document uses @your-org placeholders and does not agree with the rule cards about which GitHub Environment needs required reviewers."
resource: "https://github.com/infrashift/trusted-base-images/blob/main/SETUP-ENVIRONMENTS.md"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:10-05:00"
---

# SETUP-ENVIRONMENTS.md does not match the real setup

## Description

`SETUP-ENVIRONMENTS.md` uses `@your-org` placeholders. It says the `Review-Actor` environment has required reviewers and `Release-Actor` is limited to `main`. The old release-governance card said `Release-Actor` must have required reviewers.

## Context

Nobody has recorded the real protection rules of each GitHub Environment. A person must read them in the repository settings.

## Details

**Proposed Solution:** Read the settings. Record them in [Runbook: set up GitHub Environments and actor keys](/runbooks/runbook-set-up-github-environments-and-actor-keys--01a18347970a.md). Update or replace `SETUP-ENVIRONMENTS.md`.

**Alternatives Considered:** None.

## Acceptance Criteria

- [ ] The protection rules of each GitHub Environment are recorded.
- [ ] The setup document has no placeholders.

## Related

- [GitHub Environments isolate the actor keys](/architecture/github-environments-isolate-the-actor-keys--01a183479591.md)
- [Runbook: set up GitHub Environments and actor keys](/runbooks/runbook-set-up-github-environments-and-actor-keys--01a18347970a.md)
