-- Promo tracker, custom info, 18 Mar 21

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Promotion ADD
	PromoNameTracking nchar(30) NOT NULL CONSTRAINT DF_BRS_Promotion_PromotionDescription1 DEFAULT (''),
	PromotionTypeTracking nchar(30) NOT NULL CONSTRAINT DF_BRS_Promotion_PromotionType1 DEFAULT ('')
GO
ALTER TABLE dbo.BRS_Promotion SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
