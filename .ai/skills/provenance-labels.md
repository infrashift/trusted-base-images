# Skill: Provenance Labeling

## Standards
1. **Upstream Tracking:** Every image must include `io.infrashift.image.upstream.source`.
2. **Immutable Anchors:** The source value MUST include the `@sha256:` digest, not just a tag.
3. **Dashboard Sync:** These labels are used by `scripts/hydrate-dashboard.ts` to show users exactly which Red Hat base they are inheriting.