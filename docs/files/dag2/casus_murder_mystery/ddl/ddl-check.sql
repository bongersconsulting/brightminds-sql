-- Dit bestand bevat meerdere statements: selecteer alles (Ctrl+A, Mac: Cmd+A) en druk Ctrl+Enter.
-- Controleer daarna of er geen 'INCORRECT' staat in de kolom check_table_availability.

CREATE OR REPLACE TABLE ddl_check (table_name VARCHAR, table_count INTEGER);

INSERT INTO ddl_check (table_name)
VALUES ('crime_scene_report')
    , ('drivers_license')
    , ('facebook_event_checkin')
    , ('get_fit_now_check_in')
    , ('get_fit_now_member')
    , ('income')
    , ('interview')
    , ('person');

SELECT DC.table_name
    , IF(T.table_name IS NOT NULL, 'CORRECT', 'INCORRECT') AS check_table_availability
FROM ddl_check AS DC
LEFT JOIN information_schema.tables AS T ON T.table_name = DC.table_name
ORDER BY DC.table_name;
