-- ==========================================================================
-- d2_oefening_2 - Running total en moving average
-- ==========================================================================
--
-- WERKWIJZE
--   - Zet je cursor IN een query en druk Ctrl+Enter (Mac: Cmd+Enter).
--     Selecteer niet het hele bestand: dan probeert hij alles tegelijk uit te voeren.
--
-- In deze oefening gebruik je window functions voor een running total (lopend totaal) en een moving average.
--
-- Opdracht 2a: maak de tabel bikeshare aan met de query hieronder.
--
-- Opdracht 2b: schrijf een SELECT query met de kolommen start_time, bike_id_nr en duration_seconds
--              en een kolom running_total: de cumulatieve som van duration_seconds, in volgorde van start_time.
--              Kijk goed naar de output. Klopt elke rij? (Tip: er zijn ritten met precies dezelfde start_time.)
--
-- Opdracht 2c: schrijf een SELECT query met dezelfde kolommen en een kolom moving_avg: het gemiddelde van de
--              3 meest recente ritten (tip: ROWS BETWEEN 2 PRECEDING AND CURRENT ROW).
--
-- Bonus:       wat gebeurt er als je in 2b alleen ORDER BY start_time gebruikt, zonder ROWS BETWEEN ...? Waarom?

CREATE OR REPLACE TABLE bikeshare (
    duration_seconds INTEGER
    , start_time TIMESTAMP
    , end_time TIMESTAMP
    , start_terminal VARCHAR
    , end_terminal VARCHAR
    , bike_id_nr INTEGER
    , member_type VARCHAR
);

INSERT INTO bikeshare
VALUES (605,  '2024-01-05 12:30:00', '2024-01-05 12:40:05', 'DIEMEN', 'AMS', 3025, 'registered')
    , (55,   '2024-01-05 12:30:10', '2024-01-05 12:31:05', 'DIEMEN', 'AMS', 1025, 'registered')
    , (65,   '2024-01-05 12:30:10', '2024-01-05 12:31:15', 'DIEMEN', 'AMS', 2025, 'casual')
    , (7255, '2024-01-06 16:30:10', '2024-01-06 18:31:05', 'DIEMEN', 'AMS', 1025, 'registered')
    , (7265, '2024-01-06 16:30:10', '2024-01-06 18:31:15', 'DIEMEN', 'AMS', 2025, 'casual')
    , (55,   '2024-01-07 10:30:10', '2024-01-07 10:31:05', 'AMS',    'AMS', 1025, 'registered')
    , (65,   '2024-01-07 10:30:10', '2024-01-07 10:31:15', 'AMS',    'AMS', 2025, 'casual');

SELECT *
FROM bikeshare
ORDER BY start_time
    , bike_id_nr;
