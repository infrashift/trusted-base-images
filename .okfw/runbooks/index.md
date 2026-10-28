# runbooks

<!-- okfw:generated — maintained by okfw; edits here are overwritten -->

## Concepts

* [Runbook: add a new image](runbook-add-a-new-image--01a18347971a.md) - The steps to add a new image: its versions.json entry, Containerfile and docs pages.
* [Runbook: install the pinned pipeline tools](runbook-install-the-pinned-pipeline-tools--01a183479712.md) - How to install cosign, syft, grype, OPA and gitleaks locally at the versions in tools.lock.
* [Runbook: list or clean a GHCR namespace](runbook-list-or-clean-a-ghcr-namespace--01a183479702.md) - How to list the images in a namespace and how to delete all packages of the development namespace with Ops.mk.
* [Runbook: open and merge the docs-inventory pull request](runbook-open-and-merge-the-docs-inventory-pull-request--01a1834796fa.md) - The steps to publish the image inventory after each release, because the workflow cannot open the pull request itself.
* [Runbook: refresh a base to clear a CVE](runbook-refresh-a-base-to-clear-a-cve--01a1834796f2.md) - The steps to re-pin one image by hand when a fixable CVE blocks it and the drift check has not proposed a refresh.
* [Runbook: refresh a drifted upstream base](runbook-refresh-a-drifted-upstream-base--01a1834796ea.md) - The steps to take the daily drift check's refresh branch through build, review, release and docs.
* [Runbook: set up GitHub Environments and actor keys](runbook-set-up-github-environments-and-actor-keys--01a18347970a.md) - The steps to make the three actor key pairs and put each private key in its own GitHub Environment.

