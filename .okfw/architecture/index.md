# architecture

<!-- okfw:generated — maintained by okfw; edits here are overwritten -->

## Concepts

* [Code owners protect the pipeline](code-owners-protect-the-pipeline--01a1834795a5.md) - Which teams must approve a change to policy, workflows and scripts, as CODEOWNERS sets it.
* [Evidence bundle and attestations](evidence-bundle-and-attestations--01a1834795a0.md) - What the Build Actor records for each triple, how it attaches attestations to the image, and how the GHCR tag scheme affects discovery.
* [GitHub Environments isolate the actor keys](github-environments-isolate-the-actor-keys--01a183479591.md) - How GitHub Environments keep each actor key in one job, and the rules a workflow change must obey to keep it so.
* [Policy decision point: CVE gate and repo gate](policy-decision-point-cve-gate-and-repo-gate--01a18347959b.md) - The OPA policies in .github/pdp: the image-scope CVE gate, the repository-scope repo gate, and why both fail closed.
* [Registry namespaces: development, trusted, quarantine](registry-namespaces-development-trusted-quarantine--01a183479596.md) - The three GHCR namespaces, their tag schemes, and why a namespace boundary is stronger than a tag convention.
* [Signing chain and actor keys](signing-chain-and-actor-keys--01a18347958c.md) - Which key signs what, where the public keys live, and how the Release Actor adds a keyless signature.
* [System overview and principles](system-overview-and-principles--01a183479583.md) - What Trusted Base Images is, its mission, and the four principles that every part of the pipeline follows.
* [Three-actor governance: Build, Review, Release](three-actor-governance-build-review-release--01a183479588.md) - The three actors that must each sign an image before release, what each one does, and why they are separate.

