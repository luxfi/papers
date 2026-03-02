    # Research Trends: 2018–2026
    ## The arc that made Web5-style private apps practical

    ## Executive summary

    The important shift since 2018 is that several previously separate research tracks
    began reinforcing one another. The result is a much more credible architecture for
    private decentralized apps than the “everything on-chain” model that dominated many
    early web3 conversations.

    ## 2018–2019: The local-first turn

    The most important conceptual shift was the articulation of local-first software.
    The 2019 local-first paper argued that users should be able to work offline,
    collaborate, preserve history, and retain control of data without surrendering
    ownership to a cloud application.

    Why it matters:
    - reframed the app problem away from centralized databases
    - created a principled reason to keep state primarily on-device
    - made sync, not hosting, the core distributed systems problem

    ## 2019–2021: CRDTs move from niche theory toward app tooling

    CRDTs were already academically established, but the practical story improved as
    developer-friendly libraries and patterns emerged. Research and tooling around
    SQLite + CRDTs also became more concrete, including work on conflict-free replicated
    relations and local-first relational patterns.

    Why it matters:
    - made multi-device merge realistic
    - reduced dependence on coordination locks
    - supported per-user or per-workspace sharding models

    ## 2021–2023: Self-sovereign identity becomes standards-oriented

    DID Core became a W3C Recommendation in 2022, and the Verifiable Credentials model
    continued maturing until VCDM 2.0 became a W3C Recommendation in 2025.
    This shifted decentralized identity from mostly ecosystem-specific rhetoric toward
    standards-based identifiers and credential exchange models.

    Why it matters:
    - portable identity became more legible
    - issuer/holder/verifier roles became standardized
    - credentials became easier to reason about across apps and providers

    ## 2022–2025: Passkeys normalize device-centric auth

    Passkeys turned hardware- and device-bound authentication into a mainstream UX.
    By 2024, FIDO Alliance research reported strong growth in awareness and availability,
    including more than 15 billion online accounts that could use passkeys and a majority
    of surveyed users viewing passkeys as more secure and more convenient.

    Why it matters:
    - users became more accustomed to device-rooted credentials
    - strong auth shifted closer to the device, closer to local vault models
    - passwordless UX reduced friction for portable identity systems

    ## 2020–2024: Threshold signing matures

    FROST was published as RFC 9591 in 2024, giving threshold Schnorr signatures a stable,
    public protocol spec. This matters for threshold wallets, quorum approvals, delegated
    agents, and enterprise signing flows.

    Why it matters:
    - threshold security became easier to productize
    - quorum-based actions became more realistic in normal software
    - decentralized custody moved closer to mainstream application use

    ## 2024: Post-quantum cryptography crosses into standards

    NIST finalized FIPS 203 (ML-KEM) and FIPS 204 (ML-DSA) in 2024.
    This was a major transition point: PQ-safe key establishment and signatures stopped
    being “future research” and became standards that architects can reasonably target.

    Why it matters:
    - long-lived audit trails and key hierarchies can now be designed for quantum resilience
    - DEK wrapping, recovery, and inter-device key exchange can move to PQ-safe foundations
    - protocol and procurement language can stabilize around FIPS standards

    ## 2024–2026: FHE becomes selective developer infrastructure

    FHE is still not the default primitive for all app workloads, but it is much more usable
    than it was in 2018. Libraries like TFHE-rs, GPU acceleration work, and threshold-FHE
    research/software have made encrypted computation and threshold reveal more actionable.

    The key shift is not “FHE everywhere.” It is:
    - FHE for selective private computation
    - threshold FHE for conditional reveal
    - ordinary symmetric crypto for the default hot path

    ## 2023–2026: Appchains and modularity normalize specialized chains

    The industry increasingly accepted that execution, settlement, and application logic
    do not all need to share one monolithic chain. App-specific chains, L1 specialization,
    rollups, and modular architectures all reinforced the idea that a key-management chain,
    identity chain, or threshold-compute chain can be first-class rather than awkward exceptions.

    Why it matters:
    - chain specialization became strategically normal
    - trust plane services can be separated cleanly from app data plane services
    - private app architectures can use chains for policy and receipts without putting every row on-chain

    ## 2025–2026: Local-first performance and ergonomics improve

    Automerge 3.0 materially improved memory usage and performance, making CRDT-backed
    local-first apps easier to justify operationally. This is not the end-state, but it is
    a signal that the tooling layer is moving from research prototype toward production usability.

    ## What the trendline says

    The strongest architecture now is:

    - local encrypted app state
    - CRDT sync and snapshots
    - DID/VC identity and capabilities
    - passkey-style device-rooted auth
    - PQ-safe key wrapping and signatures
    - threshold signing and threshold reveal
    - selective FHE/CKKS where the workload justifies it
    - app-specific chains or L1s for trust, policy, and receipts

    ## Bottom line

    Since 2018, the center of gravity moved:
    - away from SaaS lock-in
    - away from naive global-chain apps
    - toward local-first, cryptographically portable, provider-replaceable software

    That is the opening for Web5-style private apps.

    ## Source notes

Primary and standards-oriented sources used throughout these documents:

- Kleppmann et al., *Local-First Software: You Own Your Data, in spite of the Cloud* (2019) — https://martin.kleppmann.com/papers/local-first.pdf
- W3C DID Core 1.0 Recommendation — https://www.w3.org/TR/did-1.0/
- W3C Verifiable Credentials Data Model 2.0 — https://www.w3.org/TR/vc-data-model-2.0/
- NIST FIPS 203 (ML-KEM) — https://csrc.nist.gov/pubs/fips/203/final
- NIST FIPS 204 (ML-DSA) — https://csrc.nist.gov/pubs/fips/204/final
- RFC 9591 FROST — https://www.rfc-editor.org/rfc/rfc9591.pdf
- Zama TFHE-rs docs — https://docs.zama.org/tfhe-rs
- Zama threshold-fhe repository — https://github.com/zama-ai/threshold-fhe
- SQLite one-file database — https://sqlite.org/onefile.html
- SQLite appropriate uses — https://sqlite.org/whentouse.html
- Filecoin/IPFS docs — https://docs.filecoin.io/basics/how-storage-works/filecoin-and-ipfs and https://docs.ipfs.tech/concepts/faq/
- Automerge 3.0 announcement — https://automerge.org/blog/automerge-3/
- Avalanche L1 docs — https://build.avax.network/docs/avalanche-l1s
- FIDO Alliance passkeys pages / adoption research — https://fidoalliance.org/passkeys/ and https://fidoalliance.org/passkey-adoption-doubles-in-2024-more-than-15-billion-online-accounts-can-leverage-passkeys/
