CREATE VIEW [table_names] AS
SELECT name FROM sqlite_master
WHERE type='table';

