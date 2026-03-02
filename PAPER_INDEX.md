# Lux Research Papers — Complete Index

**80 papers, 2017–2026. 10+ years of research. Quantum-safe. Open. Permissionless.**

**Lineage:** Open source (2008) → Hanzo Labs (2014) → Lux Industries (2019) → Present

**Consensus evolution:** HotStuff (2019) → Snow/Avalanche fork (2019) → Quasar triple-proof PQ (2022–2026)

---

## I. Foundations (2017–2020)

The mathematical bedrock: consensus, data structures, identity.

| Year | Paper | Formal Contribution |
|------|-------|---------------------|
| 2017 | `lux-ntt-transform` | Number Theoretic Transform for lattice operations |
| 2017 | `lux-lightspeed-dex` | Sub-microsecond CLOB matching engine |
| 2019 | `lux-consensus` | Snow family consensus: safety + liveness proofs (HotStuff → Snow) |
| 2020 | `lux-data-availability` | Erasure coding DA guarantees |
| 2020 | `lux-fraud-proofs` | Interactive fraud proof game completeness |
| 2020 | `lux-state-sync` | Merkle-based state synchronization |
| 2020 | `lux-id-did-specification` | W3C DID method specification |
| 2020 | `lux-id-iam` | OAuth 2.1 + OIDC identity architecture |

## II. Threshold Cryptography (2021–2023)

Distributed key management — no single point of trust.

| Year | Paper | Formal Contribution |
|------|-------|---------------------|
| 2021 | `lux-universal-threshold-signatures` | Unified t-of-n framework (ECDSA, EdDSA, Schnorr) |
| 2021 | `lux-threshold-mpc` *(revised 2025)* | FROST unforgeability + CGGMP21 UC-security + Taproot integration + MPC group address + LSS dynamic resharing |
| 2023 | `lux-mchain-mpc` | MPC chain architecture, NATS transport, session lifecycle |
| 2023 | `lux-warp-messaging` | BLS aggregate signature cross-chain messaging |
| 2026 | `lux-validator-mpc` | **Threshold signing for validators: CGGMP21 + FROST + DKG + resharing** |

## III. Post-Quantum Cryptography (2019–2025)

Quantum resistance at every layer — lattice, hash-based, hybrid.

| Year | Paper | Formal Contribution |
|------|-------|---------------------|
| 2019 | `lux-ntt-transform` | NTT for efficient polynomial arithmetic |
| 2024 | `lux-ethfalcon-post-quantum` | FALCON signature EVM precompile |
| 2024 | `lux-pq-crypto-suite` | ML-DSA (FIPS 204), SLH-DSA (FIPS 205), ML-KEM (FIPS 203) |
| 2024 | `lux-ringtail-pq` | Lattice-based threshold signatures (LWE) |
| 2024 | `lux-quantum-consensus` | Quantum-resistant validator signatures |
| 2025 | `lux-quasar-consensus` | Triple-proof BLS + ZK(ML-DSA) + Ringtail quantum finality |
| 2025 | `lux-quasar-benchmarks` | Performance: 10K validators, sub-second finality |
| 2025 | `lux-tfhe` | Threshold Fully Homomorphic Encryption |
| 2026 | `lux-triple-proof-consensus` | **248-byte epoch proofs, 357μs finality, 1ms blocks, 1TB/year** |
| 2026 | `lux-hybrid-pq-architecture` | **Hybrid classical+PQ: BLS+ML-DSA dual-sig, ML-KEM+ECDH hybrid KEM** |
| 2026 | `lux-quantum-threat-blockchain` | **Blockchain quantum threat model: 5 attack vectors, timeline, economics** |
| 2026 | `lux-pq-migration` | **Three-phase PQ migration: hybrid → PQ-primary → pure PQ** |
| 2026 | `lux-crypto-agility` | Crypto-agile algorithm registry for zero-downtime upgrades |
| 2026 | `lux-hybrid-certificates` | Hybrid X.509 certificates with PQ + classical dual signatures |

## IV. Consensus & Execution (2020–2026)

From Snow to Quasar — the consensus evolution.

