
/****** Object:  Schema [sops]    Script Date: 2026/02/04 2:17:07 PM ******/
CREATE SCHEMA [sops]
GO


ALTER VIEW [sops].[cm_supplemental_fields]
AS
SELECT   ShipTo, MarketClass, SegCd, MarketClass_New, SegCd_New, DSO_ParentShipTo, [comm_status_cd] AS comm_group_cd, comm_group_tier_cd 
FROM     dbo.BRS_Customer
WHERE   (BillTo > 0) AND (ShipTo <> BillTo)
GO

select top 10 * from [sops].[cm_supplemental_fields] where MarketClass = 'MIDMKT'
