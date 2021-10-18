-- comm model support, tmc, 2021-10-14

BEGIN TRANSACTION
GO
ALTER TABLE dbo.STAGE_BRS_CustomerFull ADD
	PrivilegesCode char(10) NULL,
	ApplyFreightInd char(1) NULL,
	ApplySmallOrderChargesInd char(1) NULL
GO
ALTER TABLE dbo.STAGE_BRS_CustomerFull SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- test stage
select distinct PrivilegesCode from STAGE_BRS_CustomerFull
select distinct ApplyFreightInd, ApplySmallOrderChargesInd from STAGE_BRS_CustomerFull


BEGIN TRANSACTION
GO
ALTER TABLE [dbo].[BRS_Customer] ADD
	ApplyFreightInd char(1) NULL,
	ApplySmallOrderChargesInd char(1) NULL
GO
ALTER TABLE dbo.[BRS_Customer] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- test prod
select distinct PrivilegesCode from [BRS_Customer]
select distinct ApplyFreightInd, ApplySmallOrderChargesInd from [BRS_Customer]
GO
