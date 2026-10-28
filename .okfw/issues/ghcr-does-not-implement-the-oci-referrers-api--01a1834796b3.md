---
id: "01a18347-96b3-7e3e-af34-cde99a452f43"
title: "GHCR does not implement the OCI referrers API"
type: "issue"
kind: "issue"
tags:
  - "issue"
  - "open"
  - "enhancement"
  - "registry"
  - "signing"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:10-05:00"
description: "GHCR returns 404 for the referrers endpoint, so attestations are tag-scheme artifacts that referrers-only tools cannot find."
resource: "https://infrashift.github.io/trusted-base-images/reference/known-limitations/"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:10-05:00"
---

# GHCR does not implement the OCI referrers API

## Description

GHCR returns `404` for `GET /v2/<name>/referrers/<digest>`. cosign falls back to tags named `sha256-<digest>.att` and `.sig`.

## Context

Verification still works: the signed in-toto subject names the exact digest. But a tool that reads only referrers sees an image with no attestations, and the tags clutter the tag list.

## Details

**Proposed Solution:** Re-test after each GHCR change and each cosign major upgrade. When GHCR returns `200`, attach with `--registry-referrers-mode oci-1-1` in `build.yml` and `release.yml`.

**Alternatives Considered:** Move to a registry with referrers support. Not planned.

## Acceptance Criteria

- [ ] The referrers query for a trusted image returns `200`.
- [ ] New attestations attach as referrers.

## Related

- [Evidence bundle and attestations](/architecture/evidence-bundle-and-attestations--01a1834795a0.md)
- [Plan: move to cosign v3 with all Infrashift repos](/plans/plan-move-to-cosign-v3-with-all-infrashift-repos--01a1834796a4.md)
- Public page: <https://infrashift.github.io/trusted-base-images/reference/known-limitations/>
