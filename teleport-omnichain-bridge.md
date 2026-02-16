# Lux Teleport: A Sovereign Omnichain Liquidity Protocol

**Version 1.0 — April 2026**
**Lux Industries, Inc.**

---

## Abstract

We present Lux Teleport, a non-custodial omnichain bridge and liquidity protocol that natively connects 20+ execution environments and 270+ blockchains through a unified MPC threshold signature network. Unlike existing bridges that rely on trusted intermediaries, multisigs, or chain-specific messaging layers, Teleport achieves trustless cross-chain asset transfer through FROST/CGGMP21 threshold cryptography with on-chain signature verification, per-chain nonce tracking, and automatic undercollateralization detection.

Teleport introduces three key innovations: (1) sovereign chain governance where each connected chain's native token holders control their own bridge fees, yield strategies, and risk parameters; (2) a unified yield-bearing bridge token system where locked assets on source chains are deployed to yield strategies and the yield is reflected in bridge token share prices on destination chains; and (3) a Shariah-compliant mode that programmatically filters yield sources to enable the first protocol-level Islamic finance DeFi infrastructure.

The protocol supports native bridge contracts across every major smart contract runtime: EVM (Solidity), Solana (Anchor/Rust), TON (FunC), Sui and Aptos (Move), Cosmos/IBC (CosmWasm), Bitcoin L1 (FROST Taproot), OP_NET (AssemblyScript), XRPL (Hooks), Polkadot (ink!), NEAR (Rust/WASM), Stellar (Soroban), Stacks (Clarity), Cardano (Aiken/Plutus), StarkNet (Cairo), ICP (Rust Canisters), Algorand (PyTeal), Fuel (Sway), and Tezos (CameLIGO).

---

## 1. Introduction

Cross-chain interoperability remains the critical unsolved problem in blockchain infrastructure. Existing solutions fall into four categories, each with fundamental limitations:

| Approach | Examples | Weakness |
|----------|----------|----------|
| Trusted multisig | WBTC, most bridges | Custodial risk, censorship |
| Optimistic | Across, Hop | Long withdrawal delays |
| Light client | IBC, Wormhole | Chain-specific, complex |
| MPC threshold | tBTC, Teleport | Key management complexity |

Teleport addresses the MPC approach's key management complexity through FROST (Flexible Round-Optimized Schnorr Threshold) and CGGMP21 (threshold ECDSA) protocols, which provide:

- **2-of-3 threshold**: no single point of compromise
- **7-day timelocked signer rotation**: users can exit before new signers activate
- **On-chain verification**: every mint requires a valid threshold signature checked by the destination chain's native signature verification
- **Automatic pause**: if backing falls below 98.5% of minted supply, the bridge halts

---

## 2. Architecture

### 2.1 Three-Layer Design

```
Layer 1: CHAIN ADAPTERS (native programs on each chain)
   ├── Lock/burn assets → emit events
   └── Verify MPC signatures → mint/release assets

Layer 2: MPC ATTESTATION NETWORK (FROST + CGGMP21)
   ├── Watch all chains for bridge events
   ├── Reach quorum (2-of-3)
   └── Produce threshold signatures

Layer 3: SOVEREIGN GOVERNANCE (per-chain DAO)
   ├── Control fees, strategies, risk parameters
   ├── Native token holders govern their chain
   └── Cannot override MPC security invariants
```

### 2.2 OmnichainRouter

The OmnichainRouter is the on-chain contract deployed on each EVM chain. It is:

- **Non-upgradeable**: no proxy pattern, no selfdestruct, immutable bytecode
- **Non-custodial**: never holds user funds; mints/burns via bridge token interface
- **Permissionless relay**: anyone can submit valid MPC-signed transactions
- **Sovereignly governed**: each chain's DAO controls fees and parameters

Key properties:
```solidity
// Immutable (set at deployment, never changes)
uint64 public immutable chainId;

// Governed by native DAO (changeable with timelocks)
address public governor;           // DAO timelock
address public stakeholderVault;   // Fee recipient (xLUX, LQDTY stakers, etc.)
uint256 public bridgeFeeBps;       // Max 1%, controlled by governor
uint256 public stakeholderShareBps; // Split between stakers and treasury

// MPC-controlled (rotatable with 7-day timelock)
SignerSet public signers;          // 2-of-3 threshold
```

### 2.3 Signature Verification by Chain Family

