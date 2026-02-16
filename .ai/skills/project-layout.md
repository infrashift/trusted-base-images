# Skill: Project Layout & Configuration

## Locations
1. **Config:** `versions.json` is always at `/`.
2. **Logic:** Orchestration is in `.github/workflows/`.
3. **Evidence:** Scripts that generate attestations are in `scripts/`.

## Workflow Integration
Whenever a workflow needs to know "What are we building?", it must first check `versions.json`. If that file is missing, the workflow should fail immediately with a "Missing Source of Truth" error.