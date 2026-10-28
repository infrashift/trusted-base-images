---
id: "01a18347-957f-71e2-a6b3-01bde836c7ea"
title: "Runbook: record a plan, issue or decision"
type: "runbook"
tags:
  - "wiki"
  - "conventions"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:09-05:00"
description: "The steps to add a new plan, issue or decision to this wiki with okfw."
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:09-05:00"
---

# Runbook: record a plan, issue or decision

## Goal

Add one new concept to the correct bundle, with the correct type, tags and links.

## Prerequisites

- `okfw` is on your `PATH`. Run `okfw --version`.
- You read [Writing standard: Simplified Technical English](/reference/writing-standard-simplified-technical-english--01a183479571.md) and [Wiki conventions: types, tags and body shapes](/reference/wiki-conventions-types-tags-and-body-shapes--01a18347957a.md).

## Steps

1. Search for the topic. Do not create a duplicate.

   ```sh
   okfw search "<words>"
   ```

2. Create the concept in its bundle, with its type. Write a one-sentence description. For an issue, add `--kind issue`.

   ```sh
   okfw create "<Title>" --path issues --kind issue --type issue -d "<one sentence>" --tags open,bug --json
   ```

3. Over MCP, use one `okfw_create` call. Set `dir`, `kind`, `type`, `description`, `tags`, `status`, `resource` and `generated_by` in it.
4. Write the body in the shape that [Wiki conventions: types, tags and body shapes](/reference/wiki-conventions-types-tags-and-body-shapes--01a18347957a.md) gives for the type.
5. Add links to related concepts. Use paths from the wiki root.
6. If you used the CLI, record the writer. Over MCP, `generated_by` in step 3 does this.

   ```sh
   okfw set-generated <ref> --by human:<github-login>
   ```

7. For a decision, add one row to [Decision log](/decisions/decision-log--01a183479636.md).
8. Validate the wiki.

   ```sh
   okfw validate --all && okfw validate --okf
   ```

## Verify

- `okfw search "<title words>"` finds the concept.
- The bundle's `index.md` lists the concept with its description.

## Related

- [Wiki conventions: types, tags and body shapes](/reference/wiki-conventions-types-tags-and-body-shapes--01a18347957a.md)
- [Trusted Base Images wiki overview](/trusted-base-images-wiki-overview--01a18347956d.md)
