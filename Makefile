all: geometria.pdf

geometria.pdf: src/geometria.pdf
	rsync src/geometria.pdf geometria.pdf

src/geometria.pdf: src/*.cls src/*.tex # src/*/*.tex
	cd src && pdflatex geometria.tex && bibtex geometria && pdflatex geometria.tex && pdflatex geometria.tex