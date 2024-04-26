all: geometry.pdf

geometry.pdf: src/geo-textbook.pdf
	rsync src/geo-textbook.pdf geometry.pdf

src/geo-textbook.pdf: src/*.cls src/*.tex src/*/*.tex
	cd src && lualatex geo-textbook.tex && lualatex geo-textbook.tex && lualatex geo-textbook.tex