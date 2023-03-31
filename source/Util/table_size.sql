CREATE TABLE #RowCountsAndSizes (TableName NVARCHAR(128),rows CHAR(11),      
       reserved VARCHAR(18),data VARCHAR(18),index_size VARCHAR(18), 
       unused VARCHAR(18))

EXEC       sp_MSForEachTable 'INSERT INTO #RowCountsAndSizes EXEC sp_spaceused ''?'' '

SELECT     TableName,CONVERT(bigint,rows) AS NumberOfRows,
           CONVERT(bigint,left(reserved,len(reserved)-3)) AS SizeinKB
FROM       #RowCountsAndSizes 
ORDER BY   SizeinKB DESC,TableName

DROP TABLE #RowCountsAndSizes

-- select top 10 * from [comm].[transaction_F555115] order by 1

-- select top 10 * from [dbo].[BRS_TransactionDW] order by 1