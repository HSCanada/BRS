
-- refersh DEV for genpact

USE [master]

-- est 15m
BACKUP DATABASE [BRSales] TO  DISK = N'F:\SQLData\brs_mockup_genpact_20260708.bak' WITH NOFORMAT, NOINIT,  NAME = N'BRSales-Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO

-- est 5m
RESTORE DATABASE [DEV_BRSales] FROM  DISK = N'F:\SQLData\brs_mockup_genpact_20260708.bak' WITH  FILE = 1,  
MOVE N'BRS_Primary' TO N'F:\SQLData\DEV_BRSales_PROD.mdf',  
MOVE N'BRS_UserData' TO N'F:\SQLData\DEV_BRSales_UserData.ndf',  
MOVE N'BRS_Log' TO N'F:\SQLData\DEV_BRSales_log.ldf',  NOUNLOAD, REPLACE, STATS = 5

GO


-- add prod roles to dev genpact


SELECT 
    roles.[name] as RoleName, 
    members.[name] as UserName
FROM sys.database_role_members
JOIN sys.database_principals roles 
    ON database_role_members.role_principal_id = roles.principal_id
JOIN sys.database_principals members 
    ON database_role_members.member_principal_id = members.principal_id

where members.[name] in( 'CAHSI\jli', 'CAHSI\TCrowley', 'CAHSI\GWinslow')

ORDER BY RoleName, UserName;

SELECT 
    distinct roles.[name] as RoleName
FROM sys.database_role_members
JOIN sys.database_principals roles 
    ON database_role_members.role_principal_id = roles.principal_id
JOIN sys.database_principals members 
    ON database_role_members.member_principal_id = members.principal_id

where members.[name] in( 'CAHSI\jli', 'CAHSI\TCrowley', 'CAHSI\GWinslow')

/*

-- roles
analytics_operator
db_ddladmin
eps_operator
flex_operator
hfm_operator
maint_role
nes_role
pricing_role
purch_role

--users

USHSI\Sudhir.Sudhir
USHSI\Sudhanshu.Tyagi
USHSI\Rohilla.Raina
USHSI\Tarang.Jain

-- mode 

-- reminder to run
USE DEV_BRSales

-- Step 3: Assign the user to the database role
print 'setup USHSI\Sudhir.Sudhir'

ALTER ROLE analytics_operator ADD MEMBER	[USHSI\Sudhir.Sudhir];
ALTER ROLE db_ddladmin ADD MEMBER			[USHSI\Sudhir.Sudhir];
ALTER ROLE eps_operator ADD MEMBER			[USHSI\Sudhir.Sudhir];
ALTER ROLE flex_operator ADD MEMBER			[USHSI\Sudhir.Sudhir];
ALTER ROLE hfm_operator ADD MEMBER			[USHSI\Sudhir.Sudhir];
ALTER ROLE maint_role ADD MEMBER			[USHSI\Sudhir.Sudhir];
ALTER ROLE nes_role ADD MEMBER				[USHSI\Sudhir.Sudhir];
ALTER ROLE pricing_role ADD MEMBER			[USHSI\Sudhir.Sudhir];
ALTER ROLE purch_role ADD MEMBER			[USHSI\Sudhir.Sudhir];
GO

print 'setup USHSI\Sudhanshu.Tyagi'

ALTER ROLE analytics_operator ADD MEMBER	[USHSI\Sudhanshu.Tyagi];
ALTER ROLE db_ddladmin ADD MEMBER			[USHSI\Sudhanshu.Tyagi];
ALTER ROLE eps_operator ADD MEMBER			[USHSI\Sudhanshu.Tyagi];
ALTER ROLE flex_operator ADD MEMBER			[USHSI\Sudhanshu.Tyagi];
ALTER ROLE hfm_operator ADD MEMBER			[USHSI\Sudhanshu.Tyagi];
ALTER ROLE maint_role ADD MEMBER			[USHSI\Sudhanshu.Tyagi];
ALTER ROLE nes_role ADD MEMBER				[USHSI\Sudhanshu.Tyagi];
ALTER ROLE pricing_role ADD MEMBER			[USHSI\Sudhanshu.Tyagi];
ALTER ROLE purch_role ADD MEMBER			[USHSI\Sudhanshu.Tyagi];
GO

print 'setup USHSI\Rohilla.Raina'

ALTER ROLE analytics_operator ADD MEMBER	[USHSI\Rohilla.Raina];
ALTER ROLE db_ddladmin ADD MEMBER			[USHSI\Rohilla.Raina];
ALTER ROLE eps_operator ADD MEMBER			[USHSI\Rohilla.Raina];
ALTER ROLE flex_operator ADD MEMBER			[USHSI\Rohilla.Raina];
ALTER ROLE hfm_operator ADD MEMBER			[USHSI\Rohilla.Raina];
ALTER ROLE maint_role ADD MEMBER			[USHSI\Rohilla.Raina];
ALTER ROLE nes_role ADD MEMBER				[USHSI\Rohilla.Raina];
ALTER ROLE pricing_role ADD MEMBER			[USHSI\Rohilla.Raina];
ALTER ROLE purch_role ADD MEMBER			[USHSI\Rohilla.Raina];
GO

print 'setup USHSI\Tarang.Jain'

ALTER ROLE analytics_operator ADD MEMBER	[USHSI\Tarang.Jain];
ALTER ROLE db_ddladmin ADD MEMBER			[USHSI\Tarang.Jain];
ALTER ROLE eps_operator ADD MEMBER			[USHSI\Tarang.Jain];
ALTER ROLE flex_operator ADD MEMBER			[USHSI\Tarang.Jain];
ALTER ROLE hfm_operator ADD MEMBER			[USHSI\Tarang.Jain];
ALTER ROLE maint_role ADD MEMBER			[USHSI\Tarang.Jain];
ALTER ROLE nes_role ADD MEMBER				[USHSI\Tarang.Jain];
ALTER ROLE pricing_role ADD MEMBER			[USHSI\Tarang.Jain];
ALTER ROLE purch_role ADD MEMBER			[USHSI\Tarang.Jain];
GO


-- note, add below users to mdsdb and SSISDB

GO
USE [msdb]
GO
ALTER ROLE [SQLAgentOperatorRole] ADD MEMBER [USHSI\Sudhir.Sudhir];
ALTER ROLE [SQLAgentOperatorRole] ADD MEMBER [USHSI\Sudhanshu.Tyagi];
ALTER ROLE [SQLAgentOperatorRole] ADD MEMBER [USHSI\Rohilla.Raina];
ALTER ROLE [SQLAgentOperatorRole] ADD MEMBER [USHSI\Tarang.Jain];
GO
