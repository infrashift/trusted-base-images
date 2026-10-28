---
id: "01a18347-9681-7212-a03d-c10823bcc2ac"
title: "Plan: generate inventory pages from versions.json"
type: "plan"
tags:
  - "planned"
  - "docs"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:10-05:00"
description: "Planned: generate the per-image inventory MDX pages from versions.json instead of writing them by hand."
status: "draft"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:10-05:00"
---

# Plan: generate inventory pages from versions.json

## Goal

Add an image without writing its inventory page by hand.

## Scope

`docs/src/content/docs/inventory/*.mdx` and the image pages.

## Steps

- [ ] Write a generator that reads `versions.json`.
- [ ] Run it in [Update Documentation Inventory (doc-release.yml)](/pipeline/update-documentation-inventory-doc-release-yml--01a1834795c9.md) or in the docs build.
- [ ] Remove the hand-written pages.

## Risks

- The generated pages differ from the current component structure.

## Done when

A new `versions.json` entry makes its inventory page with no manual step.

## Related

- [Runbook: add a new image](/runbooks/runbook-add-a-new-image--01a18347971a.md)
- [Update Documentation Inventory (doc-release.yml)](/pipeline/update-documentation-inventory-doc-release-yml--01a1834795c9.md)
- [Roadmap](/plans/roadmap--01a183479672.md)
