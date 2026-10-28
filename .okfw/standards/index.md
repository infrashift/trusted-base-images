# standards

<!-- okfw:generated — maintained by okfw; edits here are overwritten -->

## Concepts

* [Containerfile policy](containerfile-policy--01a18347960e.md) - The structure that every Containerfile must have: pinned FROM, re-declared build args, labels, cache cleanup and a non-root user.
* [GitHub Actions standard](github-actions-standard--01a18347961c.md) - The rules that every workflow must obey: least privilege per job, actions pinned by SHA, pinned tools, and gates that always report.
* [Promotion never rebuilds an image](promotion-never-rebuilds-an-image--01a183479623.md) - The rule that the Release Actor copies the reviewed image by digest and never builds it again.
* [Provenance labels](provenance-labels--01a183479616.md) - The OCI and io.infrashift labels that every image must carry, so consumers can trace it to its upstream digest and commit.
* [Rules for AI agents](rules-for-ai-agents--01a183479630.md) - What an AI agent may and may not do in this repo: signing limits, pin changes, scan targets, commits and the wiki.
* [Secrets and keys never enter the repository](secrets-and-keys-never-enter-the-repository--01a183479629.md) - The rules for private keys, public keys and secret scanning, including what to tell a fork that has no keys.

