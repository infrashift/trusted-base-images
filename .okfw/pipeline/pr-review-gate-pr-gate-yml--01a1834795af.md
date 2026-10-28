---
id: "01a18347-95af-72a6-a500-86aba7b12c01"
title: "PR Review Gate (pr-gate.yml)"
type: "pipeline"
tags:
  - "pipeline"
  - "security"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:09-05:00"
description: "The gate that runs on every pull request: the repo gate, workflow lint, policy tests, and the seed of the review/cve-policy status."
resource: "https://github.com/infrashift/trusted-base-images/blob/main/.github/workflows/pr-gate.yml"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:09-05:00"
---

# PR Review Gate (pr-gate.yml)

## Trigger

Every pull request to `main`. It has no path filter on purpose. A required check that never reports blocks a pull request forever.

## Jobs

**repo-gate**

1. Installs the pinned tools. See [Pinned tools: tools.lock and install-tools.sh](/pipeline/pinned-tools-tools-lock-and-install-tools-sh--01a1834795da.md).
2. Guards `.gitleaks.toml`.
3. Runs `scripts/check-no-orphan-rego.sh`: one policy file only.
4. Runs `scripts/lint-workflows.sh`. See [GitHub Actions standard](/standards/github-actions-standard--01a18347961c.md).
5. Lints shell scripts.
6. Runs the policy tests.
7. Runs `scripts/repo-gate.sh` and evaluates `data.tbi.pdp.repo_decision`. See [Policy decision point: CVE gate and repo gate](/architecture/policy-decision-point-cve-gate-and-repo-gate--01a18347959b.md).

**seed**

Sets the `review/cve-policy` commit status. If the pull request changes image paths, the status is `pending` and [Review Attestations (review.yml): the Review Actor](/pipeline/review-attestations-review-yml-the-review-actor--01a1834795b9.md) sets the result. If not, the status is `success`.

## Rule

The status context string must be the same in this workflow and in `review.yml`.

## Related

- [Workflow chain from pull request to release](/pipeline/workflow-chain-from-pull-request-to-release--01a1834795aa.md)
