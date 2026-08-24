package tbi.pdp

import future.keywords.if
import future.keywords.in

default allow_pipeline := false

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

# Fail closed. `some leak in input.gitleaks_results` is undefined -- and so
# silently non-violating -- when the field is missing or is not an array, which
# made allow_pipeline evaluate to TRUE for an empty input. That is the same trap
# violation_security_threshold already guards against at the bottom of this
# file; the secret rule never got the equivalent. Caught by
# test_pipeline_denied_when_input_is_absent, which failed on first run.
violation_secrets[msg] if {
	not is_array(object.get(input, ["gitleaks_results"], null))
	msg := "Malformed input: gitleaks_results is missing or not an array. Denying."
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

# ===========================================================================
# REPO SCOPE
# ===========================================================================
#
#   data.tbi.pdp.repo_decision   Scope: the repository. Secret scanning and
#                                tool-pinning hygiene. Once per PR.
#
#   data.tbi.pdp.allow_pipeline  Scope: the build. Kept as-is above.
#
# Every rule below consumes a MEASURED fact supplied by scripts/repo-gate.sh --
# the real byte count of .gitleaks.toml, the real findings array, the real
# tools.lock, the real workflow refs. None of them accept an assertion.
#
# That distinction is the whole point. `violation_secrets` above reads
# input.gitleaks_results and is correct as far as it goes, but it cannot tell an
# empty findings list produced by a real scan from one produced by a config with
# no rules in it -- and this repository shipped .gitleaks.toml at 0 bytes while
# scripts/bot-propose-approval.sh wrote "gitleaks_passed": true as a literal.
# GITLEAKS_CONFIG_EMPTY and GITLEAKS_DID_NOT_RUN exist so that the absence of
# findings is only ever evidence when the scan could have produced some.

default repo_decision := {
	"allow": false,
	"violations": [],
	"warnings": [],
	"error": "policy did not evaluate",
}

repo_decision := {
	"allow": count(repo_violations) == 0,
	"counts": {"violations": count(repo_violations), "warnings": count(repo_warnings)},
	"evaluated_at": repo_evaluated_at_str,
	"violations": sort([v | some v in repo_violations]),
	"warnings": sort([w | some w in repo_warnings]),
}

# Determinism: the timestamp is supplied by the caller and never read from a
# clock inside the policy, so a decision made now replays identically later.
repo_evaluated_at_ns := ns if {
	ns := time.parse_rfc3339_ns(object.get(input, ["evaluated_at"], ""))
	ns > 0
}

repo_evaluated_at_str := object.get(input, ["evaluated_at"], "missing")

# No warnings are emitted yet. The set is defined so that repo_decision's
# count() and sort() are total rather than undefined, which would take the whole
# rule with them and produce the default deny for a repository that is fine.
repo_warnings := set()

repo_violations contains v if {
	not repo_evaluated_at_ns
	v := {"code": "INPUT_TIMESTAMP_INVALID", "message": "input.evaluated_at is missing or not RFC3339. Denying."}
}

# --- Secret scanning -------------------------------------------------------

repo_violations contains v if {
	object.get(input, ["gitleaks", "status"], "missing") != "ran"
	v := {"code": "GITLEAKS_DID_NOT_RUN", "message": "gitleaks.status is not \"ran\". A gate that did not execute is not a pass. Denying."}
}

repo_violations contains v if {
	not is_array(object.get(input, ["gitleaks", "findings"], null))
	v := {"code": "GITLEAKS_REPORT_MALFORMED", "message": "gitleaks.findings is missing or not an array. Denying."}
}

repo_violations contains v if {
	not is_number(object.get(input, ["gitleaks", "config_bytes"], null))
	v := {"code": "GITLEAKS_CONFIG_UNKNOWN", "message": "gitleaks.config_bytes is missing or not a number. Denying."}
}

repo_violations contains v if {
	b := object.get(input, ["gitleaks", "config_bytes"], null)
	is_number(b)
	b < 64
	v := {"code": "GITLEAKS_CONFIG_EMPTY", "bytes": b, "message": sprintf(".gitleaks.toml is %v bytes. An empty config silently disables every rule and exits 0. Denying.", [b])}
}

repo_violations contains v if {
	object.get(input, ["gitleaks", "uses_default_ruleset"], false) != true
	v := {"code": "GITLEAKS_DEFAULTS_DISABLED", "message": ".gitleaks.toml must set [extend] useDefault = true. Denying."}
}

repo_violations contains v if {
	some leak in object.get(input, ["gitleaks", "findings"], [])
	v := {
		"code": "SECRET_DETECTED",
		"file": object.get(leak, "File", "missing"),
		"rule": object.get(leak, "RuleID", "missing"),
		"message": sprintf("Secret detected in %v (rule %v). Denying.", [object.get(leak, "File", "missing"), object.get(leak, "RuleID", "missing")]),
	}
}

# --- Tool pinning ----------------------------------------------------------
# These binaries run in the same job as the cosign signing key. build.yml
# installed syft and grype from anchore/{syft,grype}/main -- the default branch,
# piped into sh -- in exactly that job.

repo_violations contains v if {
	not is_object(object.get(input, ["tools"], null))
	v := {"code": "TOOLS_LOCK_MISSING", "message": "input.tools is missing. tools.lock could not be read. Denying."}
}

repo_violations contains v if {
	some name, version in object.get(input, ["tools"], {})
	not regex.match(`^v?[0-9]+\.[0-9]+\.[0-9]+`, version)
	v := {
		"code": "TOOL_NOT_PINNED",
		"tool": name,
		"message": sprintf("tools.lock pins %v to %q, which is not a concrete version. Denying.", [name, version]),
	}
}

# --- Action pinning --------------------------------------------------------
# Reported by scripts/lint-workflows.sh, decided here.

repo_violations contains v if {
	some ref in object.get(input, ["unpinned_actions"], [])
	v := {
		"code": "ACTION_NOT_PINNED",
		"ref": ref,
		"message": sprintf("%v is not pinned to a full commit SHA. A movable ref is code execution in CI. Denying.", [ref]),
	}
}
