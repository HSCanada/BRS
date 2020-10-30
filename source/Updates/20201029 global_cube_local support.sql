
BEGIN TRANSACTION
GO
ALTER TABLE hfm.account ADD
	HFM_Account_descr nvarchar(30) NOT NULL CONSTRAINT DF_account_HFM_Account_descr DEFAULT '',
	HFM_Account_key int identity(1,1) NOT NULL 
GO
ALTER TABLE hfm.account SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
CREATE UNIQUE NONCLUSTERED INDEX account_idx_u_01 ON hfm.account
	(
	HFM_Account_key
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE hfm.account SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_SalesDivision ADD
	SalesDivision_key int identity(1,1) NOT NULL 
GO
ALTER TABLE dbo.BRS_SalesDivision SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
CREATE UNIQUE NONCLUSTERED INDEX BRS_SalesDivision_idx_u_01 ON dbo.BRS_SalesDivision
	(
	SalesDivision_key
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE dbo.BRS_SalesDivision SET (LOCK_ESCALATION = TABLE)
GO
COMMIT




SELECT
TOP (10) 
ShipTo, Billto, Customer, CustomerGroup, SalesPlan, SalesPlanCode, SalesPlanType, FieldSales, Branch, 
SalesDivision, MarketClass, Segment, Specialty, CustomerStatus, 
SalesDivisionCode, BranchCode, MarketClassCode, 
FscTerritoryCd

FROM            Dimension.Customer