---
id: "01a18347-960e-795a-a20d-562e5967e104"
title: "Containerfile policy"
type: "standard"
tags:
  - "security"
  - "pipeline"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:10-05:00"
description: "The structure that every Containerfile must have: pinned FROM, re-declared build args, labels, cache cleanup and a non-root user."
resource: "https://github.com/infrashift/trusted-base-images/blob/main/Containerfiles/"
sources:
  - resource: "https://github.com/infrashift/trusted-base-images/blob/ea1e21e/.ai/skills/containerfile-policy.md"
    title: "Rule card .ai/skills/containerfile-policy.md (removed)"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:10-05:00"
---

# Containerfile policy

## Rules

1. `FROM` must be `${UPSTREAM_BASE}@${UPSTREAM_DIGEST}`. Do not write a digest or tag in the file. See [versions.json pin model](/images/versions-json-pin-model--01a1834795df.md).
2. Declare `UPSTREAM_BASE` and `UPSTREAM_DIGEST` again after `FROM`. A build arg before the first `FROM` is not in scope in the build stage.
3. Take `IMAGE_VERSION`, `BUILD_DATE`, `TARGETARCH` and `GIT_COMMIT` as build args.
4. Set the labels in [Provenance labels](/standards/provenance-labels--01a183479616.md).
5. Clean the package cache in the same layer as the package command.
6. The last instruction must be `USER 1001`.

## Why

Rule 1 makes `versions.json` the only source of truth. Rule 2 prevents empty label values. Rules 5 and 6 make the image smaller and stop it from running as root.

## Related

- [Provenance labels](/standards/provenance-labels--01a183479616.md)
- [Runbook: add a new image](/runbooks/runbook-add-a-new-image--01a18347971a.md)
