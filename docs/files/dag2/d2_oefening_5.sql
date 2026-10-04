-- ==========================================================================
-- d2_oefening_5 - Datum en tijd
-- ==========================================================================
--
-- WERKWIJZE
--   - Zet je cursor IN een query en druk Ctrl+Enter (Mac: Cmd+Enter).
--     Selecteer niet het hele bestand: dan probeert hij alles tegelijk uit te voeren.
--   - Werk je in sql-workbench.com in plaats van het werkblad? Werk daar in EEN tabblad,
--     plak een nieuwe oefening ONDER je vorige werk en ververs de pagina niet.
--
-- In deze oefening ga je oefenen met datumfuncties (tabel bikeshare uit oefening 2).
--     date_diff('day', a, b)     verschil tussen a en b in dagen ('second', 'minute', 'month', 'year' kan ook)
--     year(d) / month(d) / day(d)   onderdelen van een datum
--     date_trunc('month', d)     afronden naar het begin van de maand
--     current_date / now()       vandaag / nu
--     strptime(tekst, formaat)   tekst naar datum, bijv. strptime('Jan 2024', '%b %Y')
--
-- Opdracht 5a: geef duration_seconds en daarnaast het verschil in seconden tussen start_time en end_time.
--              Je berekende kolom hoort hetzelfde te zijn als duration_seconds.
--
-- Opdracht 5b: geef start_time en de kolommen jaar, maand en dag.
--
-- Opdracht 5c: maak de tabel ledger_months aan (hieronder) en sorteer de rijen in kalendervolgorde
--              (tip: CASE WHEN op left(Month, 3), of strptime).
--
-- Bonus:       geef start_terminal en duration_seconds en een kolom difference: het verschil met de vorige rit
--              (op duration_seconds gesorteerd), per start_terminal (tip: window functie LAG).

CREATE OR REPLACE TABLE ledger_months (
    EntryNo INTEGER
    , Month VARCHAR
    , Amount DECIMAL(10, 2)
);

INSERT INTO ledger_months
VALUES (1, 'Jan 2024', 120.00)
    , (2, 'Mrt 2024', 95.50)
    , (3, 'Feb 2024', 210.10)
    , (4, 'Apr 2024', 80.00)
    , (5, 'Jun 2024', 133.30)
    , (6, 'Mei 2024', 99.99);
