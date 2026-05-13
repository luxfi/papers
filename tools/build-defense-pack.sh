#!/usr/bin/env bash
# build-defense-pack.sh — reproducible Defense Pack builder.
#
# Reads defense-pack.yaml at the repo root, validates every source PDF,
# copies them flat into a staging directory, and emits a single tarball
# with a sha256 sum.
#
# Inputs (env):
#   HANZO_PAPERS_DIR   override path to hanzoai/papers checkout
#                      (default: ../../hanzo/papers relative to repo root)
#   OUT_DIR            output directory (default: dist)
#   ALLOW_UNRESOLVED   if 1, skip UNRESOLVED entries instead of failing
#
# Outputs:
#   <OUT_DIR>/<release>.tar.gz
#   <OUT_DIR>/<release>.tar.gz.sha256
#   <OUT_DIR>/<release>.manifest.txt  (per-file sha256, sorted)
#
# Requirements: bash, tar, gzip, find, sort, shasum (or sha256sum), and
# either yq (mikefarah) or python3 with pyyaml/json fallback.

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
manifest="${repo_root}/defense-pack.yaml"
hanzo_dir="${HANZO_PAPERS_DIR:-${repo_root}/../../hanzo/papers}"
out_dir="${OUT_DIR:-${repo_root}/dist}"
allow_unresolved="${ALLOW_UNRESOLVED:-0}"

if [[ ! -f "$manifest" ]]; then
    echo "error: manifest not found: $manifest" >&2
    exit 1
fi

# Pick a sha256 implementation.
if command -v sha256sum >/dev/null 2>&1; then
    sha256() { sha256sum "$1" | awk '{print $1}'; }
elif command -v shasum >/dev/null 2>&1; then
    sha256() { shasum -a 256 "$1" | awk '{print $1}'; }
else
    echo "error: need sha256sum or shasum" >&2
    exit 1
fi

# Parse the manifest into TSV: name<TAB>repo<TAB>path<TAB>pdf
parse_manifest() {
    if command -v yq >/dev/null 2>&1; then
        yq -r '.entries[] | [.name, .repo, .path, .pdf] | @tsv' "$manifest"
    else
        python3 - "$manifest" <<'PY'
import sys
try:
    import yaml
    with open(sys.argv[1]) as f:
        data = yaml.safe_load(f)
except ImportError:
    # Minimal fallback parser for the tightly-controlled manifest format.
    data = {"release": None, "entries": []}
    cur = None
    with open(sys.argv[1]) as f:
        for line in f:
            s = line.rstrip("\n")
            if s.startswith("release:"):
                data["release"] = s.split(":", 1)[1].strip()
            elif s.startswith("  - name:"):
                if cur is not None:
                    data["entries"].append(cur)
                cur = {"name": s.split(":", 1)[1].strip()}
            elif s.startswith("    "):
                if cur is None:
                    continue
                k, _, v = s.strip().partition(":")
                v = v.strip()
                if v.startswith('"') and v.endswith('"'):
                    v = v[1:-1]
                if "  #" in v:
                    v = v.split("  #", 1)[0].strip()
                cur[k] = v
    if cur is not None:
        data["entries"].append(cur)
for e in data["entries"]:
    print("\t".join([e["name"], e["repo"], e.get("path", ""), e["pdf"]]))
PY
    fi
}

release="$(grep -E '^release:' "$manifest" | head -1 | awk '{print $2}')"
if [[ -z "$release" ]]; then
    echo "error: release not found in manifest" >&2
    exit 1
fi

tmp_entries="$(mktemp)"
parse_manifest > "$tmp_entries"

echo "Defense Pack: $release"
echo "Repo root:    $repo_root"
echo "Hanzo papers: $hanzo_dir"
echo "Output dir:   $out_dir"
echo

staging_root="$(mktemp -d)"
staging="$staging_root/Lux-Hanzo-Defense-Pack"
mkdir -p "$staging"
trap 'rm -rf "$staging_root" "$tmp_entries"' EXIT INT TERM

resolved=0
unresolved=0
missing=0

