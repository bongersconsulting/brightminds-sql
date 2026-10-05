-- ==========================================================================
-- d1_oefening_6 - Formatting
-- ==========================================================================
--
-- De manier waarop je SQL schrijft bepaalt hoe snel jij (en je collega's over drie maanden) de query nog begrijpen.
--
-- Opdracht 6: herschrijf onderstaande query volgens de formatteringsregels van de slide:
--     keywords in HOOFDLETTERS · elke clause op een nieuwe regel · komma's vóór de kolomnaam ·
--     WHERE 1 = 1 gevolgd door AND-filters · inspringen · aliases voor tabellen en kolommen · een comment erboven.

select c.customerName,customermail, ordertotal,s.
salestotal from dbo.onlinecustomers as c
inner join dbo.orders as o on c.customerid=
o.customerid left joiN
dbo.sales AS s ON o.orderId=s.orderId Where s.salesId is
null
