# Skill: Sovereign Approval Sequence

## Logic
1. **Bot Pre-Approval:** The `Review-Actor` must always sign first. This provides the "Technical Confidence."
2. **Human Finalization:** The `Human-Reviewer` (user) signs the checksum manifest last. This provides the "Policy Confidence."
3. **No Short-Circuits:** A release is only valid if `sig1` (Bot) and `sig2` (Human) are both present on the `sha256` manifest.

## Action
When Claude is asked to "Release an image," it should first check for the presence of the Bot's detached signature. If missing, it must trigger the `Review-Actor` workflow instead of attempting a direct release.