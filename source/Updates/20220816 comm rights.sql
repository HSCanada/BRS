-- comm rights, tmc, 16 Aug 22

CREATE ROLE [comm_operator]
GO
--ALTER AUTHORIZATION ON SCHEMA::[dbo] TO [comm_operator]
--GO
ALTER ROLE [comm_operator] ADD MEMBER [CAHSI\GWinslow]
GO
ALTER ROLE [comm_operator] ADD MEMBER [CAHSI\TCrowley]
GO

--

USE [DEV_BRSales]
GO

/****** Object:  DatabaseRole [comm_operator]    Script Date: 2022/08/16 9:57:18 AM ******/
CREATE ROLE [comm_operator]
GO

