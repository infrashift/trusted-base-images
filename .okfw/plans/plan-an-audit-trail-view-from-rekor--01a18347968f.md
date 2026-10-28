---
id: "01a18347-968f-72b5-9bb2-d293f2b18754"
title: "Plan: an audit trail view from Rekor"
type: "plan"
tags:
  - "planned"
  - "signing"
  - "docs"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:10-05:00"
description: "Planned: show the signing timeline and governance chain of each image from its Rekor transparency log entries."
status: "draft"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:10-05:00"
---

# Plan: an audit trail view from Rekor

## Goal

Let a consumer see the full build, review and release chain of an image.

## Scope

A page on the public site, linked from each inventory page.

## Steps

- [ ] Query Rekor for the entries of each image.
- [ ] Show the signing timeline for each image.
- [ ] Link the view from the inventory pages.

## Risks

- Only the release signatures are keyless. Build and review signatures are not in Rekor.

## Done when

Each inventory page links to an audit trail for its image.

## Related

- [Signing chain and actor keys](/architecture/signing-chain-and-actor-keys--01a18347958c.md)
- [Roadmap](/plans/roadmap--01a183479672.md)
