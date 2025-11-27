#!/usr/bin/env python3
import re
import sys

ALLOWED_FIELDS = [
    "author",
    "title",
    "year",
    "edition",
    "publisher",
    "series",
    "journal",
    "volume",
    "number",
    "pages",
    "language",
    "cid",
    "doi",
    "isbn",
    "issn",
    "lccn",
    "jstor",
    "mrnumber",
    "url",
    "note",
]

FIELD_ORDER = ALLOWED_FIELDS


def read_braced_value(s, start_index):
    if s[start_index] != "{":
        raise ValueError("Value must start with '{'")

    depth = 0
    i = start_index
    value_chars = []
    i += 1
    depth = 1

    while i < len(s):
        c = s[i]
        if c == "{":
            depth += 1
            value_chars.append(c)
        elif c == "}":
            depth -= 1
            if depth == 0:
                return "".join(value_chars), i + 1
            else:
                value_chars.append(c)
        else:
            value_chars.append(c)
        i += 1

    raise ValueError("Unbalanced braces in value")


def parse_bibtex_entries(text):
    entries = []
    raw_entries = [e.strip() for e in text.split("@") if e.strip()]

    for raw in raw_entries:
        header, body = raw.split("{", 1)
        entry_type = header.strip()
        key, body = body.split(",", 1)
        key = key.strip()

        fields = {}
        i = 0
        while i < len(body):

            m = re.search(r"\s*(\w+)\s*=\s*", body[i:])
            if not m:
                break

            field = m.group(1).lower()
            if field not in ALLOWED_FIELDS:
                raise ValueError(f"Unexpected field '{field}' in entry '{key}'")

            i += m.end()


            if body[i] != "{":
                raise ValueError(f"Field '{field}' in '{key}' does not start with '{{'")

            value, next_i = read_braced_value(body, i)
            fields[field] = value


            i = next_i
            if i < len(body) and body[i] == ",":
                i += 1

        entries.append({
            "type": entry_type,
            "key": key,
            "fields": fields
        })

    return entries


def sort_entries(entries):
    def get_year(entry):
        y = entry["fields"].get("year")
        try:
            return int(y)
        except:
            return 10**12
    return sorted(entries, key=get_year)


def format_entries(entries):
    max_field_len = max(len(f.upper()) for f in ALLOWED_FIELDS)
    out = []

    for e in entries:
        out.append(f"@{e['type']} {{{e['key']},")
        fields = e["fields"]

        for field in FIELD_ORDER:
            if field in fields:
                fname = field.upper()
                pad = " " * (max_field_len - len(fname))
                out.append(f"    {fname}{pad} = {{{fields[field]}}},")

        out.append("}\n")

    return "\n".join(out)


if __name__ == "__main__":
    if len(sys.argv) != 2:
        sys.exit(1)

    with open(sys.argv[1], "r", encoding="utf-8") as f:
        text = f.read()

    entries = parse_bibtex_entries(text)
    entries = sort_entries(entries)
    print(format_entries(entries))