# Makefile for Lux FHE Papers
# Build FHE research papers using tectonic

LATEX = tectonic
BUILD_DIR = ../pdfs
PAPERS = fhevm fhecrdt voting ml-privacy

.PHONY: all clean $(PAPERS)

all: $(PAPERS)
	@echo "All FHE papers compiled successfully"

fhevm:
	@echo "Compiling fhEVM paper..."
	@cd fhevm && $(LATEX) main.tex --outdir=$(BUILD_DIR)
	@mv $(BUILD_DIR)/main.pdf $(BUILD_DIR)/luxfhe-fhevm.pdf
	@echo "Generated $(BUILD_DIR)/luxfhe-fhevm.pdf"

fhecrdt:
	@echo "Compiling fheCRDT paper..."
	@cd fhecrdt && $(LATEX) main.tex --outdir=$(BUILD_DIR)
	@mv $(BUILD_DIR)/main.pdf $(BUILD_DIR)/luxfhe-fhecrdt.pdf
	@echo "Generated $(BUILD_DIR)/luxfhe-fhecrdt.pdf"

voting:
	@echo "Compiling Voting paper..."
	@cd voting && $(LATEX) main.tex --outdir=$(BUILD_DIR)
	@mv $(BUILD_DIR)/main.pdf $(BUILD_DIR)/luxfhe-voting.pdf
	@echo "Generated $(BUILD_DIR)/luxfhe-voting.pdf"

ml-privacy:
	@echo "Compiling ML Privacy paper..."
	@cd ml-privacy && $(LATEX) main.tex --outdir=$(BUILD_DIR)
	@mv $(BUILD_DIR)/main.pdf $(BUILD_DIR)/luxfhe-ml-privacy.pdf
	@echo "Generated $(BUILD_DIR)/luxfhe-ml-privacy.pdf"

clean:
	@rm -f $(BUILD_DIR)/luxfhe-*.pdf
	@echo "Cleaned FHE PDFs"
