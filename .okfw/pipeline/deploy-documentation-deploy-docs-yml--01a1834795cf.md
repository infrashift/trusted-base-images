---
id: "01a18347-95cf-7237-bf23-ac29d9f756c6"
title: "Deploy Documentation (deploy-docs.yml)"
type: "pipeline"
tags:
  - "pipeline"
  - "docs"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:09-05:00"
description: "The workflow that builds the Astro Starlight site and deploys it to GitHub Pages when docs change on main."
resource: "https://github.com/infrashift/trusted-base-images/blob/main/.github/workflows/deploy-docs.yml"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:09-05:00"
---

# Deploy Documentation (deploy-docs.yml)

## Trigger

- A push to `main` that changes `docs/**`.
- Manual: `workflow_dispatch`.

## What it does

1. Builds the Astro Starlight site in `docs/`.
2. Deploys it to GitHub Pages at <https://infrashift.github.io/trusted-base-images/>.

## Related

- [Update Documentation Inventory (doc-release.yml)](/pipeline/update-documentation-inventory-doc-release-yml--01a1834795c9.md)
