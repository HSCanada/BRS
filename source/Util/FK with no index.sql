-- Listing 4

-- https://www.mssqltips.com/sqlservertip/4305/sql-server-performance-tuning-tip--index-foreign-key-columns/
      
SELECT o.name [table], s.name [schema], fk.name [foreign_key_no_index]
FROM sys.foreign_keys fk
INNER JOIN sys.objects o 
 ON o.[object_id] = fk.parent_object_id
INNER JOIN sys.schemas s 
 ON s.[schema_id] = o.[schema_id]
WHERE o.is_ms_shipped = 0
AND NOT EXISTS ( SELECT *
         FROM sys.index_columns ic
         WHERE EXISTS ( SELECT *
    FROM sys.foreign_key_columns fkc
           WHERE fkc.constraint_object_id = fk.[object_id]
    AND fkc.parent_object_id = ic.[object_id]
           AND fkc.parent_column_id = ic.column_id )
         GROUP BY ic.index_id
         HAVING COUNT(*) = MAX(index_column_id)
         AND COUNT(*) = ( SELECT COUNT(*)
    FROM sys.foreign_key_columns fkc
           WHERE fkc.constraint_object_id = fk.[object_id] ) )
ORDER BY o.[name], fk.[name];
