SELECT
    LTrim(RTrim(i.Item)) AS Item

    ,i.ItemDescription
    ,LTrim(RTrim(i.FamilySetLeader)) AS FamilySetLeader
    ,i.Strength
	,f4101.IMSLD__shelf_life_days
	,ISNULL(NPFIMS.IMLOCT_location_type, '') AS IMLOCT_location_type
	,i.ManufPartNumber
    ,i.Size
    ,i.MajorProductClass
	,f4101.IMPRP4_tax_classification
    ,i.Label
    ,i.Brand
    ,i.Supplier
	,f4101.IMBUYR_buyer_number
    ,ih.Currency

-- ok?
	,ISNULL(NPFIMS.IMCLSC_class_code,'') AS IMCLSC_class_code

	,f4101.IMLNTY_line_type
	,i.StockingType
	,i.GLCategory

	,'.' as Pricing_Info

	,f4101.IMBACK_backorders_allowed_yn
	,f4101.IMCKAV_check_availability_yn
	,f4101.IMSRP5_hazardous_class

	,f4101.IMINMG_print_message

    ,ih.SupplierCost
    ,i.FreightAdjPct
    ,i.CorporateMarketAdjustmentPct
    ,ih.CorporatePrice
    ,ih.SellQtyBrk2
    ,ih.SellQtyBrk3
    ,i.ItemStatus

	,i.Est12MoSales

	-- pricing info (note)




FROM
	BRS_Item i

	LEFT JOIN [Integration].[F4101_item_master_Staging] f4101
	ON i.item = f4101.IMLITM_item_number

	LEFT JOIN [Integration].[NPFIMS_item_wcs_Staging] NPFIMS
	ON i.Item = NPFIMS.IMITEM_item_number

	LEFT JOIN STAGE_BRS_ItemBaseHistory ih
		ON i.Item = ih.Item AND
			ih.CalMonth = 0

-- WHERE
	--i.item like '100%' -- in('9401155', '1900351', '1025354', '5840186') -- like '100%'

-- ORDER BY i.Item