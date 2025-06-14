#!/usr/bin/env python3
import json
import os
import pywikibot

WIKI_PAGES_FILE = "wiki-geometry.json"
WORD_COUNT_FILE = "word-count.json"

def load_json(file_path):
    if os.path.exists(file_path):
        with open(file_path) as f:
            return json.load(f)
    return {}

def save_json(data, file_path):
    with open(file_path, "w") as f:
        json.dump(dict(sorted(list(data.items()))), f, indent=2, ensure_ascii=False)

def main():
    site = pywikibot.Site("en", "wikipedia")
    wiki_pages = load_json(WIKI_PAGES_FILE)
    word_counts = load_json(WORD_COUNT_FILE)

    seen = set(word_counts.keys())

    # Gather all linked pages
    linked_pages = set()
    for k, entry in wiki_pages.items():
        linked_pages.update(entry.get("forward", []))
        linked_pages.update(entry.get("backward", []))
        linked_pages.add(k)

    to_fetch = sorted([title for title in linked_pages if title not in seen])
    total = len(to_fetch)

    for idx, title in enumerate(to_fetch, 1):
        try:
            page = pywikibot.Page(site, title)
            text = page.text
            count = len(text.split())
            word_counts[title] = count
            print(f"[{idx}/{total}] {title} — {count} words ({(idx/total)*100:.1f}%)")
        except Exception as e:
            word_counts[title] = 0
            print(f"[{idx}/{total}] {title} — failed ({(idx/total)*100:.1f}%) — {e}")

    save_json(word_counts, WORD_COUNT_FILE)
    print("✅ Done. word-count.json updated.")

if __name__ == "__main__":
    main()
