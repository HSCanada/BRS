-- Medical Market adj except, tmc 4 Feb 22

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_ItemCategory ADD
	ma_exception_factor float(53) NOT NULL CONSTRAINT DF_BRS_ItemCategory_ma_exception_factor DEFAULT 0
GO
ALTER TABLE dbo.BRS_ItemCategory SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

UPDATE       BRS_ItemCategory
SET                ma_exception_factor = - 0.1
WHERE        (MinorProductClass IN ('200-02-79', '200-04-79', '200-06-79', '200-08-79', '200-18-79', '200-22-79', '200-26-79', '200-30-79', '200-44-79', '200-46-79', '200-66-79', '200-68-79', '201-15-79', '203-16-79', '203-18-79', '203-20-79', 
                         '203-22-79', '203-26-79', '203-28-79', '203-32-79', '203-38-79', '203-40-79', '203-46-79', '203-50-79', '203-58-79', '203-66-79', '204-05-79', '204-10-79', '204-15-79', '205-16-79', '205-18-79', '205-20-79', '205-42-79', '205-48-79', 
                         '205-50-79', '205-64-79', '205-68-79', '205-76-79', '205-87-79', '207-40-79', '207-55-79', '210-45-79'))

-- test
SELECT MinorProductClass, ma_exception_factor from BRS_ItemCategory
WHERE ma_exception_factor <> 0
