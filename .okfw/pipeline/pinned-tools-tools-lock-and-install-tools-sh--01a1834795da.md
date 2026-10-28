---
id: "01a18347-95da-71bf-af64-956306dcbd42"
title: "Pinned tools: tools.lock and install-tools.sh"
type: "pipeline"
tags:
  - "pipeline"
  - "security"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:09-05:00"
description: "How the pipeline installs cosign, syft, grype, OPA and gitleaks at pinned versions with checksums."
resource: "https://github.com/infrashift/trusted-base-images/blob/main/tools.lock"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:09-05:00"
---

# Pinned tools: tools.lock and install-tools.sh

## Versions

`tools.lock` pins:

| Tool | Version |
|---|---|
| cosign | v2.6.1 |
| syft | v1.51.0 |
| grype | v0.117.0 |
| OPA | v1.19.1 |
| gitleaks | v8.30.1 |

## Install

`scripts/install-tools.sh <tool>...` downloads each tool at its pinned version. It verifies the checksum for each version and architecture. A version without a checksum fails by name.

## Why

These tools run in the same job as an actor key. A download from a mutable reference is a path to code execution in that job. Before `tools.lock`, `build.yml` piped an install script from a `main` branch into `sh`.

## Rules

1. Do not install a tool from a `latest` URL or a mutable reference.
2. When you change a version, change its checksum in `install-tools.sh` too.
3. The repo gate denies an unpinned tool. See [Policy decision point: CVE gate and repo gate](/architecture/policy-decision-point-cve-gate-and-repo-gate--01a18347959b.md).

## Related

- [Decision: stay on cosign v2 until the org moves to v3](/decisions/decision-stay-on-cosign-v2-until-the-org-moves-to-v3--01a18347965e.md)
- [Runbook: install the pinned pipeline tools](/runbooks/runbook-install-the-pinned-pipeline-tools--01a183479712.md)
