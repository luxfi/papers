# Lux Network Research Papers

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

## Conventions

1. **One paper, one directory**. No top-level .tex files.
2. **Modular sections**. Main .tex \input's `sections/NN-name.tex` files for easy editing.
3. **Shared cover**. All papers use `\usepackage{shared/luxcover}` and `\luxcoverpage`.
4. **Shared lstlang**. All papers use `\input{shared/lstlang}` after `\usepackage{listings}`.
5. **No AI slop**. Technical, dense, citation-supported.
6. **One paper per concept**. Updates over time via versioning, not duplication.
