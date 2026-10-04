-- ==========================================================================
-- d1_oefening_5 - Joins: Green-Tree
-- ==========================================================================
--
-- WERKWIJZE
--   - Zet je cursor IN een query en druk Ctrl+Enter (Mac: Cmd+Enter).
--     Selecteer niet het hele bestand: dan probeert hij alles tegelijk uit te voeren.
--   - Werk je in sql-workbench.com in plaats van het werkblad? Werk daar in EEN tabblad,
--     plak een nieuwe oefening ONDER je vorige werk en ververs de pagina niet.
--
-- Het bedrijf Green-Tree heeft een campagne gedraaid met aanbiedingen voor online klanten.
-- Als gevolg daarvan zijn sommige orders (winkelmandjes) omgezet in sales.
--
-- Opdracht 5: beantwoord de vragen van Green-Tree. De data staat in dbo.onlinecustomers, dbo.orders en dbo.sales.
-- Voor elke vraag heb je alle drie de tabellen nodig. Tip: schrijf eerst de working set uit.
--
-- Business-vragen:
--     - Welke klanten zijn vanuit een order overgegaan tot een sale? (hint: INNER JOIN)
--     - Welke klanten hebben wel een order gehad, maar geen sale? (hint: LEFT JOIN en ... IS NULL)
--
-- Bonus:
--     - Geef alle data van klanten, orders en sales in één tabel, ook de orders zonder klant en de sales zonder order
--       (hint: FULL JOIN).

SELECT * FROM dbo.onlinecustomers;
SELECT * FROM dbo.orders;
SELECT * FROM dbo.sales;
