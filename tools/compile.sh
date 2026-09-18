#!/usr/bin/env bash
# Build the BTS report (rapport.tex -> rapport.pdf) using the local toolchain.
# Usage: ./tests/../tools/compile.sh   (run from the report root)  OR  bash tools/compile.sh
set -euo pipefail
cd "$(dirname "$0")/.."

TECTONIC="$PWD/tools/tectonic"
if [[ ! -x "$TECTONIC" ]]; then
  echo "tectonic not found at $TECTONIC" >&2
  exit 1
fi

"$TECTONIC" rapport.tex 2>&1 | tee /tmp/tectonic-build.log | {
  grep -E 'error|Writing' || true
}

if grep -qE 'error|halted' /tmp/tectonic-build.log; then
  echo "BUILD FAILED — see /tmp/tectonic-build.log" >&2
  exit 1
fi
echo "OK: rapport.pdf generated"

if [[ -d "$PWD/tools/pdfvenv" ]]; then
  "$PWD/tools/pdfvenv/bin/python" - "$PWD" <<'PYEOF'
import sys, re, pymupdf
from collections import Counter
doc = pymupdf.open("rapport.pdf")
RIGHT = 524.4
viol = 0
for i, p in enumerate(doc):
    if 1 <= i+1 <= 15: continue
    d = p.get_text("dict")
    for b in d["blocks"]:
        for l in b.get("lines", []):
            if max(s["bbox"][2] for s in l["spans"]) > RIGHT + 5 and not (l["bbox"][3] > 790):
                viol += 1
figs = tabs = Counter()
figs = len(set(re.findall(r'Fig\.\s*\d\.\d+:', "".join((p.get_text() or "") for p in doc))))
tabs = len(set(re.findall(r'Tab\.\s*\d\.\d+:', "".join((p.get_text() or "") for p in doc))))
print("verified: %d pages, %d margin violations, %d Fig, %d Tab" % (len(doc), viol, figs, tabs))
if viol: sys.exit(1)
PYEOF
fi