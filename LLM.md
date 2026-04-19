# Lux Papers -- LLM.md

## LP-105: Quasar Consensus (`lp-105-quasar-consensus.tex`)

Main protocol paper. 19 pages. Sections:

- **S1 Introduction**: Three-layer consensus, algebraic independence of assumptions.
- **S2 System Model**: Partial synchrony, static Byzantine corruption, cryptographic config.
- **S3 Protocol**: Photon (proposal), Wave (FPC voting), Quasar (certificate generation).
- **S4 Cryptographic Layers**: BLS12-381, Corona (Ring-LWE threshold), ML-DSA-65.
- **S5 Chain Separation** (added 2026-04-13): X=verify, Q=Corona consensus, T=all MPC, Z=Groth16 of ML-DSA. Table~2.
- **S6 QuasarCert** (added 2026-04-13): Formal 3-tuple definition. $(\sigma_{RT}, \sigma_{BLS}, \pi_{ZK})$. Groth16 compresses N ML-DSA sigs to 192 bytes. Def~6.1, Def~6.2.
- **S7 Security Analysis**: Safety (Thm~7.1), Liveness (Thm~7.2), Unforgeability (Thm~7.3), Single-Compromise (Thm~7.4).
  - **S7.5 QuasarCert Soundness** (added 2026-04-13): Thm~7.5. Per-component forgery analysis + composition. Union bound.
  - **S7.6 Parallel Liveness** (added 2026-04-13): Thm~7.6. Three paths parallel; adversary must stall all three.
  - **S7.7 Post-Quantum Safety** (added 2026-04-13): Thm~7.7. If co-CDH falls to Shor, Corona + ML-DSA suffice. Explicit hybrid reduction.
- **S8 Performance**: BLS 371us, ML-DSA 504us, Corona 2-round, ZAP wire protocol.
- **S9 Implementation**: Go 1.24, luxfi/consensus, SQLite WAL, epoch pruning.
- **S10 Formal Verification**: Lean 4 + Tamarin artifacts.
- **Appendix A** (added 2026-04-13): Why not threshold ML-DSA (rejection sampling circular dependency, hint computation, no NIST standard) or threshold FALCON (distributed Gaussian sampling open problem, O(n^2) rounds, secondary standard).

Companion proof: `/Users/z/work/lux/proofs/quasar-cert-soundness.tex` (10 pages, 831 lines).

### Proof Sketch Appendices (added 2026-04-13)

- **Appendix B** (`\ref{app:circuit}`): ML-DSA-65 Groth16 circuit analysis. R1CS constraint count: ~1.35M per verification, ~5.77M total (n=21 optimized, ~2^22.5). Proof size 192B (circuit-independent). CPU prover ~400ms, GPU ~5-15ms. Corrects 357us claim.
- **Appendix C** (`\ref{app:adaptive}`): Adaptive corruption model. Static-only for Thm 7.5. Two corollaries: (1) programmable RO with O(n*Q_H) loss, (2) erasure model with no loss. Cites Canetti 2001, Fischlin 2005, Garay-Kiayias-Leonardos 2015.
- **Appendix D** (`\ref{app:setup}`): Groth16 trusted setup. Circuit-specific SRS, N-party ceremony (Bowe-Gabizon-Miers 2017), PLONK/Marlin as universal-setup upgrade path (192B -> ~500B).
- **Appendix E** (`\ref{app:corona-params}`): Corona parameter tightness. d=2048, q~2^48, BKZ beta~430. Classical 2^142, quantum 2^130.35 via BDGL sieving + Grover. Comparison table with ML-DSA-65 and ML-KEM-768. Four explicit caveats.

LP-105 Thm 7.5 and Thm 7.7 now cross-reference these appendices via `\cite{qcert-proof}`.

## Related Papers

- `lux-quasar-consensus.tex`: Earlier Quasar draft (superseded by LP-105).
- `lux-triple-proof-consensus.tex`: Triple-proof note (superseded by LP-105).
- `lux-corona-pq.tex`: Corona scheme (cited by LP-105 as [corona]).
- `lux-threshold-mpc.tex`: FROST + CGGMP21 for T-Chain custody.
- `lux-zchain.tex`: Z-Chain privacy/ZKP architecture.
- `lux-mchain-mpc.tex`: M-Chain (predecessor of T-Chain concept).

## Build

```bash
cd ~/work/lux/papers
/Library/TeX/texbin/pdflatex -interaction=nonstopmode lp-105-quasar-consensus.tex
# Run twice for cross-references
```
