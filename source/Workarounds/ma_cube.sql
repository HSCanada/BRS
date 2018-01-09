SELECT        
TOP (10) 
i.Item, i.FamilySetLeader, i.ItemDescription, i.Supplier, s.SupplierFamily, sf.buying_group_cd, b.Currency, i.ItemStatus, i.Label, i.[StockingType], i.SalesCategory, 
                         c.major_cd, c.major_desc, c.submajor_cd, c.submajor_desc, i.Est12MoSales, w.IMWEIG_weight, i.CurrentCorporatePrice, i.CurrentFileCost, i.FreightAdjPct, 
                         i.CorporateMarketAdjustmentPct
FROM            BRS_Item AS i INNER JOIN
                         Integration.NPFIMS_item_wcs_Staging AS w ON i.Item = w.IMITEM_item_number INNER JOIN
                         BRS_ItemCategory AS c ON i.MinorProductClass = c.MinorProductClass INNER JOIN
                         BRS_ItemBaseHistory AS b ON i.Item = b.Item INNER JOIN
                         BRS_ItemSupplier AS s ON i.Supplier = s.Supplier INNER JOIN
                         BRS_ItemSupplierFamily AS sf ON s.SupplierFamily = sf.SupplierFamily
WHERE        
	(b.CalMonth = 0) AND
	(i.ItemStatus <>'P') AND
	(i.item NOT like '105%') AND
	(1=1)



