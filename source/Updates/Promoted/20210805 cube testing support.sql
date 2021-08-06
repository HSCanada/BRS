--cube testing support, tmc, 5 Aug 21

BEGIN TRANSACTION
GO
ALTER TABLE hfm.global_product ADD
	GLBU_Class_map char(5) NOT NULL CONSTRAINT DF_global_product_GLBU_Class DEFAULT ''
GO
ALTER TABLE hfm.global_product ADD CONSTRAINT
	FK_global_product_BRS_BusinessUnitClass FOREIGN KEY
	(
	GLBU_Class_map
	) REFERENCES dbo.BRS_BusinessUnitClass
	(
	GLBU_Class
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE hfm.global_product SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
