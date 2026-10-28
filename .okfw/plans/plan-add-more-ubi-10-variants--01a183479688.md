---
id: "01a18347-9688-7148-8a7a-1341b267838d"
title: "Plan: add more UBI 10 variants"
type: "plan"
tags:
  - "planned"
  - "ubi10"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:10-05:00"
description: "Planned: add UBI 10 standard, micro and init images when Red Hat publishes them, and possibly runtime images."
status: "draft"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:10-05:00"
---

# Plan: add more UBI 10 variants

## Goal

Give UBI 10 the same variant set as UBI 9.

## Scope

UBI 10 standard, micro and init. Later, maybe RHEL-based Node.js, Python or Java runtime images.

## Steps

- [ ] Check which UBI 10 variants upstream publishes for amd64 and arm64.
- [ ] Add each one with [Runbook: add a new image](/runbooks/runbook-add-a-new-image--01a18347971a.md).

## Risks

- Upstream does not publish arm64 for a variant.

## Done when

Each available UBI 10 variant is in the trusted namespace.

## Related

- [Image: ubi10-minimal](/images/image-ubi10-minimal--01a1834795fc.md)
- [Roadmap](/plans/roadmap--01a183479672.md)
