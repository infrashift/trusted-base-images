---
id: "01a18347-96d2-7d67-8cec-b4efd61b4387"
title: "CODEOWNERS names a path that does not exist"
type: "issue"
kind: "issue"
tags:
  - "issue"
  - "open"
  - "chore"
  - "governance"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:10-05:00"
description: "CODEOWNERS lists .github/pdp/keys/, but the public keys are in .github/pdp/public-keys/."
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:10-05:00"
---

# CODEOWNERS names a path that does not exist

## Description

`.github/CODEOWNERS` has a line for `.github/pdp/keys/`. The directory is `.github/pdp/public-keys/`.

## Context

The `.github/pdp/` line covers the public keys, so ownership works. The dead line misleads readers.

## Details

**Proposed Solution:** Change the line to `.github/pdp/public-keys/` or remove it.

**Alternatives Considered:** None.

## Acceptance Criteria

- [ ] No CODEOWNERS line names a missing path.

## Related

- [Code owners protect the pipeline](/architecture/code-owners-protect-the-pipeline--01a1834795a5.md)
