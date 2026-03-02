# Lux Research Papers Index

78 papers, 50 formal proofs, 4 FHE monographs, 4 extended monographs.
All LaTeX source. All compiled PDFs alongside.

Compilation: `pdflatex <file>.tex` (uses `shared/luxcover.sty` for cover pages).

---

## Consensus and Protocol

| File | Title |
|------|-------|
| `lux-consensus.tex` | Lux Consensus: Physics-Inspired Metastable Blockchain Consensus |
| `lux-fpc-consensus.tex` | Fast Probabilistic Consensus: Adaptive Threshold Consensus with Phase-Shift Dynamics |
| `lux-quasar-consensus.tex` | Quasar: Quantum-Secure Multi-Engine Consensus with Triple-Proof Quantum Finality |
| `lux-quasar-benchmarks.tex` | Quasar Consensus: A Comparative Benchmark Study of Post-Quantum BFT |
| `lux-quantum-consensus.tex` | Lux Quantum Consensus: Post-Quantum Secure Multi-Consensus Architecture |
| `lux-triple-proof-consensus.tex` | Triple-Proof Quantum Finality (BLS + ML-DSA + Ringtail, 248 bytes/epoch) |
| `lux-wave-protocol.tex` | Wave Protocol: Decision Stability and Confidence Monotonicity in DAG-Based Metastable Consensus |
| `lux-field-protocol.tex` | Field Protocol: Electromagnetic-Inspired Distributed Consensus |
| `lux-flare-protocol.tex` | Flare Protocol: Certificate Skip Exclusivity with Honest Support in DAG Consensus |
| `lux-nova-protocol.tex` | Nova Protocol: Supernova Burst Consensus for High-Throughput DAG Chains |
| `lux-nebula-protocol.tex` | Nebula Protocol: Probabilistic Finality in Sparse Networks |
| `lux-photon-protocol.tex` | Photon Protocol: Zero-Latency Consensus Pipelining |
| `lux-prism-protocol.tex` | Prism Protocol: Multi-Spectrum Parallel Consensus |
| `lux-ray-protocol.tex` | Ray Protocol: Adaptive Finality with Light-Speed Confirmation |
| `lux-data-availability.tex` | Data Availability Sampling in Lux Network |
| `lux-state-sync.tex` | Fast State Synchronization for Blockchain Nodes via Merkle Range Proofs |
| `lux-fraud-proofs.tex` | Fraud Proofs: Optimistic Rollup Security on Lux with Interactive Verification |
| `lux-verkle-trees.tex` | Verkle Trees: Constant-Size Proofs for Stateless Clients on Lux |

## Cryptography -- Post-Quantum

| File | Title |
|------|-------|
| `lux-pq-crypto-suite.tex` | Post-Quantum Cryptographic Suite for EVM: ML-KEM, ML-DSA, and SLH-DSA as Native Precompiles |
| `lux-ethfalcon-post-quantum.tex` | ETHFALCON: EVM-Optimized Post-Quantum Signatures |
| `lux-ringtail-pq.tex` | Ringtail: Lattice-Based Post-Quantum Threshold Signatures for Blockchain Consensus |
| `lux-ntt-transform.tex` | NTT Transform: Enabling Post-Quantum Cryptography on EVM with 85% Gas Reduction |
| `lux-hybrid-pq-architecture.tex` | Hybrid Post-Quantum Cryptographic Architecture for Blockchain Systems |
| `lux-hybrid-certificates.tex` | Hybrid Certificate Chains and Post-Quantum Trust Anchors for Validator Networks |
| `lux-pq-migration.tex` | Post-Quantum Migration Strategy for Production Blockchain Networks |
| `lux-quantum-threat-blockchain.tex` | Quantum Threat Model for Blockchain Infrastructure |
| `lux-crypto-agility.tex` | Cryptographic Agility Architecture for Long-Lived Blockchain Systems |
| `lux-performance-security-tradeoffs.tex` | Performance vs Security Tradeoffs in Cryptographic Infrastructure |

## Cryptography -- Threshold, MPC, BLS

