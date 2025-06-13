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
        return json.load(f)

def save_data(data):
    with open(DATA_FILE, 'w') as f:
        json.dump(data, f, indent=2)

def compute_scores(data):
    from collections import defaultdict
    import json

    # Load word-counts
    try:
        with open("word-count.json") as f:
            word_counts = json.load(f)
            max_count = max(word_counts.values())
    except FileNotFoundError:
        word_counts = {}

    # Lowercased pages that are already explored
    seen_lower = {
        title.lower() for title, entry in data.items()
        if entry['dead'] or entry['forward'] or entry['backward']
    }

    link_counts = defaultdict(int)
    neighbors = defaultdict(list)

    # Count occurrences and gather neighbors for each linked page
    for page, entry in data.items():
        for neighbor in entry.get('forward', []) + entry.get('backward', []):
            link_counts[neighbor] += 1
            neighbors[neighbor].append(page)

    # Compute enhanced scores
    enhanced_scores = {}
    max_weight = 0

    float_scores = {}
    for page, count in link_counts.items():
        if page.lower() in seen_lower:
            continue

        weights = {nghbr: word_counts.get(nghbr, 0) for nghbr in set(neighbors[page])}
        float_scores[page] = count + sum(weights.values(), 0) / float(max_count)

        # print(f"DEBUG: Calculating score for '{page}'")
        # print(f"  Occurrences (count): {count}")
        # print(f"  Word counts of neighbors: {weights=}")
        # print(f"  Weight (sum of words):  {enhanced_scores[page]=}=")

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
