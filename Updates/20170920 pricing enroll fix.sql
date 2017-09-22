
BEGIN TRANSACTION
GO
ALTER TABLE Pricing.price_adjustment_enroll
	DROP CONSTRAINT price_adjustment_enroll_pk
GO
ALTER TABLE Pricing.price_adjustment_enroll ADD CONSTRAINT
	price_adjustment_enroll_pk PRIMARY KEY CLUSTERED 
	(
	BillTo,
	PriceMethod
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE Pricing.price_adjustment_enroll SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

Alter Table Pricing.price_adjustment_enroll
Add ID Int Identity(1, 1)
Go
