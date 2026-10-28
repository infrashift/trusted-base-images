---
id: "01a18347-96bb-7b7e-99e5-9921cce68d8a"
title: "Five old branches remain on the remote"
type: "issue"
kind: "issue"
tags:
  - "issue"
  - "open"
  - "chore"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:10-05:00"
description: "Five feature and trigger branches from February to August 2026 remain on origin; four are fully merged and one has an unmerged commit."
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:10-05:00"
---

# Five old branches remain on the remote

## Description

| Branch | Commits not in main | Last commit |
|---|---|---|
| `feat/sign-arch-digests` | 1 | 2026-08-18 "feat: sign each arch image, not just the manifest list" |
| `feature/relax-cve-policy-fixable-only` | 0 | 2026-08-17 |
| `feature/version-up-all-containers` | 0 | 2026-08-17 |
| `build/fresh-images-20260216` | 0 | 2026-02-16 |
| `trigger/fedora43-build` | 0 | 2026-03-03 |

## Context

Old branches make it hard to see the open work. One branch has a change that may still matter.

## Details

**Proposed Solution:** Delete the four merged branches. Review `feat/sign-arch-digests`: open a pull request or record why it is not needed, then delete it.

**Alternatives Considered:** Keep them. Rejected: no value.

## Acceptance Criteria

- [ ] The four merged branches are deleted.
- [ ] `feat/sign-arch-digests` has a decision.

## Related

- [Signing chain and actor keys](/architecture/signing-chain-and-actor-keys--01a18347958c.md)
