-- backorder, tmc, 2 Sept 21
--------------------------------------------------------------------------------
-- DROP TABLE Integration.FBACKRPT1_backorder
--------------------------------------------------------------------------------

SELECT 

--    Top 500 
    "IMBUYR" AS IMBUYR_buyer_number, "QN$SPC" AS QN$SPC_supplier_code, "SDLITM" AS SDLITM_item_number, "SDDSC1" AS SDDSC1_description, "QV$PRI" AS QV$PRI_pricing_info, "QV$AVC" AS QV$AVC_availability_code, "QV$CLC" AS QV$CLC_classification_code, "SDUPRC" AS SDUPRC_unit_price, "SDUORG" AS SDUORG_quantity, "SDSOBK" AS SDSOBK_quantity_backordered, "SDLNTY" AS SDLNTY_line_type, "IMLNTY" AS IMLNTY_line_type, "QCAC10" AS QCAC10_division_code, "SDMCU" AS SDMCU__business_unit, "SDDOC" AS SDDOC__document_number, "SDDOCO" AS SDDOCO_salesorder_number, "SDDCTO" AS SDDCTO_order_type, "SDLNID" AS SDLNID_line_number, CONVERT(date,"QCTRDJ") AS QCTRDJ_order_date, "SDVR01" AS SDVR01_reference, "SDVR02" AS SDVR02_reference_2, "QCENTB" AS QCENTB_entered_by, "SDSHAN" AS SDSHAN_shipto, "SDSHAN01" AS SDSHAN01_mailing_name, "SDAN8" AS SDAN8__billto, "SDAN801" AS SDAN801_mailing_name, "GIADDZ" AS GIADDZ_postal_code, "GICTY1" AS GICTY1_city, "GICOUN" AS GICOUN_county, "GIADDS" AS GIADDS_state, "GICTR" AS GICTR__country, CONVERT(date,"SDRSDJ") AS SDRSDJ_promised_delivery, "SDNXTR" AS SDNXTR_status_code_next 

 INTO Integration.FBACKRPT1_backorder

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		IMBUYR, QN$SPC, SDLITM, SDDSC1, QV$PRI, QV$AVC, QV$CLC
		, CAST((SDUPRC)/1.0 AS DEC(15,4)) AS SDUPRC
--		, CAST((SDUPRC)/10000.0 AS DEC(15,4)) AS SDUPRC
		, SDUORG, SDSOBK, SDLNTY, IMLNTY, QCAC10, SDMCU, SDDOC, SDDOCO, SDDCTO
		, CAST((SDLNID)/1.0 AS DEC(15,3)) AS SDLNID
--		, CAST((SDLNID)/1000.0 AS DEC(15,3)) AS SDLNID
		, QCTRDJ
--		, CASE WHEN QCTRDJ IS NOT NULL THEN DATE(DIGITS(DEC(QCTRDJ+ 1900000,7,0))) ELSE NULL END AS QCTRDJ
		, SDVR01, SDVR02, QCENTB, SDSHAN, SDSHAN01, SDAN8, SDAN801, GIADDZ, GICTY1, GICOUN, GIADDS, GICTR
		, SDRSDJ
--		, CASE WHEN SDRSDJ IS NOT NULL THEN DATE(DIGITS(DEC(SDRSDJ+ 1900000,7,0))) ELSE NULL END AS SDRSDJ
		, SDNXTR

	FROM
		HSIUSRFLE.FBACKRPT1
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')


--------------------------------------------------------------------------------
BEGIN TRANSACTION
GO
ALTER TABLE Integration.FBACKRPT1_backorder ADD CONSTRAINT
	FBACKRPT1_backorder_c_pk PRIMARY KEY CLUSTERED 
	(
	SDDOCO_salesorder_number,
	SDDCTO_order_type,
	SDLNID_line_number
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE Integration.FBACKRPT1_backorder SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--

-- prod ready format (add ID after)
SELECT
	c.SalesDateLastWeekly
	SDDOCO_salesorder_number
	,SDDCTO_order_type
	,SDLNID_line_number
	,SDDOC__document_number

	,SDSHAN_shipto
	,SDLITM_item_number
	,QN$SPC_supplier_code
	,QCTRDJ_order_date

	,SDUPRC_unit_price
	,SDSOBK_quantity_backordered
	,SDUORG_quantity

	,IMBUYR_buyer_number
	,SDDSC1_description
	,QV$PRI_pricing_info
	,QV$AVC_availability_code
	,QV$CLC_classification_code

	,SDSHAN01_mailing_name
	,GIADDZ_postal_code
	,GICTY1_city
	,GIADDS_state
	,GICTR__country
	,QCAC10_division_code

	,SDLNTY_line_type
	,IMLNTY_line_type
	,SDMCU__business_unit
	,SDVR01_reference
	,SDVR02_reference_2
	,QCENTB_entered_by
	,SDRSDJ_promised_delivery
	,SDNXTR_status_code_next

FROM
	Integration.FBACKRPT1_backorder
	CROSS JOIN
	[dbo].[BRS_Config] c

WHERE
	(SDSOBK_quantity_backordered <> 0) AND
	(SDLNTY_line_type <> 'MS') AND
	(QCAC10_division_code <> 'AZA') AND
	(1=1)