| File | Title |
|------|-------|
| `lux-threshold-mpc.tex` | Unified Threshold Cryptography for Omnichain Asset Custody: FROST, CGGMP21, and Taproot Integration |
| `lux-universal-threshold-signatures.tex` | Universal Threshold Signatures: Multi-Chain Cryptographic Infrastructure with Post-Quantum Security |
| `lux-validator-mpc.tex` | Threshold Cryptography for Validator Networks |
| `lux-lss-mpc.tex` | LSS: Linear Shamir's Secret Sharing -- Dynamic and Resilient Threshold Signatures with Live Secret Resharing |
| `lux-mchain-mpc.tex` | M-Chain: Decentralized Multi-Party Computation Custody with Quantum-Safe Threshold Signatures |
| `lux-warp-messaging.tex` | Lux Warp Messaging: Cross-Appchain Communication with BLS Aggregate Signatures |
| `lux-evm-precompiles.tex` | Custom EVM Precompiles for Cryptographic Operations on Lux Network |
| `lux-hsm-boundary.tex` | Secure Enclave, HSM, and Threshold Boundary Design for Validator Key Infrastructure |

## FHE and Privacy

| File | Title |
|------|-------|
| `lux-tfhe.tex` | Torus Threshold Fully Homomorphic Encryption: Boolean Circuits on Encrypted Data with Distributed Decryption |
| `lux-fhe-smart-contracts.tex` | Fully Homomorphic Encryption for Smart Contract Execution |
| `lux-fhe-api.tex` | FHE API and Developer Model for Practical Private Applications |
| `lux-fhe-benchmarks.tex` | FHE Benchmarking, Cost Models, and Operational SLOs |
| `lux-fhe-mpc-hybrid.tex` | FHE + MPC Hybrid Systems for Trustless Private Computation |
| `lux-privacy-pool.tex` | Privacy Pools on Lux: Compliant Transaction Privacy with Association Sets |
| `lux-zchain.tex` | Lux Z-Chain: Privacy-Preserving Smart Contracts with Zero-Knowledge Proofs |
| `lux-tee-computing-mesh.tex` | Lux TEE Mesh: Decentralized Confidential Computing Infrastructure for Blockchain Networks |
| `lux-secure-messaging.tex` | Authenticated Cross-Chain Message Protocol |
| `fhe/fhevm/main.tex` | fhEVM: FHE-Native Virtual Machine |
| `fhe/fhecrdt/main.tex` | fheCRDT: Conflict-Free Replicated Data Types over Encrypted State |
| `fhe/ml-privacy/main.tex` | Privacy-Preserving Machine Learning at Scale: From Training to Inference with FHE |
| `fhe/voting/main.tex` | Verifiable Encrypted Voting: End-to-End Private Elections on Public Blockchains |

## Cross-Chain Bridge and Teleport

| File | Title |
|------|-------|
| `lux-teleport-protocol.tex` | Teleport Protocol: Trustless Cross-Chain Asset Transfer via Light Client Verification |
| `lux-teleport-omnichain.tex` | Lux Teleport: Sovereign Omnichain Liquidity via Threshold Cryptography and Per-Chain Governance |
| `lux-teleport-architecture.tex` | Teleport Universal Bridge Architecture: Frozen Wire Format, Pluggable Chain Adapters, and Multi-Tenant Deployment |
| `lux-bridge.tex` | Lux Bridge: Threshold-Secured Cross-Chain Communication with MPC Custody and Post-Quantum Verification |
| `lux-omnichain-yield.tex` | Yield-Bearing Bridge Tokens: Cross-Chain Capital Efficiency through Composable Yield Strategies |
| `lux-cross-chain-security.tex` | Security Architecture for Multi-Chain Networks |
| `teleport/main.tex` | Lux Teleport: A Sovereign Omnichain Liquidity Protocol (extended monograph) |
| `omnichain-yield/main.tex` | Yield-Bearing Bridge Tokens (extended monograph) |

## DeFi and Economics

