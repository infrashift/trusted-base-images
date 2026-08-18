---
title: Known Limitations
description: Constraints imposed by upstream platforms that shape how Trusted Base Images publishes and verifies artifacts.
---

Constraints this project works around because a dependency does not yet support the
mechanism we would otherwise prefer. Each entry records the behaviour today, what would
change if the limitation were lifted, and how to check whether it still applies.

These are not defects in the pipeline. They are places where the pipeline has adapted
correctly to something outside its control.

## GHCR does not implement the OCI referrers API

**Affects:** how SBOM, CVE, provenance, review and release attestations are attached to
published images.
**Status:** open — re-test periodically.

### Background

The [OCI Distribution v1.1 referrers API](https://github.com/opencontainers/distribution-spec/blob/main/spec.md#listing-referrers)
lets an artifact declare a `subject` — another manifest it describes. A registry that
implements it exposes `GET /v2/<name>/referrers/<digest>`, returning an index of every
artifact pointing at that digest. Discovery becomes a registry-native query: ask the
registry what it holds *about* an image, and it tells you.

Cosign supports this, but it is not the only mechanism it supports. Its original scheme
attaches artifacts as ordinary tags named after the digest they describe:

```
sha256-<digest>.sig    signature for sha256:<digest>
sha256-<digest>.att    attestations for sha256:<digest>
```

The relationship is encoded in the tag name rather than in the manifest, so nothing in
the artifact itself points back at its subject.

### How it works today

GHCR does not implement the referrers API. Querying it returns `404`:

```bash
REPO=infrashift/trusted-base-images/trusted/ubi9-minimal
TOKEN=$(curl -s "https://ghcr.io/token?scope=repository:${REPO}:pull&service=ghcr.io" | jq -r .token)

curl -s -o /dev/null -w '%{http_code}\n' \
  -H "Authorization: Bearer $TOKEN" \
  "https://ghcr.io/v2/${REPO}/referrers/sha256:<arch-digest>"
# 404
```

A registry that supports referrers returns `200` with an index — empty if nothing refers
to that digest. `404` means the endpoint does not exist, and the distribution spec
prescribes exactly what cosign then does: fall back to the tag scheme.

So attestations are attached as tag-scheme artifacts:

```bash
skopeo list-tags docker://ghcr.io/$REPO | jq -r '.Tags[] | select(startswith("sha256-"))'
# sha256-<arch-digest>
# sha256-<arch-digest>.att
# sha256-<index-digest>.sig
```

The `.att` manifest carries the attestations as DSSE envelopes
(`application/vnd.dsse.envelope.v1+json`). Its own media type is
`application/vnd.docker.distribution.manifest.v2+json` — a Docker v2s2 manifest, not an
OCI artifact manifest, and it has no `subject` field.

**The binding is still exact.** Every attestation is an in-toto statement whose `subject`
names the arch image digest:

```json
{
  "_type": "https://in-toto.io/Statement/v0.1",
  "predicateType": "https://slsa.dev/provenance/v1",
  "subject": [{ "digest": { "sha256": "<arch-digest>" } }]
}
```

So the relationship is asserted **inside the signed payload** rather than by the
registry. Verification is unaffected — `cosign verify-attestation` resolves the tag,
checks the DSSE signature, and confirms the subject digest. What is lost is
*registry-native discovery*.

#### What this costs

| | Today (tag scheme) | With referrers |
|---|---|---|
| Attach | `cosign attest` writes `sha256-<digest>.att` | artifact with `subject` pointing at the image |
| Discover | guess the tag name, or list all tags and filter | `GET /v2/<name>/referrers/<digest>` |
| `oras discover` | finds nothing | lists every attestation |
| Referrers-aware scanners | see an unattested image | see SBOM and CVE data automatically |
| Registry GC | tags are independent objects; deleting an image can orphan its `.att` | registry understands the link |
| Tag listing | attachment tags appear alongside real tags | attachments are not tags |

The practical consequences: tooling that speaks only referrers concludes these images
carry no provenance, and attachment tags clutter the tag list. Neither weakens the
guarantees — it makes them harder for third-party tools to find.

Because the images themselves are published as proper OCI
(`application/vnd.oci.image.index.v1+json` and
`application/vnd.oci.image.manifest.v1+json`), the limitation is confined to how
*attachments* are linked. Nothing about the image format needs to change.

### How it would work if GHCR supported it

Cosign would attach the same attestations as OCI artifacts carrying a `subject`, and no
attachment tags would be created:

```bash
cosign attest --yes \
  --registry-referrers-mode oci-1-1 \
  --key env://COSIGN_PRIVATE_KEY \
  --type slsaprovenance1 \
  --predicate provenance.json "$IMAGE_URI"
```

The referrers query would then return the full set:

```bash
curl -s -H "Authorization: Bearer $TOKEN" \
  "https://ghcr.io/v2/${REPO}/referrers/sha256:<arch-digest>" | jq '.manifests[].artifactType'
```

and `oras discover` would resolve the whole build → review → release chain without
knowing any cosign-specific tag convention.

The change is confined to the `cosign attest` and `cosign sign` invocations in
`build.yml` and `release.yml`. Predicate types, signing keys, and the actor model are
unaffected — only the transport of the link changes.

Migration would not be retroactive. Images published under the tag scheme keep their
`.att` tags, so both schemes would coexist until every image had been rebuilt and
re-released. Cosign reads both, so verification would continue to work throughout.

### How to re-test

Run the `curl` above against any published image. A `200` — even with an empty
`manifests` array — means GHCR has shipped referrers support and the migration is
available. `404` means this entry still applies.

Worth checking whenever GHCR announces registry changes, or on any cosign major upgrade.

### Related

- [Verify Attestations](/trusted-base-images/guides/verify-attestations/)
- [Supply Chain](/trusted-base-images/security/supply-chain/)
- [Image Annotations](/trusted-base-images/security/image-annotations/)
