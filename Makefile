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
	@echo "  make lux-dex          - Compile only Lightspeed DEX paper"
	@echo ""
	@echo "Available papers:"
	@echo "  lux-consensus         - Multi-consensus architecture"
	@echo "  lux-quantum           - Post-quantum cryptography"
	@echo "  lux-dex               - High-frequency trading DEX"
