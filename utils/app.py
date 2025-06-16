# app.py
from flask import Flask, render_template_string, redirect, request
import crawler

app = Flask(__name__)


TEMPLATE = """
<!doctype html>
<title>Wiki Crawler</title>
<h1>Suggested Pages to Visit</h1>
{% for yearmonth, pages in good.items() %}
<h2>h2= {{yearmonth}}</h2>
<p>
{{pages | safe}}
</p>
{% endfor %}

{% for cata, catb in cats %}
A {{cata}} B {{catb}}
{% endfor %}
"""

x = '''{% for page, score, good_score, bad_score in pages %}
  <li>
    <a href="{{ crawler.get_url(page) }}" target="_blank">{{ page }}</a>
    [score: {{ score }}, good: {{ good_score }}, bad: {{ bad_score }}]
    <a href="/mark/{{ page }}?state=good">✅</a>
    <a href="/mark/{{ page }}?state=bad">❌</a>
  </li>
{% endfor %}
'''

@app.route("/")
def index():
    unknown_pages = crawler.list_unvisited_pages()
    page_scores = []

 

    # rather good questions
    # 2025-06
    # ... sorted by some score, limit 10
    # 2025-05
    # ... sorted by some score, limit 10
    # 2025-04
    # ... sorted by some score, limit 10

    # rather bad

    page_scores.sort(key=lambda x: x[1], reverse=True)
    gp = crawler.list_good_pages()

    # page_scores = [["Poland", 1, 1, 0]]
    return render_template_string(TEMPLATE, oracle={"a":" B"}, cats=crawler.list_cats("unknown"), good=gp)

@app.route("/mark/<page>")
def mark(page):
    state = request.args.get("state")
    if state in ("good", "bad"):
        crawler.mark_page(page, state)
    return redirect("/")

if __name__ == "__main__":
    app.run(debug=True, port=5001)
