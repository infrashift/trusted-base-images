package tbi.pdp_test

import data.tbi.pdp

# The gate consumes `violations` as a JSON ARRAY. If any of these rules is ever
# written `p[x] if { ... }` instead of `p contains x if { ... }`, Rego v1 makes
# it a partial OBJECT, `opa check --strict` still passes, and a clean scan
# marshals to {} instead of []. A sibling repo blocked every release that way.
# The shape assertions below are the guard, because a type check will not do it.

NOW := "2026-08-24T00:00:00Z"

# ===========================================================================
# repo_decision -- the repository gate
# ===========================================================================

clean_repo := {
	"evaluated_at": NOW,
	"gitleaks": {"status": "ran", "findings": [], "config_bytes": 2975, "uses_default_ruleset": true},
	"tools": {"OPA_VERSION": "v1.19.1", "SYFT_VERSION": "v1.51.0"},
	"unpinned_actions": [],
}

test_clean_repo_is_allowed if {
	d := pdp.repo_decision with input as clean_repo
	d.allow
	d.counts.violations == 0
}

test_repo_violations_marshal_as_an_array if {
	d := pdp.repo_decision with input as clean_repo
	json.marshal(d.violations) == "[]"
	json.marshal(d.warnings) == "[]"
}

# --- fail closed on the input itself ---------------------------------------

test_missing_timestamp_denies if {
	d := pdp.repo_decision with input as object.remove(clean_repo, {"evaluated_at"})
	not d.allow
	some v in d.violations
	v.code == "INPUT_TIMESTAMP_INVALID"
}

test_non_rfc3339_timestamp_denies if {
	d := pdp.repo_decision with input as object.union(clean_repo, {"evaluated_at": "yesterday"})
	not d.allow
}

test_default_repo_decision_denies if {
	d := pdp.repo_decision with input as "not-an-object"
	not d.allow
}

# --- secret scanning -------------------------------------------------------
# The first two are the exact failure this repository shipped: a 0-byte config,
# and a pass asserted by something other than a scan.

test_empty_gitleaks_config_denies if {
	d := pdp.repo_decision with input as object.union(clean_repo, {"gitleaks": {"status": "ran", "findings": [], "config_bytes": 0, "uses_default_ruleset": true}})
	not d.allow
	some v in d.violations
	v.code == "GITLEAKS_CONFIG_EMPTY"
	v.bytes == 0
}

test_gitleaks_not_run_denies if {
	d := pdp.repo_decision with input as object.union(clean_repo, {"gitleaks": {"status": "not-installed", "findings": [], "config_bytes": 2975, "uses_default_ruleset": true}})
	not d.allow
	some v in d.violations
	v.code == "GITLEAKS_DID_NOT_RUN"
}

# A config just under the floor still denies; the boundary is 64 bytes.
test_config_below_the_floor_denies if {
	d := pdp.repo_decision with input as object.union(clean_repo, {"gitleaks": {"status": "ran", "findings": [], "config_bytes": 63, "uses_default_ruleset": true}})
	not d.allow
	some v in d.violations
	v.code == "GITLEAKS_CONFIG_EMPTY"
}

test_config_at_the_floor_is_allowed if {
	d := pdp.repo_decision with input as object.union(clean_repo, {"gitleaks": {"status": "ran", "findings": [], "config_bytes": 64, "uses_default_ruleset": true}})
	d.allow
}

test_gitleaks_defaults_disabled_denies if {
	d := pdp.repo_decision with input as object.union(clean_repo, {"gitleaks": {"status": "ran", "findings": [], "config_bytes": 2975, "uses_default_ruleset": false}})
	not d.allow
	some v in d.violations
	v.code == "GITLEAKS_DEFAULTS_DISABLED"
}

test_malformed_findings_denies if {
	d := pdp.repo_decision with input as object.union(clean_repo, {"gitleaks": {"status": "ran", "findings": "none", "config_bytes": 2975, "uses_default_ruleset": true}})
	not d.allow
	some v in d.violations
	v.code == "GITLEAKS_REPORT_MALFORMED"
}

