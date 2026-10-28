# pipeline

<!-- okfw:generated — maintained by okfw; edits here are overwritten -->

## Concepts

* [CI Build & Audit (build.yml): the Build Actor](ci-build-audit-build-yml-the-build-actor--01a1834795b4.md) - The Build Actor workflow: which changes trigger it, how it selects triples, and what it builds, scans, signs and pushes.
* [Cleanup Development Images (cleanup-dev.yml)](cleanup-development-images-cleanup-dev-yml--01a1834795c4.md) - The workflow that deletes a pull request's images from the development namespace after a successful release.
* [Deploy Documentation (deploy-docs.yml)](deploy-documentation-deploy-docs-yml--01a1834795cf.md) - The workflow that builds the Astro Starlight site and deploys it to GitHub Pages when docs change on main.
* [PR Review Gate (pr-gate.yml)](pr-review-gate-pr-gate-yml--01a1834795af.md) - The gate that runs on every pull request: the repo gate, workflow lint, policy tests, and the seed of the review/cve-policy status.
* [Pinned tools: tools.lock and install-tools.sh](pinned-tools-tools-lock-and-install-tools-sh--01a1834795da.md) - How the pipeline installs cosign, syft, grype, OPA and gitleaks at pinned versions with checksums.
* [Release Images (release.yml): the Release Actor](release-images-release-yml-the-release-actor--01a1834795be.md) - The Release Actor workflow: how it finds the reviewed build, re-verifies it, promotes it, and signs the release.
* [Review Attestations (review.yml): the Review Actor](review-attestations-review-yml-the-review-actor--01a1834795b9.md) - The Review Actor workflow: what it verifies for each triple, how it applies the CVE gate, and the verdict it signs.
* [Update Documentation Inventory (doc-release.yml)](update-documentation-inventory-doc-release-yml--01a1834795c9.md) - The workflow that writes the image inventory after a release and pushes it to a branch that a person must open as a PR.
* [Upstream Drift Check (upstream-drift.yml)](upstream-drift-check-upstream-drift-yml--01a1834795d4.md) - The daily workflow that compares each pin with its upstream tag, scans both, and proposes a refresh branch.
* [Workflow chain from pull request to release](workflow-chain-from-pull-request-to-release--01a1834795aa.md) - The order in which the eight workflows run, from a pull request to a trusted image and published docs.

