#!/usr/bin/env python3
from flask import Flask, render_template, redirect, url_for, request
from flask import Flask, render_template, redirect

import json
import subprocess
from collections import defaultdict
import os

app = Flask(__name__)
DATA_FILE = 'wiki-geometry.json'

def load_data():
    with open(DATA_FILE) as f:
        d = json.load(f)

    for k, v in d.items():
        if not v:
            d[k] = {"dead": False, "forward": [], "backward": []}
    return d

def save_data(data):
    with open(DATA_FILE, 'w') as f:
        json.dump(data, f, indent=2, ensure_ascii=False)

import math
import scipy.stats as stats

def ci_lower_bound(pos, n, confidence):
    if n == 0:
        return 0
    z = stats.norm.ppf(1 - (1 - confidence) / 2)
    phat = pos / n
    return (phat + z*z/(2*n) - z * math.sqrt((phat*(1 - phat) + z*z/(4*n)) / n)) / (1 + z*z/n)

def compute_scores(data):
    from collections import defaultdict
    import json

    already_seen = [title.lower() for title in data.keys()]

    nice_neighbours = defaultdict(int)
    bad_neighbours = defaultdict(int)
    
    # Count occurrences and gather neighbors for each linked page
    for page, entry in data.items():
        multis = {"forward": 2, "backward": 1}
        for kmulti, vmulti in multis.items():
            for linked in entry.get(kmulti, []):
                if not entry["dead"]:
                    nice_neighbours[linked] += vmulti
                else:
                    bad_neighbours[linked] += vmulti
        float_scores = {}
    
    keys = set(list(nice_neighbours.keys()) + list(nice_neighbours.keys()))
    keys = [key for key in keys if key not in already_seen and not data.get(key, {"dead": False})["dead"]]
    votes = {
        page: ci_lower_bound(nice_neighbours[page], nice_neighbours[page] + bad_neighbours[page], 0.95)
        for page in keys
    }

    return {
        "DUPA": sorted([(score, page) for page, score in votes.items()], reverse=True)
    }

    # Group pages by integer part of float score
    grouped = defaultdict(list)
    for page, score in float_scores.items():
        group_key = int(score)
        grouped[group_key].append((score, page))  # keep float score for sorting within group

    # Sort each group by float score descending
    sorted_grouped = {
        group: sorted(items, reverse=True)  # now items are (score, title)
        for group, items in grouped.items()
    }
    return sorted_grouped

@app.route("/")
def index():
    data = load_data()
    scores = compute_scores(data)
    from collections import OrderedDict
    sorted_scores = OrderedDict(
        sorted(scores.items(), key=lambda x: x[0], reverse=True)
    )
    return render_template("index.html", pages=sorted_scores)

@app.route('/extend/<title>')
def extend(title):
    data = load_data()
    if title not in data:
        data[title] = {"dead": False, "forward": [], "backward": []}
        save_data(data)
        subprocess.run(['make', 'crawl'])

    return redirect(url_for('index'))

@app.route('/mark_dead/<title>')
def mark_dead(title):
    data = load_data()
    if title not in data:
        data[title] = dict()
    data[title]['dead'] = True
    data[title]['forward'] = []
    data[title]['backward'] = []
    save_data(data)
    return redirect(url_for('index'))

if __name__ == '__main__':
    app.run(debug=True, port=5001)
