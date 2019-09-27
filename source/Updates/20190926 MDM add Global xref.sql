-- MDM add Global xref, 26 Sep 19, tmc

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_ItemHistory ADD
	global_product_class char(12) NOT NULL CONSTRAINT DF_BRS_ItemHistory_global_product_class DEFAULT ''
GO
ALTER TABLE dbo.BRS_ItemHistory SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


--

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_ItemHistory ADD CONSTRAINT
	FK_BRS_ItemHistory_global_product FOREIGN KEY
	(
	global_product_class
	) REFERENCES hfm.global_product
	(
	global_product_class
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_ItemHistory SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


--

SELECT        top 1000
h.Item, h.FiscalMonth, h.MinorProductClass, icat.global_product_class
FROM            BRS_ItemHistory AS h INNER JOIN
                         BRS_Item AS i ON h.Item = i.Item INNER JOIN
                         BRS_ItemCategory AS icat ON i.MinorProductClass = icat.MinorProductClass
where h.Item <> '' and icat.global_product_class <> ''

-- update history map based on current global mapping

UPDATE       BRS_ItemHistory
SET                global_product_class = icat.global_product_class
FROM            BRS_ItemHistory INNER JOIN
                         BRS_Item AS i ON BRS_ItemHistory.Item = i.Item INNER JOIN
                         BRS_ItemCategory AS icat ON i.MinorProductClass = icat.MinorProductClass
WHERE        (BRS_ItemHistory.Item <> '') AND (icat.global_product_class <> '')
