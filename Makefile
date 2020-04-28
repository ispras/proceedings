# Latex Makefile using latexmk
# Modified by Dogukan Cagatay <dcagatay@gmail.com>
# Originally from : http://tex.stackexchange.com/a/40759
#
# Change only the variable below to the name of the main tex file.
PROJNAME=main

# You want latexmk to *always* run, because make does not have all the info.
# Also, include non-file targets in .PHONY so they are run regardless of any
# file of the given name existing.
.PHONY: $(PROJNAME).pdf all clean

# The first rule in a Makefile is the one executed by default ("make"). It
# should always be the "all" rule, so that "make" and "make all" are identical.
all: $(PROJNAME)_2.pdf

# CUSTOM BUILD RULES

# In case you didn't know, '$@' is a variable holding the name of the target,
# and '$<' is a variable holding the (first) dependency of a rule.
# "raw2tex" and "dat2tex" are just placeholders for whatever custom steps
# you might have.

%.tex: %.raw
	./raw2tex $< > $@

%.tex: %.dat
	./dat2tex $< > $@

# MAIN LATEXMK RULE

# -pdf tells latexmk to generate PDF directly (instead of DVI).
# -pdflatex="" tells latexmk to call a specific backend with specific options.
# -use-make tells latexmk to call make for generating missing files.

# -interactive=nonstopmode keeps the pdflatex backend from stopping at a
# missing file reference and interactively asking you for an alternative.

$(PROJNAME).pax: $(PROJNAME).pdf
	pdfannotextractor $<

$(PROJNAME)_2.pdf: $(PROJNAME).pdf $(PROJNAME).pax $(PROJNAME)_2.tex
	latexmk -pdf $(PROJNAME)_2.tex

$(PROJNAME).pdf: $(PROJNAME).tex
	latexmk -pdf -xelatex -pdflatex="xelatex -interactive=nonstopmode" -use-make $<

cleanall:
	latexmk -C
	rm -f $(PROJNAME).bbl
	rm -f *.synctex.gz
	rm -f *.run.xml
	rm -f *.pax
	rm -f $(PROJNAME).pdf
	rm -f $(PROJNAME)_2.pdf

clean:
	latexmk -c
	rm -f $(PROJNAME).bbl
	rm -f *.synctex.gz
	rm -f *.run.xml
	rm -f *.pax