| Year | Paper | Formal Contribution |
|------|-------|---------------------|
| 2020 | `lux-consensus` | Snow family: Snowball, Snowflake, Avalanche |
| 2021 | `lux-evm-precompiles` | Custom EVM opcodes for crypto primitives |
| 2023 | `lux-zap-wire-protocol` | Binary wire protocol (sub-microsecond serialization) |
| 2023 | `lux-zap-benchmarks` | 434M orders/sec on GPU, 1M ops/sec on CPU |
| 2025 | `lux-fpc-consensus` | Fast Probabilistic Consensus |
| 2025 | `lux-wave-protocol` | Wave propagation consensus |
| 2026 | `gpu-evm-whitepaper` | GPU-accelerated EVM execution |
| 2026 | `evmgpu-benchmark` | CUDA/Metal EVM benchmarks |

## V. Cross-Chain Bridge & Teleport (2022–2025)

The omnichain liquidity layer — trustless, sovereign, yield-bearing.

| Year | Paper | Formal Contribution |
|------|-------|---------------------|
| 2022 | `lux-teleport-protocol` | Original teleport: burn/mint with MPC attestation |
| 2022 | `lux-verkle-trees` | Verkle tree state proofs for light clients |
| 2022 | `lux-teleport-omnichain` *(revised 2025)* | **Full protocol: 18 native bridge programs, 270 chain IDs, MPC group key, IBridgeToken, configurable rotation delay** |
| 2023 | `lux-bridge` | Threshold-secured bridge with formal MPC analysis |
| 2024 | `lux-omnichain-yield` *(revised 2025)* | **Yield-bearing bridge tokens, 29 strategies, xLUX flywheel, VIRTUAL\_SHARES 1e8, 54 security tests** |
| 2026 | `lux-teleport-protocol-spec` | **Auditor-ready spec: asset taxonomy, solvency state machine, message schema** |
| 2026 | `lux-credit-protocol-spec` | **Credit protocol: LETH/LBTC issuance invariants, failure modes** |
| 2026 | `lux-secure-messaging` | **13-field envelope, 5 replay classes, 8 mandatory verification checks** |
| 2026 | `lux-cross-chain-security` | **Multi-chain security inheritance, 4 attack classes, finality propagation** |

## VI. DeFi Protocols (2019–2024)

Complete on-chain financial infrastructure.

| Year | Paper | Formal Contribution |
|------|-------|---------------------|
| 2019 | `lux-lightspeed-dex` | CLOB matching: price-time priority proof |
| 2023 | `lux-economics` | Token economics model |
| 2023 | `lux-tokenomics` | Supply dynamics, emission schedules |
| 2023 | `lux-validator-economics` | Validator reward game theory |
| 2024 | `lux-credit-lending` | Isolated lending markets (Morpho-style) |
| 2024 | `lux-perpetuals-derivatives` | Perpetual futures with LLP |
| 2024 | `lux-liquid-staking` | Liquid staking (xLUX) architecture |
| 2024 | `lux-restaking` | EigenLayer/Symbiotic restaking integration |
| 2024 | `lux-oracle-infrastructure` | Multi-source price aggregation |
| 2024 | `lux-market-nft` | NFT AMM (LSSVM/sudoswap-style) |
| 2026 | `lux-performance-security-tradeoffs` | **MPC/FHE/BLS/ML-DSA benchmarks, temporal composition architecture** |

## VII. Governance & Compliance (2022–2025)

Sovereign governance, Shariah compliance, securities law.

| Year | Paper | Formal Contribution |
|------|-------|---------------------|
| 2022 | `lux-sovereign-defi` *(revised 2025)* | **Per-chain governance isolation theorem, exit guarantee, Shariah classification algebra (SAB-only membership), configurable rotation delay, ERC-3643 securities compliance** |
| 2023 | `lux-dao-governance-framework` | DAO structure: Karma + DLUX + vLUX |
| 2023 | `lux-governance-dao` | Governor contract, gauge weights |

## VIII. Privacy & Confidential Computing (2021–2025)

Private transactions, FHE, TEE, zero-knowledge.

