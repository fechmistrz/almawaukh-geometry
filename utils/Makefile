all: crawl

crawl: venv
	. venv/bin/activate && python3 crawl-wiki.py wiki-geometry.json

venv:
	if ! [ -d venv ]; then python3 -m venv venv; . venv/bin/activate; pip install pywikibot; fi; 