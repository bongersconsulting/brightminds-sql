-- ==========================================================================
-- d1_oefening_6 - Formatting
-- ==========================================================================
--
-- De manier waarop je SQL schrijft bepaalt hoe snel jij (en je collega's over drie maanden) de query nog begrijpen.
--
-- Opdracht 6: herschrijf onderstaande query volgens de formatteringsregels van de slide:
--     keywords in HOOFDLETTERS · elke clause op een nieuwe regel · komma's vóór de kolomnaam ·
--     WHERE 1 = 1 gevolgd door AND-filters · inspringen · aliases voor tabellen en kolommen · een comment erboven.
--
-- Bonus: haal het filter op salesId weg en toon alleen de 3 orders met het hoogste ordertotal
--     (aflopend gesorteerd, beperkt tot 3 rijen).
--     Schrijf daarna dezelfde query voor het dialect dat je op je werk gebruikt (SQL Server, Postgres, BigQuery, ...).
--     Wat moest je aanpassen en wat niet? Je kunt dat dialect hier niet draaien: check het met je buurman
--     of in je eigen omgeving.

select c.customerName,customermail, ordertotal,s.
salestotal from dbo.onlinecustomers as c
inner join dbo.orders as o on c.customerid=
o.customerid left joiN
dbo.sales AS s ON o.orderId=s.orderId Where s.salesId is
null
