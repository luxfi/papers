# Lux Network Research Paper Timeline

This document tracks the proper dating of research papers based on when the actual work was completed, not when documentation was written.

## Dating Methodology

Papers should be dated to reflect:
1. **Initial Version**: When core innovation was first implemented (git history)
2. **Revisions**: Major feature additions or architectural changes
3. **Current Version**: Latest significant update

All papers use **arXiv-style versioning**: `vYYYY.MM` (e.g., v2023.12 for December 2023)

---

## 📄 Lux Network Papers

### Core Infrastructure

#### 1. Lux Quantum Consensus
- **Initial Version**: v2025.07 (July 2025)
  - *Repository created*: July 28, 2025
  - Post-quantum CRYSTALS-Dilithium integration
  - 50,000+ TPS with sub-2s finality
- **Status**: ✅ Published (October 2025)
- **File**: `lux-quantum-consensus.tex`

#### 2. Lux Lightspeed DEX
- **Initial Version**: v2025.07 (July 2025)
  - *Based on TEE stack*: July 2025
  - 261ms execution latency, 1M orders/sec
  - FPGA acceleration integration
- **Status**: ✅ Published (October 2025)
- **File**: `lux-lightspeed-dex.tex`

#### 3. Lux Consensus (Original)
- **Initial Version**: v2025.07 (July 2025)
  - *Extracted from node*: July 28, 2025
  - Multi-consensus architecture
- **Status**: 🔄 Needs revision for post-quantum enhancements
- **File**: `lux-consensus.tex`

---

### Identity & Access Management

#### 4. Lux ID & Decentralized Identity **[DRAFT]**
- **Target Version**: v2020.10 (October 2020)
  - *Repository created*: October 20, 2020 (based on Casdoor)
  - Multi-protocol IAM (OAuth2, OIDC, SAML, WebAuthn)
  - DID specification: `did:lux:address` format
- **Major Revision**: v2025.10 (October 2025)
  - Post-quantum credential integration
  - Hardware security key enhancements
- **Status**: 📝 To be written
- **Estimated Date**: Should reflect 5 years of development (2020-2025)

---

### Cryptography & Security

#### 5. Universal Threshold Signatures **[DRAFT]**
- **Initial Version**: v2021.02 (February 2021)
  - *Repository created*: February 16, 2021
  - CMP, FROST, Doerner protocols
  - Multi-chain support (Bitcoin, Ethereum, XRPL)
- **Major Revision**: v2025.08 (August 2025)
  - Post-quantum Ringtail integration
  - 20+ blockchain support
  - LSS dynamic resharing
  - Production readiness
- **Status**: 📝 To be written
- **Estimated Date**: Should show 4+ years of evolution

#### 6. Post-Quantum Cryptography Suite **[DRAFT]**
- **Initial Version**: v2025.01 (January 2025)
  - *ETHFALCON repo created*: January 24, 2025
  - FALCON, FALCON-SOLIDITY, FALCONREC
  - EPERVIER EVM optimization
- **Status**: 📝 To be written

#### 7. Warp V2 Cross-Chain Messaging **[DRAFT]**
- **Initial Version**: v2025.07 (July 2025)
  - *Extracted from node*: July 24-25, 2025
  - Post-quantum ringtail validation
  - FHE for private messages
  - Ring signatures for anonymity
- **Status**: 📝 To be written

---

### Governance & Economics

#### 8. Lux DAO Governance Framework **[DRAFT]**
- **Initial Version**: v2022.10 (October 2022)
  - *Contracts repo created*: October 6, 2022
  - Azorius modular governance
  - LinearERC20Voting
- **Major Revision**: v2024.06 (June 2024)
  - DecentAutonomousAdmin
  - DecentHats integration
  - ERC6551 token-bound accounts
- **Status**: 📝 To be written
- **Estimated Date**: Should show 3+ years of DAO development

#### 9. Lux Tokenomics **[DRAFT]**
- **Target Version**: v2020.10 (October 2020)
  - *Initial LUX token design*: ~2020
  - Staking mechanics (5,000 LUX per validator)
  - Fee structure and economics
- **Major Revision**: v2025.07 (July 2025)
  - TEE compute pricing integration
  - Dynamic AMM-based fees
- **Status**: 📝 To be written

---

### Advanced Infrastructure

#### 10. TEE Computing Mesh **[DRAFT]**
- **Initial Version**: v2025.07 (July 2025)
  - *Stack repo created*: July 6, 2025
  - Intel SGX/TDX, AMD SEV-SNP, NVIDIA Hopper support
  - Unified attestation framework
  - Encrypted execution in RAM
- **Status**: 📝 To be written
- **Estimated Date**: 4 months of development

#### 11. Bridge & MPC Architecture **[DRAFT]**
- **Initial Version**: v2023.12 (December 2023)
  - *Bridge repo created*: December 30, 2023
  - Cross-chain atomic swaps
  - Threshold ECDSA for security
- **Major Revision**: v2025.08 (August 2025)
  - Migration to Go-based MPC
  - Lux ID integration
- **Status**: 📝 To be written

#### 12. Liquidity Provider System **[DRAFT]**
- **Target Version**: v2024.06 (June 2024)
  - *LP mechanics implemented*: ~mid-2024
  - Integration with Lightspeed DEX
  - Cross-subnet liquidity routing
- **Status**: 📝 To be written

#### 13. VM SDK & Custom Blockchains **[DRAFT]**
- **Target Version**: v2024.01 (January 2024)
  - *VM SDK development*: ~2024
  - Custom blockchain framework
  - Subnet deployment tooling
- **Status**: 📝 To be written

---

