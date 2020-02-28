-- add additional flags for Private Label analysis modeling, tmc, 27 Feb 20

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_CustomerSpecialty ADD
	PrivateLabelScopeInd bit NOT NULL CONSTRAINT DF_BRS_CustomerSpecialty_PrivateLabelScopeInd DEFAULT 0
GO
ALTER TABLE dbo.BRS_CustomerSpecialty SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_CustomerMarketClass ADD
	PrivateLabelScopeInd bit NOT NULL CONSTRAINT DF_BRS_CustomerMarketClass_PrivateLabelScopeInd DEFAULT 0
GO
ALTER TABLE dbo.BRS_CustomerMarketClass SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Branch ADD
	PrivateLabelScopeInd bit NOT NULL CONSTRAINT DF_BRS_Branch_PrivateLabelScopeInd DEFAULT 0
GO
ALTER TABLE dbo.BRS_Branch SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

UPDATE dbo.BRS_CustomerSpecialty
SET PrivateLabelScopeInd = 1
WHERE
Specialty IN('ENDOD', 'ORMS', 'ORTHO', 'PEDO', 'PERIO', 'PROS', 'GENP', 'DSO', 'HYGEN')
GO

UPDATE dbo.BRS_Branch
SET PrivateLabelScopeInd = 1
WHERE
Branch IN ('LONDN', 'OTTWA', 'TORNT', 'MNTRL', 'QUEBC', 'VACVR', 'VICTR')
GO

UPDATE dbo.BRS_CustomerMarketClass
SET PrivateLabelScopeInd = 1
WHERE [MarketClass] In ('MIDMKT','PVTPRC','PVTSPC')
GO

