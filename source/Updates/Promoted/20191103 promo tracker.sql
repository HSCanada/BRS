-- Promo tracker, tmc 3 Nov 19

ALTER TABLE dbo.BRS_Promotion ADD CONSTRAINT
	FK_BRS_Promotion_BRS_Promotion FOREIGN KEY
	(
	PromotionTrackingCode
	) REFERENCES dbo.BRS_Promotion
	(
	PromotionCode
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO


BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext ADD
	PromotionTrackingCode char(2) NOT NULL CONSTRAINT DF_BRS_TransactionDW_Ext_PromotionTrackingCode DEFAULT ''
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext ADD CONSTRAINT
	FK_BRS_TransactionDW_Ext_BRS_Promotion FOREIGN KEY
	(
	PromotionTrackingCode
	) REFERENCES dbo.BRS_Promotion
	(
	PromotionCode
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext SET (LOCK_ESCALATION = TABLE)
GO
COMMIT