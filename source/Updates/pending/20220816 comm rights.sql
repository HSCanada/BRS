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


