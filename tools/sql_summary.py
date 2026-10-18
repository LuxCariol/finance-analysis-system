import collections
import re
import sys


def main(path):
    text = open(path, encoding="utf-8", errors="replace").read()
    tables = re.findall(r"CREATE TABLE `([^`]+)`", text)
    inserts = collections.Counter(
        match.group(1).lower()
        for match in re.finditer(r"(?im)^\s*(?:insert\s+into|INSERT INTO)\s+`([^`]+)`", text)
    )
    print("tables:", len(tables))
    for table in tables:
        print("%-38s %d" % (table, inserts[table.lower()]))


if __name__ == "__main__":
    main(sys.argv[1])
