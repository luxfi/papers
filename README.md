# Lux Network Research Papers

> Lux is not merely adding post-quantum signatures to a chain; it defines a hybrid finality architecture for DAG-native consensus, with protocol-agnostic threshold lifecycle, post-quantum threshold sealing, and cross-chain propagation of Horizon finality.

See [LP-105 §Claims and evidence](https://github.com/luxfi/lps/blob/main/LP-105-lux-stack-lexicon.md#claims-and-evidence) for the canonical claims/evidence table and the ten architectural commitments — single source of truth.

Technical and formal papers covering the Lux multi-consensus blockchain: Quasar consensus engine, post-quantum cryptography, cross-chain bridging, DeFi protocols, and EVM infrastructure.

## Structure

Each paper lives in its own subdirectory:
```
papers/
├── shared/             # cover styles, lstlang.tex, paperkit
│   ├── luxcover.sty
│   └── lstlang.tex
├── <paper-slug>/
│   ├── <paper-slug>.tex          # main file (\input's sections)
│   ├── <paper-slug>.pdf          # compiled output
│   └── sections/                 # modular sections
│       ├── 01-intro.tex
│       ├── 02-architecture.tex
│       ├── 03-protocol.tex
│       ├── ...
│       └── 99-bibliography.tex
└── INDEX.md                      # auto-generated catalogue
```

## Building

```bash
cd <paper-slug>
TEXINPUTS=".:..:" latexmk -pdf <paper-slug>.tex
```

Or build all:
```bash
make all
```

## Index

See [INDEX.md](INDEX.md) for full catalogue of papers.

## Defense Pack

`defense-pack.yaml` is the authoritative manifest of the curated bundle
distributed via [GitHub Releases](https://github.com/luxfi/papers/releases)
under the `defense-pack-*` tag prefix. Each entry maps an output filename
to its source repository + relative path (`luxfi/papers` or `hanzoai/papers`),
so the pack is fully reproducible from git state — no ad-hoc copies.

Build locally:

```bash
# Default: sibling clone at ../../hanzo/papers
bash tools/build-defense-pack.sh

# Custom hanzoai/papers location
HANZO_PAPERS_DIR=/path/to/hanzoai-papers bash tools/build-defense-pack.sh

# Skip UNRESOLVED entries (manifest items with no source yet)
ALLOW_UNRESOLVED=1 bash tools/build-defense-pack.sh
```

Outputs land in `dist/`:
- `<release>.tar.gz`             — bundled PDFs under `Lux-Hanzo-Defense-Pack/`
- `<release>.tar.gz.sha256`      — archive digest
- `<release>.manifest.txt`       — per-file sha256 digests, sorted

CI: pushing a `defense-pack-*` tag triggers `.github/workflows/defense-pack.yml`,
which checks out both repos, builds via the same script, and attaches the
tarball + sha256 + per-file manifest to the GitHub Release. Manual dispatch
also uploads workflow artifacts for inspection.

**Reproducibility caveat.** The build script makes the *archive layer*
reproducible (sorted entries, zeroed uid/gid, fixed mtime, gzip without
filename). PDF *content* itself is non-deterministic across `latexmk` runs
unless `SOURCE_DATE_EPOCH` is pinned at compile time — see
`tools/build-defense-pack.sh` and follow-up in `FOLLOW-UPS-2026-05-12.md`.
Use `<release>.manifest.txt` to check whether a divergence is in a single
PDF or in the archive layer.

## Conventions

1. **One paper, one directory**. No top-level .tex files.
2. **Modular sections**. Main .tex \input's `sections/NN-name.tex` files for easy editing.
3. **Shared cover**. All papers use `\usepackage{shared/luxcover}` and `\luxcoverpage`.
4. **Shared lstlang**. All papers use `\input{shared/lstlang}` after `\usepackage{listings}`.
5. **No AI slop**. Technical, dense, citation-supported.
6. **One paper per concept**. Updates over time via versioning, not duplication.
