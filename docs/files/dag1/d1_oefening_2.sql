-- ==========================================================================
-- d1_oefening_2 - Filteren en sorteren
-- ==========================================================================
--
-- WERKWIJZE
--   - Zet je cursor IN een query en druk Ctrl+Enter (Mac: Cmd+Enter).
--     Selecteer niet het hele bestand: dan probeert hij alles tegelijk uit te voeren.
--   - Werk je in sql-workbench.com in plaats van het werkblad? Werk daar in EEN tabblad,
--     plak een nieuwe oefening ONDER je vorige werk en ververs de pagina niet.
--
-- De WHERE clause bestaat uit één of meer vergelijkings-operatoren en logische operatoren (AND, OR, NOT).
--
-- De vergelijkings-operatoren zijn:
--     Gelijk:            =
--     Ongelijk:          <> of !=
--     Bereik:            >   >=   <   <=   BETWEEN
--     Lidmaatschap:      IN ('a', 'b')
--     Deel van tekst:    LIKE / NOT LIKE   (% = nul of meer tekens, _ = precies één teken)
--
-- Opdracht 2: vul de onderstaande query aan: alle ordernummers (SalesOrderNumber) met een totaalbedrag
--             (TotalDue) tussen de 10 en 1000 dollar, oplopend gesorteerd op TotalDue.
--
-- Bonus: hetzelfde, maar dan alleen orders die verzonden zijn met 'CARGO TRANSPORT 5' (kolom ShipMethod).

SELECT SOH.SalesOrderNumber
    , SOH.TotalDue
FROM SalesLT.SalesOrderHeader AS SOH
WHERE 1 = 1
    -- AND ...
;
