# Skill: Containerfile Policy

## Mandatory Structure
1. **Dynamic Metadata:** Always use `ARG` for versioning and build dates.
2. **Labeling:** Include `org.opencontainers.image` and `io.infrashift.image` namespaces.
3. **Security:** - All files MUST end with `USER 1001`.
   - All package installations must be followed by a `clean all` command in the same layer.
4. **Base Integrity:** Pins should be via `@sha256` digest where possible to ensure reproducibility.