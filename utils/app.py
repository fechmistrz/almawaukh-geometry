#!/usr/bin/env python3
from flask import Flask, render_template, redirect, url_for, request
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
    score_count = defaultdict(int)
    seen_lower = {
        title.lower() for title, entry in data.items()
        if entry['dead'] or entry['forward'] or entry['backward']
    }

    # Count all page mentions in forward/backward links
    for entry in data.values():
        for linked in entry.get('forward', []) + entry.get('backward', []):
            score_count[linked] += 1

    # Keep only unexplored pages
    grouped = defaultdict(list)
    for page, score in score_count.items():
        if page.lower() not in seen_lower:
            grouped[score].append(page)

    return dict(sorted(grouped.items(), key=lambda x: -x[0]))

@app.route('/')
def index():
    data = load_data()
    scored_pages = compute_scores(data)
    return render_template('index.html', pages=scored_pages)

@app.route('/extend/<title>')
def extend(title):
    data = load_data()
    if title not in data:
        data[title] = {"dead": False, "forward": [], "backward": []}
        save_data(data)
        subprocess.run(['python3', 'crawl-wiki.py', "wiki-geometry.json"])

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
