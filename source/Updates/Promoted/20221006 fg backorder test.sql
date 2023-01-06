-- backorder mock-up

SELECT

[IMBUYR_buyer_number]
,[QN$SPC_supplier_code]						
,[SDLITM_item_number]
,[SDDSC1_description]
,[QV$PRI_pricing_info]
,[QV$AVC_availability_code]
,[QV$CLC_classification_code]
,[SDUPRC_unit_price]
,[SDUORG_quantity]
,[SDSOBK_quantity_backordered]
,[SDLNTY_line_type]
,[IMLNTY_line_type]
,[QCAC10_division_code]
,[SDMCU__business_unit]
,[SDDOC__document_number]
,[SDDOCO_salesorder_number]
,[SDDCTO_order_type]
,[SDLNID_line_number]
,[QCTRDJ_order_date]
,[SDVR01_reference]
,[SDVR02_reference_2]
,[QCENTB_entered_by]
,[SDSHAN_shipto]
,[SDSHAN01_mailing_name]
,null as billto
,null as btname
,[GIADDZ_postal_code]
,[GICTY1_city]
,[GIADDS_state]
,[GICTR__country]
,[SDRSDJ_promised_delivery]
,[SDNXTR_status_code_next]

FROM
	[fg].[backorder_FBACKRPT1_history] t

	INNER JOIN [dbo].[BRS_Item] i
	ON t.[SDLITM_item_number] = i.item

	INNER JOIN [dbo].[BRS_Customer] c
	ON t.[SDSHAN_shipto] = c.ShipTo

WHERE
	(t.SalesDay ='2022-10-05') AND

	-- manual removes slow
	--(t.Item > '0') AND
	-- remove restocking
	-- (t.SalesOrderNumber = 14651893) AND
	(1=1)

