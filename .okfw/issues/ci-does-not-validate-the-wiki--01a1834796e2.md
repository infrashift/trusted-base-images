---
id: "01a18347-96e2-767e-9a49-d0c07ad00430"
title: "CI does not validate the wiki"
type: "issue"
kind: "issue"
tags:
  - "issue"
  - "open"
  - "enhancement"
  - "wiki"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:10-05:00"
description: "No workflow runs okfw validate, so a broken concept or a broken link can merge."
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:10-05:00"
---

# CI does not validate the wiki

## Description

No workflow runs `okfw validate`. A person or agent must run it before a commit.

## Context

The wiki is part of the repo. Broken frontmatter or links reduce trust in it.

## Details

**Proposed Solution:** See [Plan: validate the wiki in CI](/plans/plan-validate-the-wiki-in-ci--01a1834796ac.md).

**Alternatives Considered:** A pre-commit hook. Not chosen: it runs only on machines that install it.

## Acceptance Criteria

- [ ] The PR gate runs `okfw validate --all` and `okfw validate --okf`.

## Related

- [Plan: validate the wiki in CI](/plans/plan-validate-the-wiki-in-ci--01a1834796ac.md)
