---
id: "01a18347-96ac-732d-93a0-f8846747bc79"
title: "Plan: validate the wiki in CI"
type: "plan"
tags:
  - "planned"
  - "wiki"
  - "pipeline"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:10-05:00"
description: "Planned: run okfw validate in the PR gate so a broken concept or link fails the pull request."
status: "draft"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:10-05:00"
---

# Plan: validate the wiki in CI

## Goal

Keep the wiki valid without a manual check.

## Scope

A step in [PR Review Gate (pr-gate.yml)](/pipeline/pr-review-gate-pr-gate-yml--01a1834795af.md) for pull requests that change `.okfw/**`.

## Steps

- [ ] Add okfw to `tools.lock` with a checksum.
- [ ] Install it with `scripts/install-tools.sh`.
- [ ] Run `okfw validate --all` and `okfw validate --okf`.

## Risks

- The gate must still report on every pull request. Do not add a path filter. See [GitHub Actions standard](/standards/github-actions-standard--01a18347961c.md).

## Done when

A pull request with an invalid concept fails the PR gate.

## Related

- [CI does not validate the wiki](/issues/ci-does-not-validate-the-wiki--01a1834796e2.md)
- [Pinned tools: tools.lock and install-tools.sh](/pipeline/pinned-tools-tools-lock-and-install-tools-sh--01a1834795da.md)
- [Roadmap](/plans/roadmap--01a183479672.md)
