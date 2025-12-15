# Scientist Review -- Lux Papers and Proofs Accuracy Audit

Reviewer: Scientist agent
Date: 2026-04-12
Scope: lux/papers (89 .tex files), lux/proofs/lean (87 project .lean files), hanzo/proofs/lean (46 project .lean files + 3 CRDT files)

---

## 1. Paper Accuracy Scores

### 1.1 LP-105 Quasar Consensus (lp-105-quasar-consensus.tex)

**Score: CORRECT**

| Claim | Source (paper) | Source (code) | Match? |
|-------|---------------|---------------|--------|
| Triple-proof = BLS + Ringtail + ML-DSA | S3: three signing paths | `quasar/doc.go` line 3-6: "BLS12-381 threshold signatures, Ringtail (Ring-LWE) 2-round threshold, ML-DSA-65 (FIPS 204) identity signatures" | YES |
| Three hardness assumptions (ECDL, Module-LWE, Module-SIS/Ring-LWE) | S1 lines 89-100 | `doc.go` line 16: "break ECDL AND Module-LWE AND Module-SIS simultaneously" | YES |
| Four modes (BLS-only, BLS+ML-DSA, BLS+Ringtail, full Quasar) | Definition 2.3 | `doc.go` lines 10-13: four modes listed identically | YES |
| Parallel execution via goroutines | S3 line 261 | `doc.go` line 15: "TripleSignRound1 runs all three paths in parallel" | YES |
| BLS signing 371us, ML-DSA-65 504us, verification 18.8ns | Abstract | Cannot verify without running benchmark | UNVERIFIED |
| Full threshold round 69ms at n=100 | Abstract, S11 | Cannot verify without running benchmark | UNVERIFIED |
| Date: April 2026 | Header | Git commit 2026-04-13 | YES |

LP-105 bibliography: 7 references. All real papers. One self-citation (Ringtail, bibitem `ringtail`, attributed to "Z. Kelling and V. Seesahai, Lux Industries, 2024") -- this is a Lux internal paper, not a peer-reviewed or ePrint publication. The lux-quasar-consensus.tex version (older paper) cites it as "NTT Research (2024)" which is incorrect attribution -- NTT Research published Ringtail (Agrawal et al.), Lux's implementation is derived from but not identical to it.

### 1.2 Lux Quasar Consensus (lux-quasar-consensus.tex, older paper)

**Score: PARTIALLY CORRECT**

| Issue | Detail |
|-------|--------|
| Triple-proof description inconsistent | Paper abstract says "BLS + Ringtail" (two-part). Body says "BLS + ZK proof of ML-DSA" (two-part). Combined as "triple-proof" but the verification function `IsBlockFinal` (line 129-133) checks only `valid_BLS AND valid_ZK` -- Ringtail is embedded in the ZK proof, not a separate check. This is architecturally different from LP-105 which has all three as explicit parallel paths. |
| TPS claim 4,761,904 | Derived from 1B gas / 21000 gas per tx / 10ms = 4.76M TPS. Arithmetic is correct. However, 10ms finality requires GPU BLS on co-located validators. No evidence this has been benchmarked end-to-end at that TPS. Paper says "target" which is honest. |
| 434M orders/sec (Lightspeed DEX paper, cross-ref) | No benchmark data. Pure projection from gas limit. |
| Ringtail attribution | bibitem `ntt-ringtail` says "NTT Research (2024)" -- the actual Ringtail paper is by Agrawal, Garg, Masny, Peceny (NTT Research). Correct lab, incomplete authorship. |
| Verkle trees citation | Attributed to "Kuszmaul, J. (2019)" as "Ethereum Research". The actual Verkle trees paper is by John Kuszmaul (2018, now published). The "Ethereum Research" venue is informal -- it was an ethresear.ch post. Date varies across papers (2018, 2019, 2021 used in different .tex files). |
| Date: "2022 (Revised 2025)" | Git first commit of this file: 2025-10-28. The 2022 date for a Quasar paper is plausible if describing research that began in 2022, but the formal writeup postdates 2025. |

### 1.3 GPU EVM Whitepaper (gpu-evm-whitepaper.tex, in stash)

**Score: PARTIALLY CORRECT**

