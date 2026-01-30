-- load HSPS Entity, tmc, 19 Jan 26

BEGIN TRANSACTION
GO
ALTER TABLE dbo.STAGE_BRS_CustomerFull ADD
	MedicalEntity nvarchar(50) NULL,
	BuyingGroup nvarchar(50) NULL,
	ExclusiveLevel4Cd nvarchar(50) NULL
GO
ALTER TABLE dbo.STAGE_BRS_CustomerFull SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


select distinct 
-- [MedicalEntity]
-- [BuyingGroup]
[ExclusiveLevel4Cd]
FROM dbo.STAGE_BRS_CustomerFull 

select distinct 
eps_code
FROM dbo.BRS_Customer

update dbo.BRS_Customer
set eps_code = ''