## 🤖 Hanzo AI Papers

### Core Infrastructure

#### 14. Hanzo Compute Network Architecture **[DRAFT]**
- **Initial Version**: v2025.09 (September 2025)
  - *Node repo created*: September 18, 2025
  - Decentralized GPU/TPU marketplace
  - Proof of compute verification
  - HIPS governance system
- **Status**: 📝 To be written

#### 15. MCP (Model Context Protocol) **[DRAFT]**
- **Target Version**: v2025.09 (September 2025)
  - *MCP implementation*: September 2025
  - Context windowing strategies
  - Cross-model communication
- **Status**: 📝 To be written

#### 16. Jin Multimodal Architecture **[DRAFT]**
- **Target Version**: v2025.09 (September 2025)
  - *Jin architecture*: September 2025
  - Vision-language integration
  - Cross-modal understanding
- **Status**: 📝 To be written

#### 17. ACI (AI Chain Infrastructure) **[DRAFT]**
- **Target Version**: v2025.09 (September 2025)
  - *ACI implementation*: September 2025
  - Decentralized compute verification
  - Model checkpoint storage
- **Status**: 📝 To be written

---

## 🦁 Zoo Network Papers

### AI Training & Optimization

#### 18. Gym: AI Model Training Platform **[DRAFT]**
- **Initial Version**: v2023.05 (May 2023)
  - *LLaMA Factory fork created*: May 28, 2023
  - Full fine-tuning, LoRA, QLoRA
  - 100+ model support
- **Major Revision**: v2025.09 (September 2025)
  - Rebranded as Gym
  - GRPO/GSPO integration (Sept 24-25, 2025)
  - Training-Free GRPO
  - Zoo.ngo 501(c)(3) foundation
- **Status**: 📝 To be written
- **Estimated Date**: Should show 2.5 years of evolution

#### 19. HLLM with Training-Free GRPO **[DRAFT]**
- **Initial Version**: v2025.09 (September 2025)
  - *GRPO implementation*: September 24, 2025
  - Semantic advantage extraction
  - Hamiltonian invariant: Ψ · Θ = κ
  - 99.8% cost reduction vs fine-tuning
- **Status**: 📝 To be written

#### 20. Zoo as AI/ML Layer on Hanzo **[DRAFT]**
- **Initial Version**: v2025.09 (September 2025)
  - *Zoo network architecture*: September 2025
  - Hanzo → Zoo → HLLM layering
  - Specialization for AI workloads
- **Status**: 📝 To be written

#### 21. Experience Ledger & Semantic Optimization **[DRAFT]**
- **Initial Version**: v2025.09 (September 2025)
  - *Experience library design*: September 2025
  - IPFS/Arweave storage
  - DAO-based curation
- **Status**: 📝 To be written

#### 22. Zoo Tokenomics **[DRAFT]**
- **Target Version**: v2025.09 (September 2025)
  - *Token design*: September 2025
  - Data contribution → inference credit exchange
  - Governance rights distribution
- **Status**: 📝 To be written

---

## 🎯 Paper Writing Priority & Dating Strategy

### Phase 1: Foundational (Backdate to Original Work)

1. **Lux ID & DID** → v2020.10 with v2025.10 revision
   - Shows 5 years of identity system evolution
   - Emphasizes maturity and production deployment

2. **Threshold Signatures** → v2021.02 with v2025.08 revision
   - Shows 4+ years of cryptographic innovation
   - Post-quantum enhancements as major revision

3. **Lux DAO** → v2022.10 with v2024.06 revision
   - Shows 3 years of governance framework development
   - Multiple production deployments

### Phase 2: Recent Innovations (Current Dating)

4. **Lux Tokenomics** → v2020.10 with v2025.07 revision
5. **TEE Computing Mesh** → v2025.07
6. **Post-Quantum Crypto Suite** → v2025.01 with v2025.10 revision
7. **Warp V2 Messaging** → v2025.07

### Phase 3: Emerging Technologies (Very Recent)

8. **Hanzo Compute Network** → v2025.09
9. **Gym Training Platform** → v2023.05 with v2025.09 revision
10. **HLLM & Training-Free GRPO** → v2025.09
11. **Zoo AI Layer** → v2025.09

---

## 📋 Version Tracking Format

Each paper should include in the header:

```latex
\title{Paper Title}
\author{Lux Foundation / Hanzo AI / Zoo Labs}
\date{
  v2023.05 — May 2023 (Initial Version) \\
  v2025.09 — September 2025 (Current Revision)
}

\begin{abstract}
% ...
\end{abstract}

\section*{Version History}
\begin{itemize}
  \item \textbf{v2023.05} (May 2023): Initial implementation of core features
  \item \textbf{v2024.06} (June 2024): Added major feature X
  \item \textbf{v2025.09} (September 2025): Current revision with feature Y
\end{itemize}
```

---

## 🔄 Update Policy

Papers should be revised when:
1. **Major architectural changes** (new version)
2. **Significant performance improvements** (>2x)
3. **New security features** (especially post-quantum)
4. **Production deployment milestones**
5. **Academic collaborations or validations**

Minor updates (bug fixes, optimizations) should be tracked in git but don't require new paper versions.

---

## 📊 Publication Strategy

1. **Internal Review**: Peer review within Lux/Hanzo/Zoo teams
2. **Public GitHub Release**: Version-tagged releases
3. **arXiv Submission**: For academic visibility (optional)
4. **Conference Submissions**: Target blockchain/cryptography conferences
5. **Journal Submissions**: For major innovations (threshold sigs, PQ crypto)

---

**Last Updated**: October 29, 2025
**Maintained by**: Lux Foundation Research Team