| Year | Paper | Formal Contribution |
|------|-------|---------------------|
| 2021 | `lux-zchain` | UTXO privacy with Poseidon2/STARK |
| 2024 | `lux-privacy-pool` | Shielded pool with nullifier tracking |
| 2024 | `lux-tee-computing-mesh` | Trusted execution environment mesh |
| 2025 | `lux-tfhe` | Threshold FHE for confidential DeFi |
| 2026 | `lux-fhe-smart-contracts` | **FHE VM: encrypted state transitions, Go+NTT SIMD impl** |
| 2026 | `lux-fhe-mpc-hybrid` | **FHE+MPC: encrypted compute + distributed decryption** |
| 2026 | `lux-fhe-api` | FHE precompile API specification |
| 2026 | `lux-fhe-benchmarks` | FHE performance: bootstrapping, throughput, latency |

## IX. Chain-Specific Protocols (2024)

Named protocol implementations for specific chain functions.

| Year | Paper | Chain | Formal Contribution |
|------|-------|-------|---------------------|
| 2024 | `lux-achain-attestation` | A-Chain | GPU attestation, TEE quotes |
| 2024 | `lux-field-protocol` | - | Field arithmetic optimizations |
| 2024 | `lux-flare-protocol` | - | Cross-chain event detection |
| 2024 | `lux-nova-protocol` | - | Recursive proof composition |
| 2024 | `lux-prism-protocol` | - | Light refraction state sharding |
| 2024 | `lux-ray-protocol` | - | Directed state transitions |
| 2023 | `lux-nebula-protocol` | - | Distributed storage |
| 2023 | `lux-photon-protocol` | - | Message propagation |
| 2021 | `lux-gchain-graphql` | G-Chain | GraphQL indexing chain |

## X. Security & Infrastructure (2026)

Master security model, operational security, formal methods.

| Year | Paper | Formal Contribution |
|------|-------|---------------------|
| 2026 | `lux-master-security-model` | **4 adversary classes, 3 assumption families, per-layer guarantees, machine-checkable invariants** |
| 2026 | `lux-zero-trust-validators` | Zero-trust validator architecture |
| 2026 | `lux-hsm-boundary` | Hardware security module integration boundaries |
| 2026 | `lux-reproducible-builds` | Deterministic builds for cryptographic software |
| 2026 | `lux-proof-methodology` | Formal verification methodology and proof standards |
| 2026 | `lux-adoption-roadmap` | Enterprise adoption path for PQ infrastructure |

---

## Dependency Graph

```
Foundations (2019-2020)
    │
    ├── Consensus (2020-2025)
    │     ├── Snow → FPC → Quasar
    │     └── ZAP wire protocol → GPU EVM
    │
    ├── Threshold Crypto (2021-2025)
    │     ├── Universal Threshold Sigs (2021)
    │     ├── FROST + CGGMP21 (2021-2023)
    │     ├── Ringtail PQ (2024)
    │     └── Quasar Hybrid (2025)
    │
    ├── Post-Quantum (2019-2025)
    │     ├── NTT Transform (2019)
    │     ├── FALCON/ML-DSA/SLH-DSA (2024)
    │     ├── Ringtail Lattice (2024)
    │     └── TFHE (2025)
    │
    ├── Bridge & Teleport (2022-2025)
    │     ├── Teleport Protocol (2022)
    │     ├── Warp Messaging (2023)
    │     ├── Bridge MPC (2023)
    │     ├── Yield-Bearing Tokens (2024)
    │     └── Omnichain Router (2025)
    │
    ├── DeFi (2019-2024)
    │     ├── DEX CLOB (2019)
    │     ├── Lending, Perps, Options (2024)
    │     ├── Liquid Staking (2024)
    │     └── Restaking (2024)
    │
    ├── Governance (2022-2025)
    │     ├── Sovereign DeFi (2022)
    │     ├── DAO Framework (2023)
    │     └── Shariah + Securities (2022)
    │
    └── Privacy (2021-2025)
          ├── Z-Chain (2021)
          ├── Privacy Pool (2024)
          └── TFHE Confidential (2025)
```

---

## Compilation

```bash
brew install basictex  # or: brew install --cask mactex-no-gui
cd ~/work/lux/papers
pdflatex lux-teleport-omnichain.tex  # compile any paper
```

All papers use `shared/luxcover.sty` for the monochrome triangle cover page.

---

*55 papers. 2017–2026. Quantum-safe. Open. Public. Permissionless.*
*Lineage: Hanzo Labs (2017) → Lux Industries (2019) → Present*
*Securities compliance lineage: Arca Labs (2018) → ERC-3643/T-REX (2021) → Lux (2021+)*
*Lux Industries — research@lux.network*
