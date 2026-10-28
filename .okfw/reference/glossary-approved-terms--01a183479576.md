---
id: "01a18347-9576-706b-91f0-b772a9a05360"
title: "Glossary: approved terms"
type: "glossary"
tags:
  - "wiki"
  - "writing"
  - "glossary"
created: "2026-10-28T11:11:09-05:00"
timestamp: "2026-10-28T11:11:09-05:00"
description: "The controlled vocabulary for this wiki: approved technical names and verbs, with the words not to use."
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-10-28T11:11:09-05:00"
---

# Glossary: approved terms

ASD-STE100 permits a technical name that is not in its dictionary if the project approves it and uses it the same way each time. This page approves the names. Use the term in the first column. Do not use the words in the last column.

## Actors and keys

| Approved term | Meaning | Do not use |
|---|---|---|
| Build Actor | The `build-and-sign` job in `build.yml`. It runs in the `Build-Actor` GitHub Environment. | builder bot, CI signer |
| Review Actor | The `review` job in `review.yml`. It runs in the `Review-Actor` GitHub Environment. | bot reviewer, auditor |
| Release Actor | The `release` and `manifest` jobs in `release.yml`. They run in the `Release-Actor` GitHub Environment. | sovereign, human signer |
| actor key | The cosign private key of one actor, stored as `COSIGN_PRIVATE_KEY` in its GitHub Environment. | secret key, signing secret |
| public key | One file in `.github/pdp/public-keys/`: `build.pub`, `review.pub` or `release.pub`. | cert, pubkey |
| GitHub Environment | A GitHub deployment environment that holds one actor key and its protection rules. | env, stage |
| keyless signature | A cosign signature made with the workflow's OIDC identity and logged in Rekor. | OIDC signature |

## Images and pins

| Approved term | Meaning | Do not use |
|---|---|---|
| image | One of the products this repo builds, for example `ubi9-minimal`. | container, base image (for our product) |
| upstream base | The vendor image an image is built from, for example `registry.access.redhat.com/ubi9-minimal`. | parent image, base layer |
| upstream digest | The `sha256:` digest of the upstream base for one architecture, recorded in `versions.json`. | hash, SHA, tag |
| pin | (noun) An upstream digest in `versions.json`. (verb) To record one. | lock, freeze |
| drift | The state where the upstream tag serves a digest different from the pin. | staleness, lag |
| refresh | To change a pin to the digest that the upstream tag serves now. | bump, update (for pins) |
| triple | One `{version, variant, arch}` combination that the build matrix builds. | job, target |
| variant | The image flavor: `standard`, `minimal`, `micro` or `init`. | type, edition |

## Registry

| Approved term | Meaning | Do not use |
|---|---|---|
| development namespace | `ghcr.io/infrashift/trusted-base-images/development/`. Unreviewed builds. | dev registry, staging |
| trusted namespace | `ghcr.io/infrashift/trusted-base-images/trusted/`. Released images. The only namespace consumers pull. | prod, root namespace |
| quarantine namespace | `ghcr.io/infrashift/trusted-base-images/quarantine/`. Images whose review verdict is FAIL. | failed registry |
| promote | To copy a built image to the trusted or quarantine namespace without a rebuild. | deploy, publish, release (as a verb for the copy) |

## Evidence and policy

| Approved term | Meaning | Do not use |
|---|---|---|
| evidence bundle | The SBOM, CVE report, provenance and checksums that the Build Actor makes, with a signature for each. | artifacts (alone), proof |
| attestation | A signed in-toto statement attached to an image. | annotation, label |
| review verdict | The PASS or FAIL result that the Review Actor signs for one triple. | approval, score |
| PDP | Policy decision point: the OPA policies in `.github/pdp/`. | policy engine, gatekeeper |
| CVE gate | The image-scope PDP rules and the `review/cve-policy` commit status. | vuln check |
| repo gate | The repository-scope PDP decision `data.tbi.pdp.repo_decision`, run by `pr-gate.yml`. | lint gate |
| fail closed | A gate denies when its input is missing or malformed. | safe default |

## Wiki

| Approved term | Meaning | Do not use |
|---|---|---|
| concept | One markdown file in `.okfw/`. | note, page, doc |
| bundle | One top-level directory of `.okfw/`, for example `issues/`. | folder, section |
| hub | A concept whose main job is to link to other concepts. | index (that word is for `index.md`) |

## Technical verbs

build, scan, sign, attest, verify, promote, pin, refresh, quarantine, seed (a commit status).
