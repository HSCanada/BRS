-- comm_freegoods, tmc, 30 Sep 22

BEGIN TRANSACTION
GO
ALTER TABLE comm.freegoods ADD
	CalMonthRedeem int NOT NULL CONSTRAINT DF_freegoods_CalMonthRedeem DEFAULT 0,
	fg_quantity int NOT NULL CONSTRAINT DF_freegoods_fg_quantity DEFAULT 0,
	item_label_cd char(1) NOT NULL CONSTRAINT DF_freegoods_item_label_cd DEFAULT ''
GO
ALTER TABLE comm.freegoods ADD CONSTRAINT
	FK_freegoods_BRS_CalMonth FOREIGN KEY
	(
	CalMonthRedeem
	) REFERENCES dbo.BRS_CalMonth
	(
	CalMonth
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.freegoods ADD CONSTRAINT
	FK_freegoods_BRS_ItemLabel FOREIGN KEY
	(
	item_label_cd
	) REFERENCES dbo.BRS_ItemLabel
	(
	Label
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.freegoods SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- update missing info

UPDATE       comm.freegoods
SET                item_label_cd = BRS_ItemHistory.Label, ItemDescription = BRS_Item.ItemDescription
FROM            
comm.freegoods 
INNER JOIN BRS_Item 
ON comm.freegoods.Item = BRS_Item.Item 

INNER JOIN BRS_ItemHistory 
ON comm.freegoods.FiscalMonth = BRS_ItemHistory.FiscalMonth AND 
comm.freegoods.Item = BRS_ItemHistory.Item

WHERE        
comm.freegoods.FiscalMonth > = 202101
GO
