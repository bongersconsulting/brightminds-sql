-- Database laden in SQL Workbench (sql-workbench.com)
-- Plak dit, zet je cursor op een regel en druk Ctrl+Enter (Mac: Cmd+Enter). Doe dat per regel.
-- Let op: na verversen of in een nieuw tabblad moet je dit opnieuw doen.

ATTACH 'https://raw.githubusercontent.com/bongersconsulting/brightminds-sql/main/brightminds_sql.duckdb' AS bm (READ_ONLY);

COPY FROM DATABASE bm TO memory;

DETACH bm;

-- Controle: dit hoort 'OK: 440 klanten, 294 producten, 5889 contracten' te geven.
SELECT 'OK: '
    || (SELECT COUNT(*) FROM SalesLT.Customer) || ' klanten, '
    || (SELECT COUNT(*) FROM SalesLT.Product) || ' producten, '
    || (SELECT COUNT(*) FROM ecodrive.contract) || ' contracten' AS status;
