-- add history to base lookup table

-- copy from month to day (30 s)
INSERT INTO BRS_ItemBaseHistoryDayLNK
                         (SalesDate, ItemKey, FamilySetLeaderKey, PriceKey)
SELECT        BRS_CalMonth.BCI_ExtractDt, BRS_ItemBaseHistoryLNK.ItemID, BRS_ItemBaseHistoryLNK.FamilySetLeaderID, BRS_ItemBaseHistoryLNK.PriceID
FROM            BRS_ItemBaseHistoryLNK INNER JOIN
                         BRS_CalMonth ON BRS_ItemBaseHistoryLNK.CalMonth = BRS_CalMonth.CalMonth
WHERE        (BRS_ItemBaseHistoryLNK.CalMonth >= 201501) AND (BRS_CalMonth.BCI_ExtractDt > CONVERT(DATETIME, '1980-01-01 00:00:00', 102))

-- delete old (leave current month zero) (70s)
DELETE FROM BRS_ItemBaseHistoryLNK
FROM            BRS_ItemBaseHistoryLNK INNER JOIN
                         BRS_CalMonth ON BRS_ItemBaseHistoryLNK.CalMonth = BRS_CalMonth.CalMonth
WHERE        (BRS_ItemBaseHistoryLNK.CalMonth >= 201501) AND (BRS_CalMonth.BCI_ExtractDt > CONVERT(DATETIME, '1980-01-01 00:00:00', 102))

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_CalMonth
	DROP CONSTRAINT DF_BRS_CalMonth_BCI_LineCountQty
GO
ALTER TABLE dbo.BRS_CalMonth
	DROP CONSTRAINT DF_BRS_CalMonth_BCI_LoadDt
GO
ALTER TABLE dbo.BRS_CalMonth
	DROP CONSTRAINT DF_BRS_CalMonth_BCI_StatusCd
GO
ALTER TABLE dbo.BRS_CalMonth
	DROP COLUMN BCI_LineCountQty, BCI_LoadDt, BCI_StatusCd
GO
ALTER TABLE dbo.BRS_CalMonth SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
EXECUTE sp_rename N'dbo.BRS_CalMonth.BCI_ExtractDt', N'Tmp_BCI_BenchmarkDay', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.BRS_CalMonth.Tmp_BCI_BenchmarkDay', N'BCI_BenchmarkDay', 'COLUMN' 
GO
ALTER TABLE dbo.BRS_CalMonth SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- test
SELECT        FiscalMonth, count(SalesDate)
FROM            BRS_ItemBaseHistoryDay
GROUP BY FiscalMonth order by 1


-- FIX 201604, 201609 so that we have a day in the fiscal month

UPDATE       BRS_CalMonth
SET                BCI_BenchmarkDay = CONVERT(DATETIME, '2016-04-22 00:00:00', 102)
WHERE        (CalMonth IN (201604))

UPDATE       BRS_CalMonth
SET                BCI_BenchmarkDay = CONVERT(DATETIME, '2016-09-23 00:00:00', 102)
WHERE        (CalMonth IN (201609))


UPDATE       BRS_ItemBaseHistoryDayLNK
SET                SalesDate = CONVERT(DATETIME, '2016-04-22 00:00:00', 102)
WHERE        (SalesDate = CONVERT(DATETIME, '2016-04-25 00:00:00', 102))


UPDATE       BRS_ItemBaseHistoryDayLNK
SET                SalesDate = CONVERT(DATETIME, '2016-09-23 00:00:00', 102)
WHERE        (SalesDate = CONVERT(DATETIME, '2016-10-03 00:00:00', 102))


--

UPDATE       BRS_CalMonth
SET                BCI_BenchmarkDay = CONVERT(DATETIME, '2017-06-26 00:00:00', 102)
WHERE        (CalMonth IN (201706))



INSERT INTO BRS_ItemBaseHistoryDayLNK
                         (SalesDate, ItemKey, FamilySetLeaderKey, PriceKey)
SELECT        BRS_CalMonth.BCI_BenchmarkDay , BRS_ItemBaseHistoryLNK.ItemID, BRS_ItemBaseHistoryLNK.FamilySetLeaderID, BRS_ItemBaseHistoryLNK.PriceID
FROM            BRS_ItemBaseHistoryLNK INNER JOIN
                         BRS_CalMonth ON BRS_ItemBaseHistoryLNK.CalMonth = BRS_CalMonth.CalMonth
WHERE        (BRS_ItemBaseHistoryLNK.CalMonth = 201706) AND (BRS_CalMonth.BCI_BenchmarkDay > CONVERT(DATETIME, '1980-01-01 00:00:00', 102))

-- delete old (leave current month zero) (70s)
DELETE FROM BRS_ItemBaseHistoryLNK
FROM            BRS_ItemBaseHistoryLNK INNER JOIN
                         BRS_CalMonth ON BRS_ItemBaseHistoryLNK.CalMonth = BRS_CalMonth.CalMonth
WHERE        (BRS_ItemBaseHistoryLNK.CalMonth = 201706) AND (BRS_CalMonth.BCI_BenchmarkDay > CONVERT(DATETIME, '1980-01-01 00:00:00', 102))
