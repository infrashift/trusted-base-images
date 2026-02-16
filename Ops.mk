# Ops.mk — Operational targets for GHCR image management
#
# Usage:
#   make -f Ops.mk list-images target_namespace=development
#   make -f Ops.mk clean-ghcr-namespace target_namespace=development

SHELL := /bin/bash
.ONESHELL:

REPO       := infrashift/trusted-base-images
REGISTRY   := ghcr.io/$(REPO)
ORG        := infrashift
PKG_PREFIX := trusted-base-images

# Derive image names from versions.json
IMAGES := $(shell jq -r '[to_entries[] | .key as $$ver | .value | to_entries[] | select(.value | type == "object" and has("base")) | "\($$ver)-\(.key)"] | .[]' versions.json)

# --- Validation ---

_require_namespace:
ifndef target_namespace
	$(error target_namespace is required (e.g. target_namespace=development))
endif

# --- Targets ---

.PHONY: list-images
list-images: _require_namespace
	@echo "=== $(REGISTRY)/$(target_namespace) ==="
	@echo ""
	@FOUND=0; \
	for img in $(IMAGES); do \
		PKG="$(PKG_PREFIX)%2F$(target_namespace)%2F$${img}"; \
		TAGS=$$(gh api "orgs/$(ORG)/packages/container/$${PKG}/versions" \
			--jq '[.[].metadata.container.tags[] | select(startswith("sha256-") | not)] | sort | join(", ")' 2>/dev/null); \
		if [ $$? -eq 0 ] && [ -n "$$TAGS" ]; then \
			echo "$$img: $$TAGS"; \
			FOUND=$$((FOUND + 1)); \
		fi; \
	done; \
	if [ "$$FOUND" -eq 0 ]; then \
		echo "No packages found in $(target_namespace) namespace."; \
	fi

.PHONY: clean-ghcr-namespace
clean-ghcr-namespace: _require_namespace
	@echo "Cleaning $(REGISTRY)/$(target_namespace)..."
	@echo ""
	@DELETED=0; \
	for img in $(IMAGES); do \
		PKG="$(PKG_PREFIX)%2F$(target_namespace)%2F$${img}"; \
		if gh api "orgs/$(ORG)/packages/container/$${PKG}" --jq '.name' >/dev/null 2>&1; then \
			echo -n "  Deleting $(target_namespace)/$${img}... "; \
			gh api -X DELETE "orgs/$(ORG)/packages/container/$${PKG}" 2>&1 && echo "done"; \
			DELETED=$$((DELETED + 1)); \
		fi; \
	done; \
	if [ "$$DELETED" -eq 0 ]; then \
		echo "  No packages found in $(target_namespace) namespace."; \
	else \
		echo ""; \
		echo "Deleted $$DELETED package(s)."; \
	fi
