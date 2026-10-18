import os
import re
import sys
import zipfile
import xml.etree.ElementTree as ET

NS = {"m": "http://schemas.openxmlformats.org/spreadsheetml/2006/main"}


def cell_value(cell, shared):
    value = cell.find("m:v", NS)
    if cell.get("t") == "inlineStr":
        inline = cell.find("m:is", NS)
        if inline is None:
            return ""
        return "".join(node.text or "" for node in inline.iter("{%s}t" % NS["m"]))
    if value is None:
        return ""
    if cell.get("t") == "s":
        return shared[int(value.text)]
    return value.text or ""


def dump(path, limit):
    print("\n===", os.path.basename(path))
    with zipfile.ZipFile(path) as archive:
        shared = []
        if "xl/sharedStrings.xml" in archive.namelist():
            root = ET.fromstring(archive.read("xl/sharedStrings.xml"))
            for item in root.findall("m:si", NS):
                shared.append("".join(node.text or "" for node in item.iter("{%s}t" % NS["m"])))
        sheets = sorted(
            name for name in archive.namelist()
            if re.match(r"xl/worksheets/sheet\d+\.xml$", name)
        )
        for sheet in sheets[:1]:
            root = ET.fromstring(archive.read(sheet))
            for index, row in enumerate(root.iter("{%s}row" % NS["m"])):
                if index >= limit:
                    break
                values = []
                for cell in row.findall("m:c", NS):
                    values.append("%s=%s" % (cell.get("r"), cell_value(cell, shared)))
                if values:
                    print(" | ".join(values))


if __name__ == "__main__":
    row_limit = int(sys.argv[1]) if len(sys.argv) > 1 else 30
    for file_name in sys.argv[2:]:
        dump(file_name, row_limit)
