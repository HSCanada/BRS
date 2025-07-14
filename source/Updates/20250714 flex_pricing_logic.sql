-- flex_pricing_logic, tmc, 14 Jul 25

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_CustomerVPA ADD
	flex_jde_pricing_ind bit NOT NULL CONSTRAINT DF_BRS_CustomerVPA_flex_jde_pricing_ind DEFAULT 0
GO
ALTER TABLE dbo.BRS_CustomerVPA SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

select * from [dbo].[BRS_CustomerVPA] where VPA in ('ALEXYEH', '123DNST','DENCORP')

UPDATE  BRS_CustomerVPA 
SET        flex_jde_pricing_ind = 1
WHERE   (VPA IN ('ALEXYEH', '123DNST', 'DENCORP'))
GO