| File | Title |
|------|-------|
| `lux-lightspeed-dex.tex` | Lux Lightspeed DEX: High-Frequency Trading at the Speed of Light |
| `lux-economics.tex` | Appchain Economics: Incentive Design for Application-Specific Chains |
| `lux-tokenomics.tex` | Lux Tokenomics: Economic Design for Multi-Chain Consensus Networks |
| `lux-validator-economics.tex` | Validator Economics in Proof-of-Stake: Incentive Alignment for Lux Network |
| `lux-credit-lending.tex` | Lux Credit: Zero-Interest Self-Repaying Lending Protocol with 90% LTV and Cross-Chain Collateral |
| `lux-credit-protocol-spec.tex` | Lux Credit Protocol Specification: Omnichain Collateralized Credit Issuance, Transport, and Settlement |
| `lux-perpetuals-derivatives.tex` | Lux Perpetuals: High-Leverage Derivatives with Automated Risk Management |
| `lux-liquid-staking.tex` | Liquid Staking on Lux: Tokenized Validator Positions with DeFi Composability |
| `lux-restaking.tex` | Restaking Protocol for Lux Network Security Extension |
| `lux-oracle-infrastructure.tex` | Lux Oracle Infrastructure: Decentralized Price Feeds and AI-Powered Data Oracles |
| `lux-market-nft.tex` | Lux.market: Aggregated NFT Marketplace with Instant Liquidity |
| `lux-sovereign-defi.tex` | (see `sovereign-defi/main.tex`) |
| `sovereign-defi/main.tex` | Sovereign DeFi: Per-Chain Governance, Shariah Compliance, and Securities-Compatible Cross-Chain Infrastructure (extended monograph) |

## Network and Infrastructure

| File | Title |
|------|-------|
| `lux-zap-wire-protocol.tex` | ZAP: Zero-Allocation Binary Wire Protocol for Consensus Transport |
| `lux-zap-benchmarks.tex` | ZAP Benchmarks: Zero-Allocation Protocol Performance Analysis for Consensus Transport |
| `gpu-evm-whitepaper.tex` | cevm: A GPU-Native Ethereum Virtual Machine with Post-Quantum Cryptography and FHE Acceleration |
| `evmgpu-benchmark.tex` | GPU-Accelerated EVM Execution: Measured Benchmarks on Apple M1 Max Metal |
| `lux-reproducible-builds.tex` | Signed Software, Reproducible Builds, and Quantum-Resilient Release Pipelines |
| `lux-zero-trust-validators.tex` | Zero-Trust Validator Operations and Service Identity for Blockchain Infrastructure |
| `lux-achain-attestation.tex` | A-Chain: Unified Trusted Execution Environment Attestation for Decentralized AI Compute |
| `lux-gchain-graphql.tex` | G-Chain: Unified GraphQL Query Engine with Decentralized Indexing for Multi-Chain State |
| `lux-adoption-roadmap.tex` | Adoption Roadmap: From Research Stack to Deployable Infrastructure |

## Identity and Governance

| File | Title |
|------|-------|
| `lux-id-did-specification.tex` | Lux ID: Decentralized Identity and Universal Access Management |
| `lux-id-iam.tex` | Lux.id: Decentralized Identity and Access Management for Web3 |
| `lux-dao-governance-framework.tex` | Lux DAO: Modular Governance Framework for Decentralized Organizations |
| `lux-governance-dao.tex` | Lux Governance: Unified DAO Framework for Multi-Ecosystem Coordination |

## Security

| File | Title |
|------|-------|
| `lux-master-security-model.tex` | Comprehensive Security Model for the Lux Network |
| `lux-proof-methodology.tex` | Security Proof Obligations, Red-Team Methodology, and Verification Strategy |

## Formal Proofs (`proofs/`)

50 mechanized proofs. Each proves a specific property referenced by the papers above.

### Consensus Proofs
| File | Property |
|------|----------|
| `proofs/proof-consensus-safety.tex` | Consensus Safety |
| `proofs/proof-consensus-liveness.tex` | Consensus Liveness |
| `proofs/proof-consensus-bft.tex` | BFT Threshold Properties |
| `proofs/proof-consensus-finality.tex` | End-to-End Finality Composition |
| `proofs/proof-consensus-quasar.tex` | Quasar Hybrid Consensus |
| `proofs/proof-consensus-validator.tex` | Validator Economics and Slashing |

### Protocol Proofs
| File | Property |
|------|----------|
| `proofs/proof-protocol-field.tex` | Field DAG Consensus Driver |
| `proofs/proof-protocol-flare.tex` | Flare DAG Commit Rule |
| `proofs/proof-protocol-nebula.tex` | Nebula DAG Consensus Mode |
| `proofs/proof-protocol-nova.tex` | Nova Linear Blockchain Mode |
| `proofs/proof-protocol-photon.tex` | Photon Committee Selection |
| `proofs/proof-protocol-prism.tex` | Prism Peer Sampling via Fisher-Yates |
| `proofs/proof-protocol-quasar.tex` | Quasar Protocol: BLS + Ringtail Hybrid Finality |
| `proofs/proof-protocol-ray.tex` | Ray Linear Chain Driver |
| `proofs/proof-protocol-wave.tex` | Wave Threshold Voting Engine |
| `proofs/proof-protocol-handshake.tex` | Post-Quantum Key Exchange Handshake |

