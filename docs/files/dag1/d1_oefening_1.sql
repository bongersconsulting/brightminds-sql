-- ==========================================================================
-- d1_oefening_1 - Let's query!
-- ==========================================================================
--
-- WERKWIJZE
--   - Zet je cursor IN een query en druk Ctrl+Enter (Mac: Cmd+Enter).
--     Selecteer niet het hele bestand: dan probeert hij alles tegelijk uit te voeren.
--   - Werk je in sql-workbench.com in plaats van het werkblad? Werk daar in EEN tabblad,
--     plak een nieuwe oefening ONDER je vorige werk en ververs de pagina niet.
--
-- Een regel die begint met -- is een comment: die wordt niet uitgevoerd. Zo staat de uitleg in elk
-- oefenbestand, en zo zet je zelf een stuk query tijdelijk uit (Ctrl + / zet de -- aan en uit).
--
-- Opdracht 1a: links in het werkblad zie je de schema's SalesLT, ecodrive en dbo met hun tabellen.
--              Klap SalesLT open. Welke tabellen zie je? Klik op Customer: welke kolommen heeft die tabel?
--
-- Opdracht 1b: zet je cursor in de query hieronder en druk Ctrl+Enter (Mac: Cmd+Enter). Je ziet 100 rijen.
--
-- Opdracht 1c: haal de -- weg voor de regel met WHERE (cursor op die regel, Ctrl + /) en draai de query
--              opnieuw. Hoeveel rijen blijven er over? Zet de -- daarna weer terug.
--
-- Opdracht 1d: schrijf een query die alleen de voornaam (FirstName) van alle klanten laat zien.
--
-- Opdracht 1e: hoeveel rijen heeft SalesLT.Customer? (tip: rechtsonder bij het resultaat staat het aantal rijen;
--              of gebruik SELECT COUNT(*) ...)

SELECT *
FROM SalesLT.Customer
-- WHERE FirstName = 'Kerim'
LIMIT 100;
