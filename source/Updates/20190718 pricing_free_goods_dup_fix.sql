--truncate table [DEV_BRSales].[Integration].[F4073_free_goods_master_file_Staging]

BEGIN TRANSACTION
GO
ALTER TABLE Integration.F4073_free_goods_master_file_Staging
	DROP CONSTRAINT PK_F4073_free_goods_master_file
GO
ALTER TABLE Integration.F4073_free_goods_master_file_Staging SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

ALTER TABLE Integration.F4073_free_goods_master_file_Staging
	add ID integer NOT NULL identity(1,1)
	
GO

