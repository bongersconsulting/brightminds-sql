-- ==========================================================================
-- d2_oefening_1 - Window functions
-- ==========================================================================
--
-- In deze oefening ga je oefenen met window functions.
-- Je maakt zelf een tabel aan. Die komt in dezelfde database als SalesLT en ecodrive, in het geheugen van je browser.
-- Ververs je de pagina, dan is de tabel weg: de CREATE TABLE hieronder opnieuw uitvoeren. Je tekst in het
-- werkblad blijft wel bewaard.
--
-- Opdracht 1a: maak de tabel student_score aan met de query hieronder.
--
-- Opdracht 1b: schrijf een SELECT query met alle kolommen plus een kolom maximum_score en een kolom minimum_score
--              met de hoogste en laagste score over alle rijen (tip: gebruik alleen OVER (), geen PARTITION BY).
--
-- Opdracht 1c: schrijf een SELECT query met een kolom dep_maximum_score en dep_average_score:
--              de hoogste en de gemiddelde score per departement (tip: OVER (PARTITION BY ...)).
--
-- Opdracht 1d: schrijf een SELECT query met een kolom score_rank die de studenten rangschikt op score,
--              per departement (tip: RANK() OVER (PARTITION BY ... ORDER BY ...)).
--
-- Opdracht 1e: gebruik DENSE_RANK in plaats van RANK in de query van 1d. Wat is het verschil in de output?
--
-- Bonus:       geef alleen de nummer 1 van elk departement (tip: QUALIFY, of een CTE met WHERE).

CREATE OR REPLACE TABLE student_score (
    student_id INTEGER PRIMARY KEY
    , student_name VARCHAR
    , dep_name VARCHAR
    , score INTEGER
);

INSERT INTO student_score (student_id, student_name, dep_name, score)
VALUES (11, 'Ibrahim', 'Computer Science', 80)
    , (7, 'Taiwo', 'Microbiology', 76)
    , (9, 'Nurain', 'Biochemistry', 80)
    , (8, 'Joel', 'Computer Science', 90)
    , (10, 'Mustapha', 'Industrial Chemistry', 78)
    , (5, 'Muritadoh', 'Biochemistry', 85)
    , (2, 'Yusuf', 'Biochemistry', 70)
    , (3, 'Habeebah', 'Microbiology', 80)
    , (1, 'Tomiwa', 'Microbiology', 65)
    , (4, 'Gbadebo', 'Computer Science', 80)
    , (12, 'Tolu', 'Computer Science', 67);

SELECT *
FROM student_score
ORDER BY score;
