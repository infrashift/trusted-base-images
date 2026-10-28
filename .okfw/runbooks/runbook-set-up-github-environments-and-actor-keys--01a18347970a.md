---
id: "01a18347-970a-7a94-b1be-87626bff1796"
title: "Runbook: set up GitHub Environments and actor keys"
type: "runbook"
tags:
  - "signing"
  - "security"
  - "governance"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:10-05:00"
description: "The steps to make the three actor key pairs and put each private key in its own GitHub Environment."
resource: "https://github.com/infrashift/trusted-base-images/blob/main/SETUP-ENVIRONMENTS.md"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:10-05:00"
---

# Runbook: set up GitHub Environments and actor keys

## Goal

Give each actor its own key in its own GitHub Environment.

## Prerequisites

- cosign v2 is installed. See [Pinned tools: tools.lock and install-tools.sh](/pipeline/pinned-tools-tools-lock-and-install-tools-sh--01a1834795da.md).
- You are a repository admin.

## Steps

1. In a temporary directory outside the repo, make the three key pairs.

   ```sh
   for a in build review release; do
     cosign generate-key-pair && mv cosign.key "$a.key" && mv cosign.pub "$a.pub"
   done
   ```

2. In the repository settings, create GitHub Environments `Build-Actor`, `Review-Actor` and `Release-Actor`.
3. In each GitHub Environment, add secret `COSIGN_PRIVATE_KEY` with the matching private key.
4. Set the protection rules. See [SETUP-ENVIRONMENTS.md does not match the real setup](/issues/setup-environments-md-does-not-match-the-real-setup--01a1834796da.md) for the open question about required reviewers.
5. Copy the public keys to `.github/pdp/public-keys/` and commit them.
6. **Warning:** a private key on disk is a risk. Store it in a secret manager, then delete the local files.

## Verify

- A test pull request passes [CI Build & Audit (build.yml): the Build Actor](/pipeline/ci-build-audit-build-yml-the-build-actor--01a1834795b4.md) and [Review Attestations (review.yml): the Review Actor](/pipeline/review-attestations-review-yml-the-review-actor--01a1834795b9.md).

## Related

- [GitHub Environments isolate the actor keys](/architecture/github-environments-isolate-the-actor-keys--01a183479591.md)
- [Decision: three actors with three separate keys](/decisions/decision-three-actors-with-three-separate-keys--01a18347963d.md)
