# Trusted Base Images

This repo builds six container base images from upstream bases pinned in
`versions.json`. Every image needs three signatures before release: Build Actor,
Review Actor and Release Actor. Consumers pull only from the trusted namespace.

## Start here

Read the wiki hub first:
[.okfw/trusted-base-images-wiki-overview--01a18347956d.md](.okfw/trusted-base-images-wiki-overview--01a18347956d.md).
It maps each bundle and gives the read order. Then read
[Rules for AI agents](.okfw/standards/rules-for-ai-agents--01a183479630.md).

Record new plans, issues, decisions and runbooks in the wiki, not in other
files. Follow the wiki conventions in `.okfw/reference/`.

## Writing

Write all wiki text in Simplified Technical English (ASD-STE100). The rules are in
[the writing standard](.okfw/reference/writing-standard-simplified-technical-english--01a183479571.md).
Use only the terms in [the glossary](.okfw/reference/glossary-approved-terms--01a183479576.md).
In short: one topic per sentence, 20 words or fewer in a procedure step, active
voice, imperative steps, and one word for one meaning.

<!-- BEGIN okfw -->
## Project knowledge base (okfw)

trusted-base-oci-images keeps a local-first OKF wiki in `.okfw/`: markdown concepts with
YAML frontmatter, linked to each other. The files are the whole database —
search and the link graph are computed from them on demand, so there is no
index to build and nothing to sync. Each directory's `index.md` is generated
and gives a cheap overview before you open anything (OKF section 8).

- **Search before you derive.** `okfw search "<query>"` / `okfw_search`. The
  wiki holds what the code does not say — why things are built the way they
  are, what was considered and rejected, dependency and security findings,
  operational context, open work. Check it before explaining a design,
  assessing risk, or running an analysis someone may already have recorded and
  adjudicated.
- **Search before you write**, too, so a new concept links to what already
  exists instead of duplicating it.
- **Link actively** — `[Title](/dir/file.md)` from the wiki root, or
  `./file.md`. Links are what makes the wiki more than a folder.
- **One idea per concept**, with a one-sentence `description`.
- **Use `okfw move` / `okfw delete`, never `mv` / `rm`.** `move` repairs every
  link to the concept and its own relative links, and both keep the `index.md`
  listings current; the shell commands break the links and leave the listings
  stale.
- **`status` is the OKF lifecycle field** (`draft`/`stable`/`deprecated`), not
  task state. Mark superseded knowledge rather than deleting it.
- **Custom metadata goes under `x:`** — the schema is closed and rejects any
  other unrecognized key.
- Don't edit `index.md` or `log.md`; okfw generates them.

Results are capped and say so: `truncated`, or `… N more`, means you did not
see everything — raise the limit or page with `--offset`/`"offset"`.

`okfw mcp` serves all of this as MCP stdio tools named `okfw_*`.
<!-- END okfw -->
