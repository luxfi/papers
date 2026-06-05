# LP-200 — Lux vs Avalanche quantitative audit
# Build with `make` (uses pdflatex; tectonic also works via `make tectonic`).

PAPER := paper
TEX_INPUTS := .:..:../shared:

.PHONY: all clean check pdflatex

# tectonic is the canonical builder (cross-platform, hermetic)
all: $(PAPER).pdf

$(PAPER).pdf: $(PAPER).tex translation.tex bench-table.tex references.bib
	@TEXINPUTS=$(TEX_INPUTS) tectonic --keep-intermediates $(PAPER).tex
	@[ -f $(PAPER).pdf ] && echo "OK $(PAPER).pdf" || (echo "FAIL — see $(PAPER).log" && exit 1)

# Fallback: pdflatex if tectonic isn't installed
pdflatex: $(PAPER).tex translation.tex bench-table.tex
	@TEXINPUTS=$(TEX_INPUTS) pdflatex -interaction=nonstopmode $(PAPER).tex > /dev/null 2>&1 || true
	@TEXINPUTS=$(TEX_INPUTS) bibtex $(PAPER) > /dev/null 2>&1 || true
	@TEXINPUTS=$(TEX_INPUTS) pdflatex -interaction=nonstopmode $(PAPER).tex > /dev/null 2>&1 || true
	@TEXINPUTS=$(TEX_INPUTS) pdflatex -interaction=nonstopmode $(PAPER).tex > /dev/null 2>&1 || true
	@[ -f $(PAPER).pdf ] && echo "OK $(PAPER).pdf" || (echo "FAIL — see $(PAPER).log" && exit 1)

# Quick syntactic sanity check: confirm .tex inputs are present.
check:
	@for f in $(PAPER).tex translation.tex bench-table.tex inventory.csv; do \
		[ -f "$$f" ] && echo "OK  $$f" || echo "MISSING $$f"; \
	done

clean:
	@rm -f $(PAPER).aux $(PAPER).log $(PAPER).out $(PAPER).toc \
		$(PAPER).bbl $(PAPER).blg $(PAPER).fls $(PAPER).fdb_latexmk \
		$(PAPER).synctex.gz
	@echo "Cleaned"

distclean: clean
	@rm -f $(PAPER).pdf
