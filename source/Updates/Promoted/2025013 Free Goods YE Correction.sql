/*
-- FG before 
USE [master]
RESTORE DATABASE [DEV_BRSales] FROM  DISK = N'\\cahsionnlfp04\test2\SQLData2\Backup\BRSales_backup_2025_01_13_130006_1683211.trn' WITH  FILE = 2,  MOVE N'BRS_Primary' TO N'D:\SQLData\DEV_BRSales_PROD.mdf',  MOVE N'BRS_UserData' TO N'D:\SQLData\DEV_BRSales_UserData.ndf',  MOVE N'BRS_Log' TO N'E:\SQLData\DEV_BRSales_log.ldf',  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [DEV_BRSales] FROM  DISK = N'\\cahsionnlfp04\test2\SQLData2\Backup\BRSales_backup_2025_01_13_130006_1683211.trn' WITH  FILE = 3,  NOUNLOAD,  STATS = 5

GO
*/


SELECT TOP (1000) *  FROM [BRSales].[comm].[transaction_F555115] where ID >20152191

SELECT count(*), sum(gp_ext_amt)  FROM [BRSales].[comm].[transaction_F555115] where ID >20152191
-- rows = 48456

-- delete new 
DELETE FROM [BRSales].[comm].[transaction_F555115] where ID >20152191 


SELECT TOP (1000) *  FROM [BRSales].[comm].[transaction_F555115] where ID >20152191 

SELECT *  FROM [BRSales].[comm].[transaction_F555115] where ID >20152191 and FiscalMonth <> 202412

-- reswirl to Dec so FSC get paid
UPDATE  comm.transaction_F555115
SET        FiscalMonth = 202412
WHERE   (ID > 20152191) AND (FiscalMonth <> 202412)
GO
-- 45927