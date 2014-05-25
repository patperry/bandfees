# bandfees.py
# -----------
# Combined cleaned files into bandfees.csv
#

import csv
import os
import re


def parse_fee(fee):
    fee = fee.strip()
    m1 = re.match(r'^\$(\d*\.?\d+)k(\+?)$', fee)
    m2 = re.match(r'^\$(\d*\.?\d+)k?\s*-\s*\$?(\d*\.?\d+)[kK]?(\+?)$', fee)
    mil = re.match(r'\$(\d*\.?\d+)\s*mil(\+?)$', fee)
    if m1:
        lo = float(m1.group(1))
        hi = lo
        plus = m1.group(2)
    elif m2:
        lo = float(m2.group(1))
        hi = float(m2.group(2))
        plus = m2.group(3)
    elif mil:
        lo = float(mil.group(1)) * 1000
        hi = lo
        plus = mil.group(2)
    else:
        raise ValueError('fee "{}" does not match expected pattern'.format(fee))
    plus = 1 if plus == '+' else 0
    return (lo,hi,plus)


data = {}

for filename in os.listdir("clean"):
    m = re.match(r'^(\d+)k\.tsv$', filename)
    if not m:
        pass
    
    with open('clean/' + filename, 'r') as f:
        for line in f:
            name,fee = line.split('\t')
            name = name.strip()
            val = parse_fee(fee)
            if name in data:
                data[name].append(val)
            else:
                data[name] = [val]


with open('bandfees.csv', 'w') as csvfile:
    w = csv.writer(csvfile)
    w.writerow(['name', 'lower', 'upper', 'plus'])
    for name in sorted(data.keys()):
        for v in data[name]:
            w.writerow([name, v[0], v[1], v[2]])

