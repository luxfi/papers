# Lux FHE Research Papers

14 research papers demonstrating practical applications of Fully Homomorphic Encryption.

## Building PDFs

Requires [Tectonic](https://tectonic-typesetting.github.io/) or pdflatex.

```bash
# Build all papers
make all

# Build individual paper
make fhevm
make fhecrdt
make voting
make ml-privacy

# Package all PDFs
make package
```

## Papers

### Flagship Papers (Full LaTeX)

| Paper | Pages | Description |
|-------|-------|-------------|
| **fhEVM** | ~10 | Fully Homomorphic Ethereum Virtual Machine |
| **fheCRDT** | ~10 | CRDTs over Encrypted State |
| **Voting** | ~10 | Verifiable Encrypted Voting |
| **ML Privacy** | ~12 | Privacy-Preserving ML at Scale |

### Mathematical Contributions

**fhEVM:**
- FHE precompile gas cost model
- Threshold decryption protocol
- Ciphertext indistinguishability proofs

**fheCRDT:**
- Lattice preservation theorem for encrypted merge
- Encrypted convergence guarantees
- Delta-state compression for FHE

**Voting:**
- Deniable encryption construction for coercion resistance
- Batch verification security proof
- On-chain tally soundness theorem

**ML Privacy:**
- FHE-friendly activation approximations
- Quantization-aware training convergence
- Secure aggregation protocol

## Shared Components

- `shared/luxfhe.cls` - LaTeX document class
- `shared/fhe-macros.tex` - Common notation (400+ macros)
- `shared/references.bib` - Bibliography

## Reusable Macros

```latex
% Cryptographic
\Enc, \Dec, \KeyGen, \pk, \sk

% FHE Operations  
\FHEadd, \FHEsub, \FHEmul, \FHElt, \FHEgt, \FHEeq, \FHEselect

% Encrypted Types
\euint{8}, \euint{32}, \ebool, \eaddr

% CRDT
\join, \meet, \merge, \encmerge, \state, \encstate

% Voting
\vote, \encvote, \tally, \enctally, \Voter, \Coercer

% ML
\weights, \bias, \activation, \loss, \gradient, \quant
```

## Citation

```bibtex
@misc{luxfhe2025,
  title={Lux FHE: Practical Fully Homomorphic Encryption for Blockchain and ML},
  author={Lux Partners},
  year={2025},
  url={https://github.com/luxfi/fhe}
}
```

## License

Apache 2.0
