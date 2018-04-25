-- Fix BRS_BusinessUnit-GLBU_Class RI
-- 25 Apr 18

ALTER TABLE dbo.BRS_BusinessUnit ADD CONSTRAINT
	FK_BRS_BusinessUnit_BRS_BusinessUnitClass FOREIGN KEY
	(
	GLBU_Class
	) REFERENCES dbo.BRS_BusinessUnitClass
	(
	GLBU_Class
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 

	
GO

UPDATE       BRS_BusinessUnit
SET                GLBU_Class = 'HICAD'
WHERE        (BusinessUnit = '020024001003')

-- DELETE FROM  [dbo].[BRS_Transaction] WHERE [SalesDate] = '20180417'

-- SELECT * FROM  [dbo].[BRS_Transaction] WHERE [SalesOrderNumberKEY] = 11253680

