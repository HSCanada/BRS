       -- Search in All Objects
SELECT OBJECT_NAME(OBJECT_ID),definition
FROM sys.sql_modules
WHERE definition LIKE '%' + 'BRS_AGG_CMI_DW_Sales' + '%'
Order by 1
GO