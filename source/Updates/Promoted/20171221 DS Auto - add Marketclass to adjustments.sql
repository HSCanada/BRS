-- add Marketclass to adjustments, tmc, 21 Dec 17

ALTER TABLE Integration.account_adjustment_F0911 ADD
	MarketClass char(6) NULL
GO

BEGIN TRANSACTION
GO
ALTER TABLE hfm.account_adjustment_F0911 ADD
	MarketClass char(6) NULL
GO
ALTER TABLE hfm.account_adjustment_F0911 ADD CONSTRAINT
	FK_account_adjustment_F0911_BRS_CustomerMarketClass FOREIGN KEY
	(
	MarketClass
	) REFERENCES dbo.BRS_CustomerMarketClass
	(
	MarketClass
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE hfm.account_adjustment_F0911 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


