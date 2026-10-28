# plans

<!-- okfw:generated — maintained by okfw; edits here are overwritten -->

## Concepts

* [Plan: add more UBI 10 variants](plan-add-more-ubi-10-variants--01a183479688.md) - Planned: add UBI 10 standard, micro and init images when Red Hat publishes them, and possibly runtime images.
* [Plan: an audit trail view from Rekor](plan-an-audit-trail-view-from-rekor--01a18347968f.md) - Planned: show the signing timeline and governance chain of each image from its Rekor transparency log entries.
* [Plan: enforce commit signatures](plan-enforce-commit-signatures--01a18347969d.md) - Planned: enable the commented-out commit-signature rule in the PDP and check signers against an allowlist.
* [Plan: generate inventory pages from versions.json](plan-generate-inventory-pages-from-versions-json--01a183479681.md) - Planned: generate the per-image inventory MDX pages from versions.json instead of writing them by hand.
* [Plan: move to cosign v3 with all Infrashift repos](plan-move-to-cosign-v3-with-all-infrashift-repos--01a1834796a4.md) - Planned: move every Infrashift repo from cosign v2 to v3 at the same time, including how attestations are read back.
* [Plan: replace OPA with the GARMR policy agent](plan-replace-opa-with-the-garmr-policy-agent--01a183479696.md) - Planned: move the PDP from OPA and Rego to the GARMR policy agent at the Review Actor's enforcement point.
* [Plan: trigger a rescan when a new CVE affects an image](plan-trigger-a-rescan-when-a-new-cve-affects-an-image--01a18347967a.md) - Planned: watch CVE feeds for packages in the SBOMs and start a rescan or refresh when a Critical or High CVE appears.
* [Plan: validate the wiki in CI](plan-validate-the-wiki-in-ci--01a1834796ac.md) - Planned: run okfw validate in the PR gate so a broken concept or link fails the pull request.
* [Roadmap](roadmap--01a183479672.md) - The list of planned work, with a link to the plan for each item; the public roadmap page summarizes it.

