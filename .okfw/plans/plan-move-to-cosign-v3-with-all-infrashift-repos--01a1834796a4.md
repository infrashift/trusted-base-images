---
id: "01a18347-96a4-7cdf-8f31-599e86dd0037"
title: "Plan: move to cosign v3 with all Infrashift repos"
type: "plan"
tags:
  - "planned"
  - "signing"
  - "pipeline"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:10-05:00"
description: "Planned: move every Infrashift repo from cosign v2 to v3 at the same time, including how attestations are read back."
status: "draft"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:10-05:00"
---

# Plan: move to cosign v3 with all Infrashift repos

## Goal

Use a supported cosign major version without breaking verification.

## Scope

`tools.lock`, `build.yml`, `review.yml`, `release.yml` and the same files in the other Infrashift repos.

## Steps

- [ ] List each repo and step that reads `sha256-<digest>.att` tags.
- [ ] Decide the referrers mode. GHCR has no referrers API. See [GHCR does not implement the OCI referrers API](/issues/ghcr-does-not-implement-the-oci-referrers-api--01a1834796b3.md).
- [ ] Change all repos in one coordinated change.

## Risks

- A downstream consumer cannot verify an image during the move.

## Done when

All repos use cosign v3 and verification passes for old and new images.

## Related

- [Decision: stay on cosign v2 until the org moves to v3](/decisions/decision-stay-on-cosign-v2-until-the-org-moves-to-v3--01a18347965e.md)
- [Pinned tools: tools.lock and install-tools.sh](/pipeline/pinned-tools-tools-lock-and-install-tools-sh--01a1834795da.md)
- [Roadmap](/plans/roadmap--01a183479672.md)