while IFS=$'\t' read -r name repo path pdf; do
    [[ -z "$name" ]] && continue
    if [[ "$repo" == "UNRESOLVED" ]]; then
        if [[ "$allow_unresolved" == "1" ]]; then
            echo "skip UNRESOLVED: $pdf"
            unresolved=$((unresolved + 1))
            continue
        else
            echo "error: UNRESOLVED entry: $pdf (set ALLOW_UNRESOLVED=1 to skip)" >&2
            unresolved=$((unresolved + 1))
            continue
        fi
    fi

    case "$repo" in
        luxfi/papers)   src_root="$repo_root" ;;
        hanzoai/papers) src_root="$hanzo_dir" ;;
        luxfi/*)        src_root="${repo_root}/../$(echo "$repo" | cut -d/ -f2)" ;;
        hanzoai/*)      src_root="${hanzo_dir%/papers}/$(echo "$repo" | cut -d/ -f2)" ;;
        *) echo "error: unknown repo '$repo' for $pdf" >&2; missing=$((missing + 1)); continue ;;
    esac

    src="$src_root/$path"
    if [[ ! -f "$src" ]]; then
        echo "MISSING: $src ($pdf)" >&2
        missing=$((missing + 1))
        continue
    fi
    if [[ ! -s "$src" ]]; then
        echo "EMPTY:   $src ($pdf)" >&2
        missing=$((missing + 1))
        continue
    fi
    # PDF magic check (first 4 bytes == %PDF) — pdftotext if available.
    if [[ "$(head -c 4 "$src")" != "%PDF" ]]; then
        echo "NOTPDF:  $src ($pdf)" >&2
        missing=$((missing + 1))
        continue
    fi
    if command -v pdftotext >/dev/null 2>&1; then
        if ! pdftotext -l 1 "$src" - >/dev/null 2>&1; then
            echo "UNREADABLE: $src ($pdf)" >&2
            missing=$((missing + 1))
            continue
        fi
    fi

    cp "$src" "$staging/$pdf"
    resolved=$((resolved + 1))
done < "$tmp_entries"

echo
echo "Resolved:   $resolved"
echo "Unresolved: $unresolved"
echo "Missing:    $missing"

if (( missing > 0 )); then
    echo "error: $missing source PDF(s) missing or invalid" >&2
    exit 2
fi
if (( unresolved > 0 )) && [[ "$allow_unresolved" != "1" ]]; then
    echo "error: $unresolved UNRESOLVED entry(ies) — set ALLOW_UNRESOLVED=1 to skip" >&2
    exit 3
fi

mkdir -p "$out_dir"
tarball="$out_dir/$release.tar.gz"
manifest_txt="$out_dir/$release.manifest.txt"

# Per-file sha (sorted, deterministic).
( cd "$staging" && for f in *.pdf; do
    printf "%s  %s\n" "$(sha256 "$f")" "$f"
done ) | sort > "$manifest_txt"

# Build tarball with sorted file order and zeroed mtime/uid/gid for reproducibility.
# Note: PDF *content* is still non-deterministic if LaTeX timestamps differ —
# this only makes the *archive layer* reproducible given identical PDFs.
# Prefer GNU tar (gtar on macOS); fall back to BSD tar with reduced determinism.
if command -v gtar >/dev/null 2>&1; then
    tar_bin=gtar
elif tar --version 2>&1 | grep -q 'GNU tar'; then
    tar_bin=tar
else
    tar_bin=""
fi
(
    cd "$staging_root"
    if [[ -n "$tar_bin" ]]; then
        $tar_bin --format=ustar \
            --sort=name \
            --owner=0 --group=0 --numeric-owner \
            --mtime='2026-05-12 00:00:00 UTC' \
            -cf - Lux-Hanzo-Defense-Pack | gzip -n > "$tarball"
    else
        echo "warning: GNU tar not found; using BSD tar (less reproducible)" >&2
        tar --format=ustar --uid 0 --gid 0 --numeric-owner \
            -cf - Lux-Hanzo-Defense-Pack | gzip -n > "$tarball"
    fi
)

pack_sha="$(sha256 "$tarball")"
printf "%s  %s\n" "$pack_sha" "$(basename "$tarball")" > "$tarball.sha256"

echo
echo "Wrote $tarball"
echo "  size: $(wc -c < "$tarball") bytes"
echo "  sha256: $pack_sha"
echo "Per-file manifest: $manifest_txt ($(wc -l < "$manifest_txt") entries)"
