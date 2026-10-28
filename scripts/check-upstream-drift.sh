#!/usr/bin/env bash
# Compare every per-arch digest pinned in versions.json with the digest the
# upstream tag serves now.
#
# Usage: scripts/check-upstream-drift.sh [--apply] [versions.json]
#
# Prints a JSON array to stdout, one object per image/arch:
#   {image, key, variant, arch, base, tag, pinned, upstream, drifted}
#
# With --apply, also rewrites each drifted digest in versions.json in place and
# stamps `updated`/`reason` on every distro key that changed. The file is edited
# textually rather than round-tripped through jq, so its compact per-arch layout
# survives and the diff shows only the lines that moved.
#
# Before this existed, every refresh started from a downstream CVE report, and
# five of the six bases sat two months stale with no signal at all, because
# nothing compared the pins with upstream.
set -euo pipefail

APPLY=false
if [ "${1:-}" = "--apply" ]; then APPLY=true; shift; fi
VERSIONS="${1:-versions.json}"
TODAY="${TODAY:-$(date -u +%F)}"

die() { echo "error: $*" >&2; exit 1; }

# versions.json records the repository a pin came from, not the tag. Fedora
# repositories carry every release, so the tag is the release number; each UBI
# repository is already one major, so `latest` is the newest minor of it.
upstream_tag() {
  case "$1" in
    fedora[0-9]*) echo "${1#fedora}" ;;
    ubi[0-9]*)    echo latest ;;
    *) die "no upstream tag rule for distro key ${1}" ;;
  esac
}

DIGEST_RE='^sha256:[0-9a-f]{64}$'

ROWS='[]'
while IFS=$'\t' read -r key variant base; do
  tag=$(upstream_tag "$key")
  raw=$(skopeo inspect --retry-times 3 --raw "docker://${base}:${tag}") \
    || die "cannot read ${base}:${tag}"

  for arch in amd64 arm64; do
    pinned=$(jq -r --arg k "$key" --arg v "$variant" --arg a "$arch" \
      '.[$k][$v][$a].digest // empty' "$VERSIONS")
    [ -n "$pinned" ] || continue

    # Exactly one linux child per arch, or the index is not what we think it is.
    upstream=$(jq -r --arg a "$arch" '
      [.manifests[]? | select(.platform.os == "linux" and .platform.architecture == $a)]
      | if length == 1 then .[0].digest else empty end' <<<"$raw")
    [[ "$upstream" =~ $DIGEST_RE ]] \
      || die "${base}:${tag} has no single linux/${arch} manifest"

    # Same check every refresh PR has made by hand: the pin must be the per-arch
    # child, never the index, and it must report the arch it is pinned under.
    got=$(skopeo inspect --retry-times 3 --format '{{.Architecture}}' "docker://${base}@${upstream}")
    [ "$got" = "$arch" ] || die "${base}@${upstream} reports ${got}, expected ${arch}"

    ROWS=$(jq -c \
      --arg image "${key}-${variant}" --arg key "$key" --arg variant "$variant" \
      --arg arch "$arch" --arg base "$base" --arg tag "$tag" \
      --arg pinned "$pinned" --arg upstream "$upstream" \
      '. + [{image: $image, key: $key, variant: $variant, arch: $arch, base: $base,
             tag: $tag, pinned: $pinned, upstream: $upstream,
             drifted: ($pinned != $upstream)}]' <<<"$ROWS")
  done
done < <(jq -r 'to_entries[] | .key as $k | .value | to_entries[]
  | select(.value | type == "object" and has("base"))
  | [$k, .key, .value.base] | @tsv' "$VERSIONS")

if $APPLY; then
  while IFS=$'\t' read -r pinned upstream; do
    [ "$(grep -c "$pinned" "$VERSIONS")" -eq 1 ] || die "${pinned} is not pinned exactly once"
    sed -i "s/${pinned}/${upstream}/" "$VERSIONS"
  done < <(jq -r '.[] | select(.drifted) | [.pinned, .upstream] | @tsv' <<<"$ROWS")

  # One `updated`/`reason` pair per distro key, inside that key's block. Track
  # the enclosing top-level key and rewrite only the blocks that changed.
  CHANGED=$(jq -r '[.[] | select(.drifted) | .key] | unique | join(" ")' <<<"$ROWS")
  for key in $CHANGED; do
    images=$(jq -r --arg k "$key" '[.[] | select(.drifted and .key == $k) | .image] | unique | join(", ")' <<<"$ROWS")
    awk -v key="$key" -v today="$TODAY" -v reason="${images}: upstream refresh found by the drift check" '
      /^  "[^"]+": \{/ { match($0, /"[^"]+"/); cur = substr($0, RSTART + 1, RLENGTH - 2) }
      cur == key && /^    "updated": / { sub(/"updated": "[^"]*"/, "\"updated\": \"" today "\"") }
      cur == key && /^    "reason": /  { sub(/"reason": ".*"/, "\"reason\": \"" reason "\"") }
      { print }
    ' "$VERSIONS" > "${VERSIONS}.tmp" && mv "${VERSIONS}.tmp" "$VERSIONS"
  done

  # The edit is textual, so prove the result: valid JSON, and every pin is now
  # the upstream digest.
  jq -e --argjson rows "$ROWS" '
    . as $v | all($rows[]; $v[.key][.variant][.arch].digest == .upstream)' "$VERSIONS" > /dev/null \
    || die "versions.json does not match upstream after --apply"
fi

echo "$ROWS" | jq '.'