| Chain Family | Signature Scheme | Verification Method |
|-------------|------------------|---------------------|
| EVM | ECDSA (secp256k1) | `ecrecover` / CGGMP21 threshold |
| Solana | Ed25519 | Native `Ed25519Program` sysvar introspection |
| TON | Ed25519 | `check_signature` TVM opcode |
| Sui | Ed25519 | `ed25519::ed25519_verify` |
| Aptos | Ed25519 | `ed25519::signature_verify_strict` |
| Cosmos | Ed25519 | `deps.api.ed25519_verify` |
| Bitcoin L1 | Schnorr (BIP-340) | FROST Taproot threshold |
| OP_NET | Schnorr/Taproot | AssemblyScript `check_signature` |
| Polkadot | Ed25519/Sr25519 | ink! chain extension |
| NEAR | Ed25519 | `env::ed25519_verify` |
| Stellar | Ed25519 | `env.crypto().ed25519_verify` |
| Cardano | Ed25519 | `extra_signatories` witness |
| StarkNet | ECDSA (Stark curve) | `check_ecdsa_signature` |
| XRPL | ECDSA (secp256k1) | Hook state verification |
| Algorand | Ed25519 | `Ed25519Verify_Bare` opcode |
| Fuel | ECDSA (secp256k1) | Native `ecrecover` |
| Tezos | Ed25519 | `Crypto.check` |
| ICP | ECDSA (t-ECDSA) | Management canister |

---

## 3. Yield-Bearing Bridge Tokens

### 3.1 Architecture

When a user bridges ETH from Ethereum to Lux, two things happen:

1. **Immediate**: User receives LETH (1:1 with deposited ETH) on Lux
2. **Background**: The deposited ETH is deployed to yield strategies on Ethereum

The yield-bearing variant (yLETH) uses share-based accounting:

```
yLETH share price = totalBackingOnEthereum / totalYLETHSupply
```

As yield accrues on Ethereum (via Lido, Rocket Pool, EigenLayer, etc.), the MPC periodically attests to the new total backing. The yLETH share price increases automatically — holders earn yield without any action.

### 3.2 Strategy Routing

Each yield strategy implements `IYieldStrategy`:

```solidity
interface IYieldStrategy {
    function deposit(uint256 amount) external returns (uint256 shares);
    function withdraw(uint256 shares) external returns (uint256 assets);
    function totalAssets() external view returns (uint256);
    function currentAPY() external view returns (uint256);
    function harvest() external returns (uint256 harvested);
    function isActive() external view returns (bool);
}
```

Deployed strategies (29 total):

| Category | Strategies | Combined APY Range |
|----------|-----------|-------------------|
| **Liquid Staking** | Lido, Rocket Pool | 3-5% |
| **Restaking** | EigenLayer, Symbiotic, Karak | 3-8% |
| **Lending** | Aave V3, Compound V3, Morpho, Euler V2, Spark, Fluid | 2-12% |
| **Stablecoin** | MakerDAO/Sky, Ethena, Frax | 4-15% |
| **LP/DEX** | Curve, Convex, Pendle, L2 DEXs | 5-20% |
| **Bitcoin Native** | Babylon, Lombard, SolvBTC, CoreDAO | 3-12% |
| **Solana** | Marinade, Jito, Kamino | 5-10% |
| **TON** | Tonstakers, Bemo, STON.fi | 5-15% |
| **OP_NET** | Bitcoin L1 yield (via OP_NET runtime) | 3-8% |
| **Perps** | LPX Perps LP (fee-based, Shariah compliant) | 10-30% |

### 3.3 Yield Composition (Layered)

A user holding yLBTC on Lux earns from multiple layers simultaneously:

```
Layer 1: Base yield    — Babylon BTC staking (~5%)
Layer 2: Restaking     — EigenLayer/Symbiotic bonus (~2%)
Layer 3: Bridge fees   — Teleport bridge fee share via xLUX (~1%)
Layer 4: DeFi yield    — yLBTC as LP/collateral on Lux (~5-15%)
                         ────────────────
Total potential:         ~13-23% APY on BTC
```

---

## 4. Sovereign Chain Governance

### 4.1 Principle

Each chain that deploys the OmnichainRouter is sovereign. The native token holders of that chain govern:

- Bridge fee rate (0-1%)
- Fee distribution split (staker vault vs treasury)
- Which tokens are registered
- Daily mint limits per token
- Shariah compliance mode
- Yield strategy preferences

The MPC signer set is separate from governance. Governance cannot:
- Mint tokens without MPC signature
- Bypass nonce checks
- Override undercollateralization pauses
- Shorten the 7-day signer rotation timelock

### 4.2 Deployment Examples

