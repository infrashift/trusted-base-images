---
id: "01a18347-961c-7c62-afc5-b846f7581915"
title: "GitHub Actions standard"
type: "standard"
tags:
  - "pipeline"
  - "security"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:10-05:00"
description: "The rules that every workflow must obey: least privilege per job, actions pinned by SHA, pinned tools, and gates that always report."
resource: "https://github.com/infrashift/trusted-base-images/blob/main/scripts/lint-workflows.sh"
sources:
  - resource: "https://github.com/infrashift/trusted-base-images/blob/ea1e21e/.ai/skills/github-actions-standard.md"
    title: "Rule card .ai/skills/github-actions-standard.md (removed)"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:10-05:00"
---

# GitHub Actions standard

## Rules

1. Start each workflow with `permissions: {}`. Give each job only the scopes it needs.
2. Pin each action to a full commit SHA. Add the version as a comment, for example `# v4`.
3. Install tools only through `scripts/install-tools.sh`. See [Pinned tools: tools.lock and install-tools.sh](/pipeline/pinned-tools-tools-lock-and-install-tools-sh--01a1834795da.md).
4. A job that signs must state its `environment:`. See [GitHub Environments isolate the actor keys](/architecture/github-environments-isolate-the-actor-keys--01a183479591.md).
5. Do not put a path filter on a workflow that gives a required check. See [PR Review Gate (pr-gate.yml)](/pipeline/pr-review-gate-pr-gate-yml--01a1834795af.md).
6. Do not put `${{ }}` expressions from untrusted input directly in `run:`. Pass them through `env:`.

## How it is enforced

- `scripts/lint-workflows.sh` checks rules 1, 2 and the path predicates. [PR Review Gate (pr-gate.yml)](/pipeline/pr-review-gate-pr-gate-yml--01a1834795af.md) runs it.
- The repo gate denies an unpinned action. See [Policy decision point: CVE gate and repo gate](/architecture/policy-decision-point-cve-gate-and-repo-gate--01a18347959b.md).
- Code owners review each workflow change. See [Code owners protect the pipeline](/architecture/code-owners-protect-the-pipeline--01a1834795a5.md).

## Note

The earlier rule card said all logic lives in `.github/actions/`. That is not true now. The only composite action is not used. See [The pdp-gate composite action calls a script that does not exist](/issues/the-pdp-gate-composite-action-calls-a-script-that-does-not-exist--01a1834796cb.md).
