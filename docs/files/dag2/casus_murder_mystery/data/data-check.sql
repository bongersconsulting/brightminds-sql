-- Voer onderstaande query uit en controleer of er geen 'INCORRECT' staat in de kolom check_table_count.

UPDATE ddl_check SET table_count = 1228  WHERE table_name = 'crime_scene_report';
UPDATE ddl_check SET table_count = 10007 WHERE table_name = 'drivers_license';
UPDATE ddl_check SET table_count = 20011 WHERE table_name = 'facebook_event_checkin';
UPDATE ddl_check SET table_count = 2703  WHERE table_name = 'get_fit_now_check_in';
UPDATE ddl_check SET table_count = 184   WHERE table_name = 'get_fit_now_member';
UPDATE ddl_check SET table_count = 7514  WHERE table_name = 'income';
UPDATE ddl_check SET table_count = 4991  WHERE table_name = 'interview';
UPDATE ddl_check SET table_count = 10011 WHERE table_name = 'person';

WITH tables_count AS (
    SELECT 'crime_scene_report' AS table_name, COUNT(*) AS cnt FROM crime_scene_report
    UNION ALL SELECT 'drivers_license', COUNT(*) FROM drivers_license
    UNION ALL SELECT 'facebook_event_checkin', COUNT(*) FROM facebook_event_checkin
    UNION ALL SELECT 'get_fit_now_check_in', COUNT(*) FROM get_fit_now_check_in
    UNION ALL SELECT 'get_fit_now_member', COUNT(*) FROM get_fit_now_member
    UNION ALL SELECT 'income', COUNT(*) FROM income
    UNION ALL SELECT 'interview', COUNT(*) FROM interview
    UNION ALL SELECT 'person', COUNT(*) FROM person
)
SELECT DC.table_name
    , DC.table_count AS verwacht
    , TC.cnt AS gevonden
    , IF(TC.cnt = DC.table_count, 'CORRECT', 'INCORRECT') AS check_table_count
FROM ddl_check AS DC
LEFT JOIN tables_count AS TC ON TC.table_name = DC.table_name
ORDER BY DC.table_name;