```
Lux C-Chain (96369):
  governor:         LUX DAO Timelock
  stakeholderVault: LiquidLUX (xLUX)
  bridgeFeeBps:     10 (0.1%)
  stakeholderShare: 9000 (90% to xLUX holders)

Zoo EVM (200200):
  governor:         ZOO DAO Timelock
  stakeholderVault: ZOO Staking Vault
  bridgeFeeBps:     15 (0.15%)
  stakeholderShare: 8000 (80% to ZOO stakers)

Any Third-Party Chain:
  governor:         Their DAO
  stakeholderVault: Their staking vault
  bridgeFeeBps:     Whatever their DAO decides
  stakeholderShare: Whatever their DAO decides
```

### 4.3 White-Label Architecture

Any L1/L2 can deploy the OmnichainRouter with their own governance and fee structure. They white-label the bridge under their brand while sharing the same MPC attestation network. This is economically efficient: one MPC set secures all connected chains, but each chain captures its own fees.

---

## 5. Shariah Compliance

### 5.1 The Problem

Islamic finance law (Shariah) prohibits riba (interest/usury). Most DeFi yield comes from lending interest, making it haram (forbidden) for the ~1.8 billion Muslims worldwide. This excludes ~25% of the world's population from DeFi.

### 5.2 The Solution

Teleport introduces protocol-level Shariah classification via the `ShariaFilter` contract:

| Status | Yield Source | Rationale |
|--------|-------------|-----------|
| **Halal** | DEX trading fees | Service fee for facilitating exchange |
| **Halal** | Bridge fees | Service fee for cross-chain transfer |
| **Halal** | Validator staking | Compensation for securing network |
| **Halal** | LP provision | Compensation for providing liquidity |
| **Halal** | Perps trading fees | Service fee (not interest) |
| **Halal** | Babylon BTC staking | Fee-based security provision |
| **Haram** | Aave/Compound interest | Riba — interest on loans |
| **Haram** | MakerDAO DSR | Interest on savings |
| **Haram** | Interest-bearing stables | sDAI, USDY — riba |
| **Conditional** | Liquid staking (Lido) | Depends on structure — Shariah board reviews |
| **Conditional** | Restaking | Depends on what's being secured |

When `shariahMode` is enabled on an OmnichainRouter:
- Only halal-classified strategies receive deposits
- Yield reports are filtered through the ShariaFilter
- Users see clearly labeled "Halal Yield" in the UI
- A Shariah Advisory Board (SAB) multisig can update classifications

### 5.3 Compliance Architecture

```solidity
contract ShariaFilter {
    enum ComplianceStatus { HALAL, HARAM, UNDER_REVIEW, CONDITIONAL }
    mapping(address => ComplianceStatus) public compliance;
    address public shariahBoard; // SAB multisig

    function isCompliant(address strategy) external view returns (bool);
    function filterCompliant(address[] calldata) external view returns (address[] memory);
}
```

---

## 6. Security Model

### 6.1 Threat Model

| Threat | Mitigation |
|--------|------------|
| MPC key compromise (1 of 3) | 2-of-3 threshold — single compromise insufficient |
| MPC key compromise (2 of 3) | 7-day timelock on signer rotation — users exit |
| Replay attacks | Per-chain per-nonce bitmap — each nonce usable exactly once |
| Undercollateralization | Auto-pause at 98.5% backing ratio |
| Governance attack | Governor cannot mint/steal — only adjust fees within hard caps |
| Relay censorship | Permissionless relay — anyone with valid MPC sig can submit |
| Contract upgrade attack | Non-upgradeable — no proxy, no admin upgrade |
| Oracle manipulation | MPC directly attests backing — no external oracle dependency |
| Daily mint limit bypass | Hard-coded per-token limits, resets every 24 hours |

### 6.2 Formal Properties

1. **Conservation**: `totalMinted[token] <= totalBacking[token]` (enforced by auto-pause)
2. **Uniqueness**: Each `(sourceChainId, nonce)` pair is processed exactly once
3. **Liveness**: If 2-of-3 MPC nodes are online, bridge operates
4. **Safety**: If <2 MPC nodes are compromised, no unauthorized minting
5. **Governance isolation**: Governor cannot mint, MPC cannot change fees

---

## 7. Supported Execution Environments

Teleport natively supports 20 execution environments through chain-specific bridge programs:

