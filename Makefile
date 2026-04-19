TEX_DIRS := $(shell find . -mindepth 2 -name '*.tex' -not -path './shared/*' -not -path './pdfs/*' -not -path './.github/*' | xargs -I{} dirname {} | sort -u)

.PHONY: all clean

all:
	@for d in $(TEX_DIRS); do \
		texfile=$$(ls "$$d"/*.tex 2>/dev/null | head -1); \
		[ -z "$$texfile" ] && continue; \
		base=$$(basename "$${texfile%.tex}"); \
		echo "Compiling $$d/$$base.tex ..."; \
		(cd "$$d" && TEXINPUTS=".:..:" pdflatex -interaction=nonstopmode "$$base.tex" > /dev/null 2>&1 || true \
			&& bibtex "$$base" > /dev/null 2>&1 || true \
			&& TEXINPUTS=".:..:" pdflatex -interaction=nonstopmode "$$base.tex" > /dev/null 2>&1 || true \
			&& TEXINPUTS=".:..:" pdflatex -interaction=nonstopmode "$$base.tex" > /dev/null 2>&1 || true); \
		[ -f "$$d/$$base.pdf" ] && echo "  OK $$base.pdf" || echo "  FAIL $$base.pdf"; \
	done
	@echo "Done"

clean:
	@find . -type f \( -name '*.aux' -o -name '*.log' -o -name '*.out' \
		-o -name '*.fls' -o -name '*.fdb_latexmk' -o -name '*.toc' \
		-o -name '*.bbl' -o -name '*.blg' -o -name '*.lof' -o -name '*.lot' \
		-o -name '*.xdv' -o -name '*.synctex.gz' \) -delete 2>/dev/null || true
	@echo "Cleaned"
