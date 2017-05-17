CSS = book.css
HTML_TEMPLATE = template.html
TEX_HEADER = header.tex
CHAPTERS = title.txt 1.introduction.md 2.environment_and_booting.md \
		   3.getting_to_c.md 4.output.md 5.segmentation.md 6.interrupts.md \
		   7.the_road_to_user_mode.md 8.virtual_memory.md \
		   9.paging.md 10.page_frame_allocation.md 11.user_mode.md 12.file_systems.md \
		   14.syscalls.md 14.scheduling.md \
		   references.md
BIB = bibliography.bib
CITATION = citation_style.csl

all: book.html

book.html: $(CHAPTERS) $(CSS) $(HTML_TEMPLATE) $(BIB) $(CITATION)
	pandoc -s -S --toc -c $(CSS) --template $(HTML_TEMPLATE) \
		   --bibliography $(BIB) --csl $(CITATION) --number-sections \
		   $(CHAPTERS) -o $@

book.pdf: $(CHAPTERS) $(TEX_HEADER) $(BIB) $(CITATION)
	pandoc --toc -H $(TEX_HEADER) --latex-engine=pdflatex --chapters \
		   --no-highlight --bibliography $(BIB) --csl $(CITATION) \
		   $(CHAPTERS) -o $@

ff: book.html
	firefox book.html

release: book.html book.pdf
	mkdir -p ../littleosbook.github.com/images
	cp images/*.png ../littleosbook.github.com/images/
	mkdir -p ../littleosbook.github.com/files
	cp files/* ../littleosbook.github.com/files/
	cp book.pdf ../littleosbook.github.com/
	cp book.html ../littleosbook.github.com/index.html
	cp book.css ../littleosbook.github.com/

clean:
	rm -f book.pdf book.html
