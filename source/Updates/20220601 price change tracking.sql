-- price change tracking, tmc, 1 Jan 22

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Item ADD
	pchg_active_ind bit NOT NULL CONSTRAINT DF_BRS_Item_pchg_active_ind DEFAULT 0,
	pchg_active_dt date NULL,
	pchg_price_old money NULL,
	pchg_price_new money NULL,
	pchg_note varchar(50) NULL,
	pchg_brand_equiv char(10) NULL
GO
ALTER TABLE dbo.BRS_Item ADD CONSTRAINT
	FK_BRS_Item_BRS_Item_brand_equiv FOREIGN KEY
	(
	pchg_brand_equiv
	) REFERENCES dbo.BRS_Item
	(
	Item
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Item SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_ItemMPC ADD
	pchg_mpc_active_ind bit NOT NULL CONSTRAINT DF_BRS_ItemMPC_pchg_active_ind DEFAULT 0
GO
ALTER TABLE dbo.BRS_ItemMPC SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

update dbo.BRS_ItemMPC 
set pchg_mpc_active_ind = 1
where [MajorProductClass] in('002', '005', '008', '012', '020', '084')

--
BEGIN TRANSACTION
GO

ALTER TABLE dbo.BRS_Item ADD
	pchg_adhoc_model_code1 varchar(50) NULL,
	pchg_adhoc_model_code2 varchar(50) NULL
GO
ALTER TABLE dbo.BRS_Item SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
-- rebate model, tmc, 16 Jun 22

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_CustomerBT ADD
	billto_adhoc_model_code1 varchar(50) NOT NULL CONSTRAINT DF_BRS_CustomerBT_billto_adhoc_model_code1 DEFAULT '',
	billto_adhoc_model_code2 varchar(50) NOT NULL CONSTRAINT DF_BRS_CustomerBT_billto_adhoc_model_code2 DEFAULT ''
GO
ALTER TABLE dbo.BRS_CustomerBT SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


/*
-- run scripts
Dimension.Item.sql
Dimension.Customer.sql
Dimension.Customer_qt.sql
*/