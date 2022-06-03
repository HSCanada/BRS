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
