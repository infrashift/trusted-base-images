---
id: "01a18347-956d-78bd-b4a2-8b34e7a46d67"
title: "Trusted Base Images wiki overview"
type: "hub"
tags:
  - "hub"
  - "wiki"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:09-05:00"
description: "Start here: what the project is, the bundles in this wiki, and the order to read them."
resource: "https://github.com/infrashift/trusted-base-images/blob/main/README.md"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:09-05:00"
---

# Trusted Base Images wiki overview

Trusted Base Images builds six container base images from pinned upstream bases. Every image needs three signatures before release: Build Actor, Review Actor and Release Actor. Consumers pull only from the trusted namespace.

This wiki holds what the code does not say. It records why the system works this way, what we plan, what is broken, and how to do each task. The public site holds user guides. The wiki links to the site and does not copy it.

## How to read this wiki

1. Read this page.
2. Open the `index.md` of the bundle you need. Each line gives one concept and one sentence. Over MCP, use `okfw_read {"ref":"<bundle>/"}`.
3. Open one concept. Follow its links only when you need more.
4. Go to the source files or the public site last.

Search first: `okfw search "<words>"`. Write with [Writing standard: Simplified Technical English](/reference/writing-standard-simplified-technical-english--01a183479571.md) and the terms in [Glossary: approved terms](/reference/glossary-approved-terms--01a183479576.md).

## Map

| Bundle | Holds | Start with |
|---|---|---|
| [reference/](/reference/index.md) | How to read and write this wiki | [Wiki conventions: types, tags and body shapes](/reference/wiki-conventions-types-tags-and-body-shapes--01a18347957a.md) |
| [architecture/](/architecture/index.md) | How the system works and why | [System overview and principles](/architecture/system-overview-and-principles--01a183479583.md) |
| [pipeline/](/pipeline/index.md) | Each workflow and what it does | [Workflow chain from pull request to release](/pipeline/workflow-chain-from-pull-request-to-release--01a1834795aa.md) |
| [images/](/images/index.md) | Each image and the pin model | [versions.json pin model](/images/versions-json-pin-model--01a1834795df.md) |
| [standards/](/standards/index.md) | Rules that every change must obey | [Rules for AI agents](/standards/rules-for-ai-agents--01a183479630.md) |
| [decisions/](/decisions/index.md) | Why we made each choice | [Decision log](/decisions/decision-log--01a183479636.md) |
| [plans/](/plans/index.md) | Work we intend to do | [Roadmap](/plans/roadmap--01a183479672.md) |
| [issues/](/issues/index.md) | Known problems and open work | `okfw search --kind issue --tag open` |
| [runbooks/](/runbooks/index.md) | Step-by-step tasks | [Runbook: refresh a drifted upstream base](/runbooks/runbook-refresh-a-drifted-upstream-base--01a1834796ea.md) |

## Outside this wiki

- Public site: <https://infrashift.github.io/trusted-base-images/>
- Source of truth for pins: `versions.json`
- Live drift status: the GitHub issue "Upstream base image drift"