| # | Runtime | Language | Chains Covered |
|---|---------|----------|----------------|
| 1 | EVM | Solidity | Ethereum, 30+ L2s, 13 Bitcoin L2s, TRON, Hedera |
| 2 | SVM | Rust/Anchor | Solana |
| 3 | TVM (TON) | FunC | TON |
| 4 | Sui MoveVM | Move | Sui |
| 5 | Aptos MoveVM | Move | Aptos |
| 6 | CosmWasm | Rust | Cosmos Hub, Osmosis, Noble, 115+ IBC chains |
| 7 | OP_NET | AssemblyScript | Bitcoin L1 (smart contracts) |
| 8 | Bitcoin Script | FROST Taproot | Bitcoin L1 (native UTXO) |
| 9 | XRPL Hooks | C/WASM | XRP Ledger |
| 10 | Substrate | Rust/ink! | Polkadot, Kusama, Astar, parachains |
| 11 | NEAR WASM | Rust | NEAR Protocol |
| 12 | Soroban | Rust | Stellar |
| 13 | Clarity | Clarity | Stacks (Bitcoin L2) |
| 14 | Plutus | Aiken | Cardano |
| 15 | Cairo | Cairo | StarkNet |
| 16 | ICP Canisters | Rust | Internet Computer |
| 17 | AVM | PyTeal | Algorand |
| 18 | FuelVM | Sway | Fuel |
| 19 | Michelson | CameLIGO | Tezos, Etherlink |
| 20 | TVM (TRON) | Solidity | TRON |

Total: **270 chain IDs registered**, covering every top-200 blockchain by TVL.

---

## 8. Fee Economics

### 8.1 Fee Structure

```
Bridge fee:     0.1% per transfer (configurable by governor, max 1%)
Yield fee:      10% of generated yield (configurable)

Fee split:      90% → stakeholder vault (xLUX on Lux, etc.)
                10% → protocol treasury
```

### 8.2 Value Flow

```
User bridges 100 ETH to Lux
  → 0.1 ETH bridge fee
  → 0.09 ETH to xLUX holders (90%)
  → 0.01 ETH to treasury (10%)
  → 99.9 LETH minted to user

99.9 ETH deployed to yield strategies on Ethereum
  → ~4.5% APY from Lido staking
  → ~4.5 ETH/year yield
  → 0.45 ETH/year to xLUX holders (10% yield fee)
  → 4.05 ETH/year to LETH holders (share price increase)
```

### 8.3 xLUX Flywheel

xLUX (LiquidLUX) receives fees from ALL protocol activity:
- Bridge fees (every chain's OmnichainRouter)
- DEX trading fees (D-Chain CLOB + AMM)
- Lending interest spread (Markets)
- Perps trading fees (LPX)
- NFT AMM fees (LSSVM)

This creates a flywheel: more bridged assets → more yield → more fees → higher xLUX APY → more LUX staked → more liquidity → more bridged assets.

---

## 9. Implementation

All source code is open-source under the Lux Industries GitHub organization:

| Component | Repository | Language |
|-----------|-----------|----------|
| Bridge contracts | `github.com/luxfi/standard` | Solidity + 18 native languages |
| MPC signing | `github.com/luxfi/mpc` | Go |
| Bridge infrastructure | `github.com/luxfi/bridge` | TypeScript + Go |
| Threshold crypto | `github.com/luxfi/threshold` | Go |
| Cross-chain messaging | `github.com/luxfi/warp` | Go |
| Chain registry | `github.com/luxfi/standard/contracts/bridge/chains/ChainIds.sol` | Solidity |
| Yield strategies | `github.com/luxfi/standard/contracts/bridge/yield/strategies/` | Solidity |

---

## 10. Conclusion

Lux Teleport provides the infrastructure for a truly omnichain liquidity layer: non-custodial, non-upgradeable, sovereignly governed, optionally Shariah-compliant, and natively deployed across every major blockchain execution environment. By separating the attestation layer (MPC) from the governance layer (per-chain DAO), Teleport enables any blockchain to join the liquidity network while retaining full sovereignty over its economic parameters.

---

## References

1. Komlo, C., Goldberg, I. "FROST: Flexible Round-Optimized Schnorr Threshold Signatures." CRYPTO 2020.
2. Canetti, R., et al. "UC Non-Interactive, Proactive, Threshold ECDSA with Identifiable Aborts." CCS 2020 (CGGMP21).
3. BIP-340: Schnorr Signatures for secp256k1.
4. BIP-341: Taproot.
5. EIP-712: Typed structured data hashing and signing.
6. ICS-20: Fungible Token Transfer (IBC).
7. TEP-74: Jetton Standard (TON).
8. SRC-20: Native Asset Standard (Fuel).
9. TZIP-12: FA2 Token Standard (Tezos).
10. CIP-25: Native Token Metadata (Cardano).
