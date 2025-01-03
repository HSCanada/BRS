SELECT   
	TOP (100) 

	RTRim(i.Item) as Item
	,i.ItemDescription
	,i.Size
	,i.Strength
	,i.MajorProductClass
	,i.Supplier
	,i.Brand
	,RTrim(i.FamilySetLeader) as FamilySetLeader
	,i.CurrentFileCost
	,RTrim(mpc.MajorProductClassDesc) as MajorProductClassDesc
	,icube.IMHEIG_height as height_cm
	,icube.IMWIDT_width as width_cm
	,icube.IMLENG_length as length_cm
	,icube.IMHEIG_height * icube.IMWIDT_width * icube.IMLENG_length as CC

	,icube.IMWEIG_weight as weight_lb

	,i.CorporateMarketAdjustmentPct
	,i.FreightAdjPct
	,i.CurrentCorporatePrice

	,i.Label
	,i.StockingType
	,(RTrim(i.SalesCategory)) SalesCategory
	,i.MinorProductClass

	,i.Est12MoSales
	,i.ItemCreationDate

FROM
	BRS_Item AS i 
	INNER JOIN BRS_ItemMPC AS mpc 
	ON i.MajorProductClass = mpc.MajorProductClass 
	
	LEFT OUTER JOIN Integration.NPFIMS_item_wcs_Staging AS icube 
	ON i.Item = icube.IMITEM_item_number

WHERE
	(i.ItemStatus <> 'P') AND 
	(i.Supplier like 'DENTZA') AND
	(i.SalesCategory = 'MERCH') AND
--	(i.MajorProductClass = '013') AND
--	(i.Item in('1042849', '1043730', '1047321', '1127252', '5838765') ) AND
--	(i.Item<>'1677197') AND
	(1=1)
order by ItemCreationDate desc

-- step 1.   add code (active)
-- step 2.   not avail for purch but still avil (disc)
-- step 3.	 project dead / purge