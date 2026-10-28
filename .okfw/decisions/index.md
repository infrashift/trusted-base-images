# decisions

<!-- okfw:generated — maintained by okfw; edits here are overwritten -->

## Concepts

* [Decision log](decision-log--01a183479636.md) - One row per project decision, newest first, with a link to the concept that records it.
* [Decision: a High CVE blocks only when upstream has a fix](decision-a-high-cve-blocks-only-when-upstream-has-a-fix--01a183479651.md) - Why the CVE gate blocks every Critical CVE but blocks a High CVE only when grype reports an upstream fix.
* [Decision: automation pushes a branch; a person opens the pull request](decision-automation-pushes-a-branch-a-person-opens-the-pull-request--01a183479657.md) - Why workflows push automation/* branches but never open pull requests, and why that setting stays off.
* [Decision: every gate fails closed](decision-every-gate-fails-closed--01a183479664.md) - Why each PDP rule and each review leg denies when its input is missing, malformed or absent.
* [Decision: pin one upstream digest per architecture](decision-pin-one-upstream-digest-per-architecture--01a183479644.md) - Why versions.json pins a separate upstream digest for amd64 and for arm64, not one multi-arch index digest.
* [Decision: scan a local copy of the pushed image](decision-scan-a-local-copy-of-the-pushed-image--01a18347964a.md) - Why the Build Actor scans a local OCI export of the exact image it pushed, not the image in the registry.
* [Decision: stay on cosign v2 until the org moves to v3](decision-stay-on-cosign-v2-until-the-org-moves-to-v3--01a18347965e.md) - Why tools.lock pins cosign v2.6.1 and why the move to v3 must happen in all repos at once.
* [Decision: three actors with three separate keys](decision-three-actors-with-three-separate-keys--01a18347963d.md) - Why each of the Build, Review and Release Actors has its own cosign key in its own GitHub Environment.
* [Decision: use an OKF wiki for project knowledge](decision-use-an-okf-wiki-for-project-knowledge--01a18347966b.md) - Why plans, issues, decisions and runbooks live in .okfw/ and why the .ai/ directory was removed.

