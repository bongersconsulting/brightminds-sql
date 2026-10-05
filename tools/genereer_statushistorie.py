"""Genereer statushistorie in ecodrive.charge_card_status (eenmalig gedraaid; staat hier ter documentatie).

Uitgangspunt: per pas stond er precies 1 regel (de huidige status, end_date leeg). Die regel blijft
ongewijzigd de laatste regel. Daarvoor komen eerdere regels, elk met end_date = start van de volgende:

  huidige status Actief (3):       Niet actief (1) -> Wacht op activatie (2) -> Actief
  huidige status Geblokkeerd (4):  1 -> 2 -> Actief (rond de contractstart) [-> tijdelijk Geblokkeerd -> Actief] -> Geblokkeerd
  huidige status Wacht op act. (2): 1 -> 2

De tijdelijke blokkade (bv. verloren pas) komt bij ~12% van de geblokkeerde passen die langer dan
120 dagen actief waren. Alles is deterministisch: de toevalsgenerator krijgt per pas een vaste seed.

Gebruik:  python3 tools/genereer_statushistorie.py brightminds_sql.duckdb
          (weigert als de tabel al historie bevat)
"""
from __future__ import annotations

import hashlib
import random
import sys
from datetime import datetime, timedelta

import duckdb

NIET_ACTIEF, WACHT, ACTIEF, GEBLOKKEERD = 1, 2, 3, 4


def status_id(card_id: str, seq: int) -> str:
    h = hashlib.md5(f"{card_id}|{seq}".encode()).hexdigest()
    return f"{h[:8]}-{h[8:12]}-{h[12:16]}-{h[16:20]}-{h[20:]}"


def days(rng: random.Random, lo: float, hi: float) -> timedelta:
    """Willekeurige duur tussen lo en hi dagen, tot op de microseconde."""
    return timedelta(seconds=rng.uniform(lo, hi) * 86400)


def history(card_id: str, cur_type: int, cur_start: datetime, contract_start: datetime) -> list[tuple[int, datetime]]:
    """Eerdere (status_type, start_date) voor een pas, oplopend in tijd, zonder de huidige regel."""
    rng = random.Random(card_id)
    if cur_type == WACHT:
        return [(NIET_ACTIEF, cur_start - days(rng, 0.5, 3))]
    if cur_type == ACTIEF:
        act = cur_start
        steps: list[tuple[int, datetime]] = []
    else:  # GEBLOKKEERD: activatie rond de contractstart, en altijd vóór de blokkade
        act = contract_start + days(rng, 0, 3)
        if act >= cur_start - timedelta(hours=6):
            act = cur_start - days(rng, 0.1, 0.9) * max(1, (cur_start - contract_start).days)
            if act >= cur_start:
                act = cur_start - days(rng, 0.05, 0.5)
        steps = [(ACTIEF, act)]
        span = (cur_start - act).days
        if span > 120 and rng.random() < 0.12:
            blok = act + timedelta(days=span * rng.uniform(0.2, 0.7))
            terug = blok + days(rng, 3, 30)
            if terug < cur_start - timedelta(days=1):
                steps += [(GEBLOKKEERD, blok), (ACTIEF, terug)]
    wacht = act - days(rng, 2, 10)
    niet = wacht - days(rng, 0.2, 2)
    return [(NIET_ACTIEF, niet), (WACHT, wacht)] + steps


def main(path: str) -> None:
    con = duckdb.connect(path)
    n_cards, n_rows = con.sql(
        "SELECT COUNT(DISTINCT charge_card_id), COUNT(*) FROM ecodrive.charge_card_status").fetchone()
    if n_rows != n_cards:
        raise SystemExit("charge_card_status bevat al historie; niets gedaan.")
    rows = con.sql("""
        SELECT S.rowid AS pos, S.charge_card_status_id, S.charge_card_id, S.status_type, S.start_date,
               MIN(K.start_date) AS contract_start
        FROM ecodrive.charge_card_status AS S
        JOIN ecodrive.charge_card_contract AS CC USING (charge_card_id)
        JOIN ecodrive.contract AS K USING (contract_id)
        GROUP BY ALL ORDER BY pos""").fetchall()
    if len(rows) != n_cards:
        raise SystemExit("niet elke pas heeft een contract")

    out = []
    for pos, sid, card, typ, start, cstart in rows:
        chain = history(card, typ, start, cstart) + [(typ, start)]
        for seq, (t, s) in enumerate(chain):
            end = chain[seq + 1][1] if seq + 1 < len(chain) else None
            out.append((pos, seq, sid if end is None else status_id(card, seq), card, t, s, end))

    con.execute("BEGIN")
    con.execute("CREATE TEMP TABLE nieuw (pos BIGINT, seq INTEGER, charge_card_status_id VARCHAR, charge_card_id VARCHAR,"
                " status_type INTEGER, start_date TIMESTAMP, end_date TIMESTAMP)")
    con.executemany("INSERT INTO nieuw VALUES (?, ?, ?, ?, ?, ?, ?)", out)
    con.execute("DELETE FROM ecodrive.charge_card_status")
    con.execute("""INSERT INTO ecodrive.charge_card_status
                   SELECT charge_card_status_id, charge_card_id, status_type, start_date, end_date
                   FROM nieuw ORDER BY pos, seq""")
    con.execute("COMMIT")
    con.execute("CHECKPOINT")
    print(f"{n_rows} -> {len(out)} regels")


if __name__ == "__main__":
    main(sys.argv[1])
