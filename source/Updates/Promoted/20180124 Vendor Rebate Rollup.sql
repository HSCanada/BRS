-- Vendor Rebate rollup, tmc, 24 Jan 18

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_ItemSupplier ADD
	RebateRollup nvarchar(30) NOT NULL CONSTRAINT DF_BRS_ItemSupplier_RebateRollup DEFAULT (''),
	RebateRollupNote nvarchar(50) NULL
GO
COMMIT

-- update data (pre loaded)

UPDATE       BRS_ItemSupplier
SET                RebateRollup = zzzItem.Note1, 
					RebateRollupNote = getdate()
FROM            BRS_ItemSupplier INNER JOIN
                         zzzItem ON BRS_ItemSupplier.Supplier = zzzItem.Item