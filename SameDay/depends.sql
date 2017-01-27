       -- Search in All Objects
SELECT OBJECT_NAME(OBJECT_ID),definition
FROM sys.sql_modules
WHERE definition LIKE '%' + 'ExtPrice' + '%'
Order by 1
GO