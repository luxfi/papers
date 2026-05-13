#!/usr/bin/env bash
# Copy section files from each engine paper into ./sections/ with engine prefix
# and label namespacing so they can coexist in one document.
set -euo pipefail

cd "$(dirname "$0")"
SRC=/Users/z/work/lux/papers

# engine_dir : prefix : intro_only_skip_dupes
engines=(
  "lux-photon-protocol:photon"
  "lux-wave-protocol:wave"
  "lux-nova-protocol:nova"
  "lux-nebula-protocol:nebula"
  "lux-prism-protocol:prism"
  "lux-ray-protocol:ray"
  "lux-field-protocol:field"
)

rm -rf sections
mkdir -p sections

for entry in "${engines[@]}"; do
  dir="${entry%%:*}"
  prefix="${entry##*:}"
  for f in "$SRC/$dir/sections/"*.tex; do
    base="$(basename "$f")"
    # skip the per-engine conclusion (we will write a single combined one);
    # but keep each engine's other content
    if [[ "$base" == "99-conclusion.tex" ]]; then
      continue
    fi
    out="sections/${prefix}-${base}"
    # Rewrite labels and refs to be engine-namespaced; this is a local sed pass.
    # Also: strip duplicate label collisions (sec:introduction, sec:model, etc.)
    sed \
      -e "s/\\\\label{sec:/\\\\label{sec:${prefix}-/g" \
      -e "s/\\\\ref{sec:/\\\\ref{sec:${prefix}-/g" \
      -e "s/\\\\label{thm:/\\\\label{thm:${prefix}-/g" \
      -e "s/\\\\ref{thm:/\\\\ref{thm:${prefix}-/g" \
      -e "s/\\\\label{lem:/\\\\label{lem:${prefix}-/g" \
      -e "s/\\\\ref{lem:/\\\\ref{lem:${prefix}-/g" \
      -e "s/\\\\label{def:/\\\\label{def:${prefix}-/g" \
      -e "s/\\\\ref{def:/\\\\ref{def:${prefix}-/g" \
      -e "s/\\\\label{alg:/\\\\label{alg:${prefix}-/g" \
      -e "s/\\\\ref{alg:/\\\\ref{alg:${prefix}-/g" \
      -e "s/\\\\label{fig:/\\\\label{fig:${prefix}-/g" \
      -e "s/\\\\ref{fig:/\\\\ref{fig:${prefix}-/g" \
      -e "s/\\\\label{tab:/\\\\label{tab:${prefix}-/g" \
      -e "s/\\\\ref{tab:/\\\\ref{tab:${prefix}-/g" \
      -e "s/\\\\label{eq:/\\\\label{eq:${prefix}-/g" \
      -e "s/\\\\eqref{eq:/\\\\eqref{eq:${prefix}-/g" \
      -e "s/\\\\ref{eq:/\\\\ref{eq:${prefix}-/g" \
      "$f" > "$out"
  done
done

echo "Wrote $(ls sections | wc -l) section files."
