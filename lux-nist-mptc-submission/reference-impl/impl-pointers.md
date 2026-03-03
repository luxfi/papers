# Reference Implementation Pointers

All reference implementations are at the canonical Go repos under `github.com/luxfi/`. Every repo carries the freeze tag `v0.1.0-rc1-pq-consensus-freeze` (Mar-3, 2026). The implementation is the byte oracle; where this submission and the implementation disagree, the implementation is the tiebreaker.

## Repository map

| Repo | Role | Freeze tag |
|---|---|---|
| [github.com/luxfi/pulsar](https://github.com/luxfi/pulsar) | Pulsar kernel: lattice math + key-era lifecycle | `v0.1.0-rc1-pq-consensus-freeze` |
| [github.com/luxfi/lens](https://github.com/luxfi/lens) | Lens kernel: FROST 2-round Schnorr | `v0.1.0-rc1-pq-consensus-freeze` |
| [github.com/luxfi/threshold](https://github.com/luxfi/threshold) | LSS lifecycle framework + adapters | `v0.1.0-rc1-pq-consensus-freeze` |
| [github.com/luxfi/consensus](https://github.com/luxfi/consensus) | Quasar engine + Horizon composition | `v1.22.84` (the consensus engine version pinning the freeze) |
| [github.com/luxfi/warp](https://github.com/luxfi/warp) | Warp 1.x + Warp 2.0 cross-chain envelopes | `v1.18.0` (the warp version pinning the freeze) |
| [github.com/luxfi/lattice](https://github.com/luxfi/lattice) | Lattigo v7 (Lux fork) | pinned to v7 |

## Pulsar kernel (`github.com/luxfi/pulsar`)

| Path | Role |
|---|---|
| `sign/config.go` (28 lines) | Every Pulsar numeric constant; the canonical parameter source. |
| `sign/sign.go` (374 lines) | `Gen`, `SignRound1`, `SignRound2Preprocess`, `SignRound2`, `SignFinalize`, `Verify`, `CheckL2Norm`, `FullRankCheck`. |
| `threshold/threshold.go` (294 lines) | High-level wrapper: `GenerateKeys(t, n, rand)`, `Signer` object, `Round1Data` / `Round2Data` / `Signature` wire types. |
| `primitives/hash.go` (209 lines) | Pulsar-SHA3 hash suite: `Hash`, `LowNormHash`, `GaussianHash`, `PRF`, `GenerateMAC`, `PRNGKey`. |
| `primitives/shamir.go` (147 lines) | Optimized $t = K$ Shamir path; `ComputeLagrangeCoefficients`. |
| `utils/utils.go` (524 lines) | NTT-aware matrix-vector multiplies, rounding helpers, Gaussian elimination over $\mathbb{F}_q$. |
| `keyera/keyera.go` | `Bootstrap`, `Reshare`, `Reanchor` entrypoints; KeyEraID / Generation / RollbackFrom lineage scalars. |
| `reshare/` | Verifiable secret redistribution (HJKY97 `Refresh` + Desmedt-Jajodia `ReshareToNewSet`) + activation cert (`activation.go`) + transcript (`transcript.go`). |
| `dkg2/` | Pedersen DKG over $R_q$: trusted-dealer-free Bootstrap path. |
| `hash/` | Canonical `Pulsar-SHA3` hash profile (TupleHash256 / cSHAKE256 / KMAC256). |
| `cmd/ringtail_oracle_v2/` | KAT oracle: `emit --out <dir>` produces 16 deterministic KAT entries. |
| `scripts/regen-kats.sh` | Deterministic regeneration + verification; produces byte-equal output across runs. |
| `CONSTANT-TIME-REVIEW.md` | Constant-time review of the lattice math. |

## Lens kernel (`github.com/luxfi/lens`)

| Path | Role |
|---|---|
| `sign/sign.go` | FROST 2-round Schnorr threshold signing (RFC 9591). |
| `sign/config.go` | Group choice (Ed25519, secp256k1, Ristretto255). |
| `keyera/keyera.go` | Lens key-era lifecycle (mirror of Pulsar's). |
| `reshare/` | HJKY97 `Refresh` + Desmedt-Jajodia `ReshareToNewSet` + activation cert (FROST-side). |
| `hash/` | Lens-specific hash suite. |
| `CONSTANT-TIME-REVIEW.md` | Constant-time review of the curve math. |

## LSS framework (`github.com/luxfi/threshold`)

| Path | Role |
|---|---|
| `protocols/lss/lss_pulsar.go` | Pulsar adapter: `DynamicResharePulsar`, `PulsarSnapshotManager`, `BuildActivationTranscript`. |
| `protocols/lss/lss_lens.go` | Lens adapter (mirror of `lss_pulsar.go`). |
| `protocols/lss/lss_cmp.go` | ECDSA-CMP adapter. |
| `protocols/lss/rollback.go` | LSS RollbackManager: snapshot retention, `Rollback(g_target)`. |
| `protocols/lss/lss_pulsar_test.go` | 10 acceptance tests for the LSS-Pulsar adapter contract. |
| `protocols/lss/lss_lens_test.go` | 10 acceptance tests for the LSS-Lens adapter contract. |
| `protocols/pulsar/` | Round orchestration wrapper around the Pulsar kernel. |
| `protocols/lens/` | Round orchestration wrapper around the Lens kernel. |

## Quasar consensus (`github.com/luxfi/consensus`)

| Path | Role |
|---|---|
| `protocol/quasar/quasar.go` | The Quasar engine: bundle interval, finality state transitions. |
| `protocol/quasar/horizon.go` | Prism predicate; per-lane error codes (`ErrBeamFailed`, `ErrMLDSAFailed`, `ErrPulseFailed`, `ErrTranscriptDrift`, `ErrValidatorSetMismatch`). |
| `protocol/quasar/types.go` | `QuasarCert` wire format. |
| `protocol/quasar/epoch.go` | `InitializeEpoch` (delegates to `keyera.Bootstrap`); `RotateEpoch` (delegates to `lss.DynamicResharePulsar`). |
| `protocol/quasar/reshare_epoch.go` | Production wiring under `QUASAR-PULSAR-ACTIVATE-v1`. |
| `protocol/quasar/grouped_threshold.go` | Grouped Pulsar quorum-of-groups path. |
| `protocol/quasar/triple_sign_test.go` | Beam + ML-DSA + Pulse parallel signing test. |
| `protocol/quasar/horizon_test.go` | Prism predicate, lane composition tests. |
| `protocol/quasar/...` | 258 tests total covering adversarial, dynamic, dual-threshold, grouped, witness, and security regressions. |

## Warp 2.0 cross-chain (`github.com/luxfi/warp`)

| Path | Role |
|---|---|
| `envelope.go` | `EnvelopeV2`, `ParseEnvelope`, `ParseEnvelopeV2`, version-byte dispatcher, wire-size guards. |
| `message.go` | v1 `Message` (unchanged). |
| `signature.go` | v1 `BitSetSignature` (unchanged). |
| `validator.go` | v1 validator-set machinery (unchanged). |
| `verifier.go` | v1 `Verifier` interface (unchanged). |
| `pulsar/pulsar.go` | `KernelVerifier`, `BuildSigningBytes`, frame walkers (`validatePolyFrame`, `validateVectorPolyFrame`), hardened deserializer. |
| `pulsar/classification.go` | `HorizonCertificate` helper; `IsPQRootOfTrust` predicate. |
| `pulsar/fuzz_pulse_test.go` | `FuzzPulseDeserialize`, `FuzzPulseSerialize`. |
| `pulsar/fuzz_horizon_cert_test.go` | `FuzzHorizonCertificate`. |
| `fuzz_envelope_test.go` | `FuzzWarpEnvelopeV2`. |
| `pulsar/groth16_classification_test.go` | Tests `IsPQRootOfTrust` correctly classifies Groth16 lanes as classical. |
| `pulsar/hashsuite_mismatch_test.go` | Tests `ErrSuiteMismatch` on resolver/envelope suite mismatch. |

## How to clone and verify

```bash
# Pulsar
git clone https://github.com/luxfi/pulsar
cd pulsar
git checkout v0.1.0-rc1-pq-consensus-freeze
go test -count=1 -short ./...
./scripts/regen-kats.sh --verify   # byte-equality of KAT outputs

# Lens
git clone https://github.com/luxfi/lens
cd lens
git checkout v0.1.0-rc1-pq-consensus-freeze
go test -count=1 -short ./...

# Threshold (LSS framework)
git clone https://github.com/luxfi/threshold
cd threshold
git checkout v0.1.0-rc1-pq-consensus-freeze
go test -count=1 -short ./...

# Consensus (Quasar engine)
git clone https://github.com/luxfi/consensus
cd consensus
GOWORK=off go test -count=1 -short -timeout 300s ./protocol/quasar/...

# Warp 2.0
git clone https://github.com/luxfi/warp
cd warp
go test -count=1 -short ./...
```

All five test suites pass on the freeze tag. The KAT regen produces byte-equal output across runs.

## Versions of upstream dependencies

| Dependency | Version | Used by |
|---|---|---|
| `github.com/luxfi/lattice/v7` | v7 (pinned) | Pulsar (lattice math) |
| `github.com/luxfi/crypto/bls` | v1.17.25 | Quasar Beam |
| `github.com/luxfi/crypto/mldsa` | v1.17.25 | Quasar ML-DSA cert set |
| `github.com/luxfi/crypto/slhdsa` | v1.17.25 | UTXO Fx (audit signatures) |
| `github.com/luxfi/zap` | v1.x (pinned) | Inter-node transport |
| `github.com/luxfi/ids` | v1.2.4 | ID types |
| `github.com/luxfi/version` | (re-exported) | Version management |

The `go.mod` files in each repo carry the exact versions; pinning ensures byte-equal builds across deployment targets.

## Audit status

The Lux research audit (`papers/AUDIT.pdf`) covers the consensus engine and the threshold-cryptography stack. The audit cites the proof bucket `proofs/` as the formal-verification companion. Audit status as of Mar-3:

- Pulsar SUF-CMA: mechanized in Lean (`lean/Crypto/Ringtail.lean`).
- Reshare preserves master secret: mechanized in Lean (`lean/Crypto/Threshold/Reshare.lean`).
- Triple consensus (BLS + Ringtail + ML-DSA): mechanized in Lean (`lean/Consensus/Quasar.lean`).
- BFT safety / liveness / finality: mechanized in Lean (`lean/Consensus/{Safety,Liveness,Finality,BFT}.lean`).
- Quasar TLA+ model: model-checked (`tla/Quasar.tla`, `tla/MC_Quasar.cfg`).
- Quasar Tamarin protocol model: verified (`tamarin/QuasarConsensus.spthy`).
- Property-based tests: Go (`proofs/property/`).

The implementation is byte-equal across the canonical Go and the in-flight C++ port (`luxcpp/crypto/ringtail/cpp/`); KAT vectors gate every release.
