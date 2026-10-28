# issues

<!-- okfw:generated — maintained by okfw; edits here are overwritten -->

## Concepts

* [CI does not validate the wiki](ci-does-not-validate-the-wiki--01a1834796e2.md) - No workflow runs okfw validate, so a broken concept or a broken link can merge.
* [CODEOWNERS names a path that does not exist](codeowners-names-a-path-that-does-not-exist--01a1834796d2.md) - CODEOWNERS lists .github/pdp/keys/, but the public keys are in .github/pdp/public-keys/.
* [Five old branches remain on the remote](five-old-branches-remain-on-the-remote--01a1834796bb.md) - Five feature and trigger branches from February to August 2026 remain on origin; four are fully merged and one has an unmerged commit.
* [Four scripts are not used by any workflow](four-scripts-are-not-used-by-any-workflow--01a1834796c3.md) - bot-propose-approval.sh, verify-and-sign.sh, verify-multi-sig.sh and execute-release.sh come from the first design and no workflow runs them.
* [GHCR does not implement the OCI referrers API](ghcr-does-not-implement-the-oci-referrers-api--01a1834796b3.md) - GHCR returns 404 for the referrers endpoint, so attestations are tag-scheme artifacts that referrers-only tools cannot find.
* [SETUP-ENVIRONMENTS.md does not match the real setup](setup-environments-md-does-not-match-the-real-setup--01a1834796da.md) - The setup document uses @your-org placeholders and does not agree with the rule cards about which GitHub Environment needs required reviewers.
* [The pdp-gate composite action calls a script that does not exist](the-pdp-gate-composite-action-calls-a-script-that-does-not-exist--01a1834796cb.md) - The composite action .github/actions/pdp-gate runs scripts/run-gatekeeper.sh, which does not exist, and no workflow uses the action.