### Cryptography Proofs
| File | Property |
|------|----------|
| `proofs/proof-crypto-bls.tex` | BLS Signature Aggregation |
| `proofs/proof-crypto-frost.tex` | FROST Threshold Schnorr Signatures |
| `proofs/proof-crypto-cggmp21.tex` | CGGMP21 Threshold ECDSA |
| `proofs/proof-crypto-mldsa.tex` | ML-DSA (FIPS 204) Digital Signatures |
| `proofs/proof-crypto-mlkem.tex` | ML-KEM (FIPS 203) Key Encapsulation |
| `proofs/proof-crypto-slhdsa.tex` | SLH-DSA (FIPS 205) Hash-Based Signatures |
| `proofs/proof-crypto-ringtail.tex` | Ringtail Post-Quantum Threshold Signatures |
| `proofs/proof-crypto-tfhe.tex` | TFHE Fully Homomorphic Encryption |
| `proofs/proof-crypto-ckks.tex` | CKKS Approximate Arithmetic FHE |
| `proofs/proof-crypto-lss.tex` | Linear Secret Sharing |
| `proofs/proof-crypto-hybrid.tex` | Hybrid Signature Scheme |
| `proofs/proof-crypto-verkle.tex` | Verkle Tree State Commitments |
| `proofs/proof-crypto-threshold-composition.tex` | Threshold Protocol Composition |

### DeFi Proofs
| File | Property |
|------|----------|
| `proofs/proof-defi-amm.tex` | AMM Constant Product Invariant |
| `proofs/proof-defi-orderbook.tex` | Order Book Correctness |
| `proofs/proof-defi-router.tex` | Cross-Pool Order Router |
| `proofs/proof-defi-hft.tex` | High-Frequency Trading Venue Model |
| `proofs/proof-defi-flash-loan.tex` | Flash Loan Safety |
| `proofs/proof-defi-liquid-staking.tex` | Liquid Staking and Yield Protocol |
| `proofs/proof-defi-governance.tex` | On-Chain DEX Governance |
| `proofs/proof-defi-fee-model.tex` | DeFi Fee Model |

### Bridge and Warp Proofs
| File | Property |
|------|----------|
| `proofs/proof-bridge-teleport.tex` | Teleport Bridge Protocol |
| `proofs/proof-warp-security.tex` | Warp Message Security |
| `proofs/proof-warp-delivery.tex` | Warp Exactly-Once Message Delivery |
| `proofs/proof-warp-ordering.tex` | Warp Causal Message Ordering |

### Network and Build Proofs
| File | Property |
|------|----------|
| `proofs/proof-network-peer-discovery.tex` | Peer Discovery and Eclipse Resistance |
| `proofs/proof-build-reproducibility.tex` | Build Reproducibility |
| `proofs/proof-build-attestation.tex` | Content-Addressed Build Attestation |
| `proofs/proof-build-coeffect.tex` | Coeffect Algebra |
| `proofs/proof-build-ecosystem.tex` | Cross-Ecosystem Build Verification |
| `proofs/proof-compute-crosschain.tex` | Cross-Chain Compute Verification |

### Trust Model Proofs
| File | Property |
|------|----------|
| `proofs/proof-trust-authority.tex` | Authority Meet-Semilattice |
| `proofs/proof-trust-vouch.tex` | Vouch-Based Trust Model |
| `proofs/proof-trust-revocation.tex` | Revocation Model |

## Extended Monographs (subdirectories)

| Directory | Title |
|-----------|-------|
| `threshold-mpc/` | Unified Threshold Cryptography for Omnichain Asset Custody: FROST, CGGMP21, and Taproot Integration |
| `teleport/` | Lux Teleport: A Sovereign Omnichain Liquidity Protocol |
| `sovereign-defi/` | Sovereign DeFi: Per-Chain Governance, Shariah Compliance, and Securities-Compatible Cross-Chain Infrastructure |
| `omnichain-yield/` | Yield-Bearing Bridge Tokens: Cross-Chain Capital Efficiency through Composable Yield Strategies |

---

See also: `PAPER_INDEX.md` (chronological view with dependency graph), `PAPER_TIMELINE.md` (timeline view).