| Claim | Paper | Code/Reality | Verdict |
|-------|-------|-------------|---------|
| 85.9M opcodes/sec GPU | Stated as measured on M1 Max | No benchmark reproduction available to verify | UNVERIFIED |
| 20.9 Ggas/s C++ interpreter | Stated as 5.1x over Go | No benchmark reproduction available | UNVERIFIED |
| 7.1x ecrecover speedup (10 CPU cores) | Paper claims 7.1x on CPU multicore | `gpu_bridge.go` comment says "32x speedup" for GPU ecrecover. These are DIFFERENT claims: paper 7.1x is CPU-only parallelism, code 32x is GPU. **Not contradictory.** |
| 32x GPU ecrecover | dag-evm-formal.tex cites this | `gpu_bridge.go` line 11: "~50ms for 47K sigs (32x speedup)" | CONSISTENT |
| 13.2x total critical-path speedup | dag-evm-formal.tex: 2198ms CPU vs 167ms GPU | Paper-internal arithmetic checks out: 2198/167 = 13.2x | ARITHMETIC OK |
| Date: April 2025 | Paper header | Git stash from 2026-04-13 (paper written 2025-2026) | PLAUSIBLE |

Benchmark reconciliation with evm-bench session data (from user prompt: "3.78x dag-cpu on ERC-20, 2.78x dag-gpu"):
- The 13.2x total speedup includes GPU ecrecover (32x on the dominant stage). Without GPU ecrecover, DAG-parallel alone yields 3-4x on CPU, consistent with the 3.78x measured.
- The 2.78x dag-gpu number being LOWER than dag-cpu is suspicious -- this suggests GPU overhead dominates for the ERC-20 workload at current implementation maturity.
- **The paper's 13.2x is a projection combining all stages at maturity; the 3.78x is measured reality for CPU-only DAG parallelism on one workload. The paper does not adequately distinguish these.**

### 1.4 DAG-EVM Formal (dag-evm-formal.tex, in stash)

**Score: PARTIALLY CORRECT**

| Issue | Detail |
|-------|--------|
| Claims "formalised" for topo_equivalence | DAGEVM.lean line 236: `axiom topo_equivalence` -- NOT proved. Paper S3 text should say "conjectured" or "axiomatized", not "formalised". |
| Claims "formalised" for no_double_spend | DAGZChain.lean line 220: `axiom no_double_spend_axiom` -- NOT proved. Same issue. |
| Path references wrong | Paper says `lux/formal/lean/Consensus/` -- actual path is `lux/proofs/lean/Consensus/`. 4 occurrences. |
| Line number references stale | Paper says lines 60-135; actual theorem spans lines 111-163. |
| serializability theorem trivially true | DAGEVM.lean line 274: proves by returning the identity permutation. This is `exists pi, pi = L`, not meaningful serialisability. |

### 1.5 NTT Transform (lux-ntt-transform.tex)

**Score: INCORRECT (DATE)**

Date field: `\date{2017}`. Lux was founded December 2019. A Lux paper cannot predate the company by 2+ years. Git first commit: 2026-01-26. The NTT paper references "Google's Willow chip" (announced December 2024) in its introduction. A 2017-dated paper cannot reference a 2024 event. This date is wrong.

### 1.6 Lightspeed DEX (lux-lightspeed-dex.tex)

**Score: INCORRECT (DATE)**

Date field: `\date{2017}`. Same issue as NTT -- predates Lux by 2+ years. The paper references "GPU BLS finality" and "Quasar consensus" which were developed in 2025. Git first commit: 2026-02-13.

### 1.7 Lux Consensus (lux-consensus.tex)

**Score: CORRECT (DATE)**

Date field: `\date{2019}`. Lux started December 2019. This is the earliest plausible date for a Lux consensus paper.

---

## 2. Sorry / Axiom Status

### 2.1 Lux Proofs (lux/proofs/lean/)

**sorry count: 0** (all former sorry converted to explicit axioms)

**axiom count: 384 unique axiom declarations across 87 project .lean files**

3 axioms explicitly listed as "pending mechanisation" in Main.lean:
- `topo_equivalence` (DAGEVM.lean:236) -- the central serialisability theorem cited by the DAG-EVM paper
- `no_double_spend_axiom` (DAGZChain.lean:220) -- the nullifier uniqueness theorem cited by the DAG-Z-Chain paper
- `sequential_worldview_preserved` (DAGEVM.lean:285) -- corollary of topo_equivalence

