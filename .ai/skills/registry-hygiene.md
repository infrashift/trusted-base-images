# Skill: Registry Hygiene & Namespacing

## Logic
1. **Isolation:** Always separate PR/Dev builds into a nested namespace (e.g., `/development`).
2. **Promotion:** Images only move to the root namespace via the `Release-Actor` after the PR is merged and signatures are verified.
3. **Naming Consistency:** Ensure the variant name (standard, micro) remains the same across namespaces to allow for easy comparison.