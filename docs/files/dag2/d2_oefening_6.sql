-- ==========================================================================
-- d2_oefening_6 - Review drie LLM-queries
-- ==========================================================================
--
-- Drie queries die een LLM schreef. Per query (tweetallen, 15 minuten totaal):
--     1. Wat was de vraag? Zeg hem in je eigen woorden, inclusief de grain ("1 rij per ...").
--     2. Wat gaat er mis? Gebruik de vijf patronen:
--          1 join fan-out · 2 aggregatie vóór/ná filter · 3 window-scoping · 4 datum & tijd · 5 dialect-mix
--     3. Wat is de fix? Schrijf hem en controleer met een van de standaard checks.
--     Je mag een LLM laten reviewen. Vraag daarna: vond het model zijn eigen fout?

-------------------------------------------------------------------------
-- Query 1 · prompt was: "Geef per klant (CustomerID) het aantal orders, de totale orderwaarde (TotalDue)
--                        en het aantal bestelde artikelen."
-------------------------------------------------------------------------
SELECT C.CustomerID
    , C.CompanyName
    , COUNT(SOH.SalesOrderID) AS aantal_orders
    , SUM(SOH.TotalDue) AS totale_orderwaarde
    , SUM(SOD.OrderQty) AS aantal_artikelen
FROM SalesLT.Customer AS C
INNER JOIN SalesLT.SalesOrderHeader AS SOH ON SOH.CustomerID = C.CustomerID
INNER JOIN SalesLT.SalesOrderDetail AS SOD ON SOD.SalesOrderID = SOH.SalesOrderID
GROUP BY C.CustomerID
    , C.CompanyName
ORDER BY totale_orderwaarde DESC;

-------------------------------------------------------------------------
-- Query 2 · prompt was: "Geef per orderregel het lopende totaal (running total) van de regelwaarde (LineTotal)
--                        binnen de order, in volgorde van SalesOrderDetailID."
-------------------------------------------------------------------------
SELECT SOD.SalesOrderID
    , SOD.SalesOrderDetailID
    , SOD.LineTotal
    , SUM(SOD.LineTotal) OVER (ORDER BY SOD.SalesOrderID) AS running_total
FROM SalesLT.SalesOrderDetail AS SOD
ORDER BY SOD.SalesOrderID
    , SOD.SalesOrderDetailID;

-------------------------------------------------------------------------
-- Query 3 · prompt was: "Geef de 10 orders uit 2008 van bedrijven met een korte naam (minder dan 15 tekens),
--                        met de bedrijfsnaam, de orderdatum en het aantal dagen tot verzending."
-------------------------------------------------------------------------
SELECT TOP 10 SOH.SalesOrderID
    , C.CompanyName
    , SOH.OrderDate
    , DATEDIFF(day, SOH.OrderDate, ISNULL(SOH.ShipDate, GETDATE())) AS dagen_tot_verzending
FROM SalesLT.SalesOrderHeader AS SOH
INNER JOIN SalesLT.Customer AS C ON C.CustomerID = SOH.CustomerID
WHERE SOH.OrderDate BETWEEN '2008-01-01' AND '2008-12-31'
    AND LEN(C.CompanyName) < 15
ORDER BY SOH.OrderDate;
