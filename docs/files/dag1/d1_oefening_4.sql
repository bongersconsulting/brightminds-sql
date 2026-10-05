-- ==========================================================================
-- d1_oefening_4 - Joins: de working set
-- ==========================================================================
--
-- Een JOIN combineert rijen van twee (of meer) tabellen op basis van een gerelateerde kolom.
--
-- Opdracht 4: verklaar het resultaat van de query onderaan met behulp van de 'working set':
--     - loop voor elke rij in A alle rijen in B af;
--     - is de ON-conditie waar, dan komt de gecombineerde rij in de working set;
--     - bij een LEFT JOIN blijft elke rij uit A sowieso over, met lege (NULL) waardes uit B als niets matcht.
-- Schrijf de working set eerst op papier uit en voer de query dan uit ter controle.
--
-- Draai eerst de twee queries met de brontabellen (cursor erin, Ctrl+Enter), schrijf de working set op papier,
-- en draai daarna pas de derde query.

SELECT * FROM dbo.A;

SELECT * FROM dbo.B;

SELECT A.City_name AS stad_uit_A
    , B.City_name AS stad_uit_B
    , B.Godzilla_attacks
FROM dbo.A
LEFT JOIN dbo.B ON (A.Country = 'USA' AND B.Godzilla_attacks = 2) OR B.Godzilla_attacks = 13;
