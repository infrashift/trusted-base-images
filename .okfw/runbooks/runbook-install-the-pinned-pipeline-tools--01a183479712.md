---
id: "01a18347-9712-7ce9-88dc-73509455e830"
title: "Runbook: install the pinned pipeline tools"
type: "runbook"
tags:
  - "pipeline"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:10-05:00"
description: "How to install cosign, syft, grype, OPA and gitleaks locally at the versions in tools.lock."
resource: "https://github.com/infrashift/trusted-base-images/blob/main/scripts/install-tools.sh"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:10-05:00"
---

# Runbook: install the pinned pipeline tools

## Goal

Run the same tool versions as CI on your machine.

## Prerequisites

- Linux on amd64 or arm64.
- `curl` and `sha256sum` are installed.

## Steps

1. Install the tools you need.

   ```sh
   scripts/install-tools.sh opa syft grype gitleaks
   ```

2. Run the repo gate locally before you open a pull request.

   ```sh
   scripts/repo-gate.sh
   ```

## Verify

- Each tool prints the version in `tools.lock`.
- `repo-decision.json` shows `allow: true`.

## Related

- [Pinned tools: tools.lock and install-tools.sh](/pipeline/pinned-tools-tools-lock-and-install-tools-sh--01a1834795da.md)
- [Policy decision point: CVE gate and repo gate](/architecture/policy-decision-point-cve-gate-and-repo-gate--01a18347959b.md)
