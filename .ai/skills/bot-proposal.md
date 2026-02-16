# Skill: Bot Proposal Logic

## Responsibility
The `Review-Actor` must perform the "Technical Audit" before notifying a human.

## Hand-off Protocol
1. **Evidence Gathering:** Collect `sbom.json` and `cve-report.json` from the Build job.
2. **Signature Verification:** Use `scripts/verify-and-sign.sh` to confirm the Build-Actor's identity.
3. **Drafting:** Call `scripts/bot-propose-approval.sh` to generate the `approval.json.sha256` manifest.
4. **Notification:** Once the bot signs the manifest (`.sig1`), Claude should inform the user that the "Sovereign Evidence Bundle" is ready for their final signature.

## Safety Rule
Claude must NEVER attempt to sign the `.sig2` (Human Signature). It must only facilitate the bot's signature.