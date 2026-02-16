---
title: Governance Model
description: Three-actor governance model for Trusted Base Images — Build, Review, and Release.
---

Trusted Base Images uses a three-actor governance model where the Build, Review, and Release stages are performed by isolated actors with separate signing keys. This ensures no single compromised actor can push an unverified image to production.

## The Three Actors

### Build-Actor

The Build-Actor is responsible for:

- Building container images from digest-pinned upstream bases
- Generating evidence artifacts (SBOM, CVE report, SLSA provenance)
- Signing all evidence with the Build-Actor's sovereign key
- Attaching signed attestations to the development image in GHCR
- Pushing images to the `development` namespace

**Environment**: `Build-Actor` (GitHub Actions environment with `COSIGN_PRIVATE_KEY`)

### Review-Actor

The Review-Actor is responsible for:

- Verifying all Build-Actor attestation signatures against `build.pub`
- Verifying evidence blob signatures and checksums
- Cross-checking upstream digests between provenance and `versions.json`
- Evaluating CVE policy using OPA (Open Policy Agent)
- Generating and signing a review verdict
- Attaching the signed review attestation to the development image

**Environment**: `Review-Actor` (GitHub Actions environment with `COSIGN_PRIVATE_KEY`)

**Trigger**: Automatically runs via `workflow_run` after a successful build

### Release-Actor

The Release-Actor is responsible for:

- Verifying all Build-Actor and Review-Actor attestations
- Checking the review verdict and commit freshness
- Promoting images to `trusted` (PASS) or `quarantine` (FAIL) namespace
- Dual-signing the release attestation (sovereign key + keyless OIDC)
- Creating multi-architecture manifest lists
- Dual-signing manifest lists

**Environment**: `Release-Actor` (GitHub Actions environment with `COSIGN_PRIVATE_KEY`, **required reviewers enabled** — human gate)

**Trigger**: Runs when a PR is merged to `main`

## Key Separation

Each actor has its own signing key pair:

| Actor | Public Key | Purpose |
|-------|-----------|---------|
| Build-Actor | `build.pub` | Signs evidence artifacts and build attestations |
| Review-Actor | `review.pub` | Signs review verdict attestations |
| Release-Actor | `release.pub` | Signs release attestations (+ keyless OIDC) |

Public keys are stored in `.github/pdp/public-keys/` and can be used by anyone to verify the signing chain.

## Environment Isolation

### Repurposing GitHub Deployment Environments as Trust Boundaries

GitHub Actions [deployment environments](https://docs.github.com/en/actions/concepts/workflows-and-actions/deployment-environments) are designed for managing deployment targets like staging and production. However, the security properties they provide — scoped secrets, required reviewer gates, and branch restrictions — are not specific to deployments. They are general-purpose isolation mechanisms that GitHub enforces at the job level.

This project repurposes environments as **trust boundaries between signing actors** rather than deployment stages. Each actor (Build, Review, Release) runs in its own environment with its own `COSIGN_PRIVATE_KEY` secret. The result is that:

- **Secret scoping**: A job can only access an environment's secrets after being dispatched to a runner in that environment. The Build-Actor's signing key is inaccessible to Review or Release jobs, and vice versa.
- **Required reviewers**: The Release-Actor environment requires manual approval before any job can execute, creating a human gate before images are promoted to production. This prevents automated code changes from releasing images without human oversight.
- **Branch restrictions**: Environments can restrict which branches are allowed to trigger jobs, limiting the blast radius of compromised workflow definitions.
- **Workflow-level control**: Only workflow definitions on the default branch (`main`) determine which environment a job uses. A PR cannot modify the environment assignment to escalate its own access.

This approach provides a stronger security posture than repository-level secrets alone. With repository secrets, any workflow job can access any secret. With environment-scoped secrets, access requires both the correct environment reference in the workflow definition *and* passing any configured protection rules (reviewers, branch policies, wait timers).

### Environment Configuration

| Environment | Secrets | Required Reviewers | Purpose |
|-------------|---------|:------------------:|---------|
| `Build-Actor` | `COSIGN_PRIVATE_KEY` | No | Signing evidence and build attestations |
| `Review-Actor` | `COSIGN_PRIVATE_KEY` | No | Signing review verdicts |
| `Release-Actor` | `COSIGN_PRIVATE_KEY` | Yes | Signing release attestations (human gate) |

## Attack Resistance

| Threat | Mitigation |
|--------|-----------|
| Compromised Build-Actor key | Review-Actor independently verifies; Release-Actor re-verifies both |
| Compromised Review-Actor key | Release-Actor verifies build attestations directly; review verdict must match |
| Compromised Release-Actor key | Requires human approval; keyless OIDC provides independent verification via Rekor |
| Tampered evidence artifacts | Checksums and blob signatures detected by Review-Actor |
| Upstream digest swap | Cross-check between provenance and `versions.json` |
| Stale review | Commit freshness check ensures review matches the merged commit |