test_non_numeric_config_bytes_denies if {
	d := pdp.repo_decision with input as object.union(clean_repo, {"gitleaks": {"status": "ran", "findings": [], "config_bytes": "big", "uses_default_ruleset": true}})
	not d.allow
	some v in d.violations
	v.code == "GITLEAKS_CONFIG_UNKNOWN"
}

test_detected_secret_denies_and_names_the_file if {
	d := pdp.repo_decision with input as object.union(clean_repo, {"gitleaks": {
		"status": "ran",
		"findings": [{"File": "scripts/release-leg.sh", "RuleID": "cosign-sigstore-private-key"}],
		"config_bytes": 2975,
		"uses_default_ruleset": true,
	}})
	not d.allow
	some v in d.violations
	v.code == "SECRET_DETECTED"
	v.file == "scripts/release-leg.sh"
	v.rule == "cosign-sigstore-private-key"
}

# --- tool and action pinning -----------------------------------------------

test_unpinned_tool_denies if {
	d := pdp.repo_decision with input as object.union(clean_repo, {"tools": {"SYFT_VERSION": "main"}})
	not d.allow
	some v in d.violations
	v.code == "TOOL_NOT_PINNED"
	v.tool == "SYFT_VERSION"
}

test_missing_tools_lock_denies if {
	d := pdp.repo_decision with input as object.remove(clean_repo, {"tools"})
	not d.allow
	some v in d.violations
	v.code == "TOOLS_LOCK_MISSING"
}

test_unpinned_action_denies if {
	d := pdp.repo_decision with input as object.union(clean_repo, {"unpinned_actions": ["actions/checkout@v4"]})
	not d.allow
	some v in d.violations
	v.code == "ACTION_NOT_PINNED"
	v.ref == "actions/checkout@v4"
}

# ===========================================================================
# allow_pipeline and the image rules -- pre-existing, previously untested
# ===========================================================================
# These rules shipped in the initial commit with no test file at all. The tests
# below pin the behaviour they already have, so the port does not quietly change
# it, and so the fail-closed rule at the bottom of policies.rego is proven to
# actually fail closed rather than merely being written that way.

test_pipeline_allowed_when_no_secrets if {
	pdp.allow_pipeline with input as {"gitleaks_results": []}
}

test_pipeline_denied_when_a_secret_is_found if {
	not pdp.allow_pipeline with input as {"gitleaks_results": [{"File": "a.sh", "RuleID": "pem-private-key-block"}]}
}

test_pipeline_denied_when_input_is_absent if {
	not pdp.allow_pipeline with input as {}
}

clean_scan := {"scan_results": {"critical_count": 0, "fixable_high_count": 0}}

test_clean_scan_has_no_threshold_violation if {
	count(pdp.violation_security_threshold) == 0 with input as clean_scan
}

test_critical_blocks if {
	count(pdp.violation_security_threshold) > 0 with input as {"scan_results": {"critical_count": 1, "fixable_high_count": 0}}
}

test_fixable_high_blocks if {
	count(pdp.violation_security_threshold) > 0 with input as {"scan_results": {"critical_count": 0, "fixable_high_count": 3}}
}

# The comment above the rule says highs with no available fix are recorded but
# do not block. Nothing asserted that until now.
test_unfixable_high_does_not_block if {
	count(pdp.violation_security_threshold) == 0 with input as {"scan_results": {"critical_count": 0, "fixable_high_count": 0, "high_count": 12}}
}

# --- the fail-closed rule --------------------------------------------------
# "> 0" comparisons are undefined, and therefore silently non-violating, when a
# count is missing or not a number. These prove the guard against that.

test_missing_scan_results_blocks if {
	count(pdp.violation_security_threshold) > 0 with input as {}
}

test_missing_critical_count_blocks if {
	count(pdp.violation_security_threshold) > 0 with input as {"scan_results": {"fixable_high_count": 0}}
}

test_non_numeric_count_blocks if {
	count(pdp.violation_security_threshold) > 0 with input as {"scan_results": {"critical_count": "none", "fixable_high_count": 0}}
}

test_null_count_blocks if {
	count(pdp.violation_security_threshold) > 0 with input as {"scan_results": {"critical_count": null, "fixable_high_count": 0}}
}
