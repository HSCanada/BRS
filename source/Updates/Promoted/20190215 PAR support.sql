

-- add cf for gloves here...

ALTER TABLE dbo.BRS_Item ADD
	size_factor smallint NOT NULL CONSTRAINT DF_BRS_Item_size_factor DEFAULT 0
GO


SELECT        Item, size_factor, Size, SubMajorProdClass, CurrentFileCost, CurrentCorporatePrice
FROM            BRS_Item
WHERE        (SubMajorProdClass = '054-03')

delete from [dbo].[zzzItem]

-- add manually

UPDATE       BRS_Item
SET size_factor = CAST(zzzItem.Note1 AS int)
FROM            BRS_Item INNER JOIN
                         zzzItem ON BRS_Item.Item = zzzItem.Item


SELECT
	ItemKey, 
	Item, 
	SubMajorProdClass, 
	Size, 
	size_factor
FROM
	BRS_Item
WHERE
	Item = '1127017'

