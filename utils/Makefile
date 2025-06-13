all: venv

venv:
	if ! [ -d venv ]; then python3 -m venv venv; . venv/bin/activate; pip install pywikibot flask; fi;

crawl:
	. venv/bin/activate && python3 crawl-wiki.py wiki-geometry.json
	. venv/bin/activate && python3 count_words.py