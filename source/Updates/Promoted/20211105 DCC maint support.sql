-- DCC maint support, tmc, 5 Nov 

BEGIN TRANSACTION
GO
ALTER TABLE Pricing.item_price_dcc ADD
	CurrentPrice_prior money NULL,
	UnitChargeback_prior money NULL,
	status_cd smallint NOT NULL CONSTRAINT DF_item_price_dcc_status_cd DEFAULT -1
GO
ALTER TABLE Pricing.item_price_dcc ADD CONSTRAINT
	DF_item_price_dcc_UnitChargeback1 DEFAULT ((0)) FOR UnitChargeback_prior
GO
ALTER TABLE Pricing.item_price_dcc SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

UPDATE Pricing.item_price_dcc
SET status_cd = 0
GO
