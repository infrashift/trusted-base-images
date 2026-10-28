---
id: "01a18347-9657-7a28-b995-401a40da9abb"
title: "Decision: automation pushes a branch; a person opens the pull request"
type: "decision"
tags:
  - "governance"
  - "pipeline"
  - "security"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:10-05:00"
description: "Why workflows push automation/* branches but never open pull requests, and why that setting stays off."
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:10-05:00"
---

# Decision: automation pushes a branch; a person opens the pull request

**Date:** 2026-08-18

## Context

Branch protection guards `main`. GitHub can let Actions create and approve pull requests. The same setting lets any workflow satisfy a required approval.

## Decision

Keep "Allow GitHub Actions to create and approve pull requests" disabled. A workflow pushes an `automation/*` branch and links to it. A person opens the pull request.

## Consequences

- [Update Documentation Inventory (doc-release.yml)](/pipeline/update-documentation-inventory-doc-release-yml--01a1834795c9.md) and [Upstream Drift Check (upstream-drift.yml)](/pipeline/upstream-drift-check-upstream-drift-yml--01a1834795d4.md) need a person after each run.
- Inventory can go stale when nobody opens the pull request. This happened from #19 to #29.

## Alternatives

- Enable the setting. Rejected: it weakens required reviews.
- Use a GitHub App token. Not chosen yet.

## Related

- [Runbook: open and merge the docs-inventory pull request](/runbooks/runbook-open-and-merge-the-docs-inventory-pull-request--01a1834796fa.md)
- [Runbook: refresh a drifted upstream base](/runbooks/runbook-refresh-a-drifted-upstream-base--01a1834796ea.md)
- [Decision log](/decisions/decision-log--01a183479636.md)
