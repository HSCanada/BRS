-- 


BEGIN TRANSACTION
GO
CREATE TABLE Pricing.item_tariff
	(
	Item char(10) NOT NULL,
	FreightAdjPct_prior float(53) NOT NULL,
	CorporateMarketAdjustmentPct_prior float(53) NOT NULL,
	FreightAdjPct_tarrif float(53) NOT NULL,
	src_file nvarchar(50) NULL,
	note nvarchar(50) NULL,
	active_ind bit default (1)
	)  ON USERDATA
GO
ALTER TABLE Pricing.item_tariff ADD CONSTRAINT
	PK_item_tariff PRIMARY KEY CLUSTERED 
	(
	Item
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE Pricing.item_tariff ADD CONSTRAINT
	FK_item_tariff_BRS_Item FOREIGN KEY
	(
	Item
	) REFERENCES dbo.BRS_Item
	(
	Item
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE Pricing.item_tariff SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- test
/*
insert into [Pricing].[item_tariff]
([Item], [FreightAdjPct_prior], [CorporateMarketAdjustmentPct_prior], [FreightAdjPct_tarrif], [src_file], [note])
SELECT        Item, FreightAdjPct, CorporateMarketAdjustmentPct,10, 'test_file', 'test note'
FROM            BRS_ItemMarketAdjustFix
GO

*/
