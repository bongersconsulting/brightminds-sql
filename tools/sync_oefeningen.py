"""Synchroniseer de oefeningen vanuit de .sql-bestanden naar alle afgeleide plekken.

Bron van waarheid: docs/files/dag{1,2}/d*_oefening_*.sql
Afgeleid (wordt door dit script overschreven):
  - docs/oefeningen.json
  - het <script id="exdata"> blok in docs/werkblad.html
  - de <pre>-blokken in docs/oefeningen-dag{1,2}.html
  - de kopieen docs/files/dag{1,2}/werkblad.html (= docs/werkblad.html)
  - docs/files/dag{1,2}.zip

Gebruik (vanuit de root van de repo):  python3 tools/sync_oefeningen.py
"""
from __future__ import annotations

import html
import json
import re
import shutil
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
DOCS = ROOT / "docs"
FILES = DOCS / "files"
DAYS = (1, 2)


def load_items() -> list[dict]:
    """Lees de huidige volgorde/titels uit oefeningen.json en vul de sql in vanuit de .sql-bestanden."""
    items = json.loads((DOCS / "oefeningen.json").read_text(encoding="utf-8"))["items"]
    for it in items:
        it["sql"] = (FILES / f"dag{it['day']}" / f"{it['id']}.sql").read_text(encoding="utf-8")
    return items


def write_json(items: list[dict]) -> str:
    payload = json.dumps({"items": items}, ensure_ascii=False, indent=1)
    (DOCS / "oefeningen.json").write_text(payload, encoding="utf-8")
    return payload


def write_werkblad(payload: str) -> None:
    path = DOCS / "werkblad.html"
    src = path.read_text(encoding="utf-8")
    new, n = re.subn(
        r'(<script id="exdata" type="application/json">).*?(</script>)',
        lambda m: m.group(1) + payload + m.group(2),
        src,
        flags=re.S,
    )
    if n != 1:
        raise SystemExit("exdata-blok niet gevonden in werkblad.html")
    path.write_text(new, encoding="utf-8")
    for day in DAYS:
        shutil.copyfile(path, FILES / f"dag{day}" / "werkblad.html")


def write_oefening_pages(items: list[dict]) -> None:
    for day in DAYS:
        path = DOCS / f"oefeningen-dag{day}.html"
        src = path.read_text(encoding="utf-8")
        for it in (x for x in items if x["day"] == day):
            pattern = rf'(<pre id="pre-{re.escape(it["id"])}">).*?(</pre>)'
            src, n = re.subn(pattern, lambda m: m.group(1) + html.escape(it["sql"]) + m.group(2), src, flags=re.S)
            if n != 1:
                raise SystemExit(f"<pre> voor {it['id']} niet gevonden in {path.name}")
        path.write_text(src, encoding="utf-8")


def write_zips() -> None:
    """Zip per dag de map docs/files/dagN (zonder geneste .zip-bestanden)."""
    for day in DAYS:
        folder = FILES / f"dag{day}"
        with zipfile.ZipFile(FILES / f"dag{day}.zip", "w", zipfile.ZIP_DEFLATED) as zf:
            for p in sorted(folder.rglob("*")):
                if p.is_file() and p.suffix != ".zip":
                    zf.write(p, p.relative_to(FILES).as_posix())


def main() -> None:
    items = load_items()
    payload = write_json(items)
    write_werkblad(payload)
    write_oefening_pages(items)
    write_zips()
    print(f"{len(items)} oefeningen gesynchroniseerd.")


if __name__ == "__main__":
    main()
