# Makefile for Lux FHE Papers
# Build FHE research papers using tectonic

LATEX = tectonic
PAPERS = fhevm fhecrdt voting ml-privacy

.PHONY: all clean $(PAPERS)

all: $(PAPERS)
	@echo "All FHE papers compiled successfully"

fhevm:
	@echo "Compiling fhEVM paper..."
	@mkdir -p build
	@cd fhevm && $(LATEX) main.tex --outdir=../build
	@mv build/main.pdf ../pdfs/luxfhe-fhevm.pdf
	@echo "Generated pdfs/luxfhe-fhevm.pdf"

fhecrdt:
	@echo "Compiling fheCRDT paper..."
	@mkdir -p build
	@cd fhecrdt && $(LATEX) main.tex --outdir=../build
	@mv build/main.pdf ../pdfs/luxfhe-fhecrdt.pdf
	@echo "Generated pdfs/luxfhe-fhecrdt.pdf"

voting:
	@echo "Compiling Voting paper..."
	@mkdir -p build
	@cd voting && $(LATEX) main.tex --outdir=../build
	@mv build/main.pdf ../pdfs/luxfhe-voting.pdf
	@echo "Generated pdfs/luxfhe-voting.pdf"

ml-privacy:
	@echo "Compiling ML Privacy paper..."
	@mkdir -p build
	@cd ml-privacy && $(LATEX) main.tex --outdir=../build
	@mv build/main.pdf ../pdfs/luxfhe-ml-privacy.pdf
	@echo "Generated pdfs/luxfhe-ml-privacy.pdf"

clean:
	@rm -rf build
	@rm -f ../pdfs/luxfhe-*.pdf
	@echo "Cleaned FHE PDFs"
