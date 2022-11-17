-- free goods mix and match, tmc, 17 Nov 22
BEGIN TRANSACTION
GO
ALTER TABLE fg.chargeback ADD
	fg_supplier char(6) NULL,
	fg_external char(10) NULL,
	fg_note varchar(50) NULL
GO
ALTER TABLE fg.chargeback ADD CONSTRAINT
	FK_chargeback_BRS_ItemSupplier1 FOREIGN KEY
	(
	fg_supplier
	) REFERENCES dbo.BRS_ItemSupplier
	(
	Supplier
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.chargeback SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
CREATE UNIQUE NONCLUSTERED INDEX fg_chargeback_idx_u_01 ON fg.chargeback(fg_supplier)  where fg_supplier is not null WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA 
GO
ALTER TABLE fg.chargeback SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE fg.deal ADD
	fg_get_item_default char(10) NOT NULL CONSTRAINT DF_deal_fg_get_item_default DEFAULT ''
GO
ALTER TABLE fg.deal ADD CONSTRAINT
	FK_deal_BRS_Item FOREIGN KEY
	(
	fg_get_item_default
	) REFERENCES dbo.BRS_Item
	(
	Item
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.deal SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
