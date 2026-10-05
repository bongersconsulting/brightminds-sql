-- ==========================================================================
-- d2_oefening_3 - CASE WHEN en datatypes
-- ==========================================================================
--
-- Stel je hebt een tabel TBL met een kolom NMBR met de waardes:
-- (1), (0), (0), (1), (1), (1), (1), (0), (0), (1), (0), (1), (0), (1), (0), (1)
--
-- Opdracht 3a: maak de tabel TBL aan met de query hieronder, precies zoals hij er staat.
--
-- Opdracht 3b: schrijf een SELECT query die bij elke 0 het getal 2 optelt en bij elke 1 het getal 3 (tip: CASE WHEN).
--              Je krijgt een foutmelding. Lees hem goed: waarom weigert DuckDB dit?
--              Welk datatype had de kolom moeten hebben? Pas de tabel aan (ALTER TABLE ... ALTER COLUMN ... TYPE ...)
--              en probeer opnieuw.
--
-- Bonus:       herschrijf de query uit 3b met de functie IF(conditie, waarde_als_waar, waarde_als_onwaar).

CREATE OR REPLACE TABLE TBL (
    NMBR VARCHAR          -- bewust het verkeerde datatype
);

INSERT INTO TBL (NMBR)
VALUES (1), (0), (0), (1), (1), (1), (1), (0), (0), (1), (0), (1), (0), (1), (0), (1);

SELECT *
FROM TBL;
