#!/usr/bin/env python3
import json
import logging
import sys

import pywikibot as pw


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


def print_unvisited(final_database):
    import collections

    unvisited_links = list()
    for v in final_database.values():
        unvisited_links.extend(v["forward"])
        unvisited_links.extend(v["backward"])

    unvisited_links = collections.Counter(
        [x for x in unvisited_links if x not in final_database.keys()]
    )
    
    for x in unvisited_links.most_common(10):
        print(f"Visit {x[1]}x {x[0]}")


def add_missing_links(article, article_title):
    forward = article.get("forward", [])
    backward = article.get("backward", [])
    if forward and backward:
        return article
    
    if article.get("dead"):
        article["forward"] = list()
        article["backward"] = list()
        return article

    page = pw.Page(SITE, article_title)
    if not page.text:
        raise Exception(f"Page {article_title} does not exist at English Wikipedia!")

    logging.info("Fixing forward/backward links in %s", article_title)
    if not forward:
        article["forward"] = get_links(page.linkedPages())
    if not backward:
        article["backward"] = get_links(page.backlinks())
    return article


logging.basicConfig(encoding="utf-8", level=logging.INFO)

SITE = pw.Site("en", "wikipedia")

with open(sys.argv[1]) as f:
    database = {k: add_missing_links(v, k) for k, v in json.load(f).items()}

with open(sys.argv[1], "w") as f:
    database = {
        k: {
            "dead": v.get("dead", False),
            "forward": clean_links(v["forward"]),
            "backward": clean_links(v["backward"]),
        }
        for k, v in database.items()
    }
    database = dict(sorted(database.items()))
    f.write(json.dumps(database, indent=2))

print_unvisited(database)
