---
id: "01a18347-966b-7deb-bb18-514c3aa70165"
title: "Decision: use an OKF wiki for project knowledge"
type: "decision"
tags:
  - "wiki"
  - "agents"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:10-05:00"
description: "Why plans, issues, decisions and runbooks live in .okfw/ and why the .ai/ directory was removed."
sources:
  - resource: "https://github.com/infrashift/trusted-base-images/blob/ea1e21e/.ai/PRD.md"
    title: "Original PRD (.ai/PRD.md, removed)"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:10-05:00"
---

# Decision: use an OKF wiki for project knowledge

**Date:** 2026-10-28

## Context

Knowledge was in `.ai/PRD.md`, 14 rule cards in `.ai/skills/`, the public site and code comments. The PRD and several cards named files that do not exist.

## Decision

Keep project knowledge in an OKF wiki in `.okfw/`, managed with `okfw`. Move the `.ai/` content into the wiki, correct it against the code, and remove `.ai/`. Write all wiki text in Simplified Technical English.

## Consequences

- Humans and agents use one source, through `okfw` or its MCP server.
- The public site stays the place for user guides.

## Alternatives

- Keep `.ai/` and link to it. Rejected: two sources drift apart.

## Related

- [Trusted Base Images wiki overview](/trusted-base-images-wiki-overview--01a18347956d.md)
- [Writing standard: Simplified Technical English](/reference/writing-standard-simplified-technical-english--01a183479571.md)
- [Wiki conventions: types, tags and body shapes](/reference/wiki-conventions-types-tags-and-body-shapes--01a18347957a.md)
- [Decision log](/decisions/decision-log--01a183479636.md)
