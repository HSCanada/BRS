       -- Search in All Objects
SELECT OBJECT_NAME(OBJECT_ID),definition
FROM sys.sql_modules
WHERE definition LIKE '%' + 'BRS_TS_Rollup' + '%'
Order by 1
GO