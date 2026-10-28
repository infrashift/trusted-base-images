---
id: "01a18347-9630-7621-a8cc-64d1bee361ca"
title: "Rules for AI agents"
type: "standard"
tags:
  - "agents"
  - "governance"
  - "security"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:10-05:00"
description: "What an AI agent may and may not do in this repo: signing limits, pin changes, scan targets, commits and the wiki."
sources:
  - resource: "https://github.com/infrashift/trusted-base-images/blob/ea1e21e/.ai/PRD.md"
    title: "Original PRD (.ai/PRD.md, removed)"
  - resource: "https://github.com/infrashift/trusted-base-images/blob/ea1e21e/.ai/skills/bot-proposal.md"
    title: "Rule card .ai/skills/bot-proposal.md (removed)"
  - resource: "https://github.com/infrashift/trusted-base-images/blob/ea1e21e/.ai/skills/sovereign-approval.md"
    title: "Rule card .ai/skills/sovereign-approval.md (removed)"
  - resource: "https://github.com/infrashift/trusted-base-images/blob/ea1e21e/.ai/skills/policy-compliance.md"
    title: "Rule card .ai/skills/policy-compliance.md (removed)"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:10-05:00"
---

# Rules for AI agents

## Rules

1. Do not sign as the Release Actor. Do not use or ask for an actor key. Only the workflows sign.
2. To update an upstream base, change `versions.json` only. See [versions.json pin model](/images/versions-json-pin-model--01a1834795df.md).
3. When you add an image, add its `versions.json` entry and its Containerfile in the same change. See [Runbook: add a new image](/runbooks/runbook-add-a-new-image--01a18347971a.md).
4. Scan a local copy of the pushed image. Do not scan through a `registry:` reference in the build. See [Decision: scan a local copy of the pushed image](/decisions/decision-scan-a-local-copy-of-the-pushed-image--01a18347964a.md).
5. Do not add a secret, a token or a placeholder such as `REPLACE_ME`. See [Secrets and keys never enter the repository](/standards/secrets-and-keys-never-enter-the-repository--01a183479629.md).
6. Do not try to bypass the PDP. If a gate fails, fix the cause or explain an exception in the pull request.
7. Sign each commit. If you cannot sign, tell the user before you push.
8. Explain any change to `.github/pdp/` in the pull request.
9. Search this wiki before you explain a design. Record new plans, issues and decisions here. See [Runbook: record a plan, issue or decision](/reference/runbook-record-a-plan-issue-or-decision--01a18347957f.md).

## Why

The pipeline is the trust boundary. An agent works inside it, not around it.

## Related

- [Three-actor governance: Build, Review, Release](/architecture/three-actor-governance-build-review-release--01a183479588.md)
- [GitHub Actions standard](/standards/github-actions-standard--01a18347961c.md)
