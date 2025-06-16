#!/usr/bin/env python3
# crawler.py
import json
from pathlib import Path

import json
import logging
import sys

import pywikibot as pw

SITE = pw.Site("en", "wikipedia")

DATA_FILE = Path("crawling.json")

def get_scores():
    data = _load()
    forward_backward = sum([
        v.get("forward", []) + v.get("backward") for k, v in data.items() if v.get("state") == "good"
    ], [])
    import collections
    forward_backward = list(collections.Counter(forward_backward).most_common())
    forward_backward = [item [0] for item, _ in collections.Counter(forward_backward).most_common()]

    logging.error(f"{forward_backward=} XX")
    return forward_backward

def _load():
    with DATA_FILE.open() as f:
        d = json.load(f)
    l1 = len(str(d))
    fixes = 0
    for k, v in d.items():
        d[k] = fix_missing_links(k, v)
        fixes += 1
        

    # d = {k: fix_missing_links(k, v) for k, v in d.items()}
    new_links = sum([v["forward"] + v["backward"] for k, v in d.items() if v["state"] == "good"], [])
    new_links = {link for link in new_links if link not in d}

    for link in new_links:
        logging.error(f"{link=}")
        d[link] = {"state": "unknown", "forward": [], "backward": []}

    l2 = len(str(d))
    if l1 != l2: 
        _save(d)
    return d

def scrap_if_needed(data, title):
    if data is None:
        data = pw.Page(SITE, title)
    return data

def fix_missing_links(title, details):
    scrapped_page = None
    
    if details.get("state", "unknown") == "unknown":
        if "cats" not in details:
            scrapped_page = scrap_if_needed(scrapped_page, title)
            logging.error(f"Looking for cats for {title=}")
            cats = sorted((str(i) for i in scrapped_page.categories()))
            details["cats"] = cats
        if "timestamp" not in details:
            scrapped_page = scrap_if_needed(scrapped_page, title)
            logging.error(f"Looking for tims for {title=}")
            details["timestamp"] = str(scrapped_page.latest_revision.timestamp)[:7]
        return details

    if details.get("state", "unknown") == "bad":
        forward = []
        backward = []
    else:
        forward = details.get("forward", [])
        backward = details.get("backward", [])

        scrapped_page = None
        if not forward:
            if scrapped_page is None:
                scrapped_page = pw.Page(SITE, title)
            forward = get_links(scrapped_page.linkedPages())
            
            
        if not backward:
            if scrapped_page is None:
                scrapped_page = pw.Page(SITE, title)
            backward = get_links(scrapped_page.backlinks())
    
    details["forward"] = forward
    details["backward"] = backward
    return details
      
        

def _save(data):
    with DATA_FILE.open("w") as f:
        json.dump(data, f, indent=2, ensure_ascii=False)

def get_url(page):
    return f"https://en.wikipedia.org/wiki/{page.replace(' ', '_')}"

def get_all_pages():
    return list(_load().keys())

def get_page_state(page):
    return _load().get(page, {}).get("state", "unknown")

def list_unvisited_pages():
    data = _load()
    return [p for p, v in data.items() if v.get("state", "unknown") == "unknown"]


def list_links_from(page):
    return _load().get(page, {}).get("forward", [])

def list_links_to(target_page):
    data = _load()
    return _load().get(target_page, {}).get("backward", [])

def clean_links(links, dead_ends=None):
    if dead_ends is None:
        dead_ends = []

    bad_words = [
        "Draft", "Glossary of engineering", "Help", "MOS", "Portal", "Talk",
        "Template talk", "Template", "User talk", "Wikipedia talk", "Wikipedia",
    ]

    return sorted(list(
        {
            link
            for link in links
            if all(f"{bad_word}:" not in link for bad_word in bad_words)
            and link not in dead_ends
        }
    ))

def get_links(links):
    return clean_links([
        link.title()
        for link in links
        if type(link) == pw.page._page.Page
    ])

def mark_page_if_unvisited(page):
    scrapped_page = pw.Page(SITE, page)
    if not scrapped_page.text:
        raise Exception(f"Page {page} does not exist at English Wikipedia!")
    forward = get_links(scrapped_page.linkedPages())
    backward = get_links(scrapped_page.backlinks())
    return {"state": "unknown", "forward": forward, "backward": backward}   

def list_good_pages():
    good_cats = [
        "[[en:Category:Euclidean geometry]]",
    ]
    data = _load()
    xx = get_scores()
    data = {k: v for k, v in data.items() if v.get("state", "unknown") == "unknown" and any(gc in v.get("cats", []) for gc in good_cats)}
    data = sorted([(xx.index(k), k, v) for k, v in data.items()])
    data = {k: v for _, k, v in data}
    pre_ret = list_into_timestamp_dict(data)
    return pre_ret

def list_into_timestamp_dict(what):
    timestamps = sorted([v.get("timestamp", None) for v in what.values()], reverse=True)
    logging.error(f"{timestamps=}")
    return {ts: ", ".join([f'<a href="{get_url(k)}">{k}</a> (<a href="/mark/{{ page }}?state=good">✅</a> <a href="/mark/{{ page }}?state=bad">❌</a>)' for k, v in what.items() if v.get("timestamp", None) == ts]) for ts in timestamps}

def list_cats(mode):
    catdata = {
        "bad": [
        "[[en:Category:Articles containing Greek-language text]]"
    ],
    "good": [],
    }
    
    data = _load()
    
    all_cats = sum([item.get("cats", []) for item in data.values() if item.get("state", "unknown") == mode], [])

    for k, v in catdata.items():
        if k != mode:
            all_cats = [i for i in all_cats if i not in v]

    import collections
    return collections.Counter(all_cats).most_common(10)

def mark_page(page, state="unknown"):
    data = _load()
    save = False
    if page not in data:
        scrapped_page = pw.Page(SITE, page)
        if not scrapped_page.text:
            raise Exception(f"Page {page} does not exist at English Wikipedia!")
        forward = get_links(scrapped_page.linkedPages())
        backward = get_links(scrapped_page.backlinks())
        data[page] = {"state": state, "forward": forward, "backward": backward}   
    else:
        data[page]["state"] = state
    
    
