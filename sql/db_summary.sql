CREATE VIEW [table_names] AS
SELECT name FROM sqlite_master
WHERE type='table';

CREATE VIEW [column_names] AS
SELECT t.name, c.name
FROM sys.tables AS t
INNER JOIN sys.columns AS c
ON t.[object_id] = c.[object_id]
WHERE c.name IN [table_names]
AND t.is_ms_shipped = 0
AND t.name NOT LIKE '#%';