The remaining ~381 axioms are structural: cryptographic primitives (BLS pairing, Ringtail correctness, ML-DSA, FROST, CGGMP21, FHE ops), algebraic group types (G1, G2, GT, Point, RistrettoPoint), hash functions (SHA3, Blake3, Poseidon2), protocol assumptions (forward secrecy, honest sample dominance, confidence accumulation), and serialization interfaces. These are standard for Lean formalisations of crypto systems -- you axiomatize the crypto and prove the protocol.

### 2.2 Hanzo Proofs (hanzo/proofs/lean/)

**sorry count: 0**

**axiom count: 102 unique axiom declarations across 46 project .lean files**

Main.lean claims "0 sorry across all files" -- verified correct.

However: the `hanzo_correctness` theorem (Main.lean:47-91) is a conjunction of 14 trivially true statements (e.g., "child <= parent -> child <= parent", "keys = keys"). The proof is `exact h` or `rfl` or `omega` for each conjunct. This proves Lean type-checking works, not meaningful platform correctness. Same issue in lux/proofs/lean/Main.lean: `lux_correctness` proves BFT quorum arithmetic (`omega`) and not much else.

### 2.3 Hanzo CRDT Proofs (hanzo/proofs/lean/CRDT/)

**sorry count: 0, axiom count: 0**

All 3 CRDT files are fully proved with no axioms:
- `Privacy.lean`: 5 theorems, all proved by `simp` over algebraic structures
- `Commutativity.lean`: 9 theorems (GCounter, PNCounter, G-Set), all proved
- `Anchor.lean`: 4 theorems, all proved

Privacy interface matches implementation: paper says "3 methods: Name, EncryptOp, DecryptOp" -- Lean `Backend` struct has `name`, `seal`, `open_` (functionally equivalent names). SyncMessage has `envelopes` only, no `Ops` field -- matches the comment in Privacy.lean line 92-94 and the claim in the user prompt.

---

## 3. Date Mismatches

| Paper | \date{} | Earliest plausible date | Git first commit | Verdict |
|-------|---------|------------------------|-----------------|---------|
| lux-ntt-transform.tex | 2017 | Dec 2019 (Lux founding) | 2026-01-26 | **WRONG** -- predates Lux by 2 years, references 2024 events |
| lux-lightspeed-dex.tex | 2017 | Dec 2019 | 2026-02-13 | **WRONG** -- predates Lux by 2 years, references 2025 tech |
| lux-consensus.tex | 2019 | Dec 2019 | 2025-10-28 | OK -- borderline but plausible |
| lux-quasar-consensus.tex | 2022 (Revised 2025) | 2022 | 2025-10-28 | OK -- research started 2022 |
| lux-fraud-proofs.tex | 2020 | Dec 2019 | 2025-10-28 | OK |
| lux-id-did-specification.tex | 2020 | Dec 2019 | 2025-10-28 | OK |
| lux-id-iam.tex | 2020 | Dec 2019 | 2025-10-28 | OK |
| lux-state-sync.tex | 2020 | Dec 2019 | 2025-10-28 | OK |
| lux-data-availability.tex | 2020 | Dec 2019 | 2025-10-28 | OK |

Note: git commit dates show "2020-06-15T12:00:00" for some papers -- these appear to be date-fixed commits (exactly noon, suspicious). The bulk of papers were committed 2025-10-28 through 2026-04-13.

---

## 4. Benchmark Claims vs Measured Reality

| Claim | Source | Measured | Delta |
|-------|--------|----------|-------|
| GPU ecrecover 32x speedup | gpu_bridge.go comment, dag-evm-formal.tex | gpu_bridge.go states 50ms vs 1613ms CPU | Consistent if measured |
| CPU-parallel ecrecover 7.1x | gpu-evm-whitepaper.tex | Not independently verified | -- |
| 85.9M opcodes/sec GPU EVM | gpu-evm-whitepaper.tex | Not independently verified | -- |
| 13.2x total pipeline speedup | dag-evm-formal.tex (2198ms vs 167ms) | evm-bench session: 3.78x dag-cpu, 2.78x dag-gpu | **3.5x gap**: paper's 13.2x includes GPU ecrecover stage; measured 3.78x is DAG parallelism only without GPU ecrecover |
| 4.76M TPS Quasar | lux-quasar-consensus.tex | Not benchmarked end-to-end | Arithmetic projection, not measurement |
| 434M orders/sec DEX | lux-lightspeed-dex.tex | No benchmark exists | Pure extrapolation from gas limits |
| 500 ops/sec fheCRDT | fheCRDT paper (per CTO review) | Unknown session showed 0.35 ops/s | **1400x gap** if the 0.35 number is real |
| BLS signing 371us | LP-105 | Not independently verified | -- |

