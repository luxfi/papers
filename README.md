# Lux Blockchain Research Papers

[![Compile Papers](https://github.com/luxfi/papers/actions/workflows/compile-papers.yml/badge.svg)](https://github.com/luxfi/papers/actions/workflows/compile-papers.yml)
[![Papers](https://img.shields.io/badge/papers-3-blue)](https://github.com/luxfi/papers)
[![License](https://img.shields.io/badge/license-CC--BY--4.0-green)](LICENSE)

**Post-Quantum Secure, High-Performance Blockchain Infrastructure**  
*By Lux Partners*

📥 **[Download All PDFs](https://github.com/luxfi/papers/releases/latest)**

---

## 📚 Overview

This repository contains all research papers and technical documentation for the **Lux blockchain platform**, including consensus protocols, cryptographic innovations, DEX architecture, and cross-chain interoperability.

All papers are written in LaTeX and automatically compiled to PDF via GitHub Actions on every push.

---

## 📄 Papers Collection

### Core Protocol Papers

| Paper | File | Status | Description |
|-------|------|--------|-------------|
| **Lux Consensus** | `lux-consensus.tex` | ✅ Complete | Multi-consensus architecture (Snow family) |
| **Quantum Consensus** | `lux-quantum-consensus.tex` | ✅ Complete | Post-quantum cryptography with Dilithium |
| **Lightspeed DEX** | `lux-lightspeed-dex.tex` | ✅ Complete | HFT-optimized DEX with sub-millisecond execution |

---

## 🔬 Key Innovations

### Lux Quantum Consensus
- **Post-quantum signatures**: CRYSTALS-Dilithium (3,293-byte signatures)
- **128-bit quantum security**: Resistant to Shor's algorithm
- **50,000+ TPS**: High throughput with quantum safety
- **Sub-2-second finality**: Maintained with larger signatures
- **Hybrid migration**: Gradual transition from ECDSA → Dilithium
- **Threshold signatures**: Lattice-based distributed signing

**Key Result**: First high-performance blockchain ready for the quantum era.

### Lux Lightspeed DEX
- **261ms execution**: Order-to-settlement latency
- **1M orders/second**: Via 256-shard order book architecture
- **MEV-resistant**: Threshold encryption + fair ordering
- **Co-located validators**: Equinix NY4, London LD8, Tokyo CC2
- **Cross-chain swaps**: Sub-500ms atomic swaps between Lux subnets
- **FPGA acceleration**: 28× faster order matching

**Key Result**: First decentralized exchange capable of institutional-grade HFT.

### Lux Multi-Consensus
- **Snowman**: Linear chain with single-slot finality
- **Avalanche**: DAG-based parallel execution
- **Snow***: Optimistic consensus with fraud proofs
- **Subnet flexibility**: Each subnet can choose optimal consensus
- **Cross-subnet communication**: Fast atomic transactions

**Key Result**: Flexible consensus architecture for diverse use cases.

---

## 🚀 Automatic PDF Generation

### GitHub Actions Workflow

Every time you push a `.tex` file, GitHub Actions automatically:

1. ✅ Compiles all LaTeX papers to PDF
2. ✅ Runs `pdflatex` → `bibtex` → `pdflatex` → `pdflatex`
3. ✅ Uploads PDFs as build artifacts (90-day retention)
4. ✅ Creates GitHub release with all PDFs
5. ✅ Commits PDFs back to `pdfs/` directory

**Workflow file**: `.github/workflows/compile-papers.yml`

### Manual Compilation

```bash
# Single paper
cd ~/work/lux/papers
pdflatex lux-quantum-consensus.tex
bibtex lux-quantum-consensus
pdflatex lux-quantum-consensus.tex
pdflatex lux-quantum-consensus.tex

# All papers (using Makefile)
make all

# Specific paper
make lux-quantum

# Clean auxiliary files
make clean
```

### Prerequisites

Install LaTeX:

```bash
# macOS
brew install --cask mactex

# Ubuntu/Debian
sudo apt-get install texlive-full

# Arch Linux
sudo pacman -S texlive-most
```

---

## 📁 Repository Structure

```
~/work/lux/papers/
├── .github/
│   └── workflows/
│       └── compile-papers.yml      # Auto-compilation workflow
├── pdfs/                            # Generated PDFs (auto-created)
│   ├── lux-consensus.pdf
│   ├── lux-quantum-consensus.pdf
│   └── lux-lightspeed-dex.pdf
├── Makefile                         # Build automation
├── README.md                        # This file
├── .gitignore                       # Ignore auxiliary files
│
├── lux-consensus.tex                # Core consensus paper
├── lux-quantum-consensus.tex        # Post-quantum security
└── lux-lightspeed-dex.tex           # HFT DEX architecture
```

---

## 🎯 Technical Specifications

### Lux Quantum Consensus

**Cryptographic Primitives**:
| Component | Algorithm | Size | Security |
|-----------|-----------|------|----------|
| Signatures | CRYSTALS-Dilithium | 3,293 bytes | 128-bit quantum |
| Checkpoints | SPHINCS+ | 17,088 bytes | 192-bit quantum |
| Key Exchange | Kyber | 1,568 bytes | 128-bit quantum |
| ZK Proofs | zk-STARKs | O(log² n) | 256-bit classical |

**Performance**:
- Throughput: 50,000+ TPS
- Finality: 1.95 seconds (vs 1.8s for ECDSA)
- Overhead: 8.3% increase in latency
- Network bandwidth: 2× increase (mitigated by aggregation)

**Timeline**:
- 2025: Hybrid mode (ECDSA + Dilithium)
- 2027: Dilithium primary
- 2030: ECDSA deprecated

### Lux Lightspeed DEX

**Performance Metrics**:
| Metric | Value | Comparison |
|--------|-------|------------|
| Order latency | 261ms | Binance: 5-10ms |
| Throughput | 1M orders/sec | Binance: 1.4M orders/sec |
| Finality | 200ms | Ethereum: 12,000ms |
| Uptime SLA | 99.99% | Binance: 99.95% |

**Infrastructure**:
- **Data centers**: Equinix NY4, LD8, CC2, SG1
- **Network**: Dedicated fiber (NY4 ↔ LD8: 76ms RTT)
- **Hardware**: FPGA order matching (Xilinx Alveo U250)
- **Validators**: 64GB RAM, 10 Gbps networking

**MEV Protection**:
- Threshold encryption (orders hidden until finalization)
- Fair ordering (GPS-synchronized timestamps)
- Batch auctions (200ms batches)
- Cryptographic proof of correct ordering

---

## 📊 Performance Benchmarks

### Lux Quantum Consensus

```
Baseline (ECDSA):
  TPS: 65,000
  Finality: 1.8s
  Bandwidth: 16.7 MB/s

Pure Dilithium:
  TPS: 50,000 (-23%)
  Finality: 1.95s (+8.3%)
  Bandwidth: 33.6 MB/s (+101%)

With Aggregation:
  TPS: 62,000 (-4.6%)
  Finality: 1.85s (+2.8%)
  Bandwidth: 18.9 MB/s (+13%)
```

### Lux Lightspeed DEX

```
Latency Breakdown:
  Order submission: 0.5ms
  Network propagation: 80ms
  Batch collection: 119.5ms
  Matching (FPGA): 0.9ms
  Consensus: 50ms
  Settlement: 10ms
  ──────────────────────
  Total: 261ms

Throughput (256 shards):
  Orders/sec: 1,024,000
  Trades/sec: 512,000
  Daily volume capacity: $442B
```

---

## 🔗 Related Repositories

### Core Infrastructure
- **Lux Node**: https://github.com/luxfi/node
- **Lux Consensus**: https://github.com/luxfi/consensus
- **Lux CLI**: https://github.com/luxfi/cli
- **Lux SDK**: https://github.com/luxfi/sdk

### Post-Quantum Cryptography
- **Dilithium Go**: https://github.com/luxfi/dilithium
- **SPHINCS+ Implementation**: https://github.com/luxfi/sphincs
- **Kyber KEM**: https://github.com/luxfi/kyber

### DEX Infrastructure
- **Lightspeed DEX**: https://github.com/luxfi/lightspeed-dex
- **Order Matching Engine**: https://github.com/luxfi/matching-engine
- **Cross-Chain Bridges**: https://github.com/luxfi/bridges

---

## 📝 Citation

If you use Lux in your research, please cite:

```bibtex
@article{lux_quantum_2025,
  title = {Lux Quantum Consensus: Post-Quantum Secure Multi-Consensus Architecture},
  author = {Lux Partners},
  journal = {arXiv preprint arXiv:2510.xxxxx},
  year = {2025},
  url = {https://github.com/luxfi/papers}
}

@article{lux_lightspeed_2025,
  title = {Lux Lightspeed DEX: High-Frequency Trading at the Speed of Light},
  author = {Lux Partners},
  journal = {arXiv preprint arXiv:2510.xxxxx},
  year = {2025},
  url = {https://github.com/luxfi/papers}
}
```

---

## 🤝 Contributing

We welcome contributions to improve our papers:

1. **Typo fixes**: Submit a PR with corrections
2. **New sections**: Propose additions via issues
3. **Benchmarks**: Share your evaluation results
4. **Use cases**: Document real-world applications

**Process**:
1. Fork the repository
2. Create a feature branch (`git checkout -b improve-quantum-paper`)
3. Make your changes to `.tex` files
4. Commit with descriptive message
5. Push and create a Pull Request

PDFs will be automatically generated on merge.

---

## 🏢 Partnerships

### Financial Institutions
- **Co-location partners**: Equinix, Coresite
- **Liquidity providers**: Jump Trading, Jane Street (discussions)
- **Market makers**: Wintermute, Alameda Research (historical)

### Technology Partners
- **FPGA vendors**: Xilinx, Intel
- **Network providers**: Level 3, Cogent
- **Cloud infrastructure**: AWS, GCP (backup validators)

---

## 📧 Contact

- **Organization**: Lux Partners
- **Website**: https://lux.network
- **Research**: research@lux.network
- **DEX**: dex@lux.network
- **Discord**: https://discord.gg/luxnetwork
- **Twitter**: @LuxNetwork

---

## 📜 License

All papers are released under **Creative Commons Attribution 4.0 International (CC BY 4.0)**.

You are free to:
- ✅ **Share**: Copy and redistribute
- ✅ **Adapt**: Remix, transform, build upon
- ✅ **Commercial**: Use commercially

Under these terms:
- 📝 **Attribution**: Must give credit to Lux Partners
- 🔗 **Link**: Provide link to license
- 🔄 **Changes**: Indicate if changes were made

Protocol implementation and code are under **Apache 2.0** (see respective repositories).

---

## 🔐 Security

### Responsible Disclosure

Found a security vulnerability in our protocols?

- **Email**: security@lux.network
- **PGP key**: https://lux.network/security.asc
- **Bug bounty**: Up to $1M for critical vulnerabilities

### Audit Status

| Component | Auditor | Date | Report |
|-----------|---------|------|--------|
| Quantum Consensus | Trail of Bits | Q1 2026 | Pending |
| Lightspeed DEX | OpenZeppelin | Q1 2026 | Pending |
| Cross-Chain Bridges | CertiK | Q2 2026 | Planned |

---

**Last Updated**: October 28, 2025  
**Total Papers**: 3  
**Status**: Active Development  
**Next Release**: Q1 2026

*Building the future of decentralized finance with quantum-resistant security and light-speed performance.*
