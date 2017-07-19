USE [master]
GO
CREATE DATABASE [DEV_BRSales] ON 
( FILENAME = N'F:\SQLData\DEV_BRSales_PROD.mdf' ),
( FILENAME = N'F:\SQLData\DEV_BRSales_log.ldf' ),
( FILENAME = N'F:\SQLData\DEV_BRSales_UserData.ndf' )
 FOR ATTACH
GO
if exists (select name from master.sys.databases sd where name = N'DEV_BRSales' and SUSER_SNAME(sd.owner_sid) = SUSER_SNAME() ) EXEC [DEV_BRSales].dbo.sp_changedbowner @loginame=N'sa', @map=false
GO