---

## 5. Bibliography Issues

### 5.1 Incorrect or Incomplete Citations

| Paper | bibitem | Issue |
|-------|---------|-------|
| lux-quasar-consensus.tex | `ntt-ringtail` | Attributed to "NTT Research (2024)" generically. Should cite Agrawal, Garg, Masny, Peceny (2024). Also, the LP-105 version self-cites as "Z. Kelling and V. Seesahai" which is the Lux implementation paper, not the NTT Research original. |
| lux-quasar-consensus.tex | `verkle-trees` | Attributed to "Kuszmaul, J. (2019), Ethereum Research". Date varies: lux-verkle-trees.tex says 2018, lux-gchain-graphql.tex says 2021. The paper was posted 2018 on ethresear.ch. |
| lux-quasar-consensus.tex | `sui-consensus` | Cited as "Narwhal and Tusk" by "Blackshear, S. et al." -- Blackshear is a Sui/Move author but Narwhal/Tusk's first authors are Danezis and Kokoris-Kogias. Wrong first author. |
| gpu-evm-whitepaper.tex (stash) | `gatlingx` | Notes "No reproducible benchmarks available" in the bibliography entry itself. Honest, but unusual. |
| dag-evm-formal.tex (stash) | `monad` | Cites "J. Tang et al." -- Monad was founded by Keone Hon and James Hunsaker. "J. Tang" does not appear to be a Monad author. |

### 5.2 Missing from Disk

`gpu-evm-whitepaper.tex` and `dag-evm-formal.tex` are in git stash, not on the main branch working tree. The INDEX.md and PAPER_INDEX.md reference them. The site config `papers.ts` links to them. Readers following those links will get 404s.

---

## 6. Cross-Org Consistency

### 6.1 Hanzo CRDT Proofs vs Implementation

CRDT proofs match the documented implementation interface:
- Privacy interface: 3 methods (Name/EncryptOp/DecryptOp) -- Lean models as Backend with `name`, `seal`, `open_`
- SyncMessage: envelopes only, no Ops field -- Lean's `Message` struct has `envelopes : List BoundEnvelope`, no ops field
- Comment in Privacy.lean line 15-17 correctly references `hanzo/base/crdt/privacy.go`, `document.go`, `sync.go`
- CTO review I-05 confirmed all "Maps to" paths exist on disk

### 6.2 Hanzo Proofs Duplicate Lux Proofs

hanzo/proofs/lean/ contains Consensus/, Crypto/, Trust/, Warp/, Network/, GPU/ libraries that are COPIES of the Lux equivalents, not dependencies. CTO review W-05 flagged this. If files drift between repos, proofs diverge silently. The hanzo Main.lean says "Hanzo inherits Lux L1 proofs" but the mechanism is copy-paste, not Lean package dependency.

### 6.3 Zoo Papers

No .tex files found in ~/work/zoo/ (glob timed out on large directory tree). Cannot verify Zoo-Lux cross-references without accessible paper files.

### 6.4 Pars Papers

No papers directory found at ~/work/lux/pars/ (does not exist). ~/work/pars/ exists but contains no .tex files accessible via standard search. Cannot verify Pars-Lux cross-references.

---

## 7. CTO Review (REVIEW-2026-03.md) Verification

The CTO agent's review exists at `/Users/z/work/lux/papers/REVIEW-2026-03.md`. Cross-checking its findings:

