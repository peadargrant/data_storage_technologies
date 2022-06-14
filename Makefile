# Makefile for Data Storage Technologies
# Peadar Grant

all: dst_notes.pdf dst_web.html

%.pdf: %.svg
	rsvg-convert -f pdf $< > $@

%.pdf: %.gif
	convert $< $@

%.pdf: %.gv
	dot -Tpdf -o $@ $<

%.svg: %.gv
	dot -Tsvg -o $@ $<

dst_notes.tex: ./gen_notes.pl $(wildcard */*_chapter.tex)
	./gen_notes.pl

dst_notes.pdf: dst_notes.tex $(patsubst %.svg,%.pdf,$(wildcard */*.svg)) $(patsubst %.gif,%.pdf,$(wildcard */*.gif)) $(patsubst %.gv,%.pdf,$(wildcard */*.gv))
	latexmk -g $(patsubst %.pdf,%,$@)

dst_web.html: dst_notes.tex Makefile $(patsubst %.gv,%.svg,$(wildcard */*.gv))
	make4ht -a info -s -c webnotes -j $(patsubst %.html,%,$@) -f xhtml -s $(patsubst %.tex,%,$<) "2"

