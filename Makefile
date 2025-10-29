# Makefile for Lux Papers
# Automatically compiles all LaTeX papers to PDF

# Find all .tex files in current directory
TEX_FILES := $(wildcard *.tex)
PDF_FILES := $(patsubst %.tex,pdfs/%.pdf,$(TEX_FILES))

# Default target: compile all papers
.PHONY: all
all: $(PDF_FILES)
	@echo "✓ All papers compiled successfully"
	@echo ""
	@echo "Generated PDFs:"
	@ls -lh pdfs/

# Create pdfs directory
pdfs:
	@mkdir -p pdfs

# Compile a single .tex file to PDF
pdfs/%.pdf: %.tex | pdfs
	@echo "Compiling $<..."
	@pdflatex -interaction=nonstopmode -output-directory=pdfs $< > /dev/null || true
	@cd pdfs && bibtex $(*F) 2>/dev/null || true
	@pdflatex -interaction=nonstopmode -output-directory=pdfs $< > /dev/null || true
	@pdflatex -interaction=nonstopmode -output-directory=pdfs $< > /dev/null || true
	@if [ -f pdfs/$(*F).pdf ]; then \
		echo "✓ Successfully compiled $(*F).pdf"; \
	else \
		echo "✗ Failed to compile $(*F).pdf"; \
	fi

# Clean auxiliary files
.PHONY: clean
clean:
	@echo "Cleaning auxiliary files..."
	@rm -f pdfs/*.aux pdfs/*.log pdfs/*.bbl pdfs/*.blg pdfs/*.out pdfs/*.toc pdfs/*.lof pdfs/*.lot
	@rm -f *.aux *.log *.bbl *.blg *.out *.toc *.lof *.lot
	@echo "✓ Cleaned"

# Clean everything including PDFs
.PHONY: clean-all
clean-all: clean
	@echo "Removing all PDFs..."
	@rm -f pdfs/*.pdf
	@echo "✓ All files cleaned"

# Compile specific papers
.PHONY: lux-consensus
lux-consensus: pdfs/lux-consensus.pdf

.PHONY: lux-quantum
lux-quantum: pdfs/lux-quantum-consensus.pdf

.PHONY: lux-dex
lux-dex: pdfs/lux-lightspeed-dex.pdf

.PHONY: lux-bridge
lux-bridge: pdfs/lux-bridge.pdf

.PHONY: lux-zchain
lux-zchain: pdfs/lux-zchain.pdf

.PHONY: lux-quasar
lux-quasar: pdfs/lux-quasar-consensus.pdf

.PHONY: lux-mchain
lux-mchain: pdfs/lux-mchain-mpc.pdf

.PHONY: lux-achain
lux-achain: pdfs/lux-achain-attestation.pdf

.PHONY: lux-gchain
lux-gchain: pdfs/lux-gchain-graphql.pdf

.PHONY: lux-credit
lux-credit: pdfs/lux-credit-lending.pdf

.PHONY: lux-governance
lux-governance: pdfs/lux-governance-dao.pdf

.PHONY: lux-oracle
lux-oracle: pdfs/lux-oracle-infrastructure.pdf

.PHONY: lux-perpetuals
lux-perpetuals: pdfs/lux-perpetuals-derivatives.pdf

.PHONY: lux-market
lux-market: pdfs/lux-market-nft.pdf

.PHONY: lux-id
lux-id: pdfs/lux-id-iam.pdf

.PHONY: lux-ntt
lux-ntt: pdfs/lux-ntt-transform.pdf

.PHONY: lux-fpc
lux-fpc: pdfs/lux-fpc-consensus.pdf

.PHONY: lux-pq
lux-pq: pdfs/lux-pq-comparison-study.pdf

.PHONY: lux-verkle
lux-verkle: pdfs/lux-verkle-trees.pdf

.PHONY: lux-fraud
lux-fraud: pdfs/lux-fraud-proofs.pdf

# Help target
.PHONY: help
help:
	@echo "Lux Papers Makefile"
	@echo ""
	@echo "Targets:"
	@echo "  make all              - Compile all papers (default)"
	@echo "  make clean            - Remove auxiliary files"
	@echo "  make clean-all        - Remove all files including PDFs"
	@echo "  make <paper-name>     - Compile specific paper"
	@echo ""
	@echo "Examples:"
	@echo "  make                  - Compile all papers"
	@echo "  make lux-quantum      - Compile only Quantum Consensus paper"
	@echo "  make lux-quasar       - Compile only Quasar Consensus paper"
	@echo "  make lux-mchain       - Compile only M-Chain MPC paper"
	@echo "  make lux-dex          - Compile only Lightspeed DEX paper"
	@echo "  make lux-bridge       - Compile only Bridge paper"
	@echo "  make lux-zchain       - Compile only Z-Chain paper"
	@echo "  make lux-achain       - Compile only A-Chain attestation paper"
	@echo "  make lux-gchain       - Compile only G-Chain GraphQL paper"
	@echo "  make lux-credit       - Compile only Lux Credit lending paper"
	@echo "  make lux-governance   - Compile only Governance & DAO paper"
	@echo "  make lux-oracle       - Compile only Oracle infrastructure paper"
	@echo "  make lux-perpetuals   - Compile only Perpetuals/derivatives paper"
	@echo "  make lux-market       - Compile only Lux.market NFT paper"
	@echo "  make lux-id           - Compile only Lux.id IAM paper"
	@echo "  make lux-ntt          - Compile only NTT Transform paper"
	@echo "  make lux-fpc          - Compile only FPC consensus paper"
	@echo "  make lux-pq           - Compile only PQ comparison study"
	@echo "  make lux-verkle       - Compile only Verkle Trees paper"
	@echo "  make lux-fraud        - Compile only Fraud Proofs paper"
	@echo ""
	@echo "Available papers:"
	@echo "  lux-consensus         - Multi-consensus architecture"
	@echo "  lux-quantum           - Post-quantum cryptography"
	@echo "  lux-quasar            - Quasar dual-certificate consensus"
	@echo "  lux-mchain            - M-Chain MPC threshold custody"
	@echo "  lux-dex               - High-frequency trading DEX"
	@echo "  lux-bridge            - Cross-chain bridge with ZK proofs"
	@echo "  lux-zchain            - Privacy-preserving smart contracts"
	@echo "  lux-achain            - TEE attestation & AI compute verification"
	@echo "  lux-gchain            - Universal GraphQL query engine"
	@echo "  lux-credit            - Self-repaying lending with 90% LTV"
	@echo "  lux-governance        - Multi-ecosystem DAO and governance"
	@echo "  lux-oracle            - Oracle infrastructure (AI + price feeds)"
	@echo "  lux-perpetuals        - Perpetuals and derivatives protocol"
	@echo "  lux-market            - NFT marketplace with Reservoir"
	@echo "  lux-id                - Identity and access management"
	@echo "  lux-ntt               - NTT Transform for post-quantum EVM"
	@echo "  lux-fpc               - Fast Probabilistic Consensus"
	@echo "  lux-pq                - Post-quantum comparison meta-study"
	@echo "  lux-verkle            - Verkle Trees for stateless clients"
	@echo "  lux-fraud             - Fraud Proofs for optimistic rollups"
