---
title: PDP Strategy
description: Policy Decision Point strategy using OPA for automated policy enforcement across the image supply chain.
---

Trusted Base Images uses a **Policy Decision Point (PDP)** strategy to enforce security and compliance rules automatically at critical points in the supply chain. The PDP evaluates structured evidence against declarative policies and produces a deterministic pass/fail verdict — removing human judgment from gate decisions.

## What Is a PDP?

A Policy Decision Point is an architectural pattern where policy evaluation is separated from policy enforcement. The PDP receives structured input (evidence), evaluates it against a policy set, and returns a decision. The calling system (the Policy Enforcement Point) acts on that decision.

In this project:

- **Policy Enforcement Point (PEP)**: The Review-Actor workflow — it calls the PDP, reads the verdict, and routes images to `trusted` or `quarantine`
- **Policy Decision Point (PDP)**: OPA evaluating `.github/pdp/policies.rego` with CVE scan data as input
- **Policy Information Point (PIP)**: The build evidence artifacts — SBOM, CVE report, provenance

This separation means policies can be updated independently of workflow logic, and the same PDP can be reused across multiple enforcement points.

## Policy Location

All policies live under `.github/pdp/`:

```
.github/pdp/
├── policies.rego          # OPA policy rules
└── public-keys/
    ├── build.pub          # Build-Actor verification key
    ├── review.pub         # Review-Actor verification key
    └── release.pub        # Release-Actor verification key
```

## Current OPA Implementation

### Policy Engine

[Open Policy Agent](https://www.openpolicyagent.org/) (OPA) is a general-purpose policy engine that evaluates Rego policies against JSON input. The Review-Actor downloads the OPA binary and runs it as a CLI tool during each review job:

```bash
opa eval \
  --data .github/pdp/policies.rego \
  --input /tmp/opa-input.json \
  'data.tbi.pdp.violation_security_threshold' \
  --format raw
```

### Policy Package

The policy package `tbi.pdp` contains three rule categories:

#### CVE Security Threshold

The active policy — evaluated during every review. It blocks images with any Critical or High severity CVEs:

```rego
package tbi.pdp

violation_security_threshold[msg] if {
    input.scan_results.critical_count > 0
    msg := "Critical vulnerabilities found. Deployment denied."
}

violation_security_threshold[msg] if {
    input.scan_results.high_count > 0
    msg := "High vulnerabilities found. Deployment denied."
}
```

**Input format**: The Review-Actor constructs a JSON input document from the Grype CVE report:

```json
{
  "scan_results": {
    "critical_count": 0,
    "high_count": 1,
    "medium_count": 42,
    "low_count": 182
  }
}
```

**Output interpretation**: OPA partial rules return violations as an array. An empty result (`[]` or `{}`) means no violations — the image passes. Any non-empty result means policy failure.

#### Secret Detection (Pre-Build Gate)

Defined but not yet wired into the build workflow:

```rego
violation_secrets[msg] if {
    some leak in input.gitleaks_results
    msg := sprintf("Secret found in %v: %v", [leak.File, leak.RuleID])
}
```

This rule would evaluate Gitleaks scan results and block the build if secrets are detected in the repository.

#### Commit Signature Enforcement

Defined but currently commented out:

```rego
# violation_signatures[msg] if {
#     some commit in input.commits
#     commit.signature_status != "G"
#     msg := sprintf("Unsigned or invalid commit signature: %v", [commit.sha])
# }
```

See the [Roadmap](/trusted-base-images/reference/roadmap/) for plans to re-enable this policy.

### Pipeline Entry Point

The top-level `allow_pipeline` rule aggregates all pre-build gate policies:

```rego
default allow_pipeline = false

allow_pipeline if {
    count(violation_secrets) == 0
    # count(violation_signatures) == 0
}
```

This rule is designed for the pre-build gate — a future enforcement point that will evaluate repository-level policies before the build begins.

## How the PDP Integrates with Review

The Review-Actor invokes the PDP at a specific point in its verification chain:

1. Verify Build-Actor attestation signatures (cosign)
2. Verify evidence blob checksums and signatures
3. Cross-check upstream digest between provenance and `versions.json`
4. **Invoke PDP**: Feed CVE counts to OPA, evaluate `violation_security_threshold`
5. Record the verdict (PASS or FAIL) in the review attestation
6. Sign and attach the review attestation to the image

The PDP verdict is embedded in the review attestation's metadata, which the Release-Actor later inspects to determine the target namespace (`trusted` or `quarantine`).

## Why a PDP Architecture?

### Declarative over Imperative

Policies are expressed as declarative Rego rules, not embedded `if/else` logic in shell scripts. This makes policies auditable, testable, and version-controlled independently from workflow code.

### Extensible Gate Points

The PDP architecture supports multiple enforcement points without duplicating policy logic:

| Gate Point | Status | Enforcement |
|------------|--------|-------------|
| Pre-build (secrets, signatures) | Planned | Build-Actor evaluates `allow_pipeline` |
| Post-build (CVE threshold) | **Active** | Review-Actor evaluates `violation_security_threshold` |
| Release admission | Future | Could gate on additional criteria |

### Separation of Concerns

Policy authors can modify thresholds (e.g., allowing High CVEs for specific packages) without touching workflow definitions. Conversely, workflow changes don't affect policy logic.

### Auditable Decisions

Every PDP evaluation is logged in the workflow output and its verdict is cryptographically signed into the review attestation. The decision trail is: CVE report (signed by Build-Actor) + OPA verdict (in review attestation signed by Review-Actor) + release action (signed by Release-Actor).

## Future: GARMR PDP (Policy Agent)

:::note[Planned Enhancement]
The current OPA-based PDP will be supplanted by [GARMR](https://infrashift.github.io) **Policy Agent** — a purpose-built Policy Decision Point from Infrashift designed for container image supply chain governance.

GARMR Policy Agent will provide:

- **Supply-chain-native policy primitives** — first-class support for SBOM, CVE, provenance, and attestation evaluation without requiring manual JSON transformation
- **Attestation-aware evaluation** — policies that directly consume and verify Sigstore attestations as input, rather than requiring pre-extraction of evidence data
- **Multi-signal correlation** — evaluate SBOM composition, CVE severity, upstream provenance, and signing chain integrity in a single policy evaluation
- **Continuous policy monitoring** — re-evaluate policies when CVE databases update, not just at build time

The migration path from OPA to GARMR will preserve the existing PDP architecture — the Review-Actor will call GARMR instead of OPA, using the same enforcement point and verdict flow. Policy definitions will migrate from Rego to GARMR's policy format.

See the [Roadmap](/trusted-base-images/reference/roadmap/) for timeline details.
:::
