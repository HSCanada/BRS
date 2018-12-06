
-- eps - add public exclusive code
-- allow renames for cube
-- updated 29 Nov 18

ALTER TABLE hfm.exclusive_product ADD
	Excl_Code_Public nchar(20) NOT NULL CONSTRAINT DF_exclusive_product_Excl_Code_Public DEFAULT ''
GO
ALTER TABLE hfm.exclusive_product SET (LOCK_ESCALATION = TABLE)
GO

UPDATE hfm.exclusive_product
SET Excl_Code_Public = Excl_Code
GO

UPDATE hfm.exclusive_product
SET Excl_Code_Public = 'BA'
where Excl_Code = 'BAINTE'