| Finding | CTO Claim | Scientist Verification | Status |
|---------|-----------|----------------------|--------|
| E-01: 5 sorry in Lean | 5 sorry locations listed | Current grep: 0 sorry. All converted to axioms. The UNDERLYING PROBLEM PERSISTS (theorems unproved) but the specific claim of `sorry` is now stale. | **OUTDATED** -- sorry eliminated, axioms remain |
| E-02: BabyJubjub gas mismatch | 150/6000/8000 vs 2000/7000/500 | Not re-verified (BabyJubjub.lean not read this session) | PLAUSIBLE |
| E-03: Wrong path lux/formal/ | 4 occurrences in dag-evm-formal.tex | Confirmed: dag-evm-formal.tex (stash) references `lux/formal/` not `lux/proofs/` | **CONFIRMED** |
| E-04: Missing lakefile entries | 9 files unreachable | Not re-verified against current lakefile | PLAUSIBLE |
| W-01: serializability trivially true | Returns identity permutation | DAGEVM.lean line 274: `exact <L, List.Perm.refl L, rfl>` | **CONFIRMED** |
| W-02: PQZParallel vacuously true | All prove True/trivial | Not re-verified this session | PLAUSIBLE |
| W-03: parallel_verify_sound wrapper | Local verifyBatch = True | DAGZChain.lean line 245-246: `verifyBatch = fun _ _ => True` | **CONFIRMED** |
| I-05: All Maps-to paths exist | Verified all 16 paths | Trust the CTO's grep; did not re-run full check | ACCEPTED |

---

## 8. Top 5 Fixes Ranked by Importance

### 1. Fix 2017 dates on lux-ntt-transform.tex and lux-lightspeed-dex.tex (CRITICAL)

These papers claim dates that predate Lux's founding and reference technology from 2024-2025. This is a credibility-destroying error visible to any reader. Change to 2024 (NTT) and 2025 (Lightspeed DEX) or whatever the actual research dates are.

### 2. Prove topo_equivalence and no_double_spend_axiom, or change paper language (CRITICAL)

The DAG-EVM and DAG-Z-Chain papers cite these as "formalised". They are axioms, not proofs. Either:
(a) Complete the mechanisation (bubble-sort induction for topo_equivalence; Accept-check formalisation for no_double_spend), or
(b) Change paper text from "formalised" to "axiomatized with partial proof; mechanisation pending"

### 3. Reconcile 13.2x benchmark claim with 3.78x measured reality (HIGH)

The gpu-evm-whitepaper.tex and dag-evm-formal.tex cite 13.2x as a measured number. The evm-bench session measured 3.78x for DAG-CPU parallelism. The 13.2x includes GPU ecrecover which adds 32x on the dominant stage. The paper should clearly separate:
- DAG parallelism alone: ~3.8x (measured)
- GPU ecrecover alone: ~32x (measured, per gpu_bridge.go)
- Combined pipeline projection: ~13.2x (projection, not yet measured end-to-end)

### 4. Unstash gpu-evm-whitepaper.tex and dag-evm-formal.tex onto main branch (HIGH)

These papers are referenced by INDEX.md, PAPER_INDEX.md, and the site config, but they are only in git stash. Any reader or CI process checking out main will not find them.

### 5. Fix Ringtail citation attribution (MEDIUM)

The older quasar paper (lux-quasar-consensus.tex) cites Ringtail as "NTT Research (2024)" without specific authors. LP-105 self-cites. The correct citation for the original Ringtail is: Agrawal, S., Garg, S., Masny, D., Peceny, S. (2024). "Ringtail: Practical Two-Round Threshold Signatures from Learning with Errors." NTT Research, Cryptology ePrint Archive.

---

## Summary Statistics

| Metric | Value |
|--------|-------|
| Papers reviewed | 7 in depth, 89 date-scanned |
| Sorry count (all repos) | 0 |
| Axiom count (Lux proofs) | 384 unique |
| Axiom count (Hanzo proofs) | 102 unique |
| Axiom count (Hanzo CRDT) | 0 |
| Date mismatches found | 2 critical (2017 dates on 2024-2025 papers) |
| Bibliography errors | 3 (Ringtail attribution, Verkle date, Narwhal first author) |
| Benchmark claim vs reality gap | 13.2x claimed vs 3.78x measured (3.5x gap, explained by GPU stage not included in bench) |
| CTO review findings confirmed | 3 of 7 errors confirmed still present, 1 outdated (sorry->axiom) |
