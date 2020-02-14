--mdm back propogate item class, tmc, 18 Nov 19

-- Do this with Special Markets restate

UPDATE       BRS_ItemHistory
SET                global_product_class = BRS_ItemCategory.global_product_class
FROM
	BRS_ItemHistory  INNER JOIN
    BRS_ItemCategory  ON BRS_ItemHistory.MinorProductClass = BRS_ItemCategory.MinorProductClass
WHERE
(BRS_ItemHistory.Item > '') AND 
BRS_ItemHistory.global_product_class <> BRS_ItemCategory.global_product_class  AND
(BRS_ItemHistory.FiscalMonth >= 201801)


--

UPDATE       BRS_ItemHistory
SET                [MinorProductClass] = i.[MinorProductClass]
FROM
	BRS_ItemHistory  INNER JOIN
     [dbo].[BRS_Item] i ON BRS_ItemHistory.Item = i.item
WHERE
(BRS_ItemHistory.Item > '') AND 
BRS_ItemHistory.MinorProductClass <> i.MinorProductClass  AND
(BRS_ItemHistory.FiscalMonth >= 201801)

