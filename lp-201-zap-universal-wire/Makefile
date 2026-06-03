# LP-201 — ZAP as Universal Wire
# Build with `make` (uses tectonic; fall back to `make pdflatex`).

PAPER := paper
TEX_INPUTS := .:..:../shared:

.PHONY: all clean check pdflatex

# tectonic is the canonical builder (hermetic, cross-platform)
all: $(PAPER).pdf

$(PAPER).pdf: $(PAPER).tex \
              sections/inventory.tex \
              sections/proposal.tex \
              sections/bench.tex \
              sections/risks.tex \
              references.bib
	@TEXINPUTS=$(TEX_INPUTS) tectonic --keep-intermediates $(PAPER).tex
	@[ -f $(PAPER).pdf ] && echo "OK $(PAPER).pdf" || (echo "FAIL — see $(PAPER).log" && exit 1)

# Fallback: pdflatex if tectonic isn't installed
pdflatex: $(PAPER).tex
	@TEXINPUTS=$(TEX_INPUTS) pdflatex -interaction=nonstopmode $(PAPER).tex > /dev/null 2>&1 || true
	@TEXINPUTS=$(TEX_INPUTS) bibtex $(PAPER) > /dev/null 2>&1 || true
	@TEXINPUTS=$(TEX_INPUTS) pdflatex -interaction=nonstopmode $(PAPER).tex > /dev/null 2>&1 || true
	@TEXINPUTS=$(TEX_INPUTS) pdflatex -interaction=nonstopmode $(PAPER).tex > /dev/null 2>&1 || true
	@[ -f $(PAPER).pdf ] && echo "OK $(PAPER).pdf" || (echo "FAIL — see $(PAPER).log" && exit 1)

# Quick syntactic sanity check
check:
	@for f in $(PAPER).tex sections/inventory.tex sections/proposal.tex \
	          sections/bench.tex sections/risks.tex \
	          references.bib wire-inventory.csv; do \
		[ -f "$$f" ] && echo "OK  $$f" || echo "MISSING $$f"; \
	done

clean:
	@rm -f $(PAPER).aux $(PAPER).log $(PAPER).out $(PAPER).toc \
	       $(PAPER).bbl $(PAPER).blg $(PAPER).pdf
