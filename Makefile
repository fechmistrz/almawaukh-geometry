all: geometry.pdf

geometry.pdf: src/geo-textbook.pdf
	rsync src/geo-textbook.pdf geometry.pdf

src/geo-textbook.pdf: src/*.cls src/*.tex src/*/*.tex src/*/*/*.tex
	cd src && lualatex geo-textbook.tex && bibtex geo-textbook && lualatex geo-textbook.tex && lualatex geo-textbook.tex

edit-unedited:
	git ls-tree -r master --name-only | sort | grep src/ | grep 'tex$$' | while read -r line ; do echo $$line $$(git log --format=format:%aI -- $$line | cut -c 1-10 | sort -u | tail -n 5 | tr '\n' ',' | sed 's/,$$//'); done | python3 utils/pick_file.py