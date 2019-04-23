document = thesis.tex

build:
	latex "$(document)"
	bibtex "${basename $(document)}.aux"
	latex "$(document)"
	pdflatex "$(document)"

check:
	@echo "The following items may contain weak word usage. ---------------------"
	@sh bin/weasels.sh *.tex 1>&2
	@echo "The following items may contain passive language. --------------------"
	@sh bin/passive.sh *.tex 1>&2
	@echo "The following items may contain unnecessary duplication. -------------"
	@perl bin/dups *.tex 2>&2
	@echo "Checking spelling. ---------------------------------------------------"
	@ispell *.tex
	@echo "Checking diction. ----------------------------------------------------"
	@sh bin/diction.sh *.tex 1>&2

test:
	$(MAKE) build
	bin/focus &> /dev/null

open:
	open "${basename $(document)}.pdf"

clean:
	rm -f *.out *.pdf *.aux *.dvi *.log *.blg *.bbl *.tex-e *.toc
