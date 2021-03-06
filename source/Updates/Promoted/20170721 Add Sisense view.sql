--
--create test user login
CREATE LOGIN [sisense_user] WITH PASSWORD=N'p@55w0rd'
GO
--create user in test database
CREATE USER [sisense_user] FOR LOGIN [sisense_user] WITH DEFAULT_SCHEMA=[sisense]
GO
--create role
CREATE ROLE [sisense_role] AUTHORIZATION [sisense_user]
GO

CREATE SCHEMA [sisense] AUTHORIZATION [sisense_role]

-- x

--apply permissions to schemas
GO
REVOKE SELECT ON SCHEMA::[dbo] TO [sisense_role]
GO
REVOKE REFERENCES ON SCHEMA::[dbo] TO [sisense_role]
GO
--ensure role membership is correct
EXEC sp_addrolemember N'sisense_role ', N'sisense_user'
GO
--Allow user to connect to database
GRANT CONNECT TO [sisense_user]

REVOKE SELECT ON [dbo].[BRS_CustomerMarketClass] TO [sisense_role]
REVOKE SELECT ON [dbo].[BRS_CustomerSpecialty] TO [sisense_role]
REVOKE SELECT ON [dbo].BRS_Customer TO [public]
REVOKE SELECT ON [dbo].BRS_AGG_CMI_DW_Sales TO [public]
REVOKE SELECT ON [dbo].BRS_CustomerBT TO [public]
REVOKE SELECT ON [dbo].BRS_CustomerMarketClass TO [public]
REVOKE SELECT ON [dbo].BRS_CustomerSpecialty TO [public]
REVOKE SELECT ON [dbo].BRS_Item TO [public]
REVOKE SELECT ON [dbo].BRS_SalesDay TO [public]



GRANT SELECT ON [sisense].[customer_segmentation_source] TO [sisense_role]

GRANT SELECT ON [dbo].[BRS_CustomerMarketClass] TO [sisense_role]
GRANT SELECT ON [dbo].[BRS_CustomerSpecialty] TO [sisense_role]
GRANT SELECT ON [dbo].BRS_Customer TO [sisense_role]
















