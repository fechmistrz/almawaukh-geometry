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

    for page_data in data.values():
        for linked in page_data.get('forward', []) + page_data.get('backward', []):
            score_count[linked] += 1

    # Filter: page is not in data or not marked as dead and has no links yet
    unexplored = {}
    for page, count in score_count.items():
        if page not in data or (not data[page]['dead'] and not data[page]['forward'] and not data[page]['backward']):
            unexplored[page] = count

    # Group by score
    grouped = defaultdict(list)
    for page, score in unexplored.items():
        grouped[score].append(page)

    return dict(sorted(grouped.items(), key=lambda x: -x[0]))

@app.route('/')
def index():
    data = load_data()
    scored_pages = compute_scores(data)
    return render_template('index.html', pages=scored_pages)

@app.route('/extend/<title>')
def extend(title):
    subprocess.run(['python3', 'extend.py', title])
    return redirect(url_for('index'))

@app.route('/mark_dead/<title>')
def mark_dead(title):
    data = load_data()
    if title in data:
        data[title]['dead'] = True
        data[title]['forward'] = []
        data[title]['backward'] = []
        save_data(data)
    return redirect(url_for('index'))

if __name__ == '__main__':
    app.run(debug=True, port=5001)
