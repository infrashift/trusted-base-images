package tbi.pdp

import future.keywords.if
import future.keywords.in

default allow_pipeline = false

# --- Entry Point: Pre-Build Gate ---
allow_pipeline if {
    count(violation_secrets) == 0
    # count(violation_signatures) == 0
}

# --- Rule: Secret Detection ---
violation_secrets[msg] if {
    some leak in input.gitleaks_results
    msg := sprintf("Secret found in %v: %v", [leak.File, leak.RuleID])
}

# --- Rule: Commit Signatures ---
# Gitter signature status: 'G' is Good, others are failures
# violation_signatures[msg] if {
#     some commit in input.commits
#     commit.signature_status != "G"
#     msg := sprintf("Unsigned or invalid commit signature: %v", [commit.sha])
# }

# --- Rule: Image Policy (For later in the pipe) ---
# Critical vulnerabilities block unconditionally, fix available or not.
violation_security_threshold[msg] if {
    input.scan_results.critical_count > 0
    msg := "Critical vulnerabilities found. Deployment denied."
}

# High vulnerabilities block only when upstream has published a fixed version
# (grype fix.state == "fixed"). Those are actionable: rebuilding against a newer
# base clears them, so a failure here means the base image is stale.
#
# Highs with no available fix are recorded in the review verdict but do not
# block. No rebuild can clear them, so blocking on them would gate every image
# on the vendor's backport schedule rather than on anything we control.
violation_security_threshold[msg] if {
    input.scan_results.fixable_high_count > 0
    msg := sprintf(
        "%v High vulnerabilities with an available upstream fix. Deployment denied.",
        [input.scan_results.fixable_high_count],
    )
}

# Fail closed. The rules above are "> 0" comparisons, which are undefined — and
# therefore silently non-violating — when a count is missing or not a number.
# Without this rule a malformed input would pass the gate rather than trip it.
violation_security_threshold[msg] if {
    some field in ["critical_count", "fixable_high_count"]
    not is_number(object.get(input, ["scan_results", field], null))
    msg := sprintf(
        "Malformed scan input: scan_results.%v is missing or not a number. Deployment denied.",
        [field],
    )
}
