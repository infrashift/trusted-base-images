---
id: "01a18347-957a-7937-ad3e-3fb0bc5c0be0"
title: "Wiki conventions: types, tags and body shapes"
type: "reference"
tags:
  - "wiki"
  - "conventions"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:09-05:00"
description: "How this wiki is organized: bundles, concept types, tags, lifecycle and the body shape for each type."
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:09-05:00"
---

# Wiki conventions: types, tags and body shapes

## Bundles

Put each concept in one bundle. If a concept fits two bundles, put it in the bundle of its main question and link from the other.

| Bundle | Question it answers |
|---|---|
| `reference/` | How do I read and write this wiki? |
| `architecture/` | How does the system work, and why? |
| `pipeline/` | What does each workflow do? |
| `images/` | What is in each image, and how is it pinned? |
| `standards/` | Which rules must a change obey? |
| `decisions/` | Why did we choose this? |
| `plans/` | What will we do next? |
| `issues/` | What is wrong or missing now? |
| `runbooks/` | How do I do this task, step by step? |

## Types

`okfw create` writes `type: "note"`. Change the `type:` line by hand after you create the concept. Then run `okfw validate --all`.

| type | Bundle | Body shape |
|---|---|---|
| `hub` | root | Purpose, how to read, map table |
| `reference`, `glossary` | `reference/` | Free |
| `architecture` | `architecture/` | What it is, how it works, why, related |
| `pipeline` | `pipeline/` | Trigger, what it does, outputs, related |
| `image` | `images/` | Facts table, notes, related |
| `standard` | `standards/` | Rules (numbered, "must"), why, how it is enforced |
| `decision` | `decisions/` | Context, Decision, Consequences, Alternatives, Related |
| `decision-log` | `decisions/` | Table: Date, Decision, Link |
| `plan`, `roadmap` | `plans/` | Goal, Scope, Steps (checklist), Risks, Done when, Related |
| `issue` | `issues/` | Description, Context, Details, Acceptance Criteria, Related |
| `runbook` | `runbooks/` | Goal, Prerequisites, Steps (numbered, one action each), Verify, Related |

An issue also has `kind: "issue"`, so `okfw search --kind issue` finds it.

## Tags

- State of an issue: `open` or `fixed`. Change the tag when the state changes.
- Class of an issue: `bug`, `enhancement` or `chore`.
- A plan has `planned` until work starts, then `active`.
- Topic: `security`, `signing`, `cve`, `pipeline`, `registry`, `governance`, `docs`, `wiki`, `agents`.
- Image: `ubi9`, `ubi10`, `fedora43`, and the image name, for example `ubi9-minimal`.

Use only these tags. Add a new tag here before you use it.

## Lifecycle

- `status: draft` means the content is not yet true or not yet checked. Plans stay `draft` until the work is done.
- No `status` means `stable`.
- `status: deprecated` means a newer concept replaces this one. Link to the new concept. Do not delete the old one.

## Provenance

- Set `resource` to the file or page that the concept describes: `okfw set-resource <ref> <url>`.
- Add each source you used: `okfw add-source <ref> --resource <url> --title "<label>"`.
- Record the writer: `okfw set-generated <ref> --by <actor>`. An AI agent writes `claude-code/<model>`. A person writes `human:<github-login>`.
- After a person checks a concept, run `okfw verify <ref>`.

## Links

- Link with a path from the wiki root: `[Title](/bundle/file--id.md)`.
- Link each new concept to one or more concepts in its bundle and to its hub.
- Use `okfw move` and `okfw delete`. Do not use `mv` or `rm`.
