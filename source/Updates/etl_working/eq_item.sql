SELECT   
	i.item
--	,i.FamilySetLeader
	,i.ItemDescription
	,i.Strength
	,i.Size

	,i.Supplier

	,icat.[subminor_cd]	
	,RTRIM(icat.[major_desc]) + ' | ' + RTRIM(icat.submajor_desc) + ' | ' + RTRIM(icat.minor_desc) + ' | ' + RTRIM(icat.subminor_desc) product_class_descr

	,ISNULL(eicat.[subminor_cd],'.') subminor_cd_us
	,ISNULL(RTRIM(eicat.[major_desc]) + ' | ' + RTRIM(eicat.submajor_desc) + ' | ' + RTRIM(eicat.minor_desc) + ' | ' + RTRIM(eicat.subminor_desc),'.') product_class_descr_us

	,rtrim(glob.global_product_class) + ' | ' 
		+ glob.global_product_class_descr					as product_class_descr_global
	,i.comm_group_cd


	,i.CurrentCorporatePrice

	,i.Est12MoSales



FROM
	BRS_Item AS i 
	
	LEFT JOIN [hfm].[global_product_map] AS icat 
	ON i.[SubMinorProductCodec] = icat.[subminor_id]

	LEFT JOIN [hfm].[global_product] glob
	ON SUBSTRING(icat.global_product_class,1,3)= glob.global_product_class

	LEFT JOIN [usd].[BRS_Item] ei
	ON i.item = ei.Item

	LEFT JOIN [hfm].[global_product_map] AS eicat 
	ON ei.[SubMinorProductCodec] = eicat.[subminor_id]


WHERE   
--	(m.active_ca_ind = 1) AND 
	-- remove Purged, discontinued items
	(i.ItemStatus not in ('P','D')) AND
	(
		(i.MajorProductClass in ('071','341','344','373','800','826','840','845','850')) or
		(i.comm_group_cd in ('DIGCCS', 'DIGCIM', 'DIGIMP', 'DIGLAB')) 
	) and

--	(s.item_subst <> '') AND
--	(s.item <> s.item_subst) AND
	(1 = 1)
