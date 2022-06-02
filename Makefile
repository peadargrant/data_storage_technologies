BASENOTES=dst

all: dst_notes.pdf index.html

dst_notes.tex: ./gen_notes.pl $(wildcard */*_chapter.tex)
	./gen_notes.pl

dst_notes.pdf: dst_notes.tex
	latexmk -g $(patsubst %.pdf,%,$@)

index.html: dst_notes.tex
	make4ht -c webnotes -j $(patsubst %.html,%,$@) -f xhtml -s $(patsubst %.tex,%,$<) "2"

