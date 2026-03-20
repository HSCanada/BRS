
/****** Object:  Schema [sops]    Script Date: 2026/02/04 2:17:07 PM ******/
CREATE SCHEMA [sops]
GO


ALTER VIEW [sops].[cm_supplemental_fields]
AS
SELECT        BRS_Customer.ShipTo, BRS_Customer.MarketClass, BRS_Customer.SegCd, BRS_Customer.MarketClass_New, BRS_Customer.SegCd_New, BRS_Customer.DSO_ParentShipTo, 
                         BRS_Customer.comm_status_cd AS comm_group_cd, BRS_Customer.comm_group_tier_cd, fsc.TerritoryCd AS FSC_TerritoryCd, fsc.FSCName AS FSC_Name,  isr.TerritoryCd AS ISR_TerritoryCd, isr.FSCName AS ISR_Name, hsps.TerritoryCd AS HSPS_TerritoryCd, 
                         hsps.FSCName AS HSPS_Name, Apply_Restocking_Charges, Credit_Card_Autopay_Flag, ISNULL(bt.A5AFC__apply_finance_charges_yn, '') AS Apply_Late_Fees, BillTo
FROM
	BRS_Customer 

	INNER JOIN BRS_FSC_Rollup AS fsc 
	ON BRS_Customer.TerritoryCd = fsc.TerritoryCd 
		
	INNER JOIN BRS_FSC_Rollup AS isr 
	ON BRS_Customer.TsTerritoryCd = isr.TerritoryCd 
		
	INNER JOIN BRS_FSC_Rollup AS hsps 
	ON BRS_Customer.eps_code = hsps.TerritoryCd

	LEFT JOIN [Integration].[F56CUSA2_CUSINF2A] as bt
	ON bt.A5AN8__billto = BillTo

WHERE
	(BRS_Customer.BillTo > 0) AND 
	(BRS_Customer.ShipTo <> BRS_Customer.BillTo)

GO

select top 10 * from [sops].[cm_supplemental_fields] where MarketClass = 'MIDMKT'



select count(*) from [sops].[cm_supplemental_fields]
--ORG 80 620

BEGIN TRANSACTION
GO
ALTER TABLE dbo.STAGE_BRS_CustomerFull ADD
	Apply_Restocking_Charges char(2) NULL,
	Credit_Card_Autopay_Flag char(2) NULL
--	,Apply_Late_Fees char(2) NULL
GO
ALTER TABLE dbo.STAGE_BRS_CustomerFull SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


select distinct Apply_Restocking_Charges, Credit_Card_Autopay_Flag FROM dbo.STAGE_BRS_CustomerFull
	
select distinct Apply_Restocking_Charges, Credit_Card_Autopay_Flag FROM dbo.[BRS_Customer]
	
BEGIN TRANSACTION
GO
ALTER TABLE [dbo].[BRS_Customer] ADD
	Apply_Restocking_Charges char(1) NOT NULL default (''),
	Credit_Card_Autopay_Flag char(1) NOT NULL  default ('')
--	,Apply_Late_Fees char(1) NULL
GO
ALTER TABLE [dbo].[BRS_Customer] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
