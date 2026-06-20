# Lux Papers -- LLM.md

## Post-E2E-PQ State (current)

Papers in this repo are the LaTeX backing for the LP / HIP proposal
set. Pulsar (HIP-0084 / LP-171) and Z-Wing (LP-9702 — hybrid PQ secure
channel) are the new additions this session.

### Recent significant commits

| SHA | Impact |
|-----|--------|
| `9bae519` | LP-9702: Z-Wing hybrid PQ secure channel |
| `ee5f6d2` | PQ canonical terminology (FIPS 203/204/205 + Pulsar + Lamport) |
| `75b2ab8` | Warp 2.0 canonical naming (Beam + ML-DSA + Pulse) + Lux Teleport rebrand |
| `d747bfe` | lux-nist-mptc-submission: convert .md → .tex (LaTeX-only rule) |
| `e7b9509` | lp-103: T-Chain (FHE) → F-Chain per LP-134 |
| `78371e8` | M/F/Z-Chain canonical naming per LP-134 |

### Rules

- LaTeX only. Per user CLAUDE.md: papers, proofs, audits MUST be `.tex`
  (no `.md`). Translation of any prior `.md` is a one-shot conversion.
- Cross-references between LP-020 (Quasar) and the proofs repo are
  kept explicit via `\cite{qcert-proof}`.

---

## LP-020: Quasar Consensus (`lp-020-quasar-consensus.tex`)

Main protocol paper. 19 pages. Sections:

- **S1 Introduction**: Three-layer consensus, algebraic independence of assumptions.
- **S2 System Model**: Partial synchrony, static Byzantine corruption, cryptographic config.
- **S3 Protocol**: Photon (proposal), Wave (FPC voting), Quasar (certificate generation).
- **S4 Cryptographic Layers**: BLS12-381, Pulsar (Module-LWE threshold), ML-DSA-65.
- **S5 Chain Separation** (added 2026-04-13): X=verify, Q=Pulsar consensus, T=all MPC, Z=Groth16 of ML-DSA. Table~2.
- **S6 QuasarCert** (added 2026-04-13): Formal 3-tuple definition. $(\sigma_{RT}, \sigma_{BLS}, \pi_{ZK})$. Groth16 compresses N ML-DSA sigs to 192 bytes. Def~6.1, Def~6.2.
- **S7 Security Analysis**: Safety (Thm~7.1), Liveness (Thm~7.2), Unforgeability (Thm~7.3), Single-Compromise (Thm~7.4).
  - **S7.5 QuasarCert Soundness** (added 2026-04-13): Thm~7.5. Per-component forgery analysis + composition. Union bound.
  - **S7.6 Parallel Liveness** (added 2026-04-13): Thm~7.6. Three paths parallel; adversary must stall all three.
  - **S7.7 Post-Quantum Safety** (added 2026-04-13): Thm~7.7. If co-CDH falls to Shor, Pulsar + ML-DSA suffice. Explicit hybrid reduction.
- **S8 Performance**: BLS 371us, ML-DSA 504us, Pulsar 2-round, ZAP wire protocol.
- **S9 Implementation**: Go 1.24, luxfi/consensus, SQLite WAL, epoch pruning.
- **S10 Formal Verification**: Lean 4 + Tamarin artifacts.
- **Appendix A** (added 2026-04-13): Why not threshold ML-DSA (rejection sampling circular dependency, hint computation, no NIST standard) or threshold FALCON (distributed Gaussian sampling open problem, O(n^2) rounds, secondary standard).

Companion proof: `/Users/z/work/lux/proofs/quasar-cert-soundness.tex` (10 pages, 831 lines).

### Proof Sketch Appendices (added 2026-04-13)

- **Appendix B** (`\ref{app:circuit}`): ML-DSA-65 Groth16 circuit analysis. R1CS constraint count: ~1.35M per verification, ~5.77M total (n=21 optimized, ~2^22.5). Proof size 192B (circuit-independent). CPU prover ~400ms, GPU ~5-15ms. Corrects 357us claim.
- **Appendix C** (`\ref{app:adaptive}`): Adaptive corruption model. Static-only for Thm 7.5. Two corollaries: (1) programmable RO with O(n*Q_H) loss, (2) erasure model with no loss. Cites Canetti 2001, Fischlin 2005, Garay-Kiayias-Leonardos 2015.
- **Appendix D** (`\ref{app:setup}`): Groth16 trusted setup. Circuit-specific SRS, N-party ceremony (Bowe-Gabizon-Miers 2017), PLONK/Marlin as universal-setup upgrade path (192B -> ~500B).
- **Appendix E** (`\ref{app:corona-params}`): Pulsar parameter tightness. d=2048, q~2^48, BKZ beta~430. Classical 2^142, quantum 2^130.35 via BDGL sieving + Grover. Comparison table with ML-DSA-65 and ML-KEM-768. Four explicit caveats.

LP-020 Thm 7.5 and Thm 7.7 now cross-reference these appendices via `\cite{qcert-proof}`.

## Related Papers

- `lux-quasar-consensus.tex`: Earlier Quasar draft (superseded by LP-020).
- `lux-triple-proof-consensus.tex`: Triple-proof note (superseded by LP-020).
- `lux-corona-pq.tex`: **the canonical Corona paper** — "Corona: Two-Round Module-LWE Threshold Signatures for Public Permissionless Chains". Module-LWE at module rank 7 (matrix `A ∈ R_q^{8×7}`, `b = A·s + e`, `R_q = Z_q[X]/(X^256+1)`, 48-bit `q`), Module-SIS commitments, leaderless permissionless DKG, ~33 KB sigs (NIST Cat-1), precompile `0x012206` / P3Q kind `0x02`, Aurora-profile diversity leg (Pulsar ‖ Corona). Aligns with LP-4440 and the `luxfi/corona`/Ringtail parameters (N=256/M=8/Nvec=7). The Corona↔Pulsar distinction is parameter regime / lifecycle (Corona = the Ringtail-derived permissionless-DKG leg), **not** rank-1-vs-rank-k; both are Module-LWE. Pulsar is the ML-DSA-byte-equal sibling at LP-4450 / `lp-073-pulsar`. (Rewritten 2026-06 from the old mislabeled "Pulsar" body.)
- `lux-threshold-mpc.tex`: FROST + CGGMP21 for M-Chain custody (the MPC chain).
- `lux-zchain.tex`: Z-Chain privacy/ZKP architecture.
- `lux-mchain-mpc.tex`: M-Chain MPC — the threshold/MPC chain (T-Chain was split into M-Chain (MPC) + F-Chain (FHE)).

## Build

```bash
cd ~/work/lux/papers
/Library/TeX/texbin/pdflatex -interaction=nonstopmode lp-020-quasar-consensus.tex
# Run twice for cross-references
```
