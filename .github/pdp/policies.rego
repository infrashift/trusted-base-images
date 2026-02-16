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
violation_security_threshold[msg] if {
    input.scan_results.critical_count > 0
    msg := "Critical vulnerabilities found. Deployment denied."
}

violation_security_threshold[msg] if {
    input.scan_results.high_count > 0
    msg := "High vulnerabilities found. Deployment denied."
}