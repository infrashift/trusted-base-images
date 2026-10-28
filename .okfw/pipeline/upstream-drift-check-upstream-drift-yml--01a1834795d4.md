---
id: "01a18347-95d4-7863-8226-b10881c6f370"
title: "Upstream Drift Check (upstream-drift.yml)"
type: "pipeline"
tags:
  - "pipeline"
  - "cve"
  - "registry"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:09-05:00"
description: "The daily workflow that compares each pin with its upstream tag, scans both, and proposes a refresh branch."
resource: "https://github.com/infrashift/trusted-base-images/blob/main/.github/workflows/upstream-drift.yml"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:09-05:00"
---

# Upstream Drift Check (upstream-drift.yml)

## Trigger

- Daily at 07:23 UTC.
- Manual: `workflow_dispatch`.

## Jobs

**detect** runs `scripts/check-upstream-drift.sh`. It compares each pin in `versions.json` with the digest that the upstream tag serves now.

**scan** runs grype on the pinned and the upstream amd64 image. So the report shows if a refresh clears findings.

**publish**:

1. If there is drift, it writes the new `versions.json` to branch `automation/upstream-refresh`. It pushes only if the proposal changed.
2. It keeps one GitHub issue, "Upstream base image drift", current. It closes the issue when no drift and no blocking finding remain.

## Limit

It cannot open the pull request. See [Decision: automation pushes a branch; a person opens the pull request](/decisions/decision-automation-pushes-a-branch-a-person-opens-the-pull-request--01a183479657.md). A person opens it. See [Runbook: refresh a drifted upstream base](/runbooks/runbook-refresh-a-drifted-upstream-base--01a1834796ea.md).

## Related

- [versions.json pin model](/images/versions-json-pin-model--01a1834795df.md)
- [Plan: trigger a rescan when a new CVE affects an image](/plans/plan-trigger-a-rescan-when-a-new-cve-affects-an-image--01a18347967a.md)
