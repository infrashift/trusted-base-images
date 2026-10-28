---
id: "01a18347-95df-781c-abdb-23dbe0548702"
title: "versions.json pin model"
type: "image"
tags:
  - "registry"
  - "pipeline"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:09-05:00"
description: "How versions.json pins one upstream digest per image and architecture, and how the pipeline reads it."
resource: "https://github.com/infrashift/trusted-base-images/blob/main/versions.json"
sources:
  - resource: "https://github.com/infrashift/trusted-base-images/blob/ea1e21e/.ai/skills/project-layout.md"
    title: "Rule card .ai/skills/project-layout.md (removed)"
  - resource: "https://github.com/infrashift/trusted-base-images/blob/ea1e21e/.ai/PRD.md"
    title: "Original PRD (.ai/PRD.md, removed)"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:09-05:00"
---

# versions.json pin model

## Shape

```json
{
  "<os>": {
    "<variant>": {
      "base": "<upstream repository>",
      "amd64": { "digest": "sha256:..." },
      "arm64": { "digest": "sha256:..." }
    },
    "updated": "YYYY-MM-DD",
    "reason": "<why the pins changed>"
  }
}
```

The image name is `<os>-<variant>`, for example `ubi9-minimal`. Its Containerfile is `Containerfiles/<image>.Containerfile`.

## Rules

1. `versions.json` is the only place for an upstream digest. A Containerfile takes it as `UPSTREAM_DIGEST`.
2. Each architecture has its own digest. See [Decision: pin one upstream digest per architecture](/decisions/decision-pin-one-upstream-digest-per-architecture--01a183479644.md).
3. When you change a pin, change `updated` and `reason` for that OS.
4. A workflow that needs the image list reads `versions.json`.

## Images

[Image: ubi9-standard](/images/image-ubi9-standard--01a1834795e5.md), [Image: ubi9-minimal](/images/image-ubi9-minimal--01a1834795ea.md), [Image: ubi9-micro](/images/image-ubi9-micro--01a1834795f0.md), [Image: ubi9-init](/images/image-ubi9-init--01a1834795f6.md), [Image: ubi10-minimal](/images/image-ubi10-minimal--01a1834795fc.md), [Image: fedora43-minimal](/images/image-fedora43-minimal--01a183479606.md).

## Who reads it

- [CI Build & Audit (build.yml): the Build Actor](/pipeline/ci-build-audit-build-yml-the-build-actor--01a1834795b4.md) selects triples from it.
- [Review Attestations (review.yml): the Review Actor](/pipeline/review-attestations-review-yml-the-review-actor--01a1834795b9.md) cross-checks the upstream digest against it.
- [Upstream Drift Check (upstream-drift.yml)](/pipeline/upstream-drift-check-upstream-drift-yml--01a1834795d4.md) compares it with upstream.
- `Ops.mk` reads the image list from it.

## Related

- Public page: <https://infrashift.github.io/trusted-base-images/reference/versions-json/>
