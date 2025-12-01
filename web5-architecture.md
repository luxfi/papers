    # Private Apps on Web5
    ## White paper

    ## Abstract

    This paper argues that private apps should be built from encrypted local vaults,
    not global on-chain state. Blockchains should act as a trust kernel for identity,
    key policy, audit receipts, provider registration, and settlement. The result is
    a local-first, private, horizontally scalable app architecture.

    ## 1. Problem statement

    Centralized SaaS backends create three persistent failures:
    - a single provider owns the source of truth
    - user export and recovery are secondary features
    - privacy collapses at the cloud boundary

    Traditional public blockchains solve only part of this problem.
    They improve verifiability and portability, but global on-chain state is often
    too public, too expensive, and too rigid for ordinary app data.

    ## 2. The Web5 stack

    ### Local vault
    The primary state lives in an encrypted vault:
    - one vault per user, org, workspace, document set, or agent
    - SQLite as the durable local file format
    - CRDT oplog for merge and offline collaboration

    ### Trust kernel
    The chain stores:
    - identity roots
    - device registrations
    - key handles and wrapping policy
    - capability grants and revocations
    - checkpoint anchors
    - provider records
    - payment and governance state

    ### Provider market
    Operators can provide:
    - sync relays
    - blob storage
    - indexers
    - gateways
    - threshold signing
    - threshold reveal
    - confidential compute

    ## 3. Cryptographic layering

    The default path should be lean:
    - AES-256-GCM for payload encryption
    - ML-KEM for PQ-safe wrapping / shared-secret establishment
    - ML-DSA for PQ signatures where long-lived integrity matters

    Threshold and confidential features should be opt-in:
    - FROST for threshold Schnorr signatures
    - TFHE for threshold reveal or exact encrypted logic
    - CKKS for approximate encrypted analytics / inference

    ## 4. Why SQLite + CRDT is the right substrate

    SQLite works well as an application file format and a local embedded database.
    CRDTs solve the merge problem when devices or collaborators edit concurrently.
    Used together, they support local speed, offline behavior, and eventual merge
    without treating the server as the exclusive owner of truth.

    ## 5. Architecture for Lux / Hanzo

    - Base Vault SDK becomes the data plane
    - Lux becomes the trust kernel
    - providers become a replaceable utility market
    - apps become portable across cloud operators

    ## 6. Conclusion

    Private apps on Web5 are not apps fully on-chain.
    They are local-first apps with shared cryptographic trust.
    That is the clearest path to private, portable, decentralized cloud software.

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
