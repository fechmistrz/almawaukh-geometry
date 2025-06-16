#!/usr/bin/env python3
import sys
import random
from datetime import datetime

def parse_line(line):
    try:
        path, dates_str = line.strip().split()
    except:
        raise Exception(f"{line=}")
    dates = [datetime.strptime(d, '%Y-%m-%d') for d in dates_str.split(',')]
    return path, dates

def score(dates, today):
    return sum(1 + (today - d).days ** 2 for d in dates)

def pick_file_from_stdin():
    today = datetime.today()
    entries = []

    for line in sys.stdin:
        if line.strip():
            path, dates = parse_line(line)
            weight = score(dates, today)
            entries.append((path, weight))

    if not entries:
        print("No valid input.", file=sys.stderr)
        sys.exit(1)

    paths, weights = zip(*entries)
    print(f"{paths=} {weights=}")
    return random.choices(paths, weights=weights, k=1)[0]

if __name__ == "__main__":
    print(pick_file_from_stdin())