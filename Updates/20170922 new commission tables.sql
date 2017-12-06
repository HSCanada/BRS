
-- Add objects to BRSales

/****** Object:  Schema [comm]    Script Date: 11/16/2017 8:21:08 PM ******/
CREATE SCHEMA [comm]
GO

-- DROP TABLE Integration.F55510_customer_territory_Staging

SELECT 

--    Top 5 
    "WRCO" AS WRCO___company,
	"WR$GTC" AS WR$GTC_group_type_category,
	"WR$GTY" AS WR$GTY_group_type,
	"WR$VNO" AS WR$VNO_number_version,
	"WR$SLO" AS WR$SLO_sales_organization,
	"WRAC10" AS WRAC10_division_code,
	"WR$TER" AS WR$TER_territory_code,
	"WR$L01" AS WR$L01_level_code_01,
	"WR$L02" AS WR$L02_level_code_02,
	"WR$L03" AS WR$L03_level_code_03,
	"WR$L04" AS WR$L04_level_code_04,
	"WR$L05" AS WR$L05_level_code_05,
	"WR$L06" AS WR$L06_level_code_06,
	"WR$L07" AS WR$L07_level_code_07,
	"WR$L08" AS WR$L08_level_code_08,
	"WR$L09" AS WR$L09_level_code_09,
	"WR$L10" AS WR$L10_level_code_10,
	"WR$K01" AS WR$K01_level_id01,
	"WR$K02" AS WR$K02_level_id02,
	"WR$K03" AS WR$K03_level_id03,
	"WR$K04" AS WR$K04_level_id04,
	"WR$K05" AS WR$K05_level_id05,
	"WR$K06" AS WR$K06_level_id06,
	"WR$K07" AS WR$K07_level_id07,
	"WR$K08" AS WR$K08_level_id08,
	"WR$K09" AS WR$K09_level_id09,
	"WR$K10" AS WR$K10_level_id10,
	"WRTKBY" AS WRTKBY_order_taken_by,
	"WR$CGN" AS WR$CGN_customer_group,
	"WR$CLS" AS WR$CLS_classification_code,
	"WRAN8" AS WRAN8__billto,
	"WRSHAN" AS WRSHAN_shipto,
	"WRNAME" AS WRNAME_name,
	"WREFFF" AS WREFFF_effective_from_date,
	"WREFFT" AS WREFFT_effective_thru_date,
	"WRUSER" AS WRUSER_user_id,
	"WRPID" AS WRPID__program_id,
	"WRJOBN" AS WRJOBN_work_station_id,
	"WRUPMJ" AS WRUPMJ_date_updated,
	"WRUPMT" AS WRUPMT_time_last_updated 

 INTO Integration.F55510_customer_territory_Staging

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		WRCO,
		WR$GTC,
		WR$GTY,
		WR$VNO,
		WR$SLO,
		WRAC10,
		WR$TER,
		WR$L01,
		WR$L02,
		WR$L03,
		WR$L04,
		WR$L05,
		WR$L06,
		WR$L07,
		WR$L08,
		WR$L09,
		WR$L10,
		WR$K01,
		WR$K02,
		WR$K03,
		WR$K04,
		WR$K05,
		WR$K06,
		WR$K07,
		WR$K08,
		WR$K09,
		WR$K10,
		WRTKBY,
		WR$CGN,
		WR$CLS,
		WRAN8,
		WRSHAN,
		WRNAME,
		CASE WHEN WREFFF IS NOT NULL THEN DATE(DIGITS(DEC(WREFFF+ 1900000,7,0))) ELSE NULL END AS WREFFF,
		CASE WHEN WREFFT IS NOT NULL THEN DATE(DIGITS(DEC(WREFFT+ 1900000,7,0))) ELSE NULL END AS WREFFT,
		WRUSER,
		WRPID,
		WRJOBN,
		CASE WHEN WRUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(WRUPMJ+ 1900000,7,0))) ELSE NULL END AS WRUPMJ,
		WRUPMT

	FROM
		ARCPDTA71.F55510
	WHERE
		WREFFF <= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) AND 		
		WREFFT >= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3))  		

--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

ALTER TABLE Integration.F55510_customer_territory_Staging ADD CONSTRAINT
	idx_F55510_customer_territory_Staging_c_pk PRIMARY KEY CLUSTERED 
	(
	WRSHAN_shipto,
	WR$TER_territory_code
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO


ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD
	source_cd char(3) NOT NULL CONSTRAINT DF_F555115_commission_sales_extract_Staging_source_cd DEFAULT ('')
GO




SELECT 

    Top 5 
    "WSCO" AS WSCO___company,
	"WSDOCO" AS WSDOCO_salesorder_number,
	"WSDCTO" AS WSDCTO_order_type,
	"WSLNTY" AS WSLNTY_line_type,
	"WSLNID" AS WSLNID_line_number,
	"WS$OSC" AS WS$OSC_order_source_code,
	"WSAN8" AS WSAN8__billto,
	"WSSHAN" AS WSSHAN_shipto,
	"WSDGL" AS WSDGL__gl_date,
	"WSLITM" AS WSLITM_item_number,
	"WSDSC1" AS WSDSC1_description,
	"WSDSC2" AS WSDSC2_description_2,
	"WSSRP1" AS WSSRP1_major_product_class,
	"WSSRP2" AS WSSRP2_sub_major_product_class,
	"WSSRP3" AS WSSRP3_minor_product_class,
	"WSSRP6" AS WSSRP6_manufacturer,
	"WSUORG" AS WSUORG_quantity,
	"WSSOQS" AS WSSOQS_quantity_shipped,
	"WSAEXP" AS WSAEXP_extended_price,
	"WSURAT" AS WSURAT_user_reserved_amount,
	"WS$UNC" AS WS$UNC_sales_order_cost_markup,
	"WSOORN" AS WSOORN_original_order_number,
	"WSOCTO" AS WSOCTO_original_order_type,
	"WSOGNO" AS WSOGNO_original_line_number,
	"WSTRDJ" AS WSTRDJ_order_date,
	"WSVR01" AS WSVR01_reference,
	"WSVR02" AS WSVR02_reference_2,
	"WSITM" AS WSITM__item_number_short,
	"WSPROV" AS WSPROV_price_override_code,
	"WSASN" AS WSASN__adjustment_schedule,
	"WSKCO" AS WSKCO__document_company,
	"WSDOC" AS WSDOC__document_number,
	"WSDCT" AS WSDCT__document_type,
	"WSPSN" AS WSPSN__pick_slip_number,
	"WSROUT" AS WSROUT_ship_method,
	"WSZON" AS WSZON__zone_number,
	"WSFRTH" AS WSFRTH_freight_handling_code,
	"WSFRAT" AS WSFRAT_rate_code_freightmisc,
	"WSRATT" AS WSRATT_rate_type_freightmisc,
	"WSGLC" AS WSGLC__gl_offset,
	"WSSO08" AS WSSO08_price_adjustment_line_indicator,
	"WSENTB" AS WSENTB_entered_by,
	"WS$PMC" AS WS$PMC_promotion_code_price_method,
	"WSTKBY" AS WSTKBY_order_taken_by,
	"WSKTLN" AS WSKTLN_kit_master_line_number,
	"WSCOMM" AS WSCOMM_committed_hs,
	"WSEMCU" AS WSEMCU_header_business_unit,
	"WS$SPC" AS WS$SPC_supplier_code,
	"WS$VCD" AS WS$VCD_vendor_code,
	"WS$CLC" AS WS$CLC_classification_code,
	"WSCYCL" AS WSCYCL_cycle_count_category,
	"WSORD" AS WSORD__equipment_order,
	"WSORDT" AS WSORDT_order_type,
	"WSCAG" AS WSCAG__cagess_code,
	"WSEST" AS WSEST__employment_status,
	"WS$ESS" AS WS$ESS_equipment_specialist_code,
	"WS$TSS" AS WS$TSS_tech_specialist_code,
	"WS$CCS" AS WS$CCS_cadcam_specialist_code,
	"WS$NM1" AS WS$NM1__name_1,
	"WS$NM3" AS WS$NM3_researched_by,
	"WS$NM4" AS WS$NM4_completed_by,
	"WS$NM5" AS WS$NM5__name_5,
	"WS$L01" AS WS$L01_level_code_01,
	"WSSRP4" AS WSSRP4_sub_minor_product_class,
	"WSCITM" AS WSCITM_customersupplier_item_number,
	"WSSIC" AS WSSIC__speciality,
	"WSAC04" AS WSAC04_practice_type,
	"WSAC10" AS WSAC10_division_code,
	"WS$O01" AS WS$O01_number_equipment_serial_01,
	"WS$O02" AS WS$O02_number_equipment_serial_02,
	"WS$O03" AS WS$O03_number_equipment_serial_03,
	"WS$O04" AS WS$O04_number_equipment_serial_04,
	"WS$O05" AS WS$O05_number_equipment_serial_05,
	"WS$O06" AS WS$O06_number_equipment_serial_06,
	"WSDL03" AS WSDL03_description_03,
	"WS$ODS" AS WS$ODS_order_discount_amount 

-- INTO Integration.F555115_commission_sales_extract_Staging

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		WSCO,
		WSDOCO,
		WSDCTO,
		WSLNTY,
		CAST((WSLNID)/1000.0 AS DEC(15,3)) AS WSLNID,
		WS$OSC,
		WSAN8,
		WSSHAN,
		CASE WHEN WSDGL IS NOT NULL THEN DATE(DIGITS(DEC(WSDGL+ 1900000,7,0))) ELSE NULL END AS WSDGL,
		WSLITM,
		WSDSC1,
		WSDSC2,
		WSSRP1,
		WSSRP2,
		WSSRP3,
		WSSRP6,
		WSUORG,
		WSSOQS,
		CAST((WSAEXP)/100.0 AS DEC(15,2)) AS WSAEXP,
		CAST((WSURAT)/100.0 AS DEC(15,2)) AS WSURAT,
		CAST((WS$UNC)/10000.0 AS DEC(15,4)) AS WS$UNC,
		WSOORN,
		WSOCTO,
		CAST((WSOGNO)/1000.0 AS DEC(15,3)) AS WSOGNO,
		CASE WHEN WSTRDJ IS NOT NULL THEN DATE(DIGITS(DEC(WSTRDJ+ 1900000,7,0))) ELSE NULL END AS WSTRDJ,
		WSVR01,
		WSVR02,
		WSITM,
		WSPROV,
		WSASN,
		WSKCO,
		WSDOC,
		WSDCT,
		WSPSN,
		WSROUT,
		WSZON,
		WSFRTH,
		WSFRAT,
		WSRATT,
		WSGLC,
		WSSO08,
		WSENTB,
		WS$PMC,
		WSTKBY,
		CAST((WSKTLN)/1000.0 AS DEC(15,3)) AS WSKTLN,
		WSCOMM,
		WSEMCU,
		WS$SPC,
		WS$VCD,
		WS$CLC,
		WSCYCL,
		WSORD,
		WSORDT,
		WSCAG,
		WSEST,
		WS$ESS,
		WS$TSS,
		WS$CCS,
		WS$NM1,
		WS$NM3,
		WS$NM4,
		WS$NM5,
		WS$L01,
		WSSRP4,
		WSCITM,
		WSSIC,
		WSAC04,
		WSAC10,
		WS$O01,
		WS$O02,
		WS$O03,
		WS$O04,
		WS$O05,
		WS$O06,
		WSDL03,
		CAST((WS$ODS)/100.0 AS DEC(15,2)) AS WS$ODS

	FROM
		ARCPDTA71.F555115
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

/*
SELECT        WSDOCO_salesorder_number, WSDCTO_order_type, WSLNID_line_number, COUNT(*) AS Expr1
FROM            Integration.F555115_commission_sales_extract_Staging AS s
GROUP BY WSDOCO_salesorder_number, WSDCTO_order_type, WSLNID_line_number
HAVING        (COUNT(*) > 1)
*/

ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	F555115_commission_sales_extract_Staging_c_pk PRIMARY KEY CLUSTERED 
	(
	WSDOCO_salesorder_number,
	WSDCTO_order_type,
	WSLNID_line_number
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO

BEGIN TRANSACTION
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSCO___company DEFAULT ('') FOR WSCO___company
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSLNTY_line_type DEFAULT ('') FOR WSLNTY_line_type
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSAN8__billto DEFAULT (0) FOR WSAN8__billto
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSSHAN_shipto DEFAULT (0) FOR WSSHAN_shipto
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSLITM_item_number DEFAULT ('') FOR WSLITM_item_number
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSDSC1_description DEFAULT ('') FOR WSDSC1_description
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSDSC2_description_2 DEFAULT ('') FOR WSDSC2_description_2
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSSRP1_major_product_class DEFAULT ('') FOR WSSRP1_major_product_class
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSSRP2_sub_major_product_class DEFAULT ('') FOR WSSRP2_sub_major_product_class
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSSRP3_minor_product_class DEFAULT ('') FOR WSSRP3_minor_product_class
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSSRP6_manufacturer DEFAULT ('') FOR WSSRP6_manufacturer
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSUORG_quantity DEFAULT (0) FOR WSUORG_quantity
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSSOQS_quantity_shipped DEFAULT (0) FOR WSSOQS_quantity_shipped
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSAEXP_extended_price DEFAULT (0) FOR WSAEXP_extended_price
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSURAT_user_reserved_amount DEFAULT (0) FOR WSURAT_user_reserved_amount
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WS$UNC_sales_order_cost_markup DEFAULT (0) FOR WS$UNC_sales_order_cost_markup
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSOORN_original_order_number DEFAULT ('') FOR WSOORN_original_order_number
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSOCTO_original_order_type DEFAULT ('') FOR WSOCTO_original_order_type
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSOGNO_original_line_number DEFAULT (0) FOR WSOGNO_original_line_number
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSVR01_reference DEFAULT ('') FOR WSVR01_reference
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSVR02_reference_2 DEFAULT ('') FOR WSVR02_reference_2
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSITM__item_number_short DEFAULT (0) FOR WSITM__item_number_short
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSPROV_price_override_code DEFAULT ('') FOR WSPROV_price_override_code
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSASN__adjustment_schedule DEFAULT ('') FOR WSASN__adjustment_schedule
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSKCO__document_company DEFAULT ('') FOR WSKCO__document_company
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSDOC__document_number DEFAULT (0) FOR WSDOC__document_number
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSDCT__document_type DEFAULT ('') FOR WSDCT__document_type
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSPSN__pick_slip_number DEFAULT (0) FOR WSPSN__pick_slip_number
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSROUT_ship_method DEFAULT ('') FOR WSROUT_ship_method
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSZON__zone_number DEFAULT ('') FOR WSZON__zone_number
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSFRTH_freight_handling_code DEFAULT ('') FOR WSFRTH_freight_handling_code
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSFRAT_rate_code_freightmisc DEFAULT ('') FOR WSFRAT_rate_code_freightmisc
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSRATT_rate_type_freightmisc DEFAULT ('') FOR WSRATT_rate_type_freightmisc
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSGLC__gl_offset DEFAULT ('') FOR WSGLC__gl_offset
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSSO08_price_adjustment_line_indicator DEFAULT ('') FOR WSSO08_price_adjustment_line_indicator
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSENTB_entered_by DEFAULT ('') FOR WSENTB_entered_by
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WS$PMC_promotion_code_price_method DEFAULT ('') FOR WS$PMC_promotion_code_price_method
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSTKBY_order_taken_by DEFAULT ('') FOR WSTKBY_order_taken_by
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSKTLN_kit_master_line_number DEFAULT (0) FOR WSKTLN_kit_master_line_number
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSCOMM_committed_hs DEFAULT ('') FOR WSCOMM_committed_hs
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSEMCU_header_business_unit DEFAULT ('') FOR WSEMCU_header_business_unit
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WS$SPC_supplier_code DEFAULT ('') FOR WS$SPC_supplier_code
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WS$VCD_vendor_code DEFAULT ('') FOR WS$VCD_vendor_code
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WS$CLC_classification_code DEFAULT ('') FOR WS$CLC_classification_code
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSCYCL_cycle_count_category DEFAULT ('') FOR WSCYCL_cycle_count_category
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSORD__equipment_order DEFAULT ('') FOR WSORD__equipment_order
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSORDT_order_type DEFAULT ('') FOR WSORDT_order_type
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSCAG__cagess_code DEFAULT ('') FOR WSCAG__cagess_code
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSEST__employment_status DEFAULT ('') FOR WSEST__employment_status
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WS$ESS_equipment_specialist_code DEFAULT ('') FOR WS$ESS_equipment_specialist_code
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WS$TSS_tech_specialist_code DEFAULT ('') FOR WS$TSS_tech_specialist_code
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WS$CCS_cadcam_specialist_code DEFAULT ('') FOR WS$CCS_cadcam_specialist_code
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WS$NM1__name_1 DEFAULT ('') FOR WS$NM1__name_1
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WS$NM3_researched_by DEFAULT ('') FOR WS$NM3_researched_by
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WS$NM4_completed_by DEFAULT ('') FOR WS$NM4_completed_by
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WS$NM5__name_5 DEFAULT ('') FOR WS$NM5__name_5
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WS$L01_level_code_01 DEFAULT ('') FOR WS$L01_level_code_01
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSSRP4_sub_minor_product_class DEFAULT ('') FOR WSSRP4_sub_minor_product_class
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSCITM_customersupplier_item_number DEFAULT ('') FOR WSCITM_customersupplier_item_number
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSSIC__speciality DEFAULT ('') FOR WSSIC__speciality
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSAC04_practice_type DEFAULT ('') FOR WSAC04_practice_type
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSAC10_division_code DEFAULT ('') FOR WSAC10_division_code
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WS$O01_number_equipment_serial_01 DEFAULT ('') FOR WS$O01_number_equipment_serial_01
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WS$O02_number_equipment_serial_02 DEFAULT ('') FOR WS$O02_number_equipment_serial_02
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WS$O03_number_equipment_serial_03 DEFAULT ('') FOR WS$O03_number_equipment_serial_03
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WS$O04_number_equipment_serial_04 DEFAULT ('') FOR WS$O04_number_equipment_serial_04
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WS$O05_number_equipment_serial_05 DEFAULT ('') FOR WS$O05_number_equipment_serial_05
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WS$O06_number_equipment_serial_06 DEFAULT ('') FOR WS$O06_number_equipment_serial_06
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WSDL03_description_03 DEFAULT (0) FOR WSDL03_description_03
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	DF_F555115_commission_sales_extract_Staging_WS$ODS_order_discount_amount DEFAULT (0) FOR WS$ODS_order_discount_amount
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- Phase 0 - drop unneeded objects from CommBE


/****** Object:  StoredProcedure [dbo].[comm_transaction_sales_history_calc_proc]    Script Date: 11/18/2017 12:54:48 PM ******/
DROP PROCEDURE [dbo].[comm_transaction_sales_history_calc_proc]
GO

/****** Object:  View [dbo].[zzcomm_ess_statement_export02]    Script Date: 11/18/2017 12:56:36 PM ******/
DROP VIEW 
	comm_eps_region_map, 
	comm_salesperson_RIS_map, 
	zzcomm_ess_statement_export02,
	zzcomm_ess_statement_history,
	zzcomm_rate_map,
	zzcomm_salesperson_category_map,
	zzcomm_statement_detail_all,
	zzcomm_statement_export03,
	zzcomm_statement_summary,
	comm_salesorder_ESS_map,
	comm_salesperson_territory_map
GO


/****** Object:  Table [dbo].[comm_eps_region]    Script Date: 11/18/2017 12:59:22 PM ******/
DROP TABLE 
comm_customer_master_ISR,
comm_eps_productline,
comm_eps_region,
comm_eps_specialist_map,
comm_salesperson_RIS,
comm_transaction_ISR,
zzcomm_group_report,
comm_salesperson_code_map_stage,
comm_transaction_stage,
comm_transaction_external_stage,
zzzCustList,
zzzItemList,
comm_transaction_hsi_stage,
comm_salesperson_master_stage,
STAGE_TransferDoc

ALTER TABLE dbo.comm_batch_control
	DROP CONSTRAINT comm_batch_control_comm_status_code_fk_1
GO
ALTER TABLE dbo.comm_salesperson_master_stage
	DROP CONSTRAINT comm_salesperson_master_stage_comm_status_code_fk_1
GO
ALTER TABLE dbo.comm_transaction
	DROP CONSTRAINT comm_transaction_comm_status_code_fk_1
GO
ALTER TABLE dbo.comm_transaction_external_stage
	DROP CONSTRAINT comm_transaction_external_stage_comm_status_code_fk_1
GO
ALTER TABLE dbo.comm_transaction_stage
	DROP CONSTRAINT comm_transaction_stage_comm_status_code_fk_1
GO

ALTER TABLE dbo.comm_salesperson_master
	DROP CONSTRAINT comm_salesperson_master_comm_salesperson_category_fk_1
GO

DROP TABLE [dbo].[comm_status_code], comm_salesperson_category
GO

-- Phase 1 - add needed tables to BRSales



CREATE TABLE [comm].[source](
	[source_cd] [char](3) NOT NULL,
	[source_desc] [varchar](40) NOT NULL,
	[active_ind] [bit] NOT NULL,
	[creation_dt] [datetime] NOT NULL,
	[source_key] [smallint] NOT NULL identity(1,1),

 CONSTRAINT [comm_source_c_pk] PRIMARY KEY CLUSTERED 
(
	[source_cd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO

ALTER TABLE [comm].[source] ADD  DEFAULT (1) FOR [active_ind]
GO

ALTER TABLE [comm].[source] ADD  DEFAULT (getdate()) FOR [creation_dt]
GO

INSERT        
INTO              comm.[source](source_cd, source_desc)
VALUES        ('', 'Unassigned')

--

CREATE TABLE [comm].[group](
	[comm_group_cd] [char](6) NOT NULL,
	[comm_group_desc] [varchar](40) NOT NULL,
	[source_cd] [char](10) NOT NULL,
	[active_ind] [bit] NOT NULL,
	[creation_dt] [datetime] NOT NULL,
	[comm_calc_rt] [int] NOT NULL,
	[note_txt] [varchar](255) NULL,
	[booking_rt] [float] NOT NULL,
	[SPM_comm_group_cd] [char](6) NOT NULL,
	[show_ind] [bit] NOT NULL,
	[SPM_EQOptOut] [char](1) NOT NULL,
	[sort_id] [smallint] NOT NULL,
	[FRG_comm_group_cd] [char](6) NOT NULL,
	[comm_group_key] [smallint] NOT NULL Identity(1,1),
 CONSTRAINT [comm_group_c_pk] PRIMARY KEY CLUSTERED 
(
	[comm_group_cd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO

ALTER TABLE [comm].[group] ADD  DEFAULT ('') FOR [source_cd]
GO

ALTER TABLE [comm].[group] ADD  DEFAULT (0) FOR [active_ind]
GO

ALTER TABLE [comm].[group] ADD  DEFAULT (getdate()) FOR [creation_dt]
GO

ALTER TABLE [comm].[group] ADD  CONSTRAINT [DF_comm_group_booking_rt]  DEFAULT ((0)) FOR [booking_rt]
GO

ALTER TABLE [comm].[group] ADD  CONSTRAINT [DF_comm_group_comm_calc_rt]  DEFAULT ((0)) FOR [comm_calc_rt]
GO

GO

ALTER TABLE [comm].[group] ADD  CONSTRAINT [DF_comm_group_SPM_comm_group_cd]  DEFAULT ('') FOR [SPM_comm_group_cd]
GO

ALTER TABLE [comm].[group] ADD  CONSTRAINT [DF_comm_group_show_ind]  DEFAULT ((1)) FOR [show_ind]
GO

ALTER TABLE [comm].[group] ADD  CONSTRAINT [DF_comm_group_SPM_EQOptOut]  DEFAULT ('') FOR [SPM_EQOptOut]
GO

ALTER TABLE [comm].[group] ADD  CONSTRAINT [DF_comm_group_sort_id]  DEFAULT ((0)) FOR [sort_id]
GO

ALTER TABLE [comm].[group] ADD  CONSTRAINT [DF_comm_group_SPM_comm_group_cd1]  DEFAULT ('') FOR [FRG_comm_group_cd]
GO

ALTER TABLE [comm].[group]  WITH NOCHECK ADD  CONSTRAINT [comm_group_comm_source_fk_1] FOREIGN KEY([source_cd])
REFERENCES [comm].[source] ([source_cd])
GO

ALTER TABLE [comm].[group] CHECK CONSTRAINT [comm_group_comm_source_fk_1]
GO

ALTER TABLE [comm].[group]  WITH CHECK ADD  CONSTRAINT [FK_comm_group_comm_group] FOREIGN KEY([SPM_comm_group_cd])
REFERENCES [comm].[group] ([comm_group_cd])
GO

ALTER TABLE [comm].[group] CHECK CONSTRAINT [FK_comm_group_comm_group]
GO

ALTER TABLE [comm].[group]  WITH CHECK ADD  CONSTRAINT [FK_comm_group_comm_group1] FOREIGN KEY([FRG_comm_group_cd])
REFERENCES [comm].[group] ([comm_group_cd])
GO

ALTER TABLE [comm].[group] CHECK CONSTRAINT [FK_comm_group_comm_group1]
GO

ALTER TABLE [comm].[group]  WITH CHECK ADD CHECK  (([comm_calc_rt] = 1 or ([comm_calc_rt] = 0 or [comm_calc_rt] = (-1))))
GO

ALTER TABLE dbo.BRS_FiscalMonth ADD
	comm_status_cd smallint NOT NULL CONSTRAINT DF_BRS_FiscalMonth_comm_status_cd DEFAULT (0)
GO

--

CREATE TABLE [comm].[plan](
	[comm_plan_id] [char](10) NOT NULL,
	[comm_plan_nm] [varchar](30) NOT NULL,
	[note_txt] [varchar](255) NULL,
	[active_ind] [bit] NOT NULL,
	[creation_dt] [datetime] NOT NULL,
	[SPM_StatusCd] [char](1) NOT NULL,
	[comm_key] [smallint] NOT NULL identity(1,1),

 CONSTRAINT [comm_plan_c_pk] PRIMARY KEY CLUSTERED 
(
	[comm_plan_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO

ALTER TABLE [comm].[plan] ADD  DEFAULT (1) FOR [active_ind]
GO

ALTER TABLE [comm].[plan] ADD  DEFAULT (getdate()) FOR [creation_dt]
GO

ALTER TABLE [comm].[plan] ADD  CONSTRAINT [DF_comm_plan_SPM_StatusCd]  DEFAULT ('') FOR [SPM_StatusCd]
GO

--


CREATE TABLE [comm].[plan_group_rate](
	[comm_plan_id] [char](10) NOT NULL,
	[comm_group_cd] [char](6) NOT NULL,
	[comm_base_rt] [float] NOT NULL,
	[active_ind] [bit] NOT NULL,
	[creation_dt] [datetime] NOT NULL,
	[note_txt] [varchar](255) NULL,
	[show_ind] [bit] NOT NULL,
 CONSTRAINT [commission_plan_c_pk] PRIMARY KEY CLUSTERED 
(
	[comm_plan_id] ASC,
	[comm_group_cd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO

ALTER TABLE [comm].[plan_group_rate] ADD  DEFAULT (0) FOR [comm_base_rt]
GO

ALTER TABLE [comm].[plan_group_rate] ADD  DEFAULT (0) FOR [active_ind]
GO

ALTER TABLE [comm].[plan_group_rate] ADD  DEFAULT (getdate()) FOR [creation_dt]
GO

ALTER TABLE [comm].[plan_group_rate] ADD  CONSTRAINT [DF_comm_plan_group_rate_show_ind]  DEFAULT ((0)) FOR [show_ind]
GO

ALTER TABLE [comm].[plan_group_rate]  WITH NOCHECK ADD  CONSTRAINT [comm_plan_group_rate_comm_group_fk_1] FOREIGN KEY([comm_group_cd])
REFERENCES [comm].[group] ([comm_group_cd])
GO

ALTER TABLE [comm].[plan_group_rate] CHECK CONSTRAINT [comm_plan_group_rate_comm_group_fk_1]
GO

ALTER TABLE [comm].[plan_group_rate]  WITH NOCHECK ADD  CONSTRAINT [comm_plan_group_rate_comm_plan_fk_1] FOREIGN KEY([comm_plan_id])
REFERENCES [comm].[plan] ([comm_plan_id])
GO

ALTER TABLE [comm].[plan_group_rate] CHECK CONSTRAINT [comm_plan_group_rate_comm_plan_fk_1]
GO

--

CREATE TABLE [Integration].[salesperson_master_Staging](
	[master_salesperson_cd] [char](6) NOT NULL,
	[fiscal_yearmo_num] [char](6) NOT NULL,
	[salesperson_nm] [varchar](30) NOT NULL,
	[comm_plan_id] [char](10) NOT NULL,
	[employee_num] [char](10) NOT NULL,
	[territory_start_dt] [datetime] NOT NULL,
	[SALD30_amt] [money] NOT NULL,
	[STMPBA_amt] [money] NOT NULL,
	[note_txt] [varchar](255) NULL,
	[salesperson_key_id] [char](30) NOT NULL,
 CONSTRAINT [PK_comm_salesperson_master_stage] PRIMARY KEY CLUSTERED 
(
	[master_salesperson_cd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO

ALTER TABLE [Integration].[salesperson_master_Staging] ADD  DEFAULT ('') FOR [salesperson_key_id]
GO

--

ALTER TABLE dbo.BRS_Branch ADD
	ZoneName varchar(50) NOT NULL CONSTRAINT DF_BRS_Branch_zone_cd DEFAULT ('')
GO

--

ALTER TABLE dbo.BRS_Item ADD
	comm_group_cd char(6) NOT NULL CONSTRAINT DF_BRS_Item_comm_group_cd DEFAULT (''),
	comm_note_txt varchar(50) NULL
GO

INSERT        
INTO              comm.[group](comm_group_cd, comm_group_desc)
VALUES        ('', 'Unassigned')


ALTER TABLE dbo.BRS_Item ADD CONSTRAINT
	FK_BRS_Item_group FOREIGN KEY
	(
	comm_group_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

ALTER TABLE dbo.BRS_Customer ADD
	comm_status_cd char(6) NOT NULL CONSTRAINT DF_BRS_Customer_comm_status_cd DEFAULT (''),
	comm_note_txt varchar(50) NULL
GO

--


CREATE TABLE [comm].[salesperson_master](
	[employee_num] [int] NOT NULL,
	[master_salesperson_cd] [char](5) NOT NULL,

	[salesperson_key_id] [varchar](30) NOT NULL,

	[salesperson_nm] [varchar](30) NOT NULL,
	[comm_plan_id] [char](10) NOT NULL,
	[territory_start_dt] [datetime] NOT NULL,
	[creation_dt] [datetime] NOT NULL,

	salesperson_master_key smallint NOT NULL identity(1,1),

	[note_txt] [varchar](50) NULL,
	[flag_ind] [bit] NULL,

 CONSTRAINT [comm_salesperson_master_pk] PRIMARY KEY NONCLUSTERED 
(
	[employee_num], [master_salesperson_cd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO

ALTER TABLE [comm].[salesperson_master] ADD  CONSTRAINT [DF_comm_salesperson_master_create_dt]  DEFAULT (getdate()) FOR [creation_dt]
GO

BEGIN TRANSACTION
GO
ALTER TABLE comm.salesperson_master ADD CONSTRAINT
	DF_salesperson_master_comm_plan_id DEFAULT ('') FOR comm_plan_id
GO
ALTER TABLE comm.salesperson_master ADD CONSTRAINT
	DF_salesperson_master_territory_start_dt DEFAULT ('1980-01-01') FOR territory_start_dt
GO
ALTER TABLE comm.salesperson_master SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


ALTER TABLE [comm].[salesperson_master]  WITH NOCHECK ADD  CONSTRAINT [comm_salesperson_master_comm_plan_fk_1] FOREIGN KEY([comm_plan_id])
REFERENCES [comm].[plan] ([comm_plan_id])
GO

ALTER TABLE [comm].[salesperson_master]  WITH NOCHECK ADD  CONSTRAINT [comm_salesperson_master_comm_salesperson_code_map_fk_1] FOREIGN KEY([master_salesperson_cd])
REFERENCES [dbo].[BRS_FSC_Rollup] ([TerritoryCd])
GO

CREATE UNIQUE CLUSTERED INDEX idx_salesperson_master_uc_idx_01 ON comm.salesperson_master
	(
	salesperson_key_id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO

--

ALTER TABLE dbo.BRS_FSC_Rollup ADD
	comm_salesperson_key_id varchar(30) NULL
GO

ALTER TABLE dbo.BRS_FSC_Rollup  WITH NOCHECK ADD  CONSTRAINT [BRS_FSC_Rollup_comm_salesperson_master_fk] FOREIGN KEY([comm_salesperson_key_id])
REFERENCES [comm].[salesperson_master] ([salesperson_key_id])
GO

---

CREATE TABLE [comm].[transaction_F555115](
	[FiscalMonth] [Integer] NOT NULL,
	[WSCO___company] [char](5) NOT NULL,
	[WSDOCO_salesorder_number] [integer] NOT NULL,
	[WSDCTO_order_type] [char](2) NOT NULL,
	[WSLNTY_line_type] [char](2) NOT NULL,
	[WSLNID_line_number] [integer] NOT NULL,
	[WS$OSC_order_source_code] [char](1) NOT NULL,
	[WSAN8__billto] [Integer] NOT NULL,
	[WSSHAN_shipto] [Integer] NOT NULL,
	[WSDGL__gl_date] [datetime] NOT NULL,
	[WSLITM_item_number] [char](10) NOT NULL,
	[WSDSC1_description] [varchar](30) NOT NULL,
	[WSDSC2_description_2] [varchar](30) NOT NULL,
	[WSSRP1_major_product_class] [char](3) NOT NULL,
	[WSSRP2_sub_major_product_class] [char](3) NOT NULL,
	[WSSRP3_minor_product_class] [char](3) NOT NULL,
	[WSSRP6_manufacturer] [char](6) NOT NULL,
	[WSUORG_quantity] [smallint] NOT NULL,
	[WSSOQS_quantity_shipped] [smallint] NOT NULL,
	[WSAEXP_extended_price] [money] NOT NULL,
	[WSURAT_user_reserved_amount] [money] NOT NULL,
	[WS$UNC_sales_order_cost_markup] [money] NOT NULL,
	[WSOORN_original_order_number] [char](8) NOT NULL,
	[WSOCTO_original_order_type] [char](2) NOT NULL,
	[WSOGNO_original_line_number] [integer] NOT NULL,
	[WSTRDJ_order_date] [date] NOT NULL,
	[WSVR01_reference] [varchar](25) NOT NULL,
	[WSVR02_reference_2] [varchar](25) NOT NULL,
	[WSITM__item_number_short] [int] NOT NULL,
	[WSPROV_price_override_code] [char](1) NOT NULL,
	[WSASN__adjustment_schedule] [char](10) NOT NULL,
	[WSKCO__document_company] [char](5) NOT NULL,
	[WSDOC__document_number] [numeric](8, 0) NOT NULL,
	[WSDCT__document_type] [char](2) NOT NULL,
	[WSPSN__pick_slip_number] [numeric](8, 0) NOT NULL,
	[WSROUT_ship_method] [char](3) NOT NULL,
	[WSZON__zone_number] [char](3) NOT NULL,
	[WSFRTH_freight_handling_code] [char](3) NOT NULL,
	[WSFRAT_rate_code_freightmisc] [varchar](10) NOT NULL,
	[WSRATT_rate_type_freightmisc] [char](1) NOT NULL,
	[WSGLC__gl_offset] [char](4) NOT NULL,
	[WSSO08_price_adjustment_line_indicator] [char](1) NOT NULL,
	[WSENTB_entered_by] [char](10) NOT NULL,
	[WS$PMC_promotion_code_price_method] [char](2) NOT NULL,
	[WSTKBY_order_taken_by] [char](10) NOT NULL,
	[WSKTLN_kit_master_line_number] [smallint] NOT NULL,
	[WSCOMM_committed_hs] [char](1) NOT NULL,
	[WSEMCU_header_business_unit] [char](12) NOT NULL,
	[WS$SPC_supplier_code] [char](6) NOT NULL,
	[WS$VCD_vendor_code] [char](6) NOT NULL,
	[WS$CLC_classification_code] [char](3) NOT NULL,
	[WSCYCL_cycle_count_category] [char](3) NOT NULL,
	[WSORD__equipment_order] [char](15) NOT NULL,
	[WSORDT_order_type] [char](2) NOT NULL,
	[WSCAG__cagess_code] [char](5) NOT NULL,
	[WSEST__employment_status] [char](10) NOT NULL,
	[WS$ESS_equipment_specialist_code] [char](5) NOT NULL,
	[WS$TSS_tech_specialist_code] [char](5) NOT NULL,
	[WS$CCS_cadcam_specialist_code] [char](5) NOT NULL,
	[WS$NM1__name_1] [varchar](30) NOT NULL,
	[WS$NM3_researched_by] [varchar](30) NOT NULL,
	[WS$NM4_completed_by] [varchar](30) NOT NULL,
	[WS$NM5__name_5] [varchar](30) NOT NULL,
	[WS$L01_level_code_01] [char](5) NOT NULL,
	[WSSRP4_sub_minor_product_class] [char](3) NOT NULL,
	[WSCITM_customersupplier_item_number] [varchar](25) NOT NULL,
	[WSSIC__speciality] [char](10) NOT NULL,
	[WSAC04_practice_type] [char](3) NOT NULL,
	[WSAC10_division_code] [char](3) NOT NULL,
	[WS$O01_number_equipment_serial_01] [varchar](30) NOT NULL,
	[WS$O02_number_equipment_serial_02] [varchar](30) NOT NULL,
	[WS$O03_number_equipment_serial_03] [varchar](30) NOT NULL,
	[WS$O04_number_equipment_serial_04] [varchar](30) NOT NULL,
	[WS$O05_number_equipment_serial_05] [varchar](30) NOT NULL,
	[WS$O06_number_equipment_serial_06] [varchar](30) NOT NULL,
	[WSDL03_description_03] [numeric](6, 0) NOT NULL,
	[WS$ODS_order_discount_amount] [money] NOT NULL,
	[ID] [integer] identity(1,1) NOT NULL
 CONSTRAINT [comm_transaction_F555115_pk] PRIMARY KEY NONCLUSTERED 
(
	[WSDOCO_salesorder_number] ASC,
	[WSDCTO_order_type] ASC,
	[WSLNID_line_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO


ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_FiscalMonth FOREIGN KEY
	(
	FiscalMonth
	) REFERENCES dbo.BRS_FiscalMonth
	(
	FiscalMonth
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

ALTER TABLE comm.transaction_F555115 ADD
	source_cd char(3) NOT NULL CONSTRAINT DF_transaction_F555115_source_cd DEFAULT ('')
GO


ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_TransactionDW_Ext FOREIGN KEY
	(
	WSDOCO_salesorder_number
	) REFERENCES dbo.BRS_TransactionDW_Ext
	(
	SalesOrderNumber
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_DocType FOREIGN KEY
	(
	WSDCTO_order_type
	) REFERENCES dbo.BRS_DocType
	(
	DocType
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_OrderSource FOREIGN KEY
	(
	WS$OSC_order_source_code
	) REFERENCES dbo.BRS_OrderSource
	(
	OrderSourceCode
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_Customer FOREIGN KEY
	(
	WSSHAN_shipto
	) REFERENCES dbo.BRS_Customer
	(
	ShipTo
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_CustomerBT FOREIGN KEY
	(
	WSAN8__billto
	) REFERENCES dbo.BRS_CustomerBT
	(
	BillTo
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_SalesDay FOREIGN KEY
	(
	WSDGL__gl_date
	) REFERENCES dbo.BRS_SalesDay
	(
	SalesDate
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_Item FOREIGN KEY
	(
	WSLITM_item_number
	) REFERENCES dbo.BRS_Item
	(
	Item
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_ItemMPC FOREIGN KEY
	(
	WSSRP1_major_product_class
	) REFERENCES dbo.BRS_ItemMPC
	(
	MajorProductClass
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_CustomerVPA FOREIGN KEY
	(
	WSASN__adjustment_schedule
	) REFERENCES dbo.BRS_CustomerVPA
	(
	VPA
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_BusinessUnit FOREIGN KEY
	(
	WSEMCU_header_business_unit
	) REFERENCES dbo.BRS_BusinessUnit
	(
	BusinessUnit
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_ItemSupplier FOREIGN KEY
	(
	WS$SPC_supplier_code
	) REFERENCES dbo.BRS_ItemSupplier
	(
	Supplier
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_FSC_Rollup FOREIGN KEY
	(
	WSCAG__cagess_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_FSC_Rollup1 FOREIGN KEY
	(
	WS$ESS_equipment_specialist_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_FSC_Rollup2 FOREIGN KEY
	(
	WS$TSS_tech_specialist_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_FSC_Rollup3 FOREIGN KEY
	(
	WS$CCS_cadcam_specialist_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_FSC_Rollup4 FOREIGN KEY
	(
	WS$L01_level_code_01
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_CustomerSpecialty FOREIGN KEY
	(
	WSSIC__speciality
	) REFERENCES dbo.BRS_CustomerSpecialty
	(
	Specialty
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_SalesDivision FOREIGN KEY
	(
	WSAC10_division_code
	) REFERENCES dbo.BRS_SalesDivision
	(
	SalesDivision
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

BEGIN TRANSACTION
GO
ALTER TABLE comm.transaction_F555115 ADD
	transaction_amt money NOT NULL CONSTRAINT DF_transaction_F555115_transaction_amt DEFAULT (0),
	gp_ext_amt money NOT NULL CONSTRAINT DF_transaction_F555115_gp_ext_amt DEFAULT (0),
	fsc_salesperson_key_id varchar(30) NULL,
	fsc_comm_plan_id char(10) NULL,
	fsc_comm_group_cd char(6) NULL,
	fsc_comm_rt float(53) NULL,
	fsc_comm_amt money NOT NULL CONSTRAINT DF_transaction_F555115_fsc_comm_amt DEFAULT (0),
	ess_salesperson_key_id varchar(30) NULL,
	ess_comm_plan_id char(10) NULL,
	ess_comm_group_cd char(6) NULL,
	ess_comm_rt float(53) NULL,
	ess_comm_amt money NOT NULL CONSTRAINT DF_transaction_F555115_ess_comm_amt DEFAULT (0),
	dtx_salesperson_key_id varchar(30) NULL,
	dtx_comm_plan_id char(10) NULL,
	dtx_comm_group_cd char(6) NULL,
	dtx_comm_rt float(53) NULL,
	dtx_comm_amt money NOT NULL CONSTRAINT DF_transaction_F555115_dtx_comm_amt DEFAULT (0)
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


BEGIN TRANSACTION
GO

ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_salesperson_master FOREIGN KEY
	(
	fsc_salesperson_key_id
	) REFERENCES comm.salesperson_master
	(
	salesperson_key_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_salesperson_master1 FOREIGN KEY
	(
	ess_salesperson_key_id
	) REFERENCES comm.salesperson_master
	(
	salesperson_key_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_salesperson_master2 FOREIGN KEY
	(
	dtx_salesperson_key_id
	) REFERENCES comm.salesperson_master
	(
	salesperson_key_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_plan FOREIGN KEY
	(
	fsc_comm_plan_id
	) REFERENCES comm.[plan]
	(
	comm_plan_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_plan1 FOREIGN KEY
	(
	ess_comm_plan_id
	) REFERENCES comm.[plan]
	(
	comm_plan_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_plan2 FOREIGN KEY
	(
	dtx_comm_plan_id
	) REFERENCES comm.[plan]
	(
	comm_plan_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_group FOREIGN KEY
	(
	fsc_comm_group_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_group1 FOREIGN KEY
	(
	ess_comm_group_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_group2 FOREIGN KEY
	(
	dtx_comm_group_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT



BEGIN TRANSACTION
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSCO___company DEFAULT ('') FOR WSCO___company
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSLNTY_line_type DEFAULT ('') FOR WSLNTY_line_type
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WS$OSC_order_source_code DEFAULT ('') FOR WS$OSC_order_source_code
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSAN8__billto DEFAULT (0) FOR WSAN8__billto
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSSHAN_shipto DEFAULT (0) FOR WSSHAN_shipto
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSLITM_item_number DEFAULT ('') FOR WSLITM_item_number
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSDSC1_description DEFAULT ('') FOR WSDSC1_description
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSDSC2_description_2 DEFAULT ('') FOR WSDSC2_description_2
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSSRP1_major_product_class DEFAULT ('') FOR WSSRP1_major_product_class
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSSRP2_sub_major_product_class DEFAULT ('') FOR WSSRP2_sub_major_product_class
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSSRP3_minor_product_class DEFAULT ('') FOR WSSRP3_minor_product_class
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSSRP6_manufacturer DEFAULT ('') FOR WSSRP6_manufacturer
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSUORG_quantity DEFAULT (0) FOR WSUORG_quantity
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSSOQS_quantity_shipped DEFAULT (0) FOR WSSOQS_quantity_shipped
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSAEXP_extended_price DEFAULT (0) FOR WSAEXP_extended_price
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSURAT_user_reserved_amount DEFAULT (0) FOR WSURAT_user_reserved_amount
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WS$UNC_sales_order_cost_markup DEFAULT (0) FOR WS$UNC_sales_order_cost_markup
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSOORN_original_order_number DEFAULT ('') FOR WSOORN_original_order_number
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSOCTO_original_order_type DEFAULT ('') FOR WSOCTO_original_order_type
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSOGNO_original_line_number DEFAULT (0) FOR WSOGNO_original_line_number
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSTRDJ_order_date DEFAULT ('1980-01-01') FOR WSTRDJ_order_date
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSVR01_reference DEFAULT ('') FOR WSVR01_reference
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSVR02_reference_2 DEFAULT ('') FOR WSVR02_reference_2
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSITM__item_number_short DEFAULT (0) FOR WSITM__item_number_short
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSPROV_price_override_code DEFAULT ('') FOR WSPROV_price_override_code
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSASN__adjustment_schedule DEFAULT ('') FOR WSASN__adjustment_schedule
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSKCO__document_company DEFAULT ('') FOR WSKCO__document_company
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSDOC__document_number DEFAULT (0) FOR WSDOC__document_number
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSDCT__document_type DEFAULT ('') FOR WSDCT__document_type
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSPSN__pick_slip_number DEFAULT (0) FOR WSPSN__pick_slip_number
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSROUT_ship_method DEFAULT ('') FOR WSROUT_ship_method
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSZON__zone_number DEFAULT ('') FOR WSZON__zone_number
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSFRTH_freight_handling_code DEFAULT ('') FOR WSFRTH_freight_handling_code
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSFRAT_rate_code_freightmisc DEFAULT ('') FOR WSFRAT_rate_code_freightmisc
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSRATT_rate_type_freightmisc DEFAULT ('') FOR WSRATT_rate_type_freightmisc
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSGLC__gl_offset DEFAULT ('') FOR WSGLC__gl_offset
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSSO08_price_adjustment_line_indicator DEFAULT ('') FOR WSSO08_price_adjustment_line_indicator
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSENTB_entered_by DEFAULT ('') FOR WSENTB_entered_by
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WS$PMC_promotion_code_price_method DEFAULT ('') FOR WS$PMC_promotion_code_price_method
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSTKBY_order_taken_by DEFAULT ('') FOR WSTKBY_order_taken_by
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSKTLN_kit_master_line_number DEFAULT ('') FOR WSKTLN_kit_master_line_number
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSCOMM_committed_hs DEFAULT ('') FOR WSCOMM_committed_hs
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSEMCU_header_business_unit DEFAULT ('') FOR WSEMCU_header_business_unit
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WS$SPC_supplier_code DEFAULT ('') FOR WS$SPC_supplier_code
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WS$VCD_vendor_code DEFAULT ('') FOR WS$VCD_vendor_code
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WS$CLC_classification_code DEFAULT ('') FOR WS$CLC_classification_code
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSCYCL_cycle_count_category DEFAULT ('') FOR WSCYCL_cycle_count_category
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSORD__equipment_order DEFAULT ('') FOR WSORD__equipment_order
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSORDT_order_type DEFAULT ('') FOR WSORDT_order_type
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSCAG__cagess_code DEFAULT ('') FOR WSCAG__cagess_code
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSEST__employment_status DEFAULT ('') FOR WSEST__employment_status
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WS$ESS_equipment_specialist_code DEFAULT ('') FOR WS$ESS_equipment_specialist_code
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WS$TSS_tech_specialist_code DEFAULT ('') FOR WS$TSS_tech_specialist_code
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WS$CCS_cadcam_specialist_code DEFAULT ('') FOR WS$CCS_cadcam_specialist_code
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WS$NM1__name_1 DEFAULT ('') FOR WS$NM1__name_1
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WS$NM3_researched_by DEFAULT ('') FOR WS$NM3_researched_by
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WS$NM4_completed_by DEFAULT ('') FOR WS$NM4_completed_by
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WS$NM5__name_5 DEFAULT ('') FOR WS$NM5__name_5
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WS$L01_level_code_01 DEFAULT ('') FOR WS$L01_level_code_01
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSSRP4_sub_minor_product_class DEFAULT ('') FOR WSSRP4_sub_minor_product_class
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSCITM_customersupplier_item_number DEFAULT ('') FOR WSCITM_customersupplier_item_number
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSSIC__speciality DEFAULT ('') FOR WSSIC__speciality
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSAC04_practice_type DEFAULT ('') FOR WSAC04_practice_type
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSAC10_division_code DEFAULT ('') FOR WSAC10_division_code
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WS$O01_number_equipment_serial_01 DEFAULT ('') FOR WS$O01_number_equipment_serial_01
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WS$O02_number_equipment_serial_02 DEFAULT ('') FOR WS$O02_number_equipment_serial_02
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WS$O03_number_equipment_serial_03 DEFAULT ('') FOR WS$O03_number_equipment_serial_03
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WS$O04_number_equipment_serial_04 DEFAULT ('') FOR WS$O04_number_equipment_serial_04
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WS$O05_number_equipment_serial_05 DEFAULT ('') FOR WS$O05_number_equipment_serial_05
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WS$O06_number_equipment_serial_06 DEFAULT ('') FOR WS$O06_number_equipment_serial_06
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WSDL03_description_03 DEFAULT (0) FOR WSDL03_description_03
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	DF_transaction_F555115_WS$ODS_order_discount_amount DEFAULT (0) FOR WS$ODS_order_discount_amount
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- DROP INDEX transaction_F555115_c_idx_01 ON comm.transaction_F555115

BEGIN TRANSACTION
GO
CREATE NONCLUSTERED INDEX transaction_F555115_c_idx_01 ON comm.transaction_F555115
	(
	FiscalMonth,
	[WSLITM_item_number],
	[WSSHAN_shipto],
	transaction_amt,
	gp_ext_amt
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

---


CREATE TABLE [comm].[config](
	[FiscalMonth] [integer] NOT NULL,
	[PriorFiscalMonth] [integer] NOT NULL,
	[SalesDateLastWeekly] datetime NOT NULL,
	[HistorySummaryMonths] [int] NOT NULL,
	[OutputPath] [varchar](255) NOT NULL,
	[LogFile] [varchar](255) NOT NULL,
	[ID] [int] NOT NULL,
 CONSTRAINT [comm_config_c_pk] PRIMARY KEY CLUSTERED 
(
	[FiscalMonth] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]


BEGIN TRANSACTION
GO
ALTER TABLE comm.config ADD CONSTRAINT
	FK_config_BRS_FiscalMonth FOREIGN KEY
	(
	FiscalMonth
	) REFERENCES dbo.BRS_FiscalMonth
	(
	FiscalMonth
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.config ADD CONSTRAINT
	FK_config_BRS_FiscalMonth1 FOREIGN KEY
	(
	PriorFiscalMonth
	) REFERENCES dbo.BRS_FiscalMonth
	(
	FiscalMonth
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

ALTER TABLE comm.config ADD CONSTRAINT
	FK_config_BRS_SalesDay FOREIGN KEY
	(
	SalesDateLastWeekly
	) REFERENCES dbo.BRS_SalesDay
	(
	SalesDate
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.config SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


GO

---

ALTER TABLE dbo.BRS_TransactionDW_Ext ADD
	ESS_code char(5) NOT NULL CONSTRAINT DF_BRS_TransactionDW_Ext_ESS_code DEFAULT (''),
	CCS_code char(5) NOT NULL CONSTRAINT DF_BRS_TransactionDW_Ext_CCS_code DEFAULT (''),
	DTX_code char(5) NOT NULL CONSTRAINT DF_BRS_TransactionDW_Ext_DTX_code DEFAULT (''),
	TSS_code char(5) NOT NULL CONSTRAINT DF_BRS_TransactionDW_Ext_TSS_code DEFAULT (''),
	FSC_code char(5) NOT NULL CONSTRAINT DF_BRS_TransactionDW_Ext_FSC_code DEFAULT (''),
	comm_note varchar(30) NULL
GO

ALTER TABLE dbo.BRS_TransactionDW_Ext ADD CONSTRAINT
	FK_BRS_TransactionDW_Ext_BRS_FSC_Rollup FOREIGN KEY
	(
	ESS_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext ADD CONSTRAINT
	FK_BRS_TransactionDW_Ext_BRS_FSC_Rollup2 FOREIGN KEY
	(
	CCS_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext ADD CONSTRAINT
	FK_BRS_TransactionDW_Ext_BRS_FSC_Rollup3 FOREIGN KEY
	(
	TSS_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
GO

ALTER TABLE dbo.BRS_TransactionDW_Ext ADD CONSTRAINT
	FK_BRS_TransactionDW_Ext_BRS_FSC_Rollup4 FOREIGN KEY
	(
	DTX_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext ADD CONSTRAINT
	FK_BRS_TransactionDW_Ext_BRS_FSC_Rollup5 FOREIGN KEY
	(
	FSC_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

BEGIN TRANSACTION
GO
ALTER TABLE comm.transaction_F555115 ADD
	fsc_code char(5) NULL
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_FSC_Rollup5 FOREIGN KEY
	(
	fsc_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


--- add data...

insert into [dbo].[BRS_DocType] (DocType) values ('')

INSERT INTO comm.salesperson_master
                         (employee_num, master_salesperson_cd, salesperson_key_id, salesperson_nm)
VALUES        (0, '', '', 'Unassigned')

INSERT INTO [dbo].[BRS_FSC_Rollup] ([TerritoryCd],[Branch])
select distinct [WSCAG__cagess_code], '' from [Integration].[F555115_commission_sales_extract_Staging] 
where not exists (select * from [dbo].[BRS_FSC_Rollup] where [WSCAG__cagess_code] =  [TerritoryCd])

INSERT INTO [dbo].[BRS_FSC_Rollup] ([TerritoryCd],[Branch])
select distinct [WS$ESS_equipment_specialist_code], '' from [Integration].[F555115_commission_sales_extract_Staging] 
where not exists (select * from [dbo].[BRS_FSC_Rollup] where [WS$ESS_equipment_specialist_code] =  [TerritoryCd])

INSERT INTO [dbo].[BRS_FSC_Rollup] ([TerritoryCd],[Branch])
SELECT        distinct master_salesperson_cd, ''
FROM            DEV_CommBE.dbo.comm_salesperson_master 
WHERE employee_num > 0 AND salesperson_key_id <> '' AND master_salesperson_cd <> '' and
	not exists(select * from [dbo].[BRS_FSC_Rollup] where master_salesperson_cd = [TerritoryCd])

INSERT INTO [dbo].[BRS_Item] ([Item])
select distinct [WSLITM_item_number] from [Integration].[F555115_commission_sales_extract_Staging] 
where not exists (select * from [dbo].[BRS_Item] where [WSLITM_item_number] =  [Item])

INSERT INTO [dbo].[BRS_TransactionDW_Ext] ([SalesOrderNumber],[DocType] )
select distinct [WSDOCO_salesorder_number],[WSDCTO_order_type] from [Integration].[F555115_commission_sales_extract_Staging] 
where not exists (select * from [dbo].[BRS_TransactionDW_Ext] where [WSDOCO_salesorder_number] =  [SalesOrderNumber])

-- truncate table comm.transaction_F555115

INSERT INTO comm.transaction_F555115
                         (FiscalMonth, WSCO___company, WSDOCO_salesorder_number, WSDCTO_order_type, WSLNTY_line_type, WSLNID_line_number, WS$OSC_order_source_code, 
                         WSAN8__billto, WSSHAN_shipto, WSDGL__gl_date, WSLITM_item_number, WSDSC1_description, WSDSC2_description_2, WSSRP1_major_product_class, 
                         WSSRP2_sub_major_product_class, WSSRP3_minor_product_class, WSSRP6_manufacturer, WSUORG_quantity, WSSOQS_quantity_shipped, 
                         WSAEXP_extended_price, WSURAT_user_reserved_amount, WS$UNC_sales_order_cost_markup, WSOORN_original_order_number, WSOCTO_original_order_type, 
                         WSOGNO_original_line_number, WSTRDJ_order_date, WSVR01_reference, WSVR02_reference_2, WSITM__item_number_short, WSPROV_price_override_code, 
                         WSASN__adjustment_schedule, WSKCO__document_company, WSDOC__document_number, WSDCT__document_type, WSPSN__pick_slip_number, 
                         WSROUT_ship_method, WSZON__zone_number, WSFRTH_freight_handling_code, WSFRAT_rate_code_freightmisc, WSRATT_rate_type_freightmisc, 
                         WSGLC__gl_offset, WSSO08_price_adjustment_line_indicator, WSENTB_entered_by, WS$PMC_promotion_code_price_method, WSTKBY_order_taken_by, 
                         WSKTLN_kit_master_line_number, WSCOMM_committed_hs, WSEMCU_header_business_unit, WS$SPC_supplier_code, WS$VCD_vendor_code, 
                         WS$CLC_classification_code, WSCYCL_cycle_count_category, WSORD__equipment_order, WSORDT_order_type, WSCAG__cagess_code, 
                         WSEST__employment_status, WS$ESS_equipment_specialist_code, WS$TSS_tech_specialist_code, WS$CCS_cadcam_specialist_code, WS$NM1__name_1, 
                         WS$NM3_researched_by, WS$NM4_completed_by, WS$NM5__name_5, WS$L01_level_code_01, WSSRP4_sub_minor_product_class, 
                         WSCITM_customersupplier_item_number, WSSIC__speciality, WSAC04_practice_type, WSAC10_division_code, WS$O01_number_equipment_serial_01, 
                         WS$O02_number_equipment_serial_02, WS$O03_number_equipment_serial_03, WS$O04_number_equipment_serial_04, WS$O05_number_equipment_serial_05, 
                         WS$O06_number_equipment_serial_06, WSDL03_description_03, WS$ODS_order_discount_amount)
SELECT        
-- TOP (10) 
d.FiscalMonth, t.WSCO___company, t.WSDOCO_salesorder_number, t.WSDCTO_order_type, t.WSLNTY_line_type, ROUND(t.WSLNID_line_number * 1000,0) AS WSLNID_line_number, 
                         t.WS$OSC_order_source_code, t.WSAN8__billto, t.WSSHAN_shipto, t.WSDGL__gl_date, t.WSLITM_item_number, t.WSDSC1_description, t.WSDSC2_description_2, 
                         t.WSSRP1_major_product_class, t.WSSRP2_sub_major_product_class, t.WSSRP3_minor_product_class, t.WSSRP6_manufacturer, t.WSUORG_quantity, 
                         t.WSSOQS_quantity_shipped, t.WSAEXP_extended_price, t.WSURAT_user_reserved_amount, t.WS$UNC_sales_order_cost_markup, 
                         t.WSOORN_original_order_number, t.WSOCTO_original_order_type, t.WSOGNO_original_line_number, t.WSTRDJ_order_date, t.WSVR01_reference, 
                         t.WSVR02_reference_2, t.WSITM__item_number_short, t.WSPROV_price_override_code, t.WSASN__adjustment_schedule, t.WSKCO__document_company, 
                         t.WSDOC__document_number, t.WSDCT__document_type, t.WSPSN__pick_slip_number, t.WSROUT_ship_method, t.WSZON__zone_number, 
                         t.WSFRTH_freight_handling_code, t.WSFRAT_rate_code_freightmisc, t.WSRATT_rate_type_freightmisc, t.WSGLC__gl_offset, 
                         t.WSSO08_price_adjustment_line_indicator, t.WSENTB_entered_by, t.WS$PMC_promotion_code_price_method, t.WSTKBY_order_taken_by, 
                         t.WSKTLN_kit_master_line_number, t.WSCOMM_committed_hs, t.WSEMCU_header_business_unit, t.WS$SPC_supplier_code, t.WS$VCD_vendor_code, 
                         t.WS$CLC_classification_code, t.WSCYCL_cycle_count_category, t.WSORD__equipment_order, t.WSORDT_order_type, t.WSCAG__cagess_code, 
                         t.WSEST__employment_status, t.WS$ESS_equipment_specialist_code, t.WS$TSS_tech_specialist_code, t.WS$CCS_cadcam_specialist_code, t.WS$NM1__name_1, 
                         t.WS$NM3_researched_by, t.WS$NM4_completed_by, t.WS$NM5__name_5, t.WS$L01_level_code_01, t.WSSRP4_sub_minor_product_class, 
                         t.WSCITM_customersupplier_item_number, t.WSSIC__speciality, t.WSAC04_practice_type, t.WSAC10_division_code, t.WS$O01_number_equipment_serial_01, 
                         t.WS$O02_number_equipment_serial_02, t.WS$O03_number_equipment_serial_03, t.WS$O04_number_equipment_serial_04, 
                         t.WS$O05_number_equipment_serial_05, t.WS$O06_number_equipment_serial_06, t.WSDL03_description_03, t.WS$ODS_order_discount_amount
FROM            Integration.F555115_commission_sales_extract_Staging AS t INNER JOIN
                         BRS_SalesDay AS d ON t.WSDGL__gl_date = d.SalesDate
WHERE 
	(WSAC10_division_code NOT IN ('AZA', 'AZE')) 

/*
SELECT        
DISTINCT t.WSDOCO_salesorder_number
FROM            Integration.F555115_commission_sales_extract_Staging AS t INNER JOIN
                         BRS_SalesDay AS d ON t.WSDGL__gl_date = d.SalesDate
WHERE 
	(WSAC10_division_code NOT IN ('AZA', 'AZE')) AND 
	NOT EXISTS ( SELECT * FROM [dbo].[BRS_TransactionDW_Ext] WHERE [SalesOrderNumber] =t.WSDOCO_salesorder_number)

SELECT        
	*
FROM            Integration.F555115_commission_sales_extract_Staging AS t
WHERE t.WSDOCO_salesorder_number = 10901332	 

*/
--- XXX
SELECT
TOP (10) 
WSAC10_division_code, 
SUM(WSAEXP_extended_price) AS WSAEXP_extended_price, 
SUM(WS$ODS_order_discount_amount) AS WS$ODS_order_discount_amount, 
SUM(WS$UNC_sales_order_cost_markup) AS WS$UNC_sales_order_cost_markup, 
SUM(WSSOQS_quantity_shipped) AS WSSOQS_quantity_shipped, 
SUM(WS$UNC_sales_order_cost_markup * WSSOQS_quantity_shipped) AS ext_cost,
SUM(WSAEXP_extended_price-WS$ODS_order_discount_amount) as net_sales,
SUM(WSAEXP_extended_price-WS$ODS_order_discount_amount - WS$UNC_sales_order_cost_markup * WSSOQS_quantity_shipped) as gp_amt

FROM            comm.transaction_F555115
WHERE        (FiscalMonth = 201711)
GROUP BY WSAC10_division_code



-- ADD

INSERT INTO comm.[source]
                         (source_cd, source_desc, active_ind, creation_dt)
SELECT        LEFT(source_cd,3), source_desc, active_ind, creation_dt
FROM            DEV_CommBE.dbo.comm_source
WHERE source_cd <>''

INSERT INTO comm.[group]
                         (comm_group_cd, comm_group_desc, source_cd, active_ind, creation_dt, comm_calc_rt, note_txt, booking_rt, SPM_comm_group_cd, show_ind, SPM_EQOptOut, 
                         sort_id, FRG_comm_group_cd)
SELECT        comm_group_cd, comm_group_desc, source_cd, active_ind, creation_dt, comm_calc_rt, note_txt, booking_rt, SPM_comm_group_cd, show_ind, SPM_EQOptOut, 
                         sort_id, FRG_comm_group_cd
FROM            DEV_CommBE.dbo.comm_group
WHERE comm_group_cd <>''

/*
UPDATE       comm.[group] 
SET             source_cd = LEFT(DEV_CommBE.dbo.comm_group.[source_cd],3)   
FROM            DEV_CommBE.dbo.comm_group INNER JOIN
                         comm.[group] ON DEV_CommBE.dbo.comm_group.comm_group_cd = comm.[group].comm_group_cd
WHERE        (DEV_CommBE.dbo.comm_group.comm_group_cd <> '')
*/

INSERT INTO comm.[plan]
                         (comm_plan_id, comm_plan_nm, note_txt, active_ind, creation_dt, SPM_StatusCd)
SELECT        comm_plan_id, comm_plan_nm, note_txt, active_ind, creation_dt, SPM_StatusCd
FROM            DEV_CommBE.dbo.comm_plan

INSERT INTO comm.plan_group_rate
                         (comm_plan_id, comm_group_cd, comm_base_rt, active_ind, creation_dt, note_txt, show_ind)
SELECT        comm_plan_id, comm_group_cd, comm_base_rt, active_ind, creation_dt, note_txt, show_ind
FROM            DEV_CommBE.dbo.comm_plan_group_rate


INSERT INTO comm.salesperson_master
                         (salesperson_key_id, salesperson_nm, comm_plan_id, creation_dt, note_txt, master_salesperson_cd, flag_ind, territory_start_dt, employee_num)
SELECT        salesperson_key_id, salesperson_nm, comm_plan_id, creation_dt, note_txt, master_salesperson_cd, select_ind, ISNULL(territory_start_dt, '1980-01-01'), employee_num
FROM            DEV_CommBE.dbo.comm_salesperson_master 
WHERE employee_num > 0 AND salesperson_key_id <> '' AND master_salesperson_cd <> '' 

-- map terr

UPDATE       BRS_FSC_Rollup
SET                Branch = c.branch_cd
FROM            CommBE.dbo.comm_salesperson_code_map AS c INNER JOIN
                         BRS_FSC_Rollup ON c.salesperson_cd = BRS_FSC_Rollup.TerritoryCd AND c.branch_cd <> BRS_FSC_Rollup.Branch AND BRS_FSC_Rollup.Branch = ''

UPDATE       BRS_FSC_Rollup
SET                [FSCName] = c.[salesperson_nm]
FROM            CommBE.dbo.comm_salesperson_code_map AS c INNER JOIN
                         BRS_FSC_Rollup ON c.salesperson_cd = BRS_FSC_Rollup.TerritoryCd AND c.[salesperson_nm] <> [FSCName] AND c.[salesperson_nm] <> ''

UPDATE       BRS_FSC_Rollup
SET                [comm_salesperson_key_id] = c.[salesperson_key_id]
FROM            CommBE.dbo.comm_salesperson_code_map AS c INNER JOIN
                         BRS_FSC_Rollup ON c.salesperson_cd = BRS_FSC_Rollup.TerritoryCd AND 
			EXISTS (SELECT * FROM CommBE.dbo.[comm_salesperson_master] s WHERE c.[salesperson_key_id] = s.[salesperson_key_id])

UPDATE       BRS_FSC_Rollup
SET                comm_salesperson_key_id = c.salesperson_key_id
FROM            CommBE.dbo.comm_salesperson_code_map AS c INNER JOIN
                         BRS_FSC_Rollup ON c.salesperson_cd = BRS_FSC_Rollup.TerritoryCd
WHERE EXISTS (SELECT * FROM comm.salesperson_master WHERE [salesperson_key_id] = c.salesperson_key_id)

-- map item
UPDATE       BRS_Item
SET                [comm_group_cd] = c.comm_group_cd
FROM            CommBE.dbo.comm_item_master AS c INNER JOIN
                         BRS_Item ON c.[item_id] = item

-- map customer

UPDATE       BRS_Customer
SET                
comm_status_cd =CASE WHEN (SPM_StatusCd+SPM_EQOptOut) = 'YY' THEN 'SMEQU' ELSE CASE WHEN SPM_StatusCd = 'Y' THEN 'SMSND' ELSE '' END END, 
comm_note_txt = CommBE.dbo.comm_customer_master.SPM_ReasonTxt
FROM            CommBE.dbo.comm_customer_master INNER JOIN
                         BRS_Customer ON CommBE.dbo.comm_customer_master.hsi_shipto_id = BRS_Customer.ShipTo

-- BranchZone

UPDATE       BRS_Branch
SET                ZoneName = [zone_cd]
FROM            CommBE.dbo.comm_branch INNER JOIN
                         BRS_Branch ON CommBE.dbo.comm_branch.branch_cd = BRS_Branch.Branch

-- purge and clean commBE data
-- 1m48 min / month?

delete from dbo.comm_transaction where 
fiscal_yearmo_num = 201501
GO

delete from dbo.comm_transaction where 
fiscal_yearmo_num = 201502
GO

delete from dbo.comm_transaction where 
fiscal_yearmo_num = 201503
GO

delete from dbo.comm_transaction where 
fiscal_yearmo_num = 201504
GO

delete from dbo.comm_transaction where 
fiscal_yearmo_num = 201505

GO
delete from dbo.comm_transaction where 
fiscal_yearmo_num = 201506
GO


delete from dbo.comm_transaction where 
fiscal_yearmo_num = 201507
GO

delete from dbo.comm_transaction where 
fiscal_yearmo_num = 201508
GO

delete from dbo.comm_transaction where 
fiscal_yearmo_num = 201509
GO

delete from dbo.comm_transaction where 
fiscal_yearmo_num = 201510
GO

delete from dbo.comm_transaction where 
fiscal_yearmo_num = 201511

GO
delete from dbo.comm_transaction where 
fiscal_yearmo_num = 201512
GO

--
select name from sys.foreign_keys where name like 'FK_transaction_F555115%' 
/*
FK_transaction_F555115_BRS_FiscalMonth
FK_transaction_F555115_BRS_FSC_Rollup
FK_transaction_F555115_BRS_FSC_Rollup1
FK_transaction_F555115_BRS_FSC_Rollup2
FK_transaction_F555115_BRS_FSC_Rollup3
FK_transaction_F555115_BRS_SalesDay
FK_transaction_F555115_BRS_TransactionDW_Ext
FK_transaction_F555115_BRS_OrderSource
FK_transaction_F555115_BRS_Item
FK_transaction_F555115_salesperson_master
FK_transaction_F555115_salesperson_master1
FK_transaction_F555115_plan
FK_transaction_F555115_plan1
FK_transaction_F555115_group
FK_transaction_F555115_group1
FK_transaction_F555115_BRS_DocType
FK_transaction_F555115_BRS_Customer
FK_transaction_F555115_BRS_CustomerBT
FK_transaction_F555115_BRS_ItemMPC
FK_transaction_F555115_BRS_SalesDivision
FK_transaction_F555115_BRS_CustomerVPA

FK_transaction_F555115_BRS_FSC_Rollup4
FK_transaction_F555115_BRS_BusinessUnit
FK_transaction_F555115_BRS_CustomerSpecialty
FK_transaction_F555115_BRS_ItemSupplier
FK_transaction_F555115_group2
FK_transaction_F555115_plan2
FK_transaction_F555115_salesperson_master2
*/

-- ok
SELECT
	TOP 10
	fiscal_yearmo_num

FROM DEV_CommBE.[dbo].[comm_transaction]
WHERE NOT EXISTS (
	SELECT * FROM [dbo].[BRS_FiscalMonth] WHERE fiscal_yearmo_num = [FiscalMonth]
)

--ok
SELECT 
	TOP 10
	salesperson_cd

FROM DEV_CommBE.[dbo].[comm_transaction]
WHERE NOT EXISTS (
	SELECT * FROM [dbo].[BRS_FSC_Rollup] WHERE salesperson_cd = [TerritoryCd]
)


--ok
SELECT 
	TOP 10
	pmts_salesperson_cd

FROM DEV_CommBE.[dbo].[comm_transaction]
WHERE NOT EXISTS (
	SELECT * FROM [dbo].[BRS_FSC_Rollup] WHERE pmts_salesperson_cd = [TerritoryCd]
)

--ok
SELECT 
	TOP 10
	salesperson_key_id

FROM DEV_CommBE.[dbo].[comm_transaction]
WHERE NOT EXISTS (
	SELECT * FROM [comm].[salesperson_master] WHERE salesperson_key_id = [salesperson_key_id]
)

--ok
SELECT 
	TOP 10
	ess_salesperson_key_id

FROM DEV_CommBE.[dbo].[comm_transaction]
WHERE NOT EXISTS (
	SELECT * FROM [comm].[salesperson_master] WHERE ess_salesperson_key_id = [salesperson_key_id]
)

--ok
SELECT 
	TOP 10
	comm_plan_id

FROM DEV_CommBE.[dbo].[comm_transaction]
WHERE NOT EXISTS (
	SELECT * FROM [comm].[plan] WHERE DEV_CommBE.[dbo].[comm_transaction].comm_plan_id = [comm_plan_id]
)
--ok
SELECT 
	TOP 10
	ess_comm_plan_id

FROM DEV_CommBE.[dbo].[comm_transaction]
WHERE NOT EXISTS (
	SELECT * FROM [comm].[plan] WHERE ess_comm_plan_id = [comm_plan_id]
)

--ok
SELECT 
	TOP 10
	item_comm_group_cd

FROM DEV_CommBE.[dbo].[comm_transaction]
WHERE NOT EXISTS (
	SELECT * FROM [comm].[group] WHERE item_comm_group_cd = [comm_group_cd]
)

--ok
SELECT 
	TOP 10
	ess_comm_group_cd

FROM DEV_CommBE.[dbo].[comm_transaction]
WHERE NOT EXISTS (
	SELECT * FROM [comm].[group] WHERE ess_comm_group_cd = [comm_group_cd]
)

-- ok
SELECT 
	TOP 10
	doc_type_cd

FROM DEV_CommBE.[dbo].[comm_transaction]
WHERE NOT EXISTS (
	SELECT * FROM [dbo].[BRS_DocType] WHERE doc_type_cd = [DocType]
)

--ok
SELECT 
	TOP 10
	hsi_shipto_id

FROM DEV_CommBE.[dbo].[comm_transaction]
WHERE NOT EXISTS (
	SELECT * FROM [dbo].[BRS_Customer] WHERE hsi_shipto_id = [ShipTo]
)

--ok
SELECT 
	TOP 10
	hsi_billto_id

FROM DEV_CommBE.[dbo].[comm_transaction]
WHERE NOT EXISTS (
	SELECT * FROM [dbo].[BRS_CustomerBT] WHERE hsi_billto_id = [BillTo]
)

-- ok
SELECT 
	TOP 10
	IMCLMJ

FROM DEV_CommBE.[dbo].[comm_transaction]
WHERE NOT EXISTS (
	SELECT * FROM [dbo].[BRS_ItemMPC] WHERE IMCLMJ = [MajorProductClass]
)

--ok
SELECT 
	TOP 10
	hsi_shipto_div_cd

FROM DEV_CommBE.[dbo].[comm_transaction]
WHERE NOT EXISTS (
	SELECT * FROM [dbo].[BRS_SalesDivision] WHERE hsi_shipto_div_cd = [SalesDivision]
)


-- fix null
SELECT 
	TOP 10
	item_id, *

FROM DEV_CommBE.[dbo].[comm_transaction]
WHERE NOT EXISTS (
	SELECT * FROM [dbo].[BRS_Item] WHERE item_id = [Item]
)

UPDATE       DEV_CommBE.dbo.comm_transaction
SET                item_id = ''
WHERE        (item_id IS NULL)

-- fix null
SELECT 
	TOP 10
	order_source_cd

FROM DEV_CommBE.[dbo].[comm_transaction]
WHERE NOT EXISTS (
	SELECT * FROM [dbo].[BRS_OrderSource] WHERE order_source_cd = [OrderSourceCode]
)

UPDATE       DEV_CommBE.dbo.comm_transaction
SET                order_source_cd = ''
WHERE        (order_source_cd IS NULL)

-- fix *ERROR* -> ''
SELECT 
	vpa_cd

FROM DEV_CommBE.[dbo].[comm_transaction]
WHERE NOT EXISTS (
	SELECT * FROM [dbo].[BRS_CustomerVPA] WHERE vpa_cd = [VPA]
)

UPDATE       DEV_CommBE.dbo.comm_transaction
SET                vpa_cd = N''
WHERE        (NOT EXISTS
                             (SELECT        *
                               FROM            BRS_CustomerVPA
                               WHERE        (DEV_CommBE.dbo.comm_transaction.vpa_cd = VPA)))

-- fix
SELECT 
	transaction_dt, CAST(transaction_dt as date) as d2

FROM DEV_CommBE.[dbo].[comm_transaction]
WHERE NOT EXISTS (
	SELECT * FROM [dbo].[BRS_SalesDay] WHERE transaction_dt = [SalesDate]
)

UPDATE       DEV_CommBE.dbo.comm_transaction
SET                transaction_dt = CAST(transaction_dt as date)
WHERE        (NOT EXISTS
                             (SELECT        *
                               FROM            BRS_SalesDay
                               WHERE        (DEV_CommBE.dbo.comm_transaction.transaction_dt = SalesDate)))

-- fix Left(1)
SELECT 
--	TOP 10
	price_method_cd, LEFT(price_method_cd,1) pmfix

FROM DEV_CommBE.[dbo].[comm_transaction]
WHERE NOT EXISTS (
	SELECT * FROM [dbo].[BRS_PriceMethod] WHERE price_method_cd = [PriceMethod]
)

UPDATE       DEV_CommBE.dbo.comm_transaction
SET                price_method_cd = LEFT(price_method_cd,1)
WHERE        (NOT EXISTS
                             (SELECT        *
                               FROM            BRS_PriceMethod
                               WHERE        (DEV_CommBE.dbo.comm_transaction.price_method_cd = PriceMethod)))
-- fix
SELECT 
	TOP 10
	ess_salesperson_cd, ess_salesperson_key_id

FROM DEV_CommBE.[dbo].[comm_transaction]
WHERE NOT EXISTS (
	SELECT * FROM [dbo].[BRS_FSC_Rollup] WHERE ess_salesperson_cd = [TerritoryCd]
)

UPDATE       DEV_CommBE.dbo.comm_transaction
SET                ess_salesperson_cd = N'ESS48'
WHERE        (ess_salesperson_cd = 'ESS13')

UPDATE       DEV_CommBE.dbo.comm_transaction
SET                ess_salesperson_cd = N''
WHERE        (ess_salesperson_cd = 'OCTOBER 21')

/*
ESS13     	HouseNCZHESS -=>ESS48                 
ESS13     	HouseNCZHESS                  
OCTOBER 21	              =>''                
*/

-- fix3 add AZAZZ to DWext?
-- fix4 ?
SELECT 
	* 
--	doc_id
FROM DEV_CommBE.[dbo].[comm_transaction]
WHERE hsi_shipto_div_cd not in ('AZA', 'AZE') and  NOT EXISTS (
	SELECT * FROM [dbo].[BRS_TransactionDW_Ext] WHERE ISNULL(doc_id,0) =[SalesOrderNumber] 
)

UPDATE       DEV_CommBE.dbo.comm_transaction
SET                doc_id = N'0'
WHERE        (doc_id = 'NA')

UPDATE       BRS_Transaction
SET                SalesOrderNumber = 0
WHERE        (DocType = 'aa')  AND (NOT EXISTS
                             (SELECT        * 
                               FROM            BRS_TransactionDW_Ext AS ext
                               WHERE        (BRS_Transaction.SalesOrderNumber = SalesOrderNumber)))

UPDATE       DEV_CommBE.dbo.comm_transaction
SET                doc_id = N'0'
WHERE        (doc_id is null)

INSERT INTO [dbo].[BRS_TransactionDW_Ext] ([SalesOrderNumber], DocType)
SELECT         distinct SalesOrderNumber, DocType
FROM            BRS_Transaction t where SalesOrderNumber IS NOT NULL AND  NOT exists 
	(select * from [dbo].[BRS_TransactionDW_Ext] ext where t.SalesOrderNumber = ext.[SalesOrderNumber]) 


BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Transaction ADD CONSTRAINT
	FK_BRS_Transaction_BRS_TransactionDW_Ext FOREIGN KEY
	(
	SalesOrderNumber
	) REFERENCES dbo.BRS_TransactionDW_Ext
	(
	SalesOrderNumber
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Transaction SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


UPDATE       DEV_CommBE.dbo.comm_transaction
SET                doc_id = '0'
WHERE        (source_cd <> 'JDE') AND (NOT EXISTS
                             (SELECT        *
                               FROM            BRS_TransactionDW_Ext
                               WHERE        (ISNULL(DEV_CommBE.dbo.comm_transaction.doc_id, 0) = SalesOrderNumber)))

SELECT         doc_id, doc_type_cd, line_id, COUNT(*) AS Expr1
FROM            DEV_CommBE.dbo.comm_transaction t
GROUP BY doc_id, doc_type_cd, line_id
HAVING COUNT(*) >1

-- fix duplicate linenumbers by setting to ID (all imports)
UPDATE       DEV_CommBE.dbo.comm_transaction
SET                line_id = [record_id],[audit_id]=line_id 
where exists(
SELECT         doc_id, doc_type_cd, line_id, COUNT(*) AS Expr1
FROM            DEV_CommBE.dbo.comm_transaction t
WHERE DEV_CommBE.dbo.comm_transaction.doc_id =t.doc_id and DEV_CommBE.dbo.comm_transaction.doc_type_cd=t.doc_type_cd and DEV_CommBE.dbo.comm_transaction.line_id = t.line_id
GROUP BY doc_id, doc_type_cd, line_id
HAVING COUNT(*) >1
)


-- migrate data
INSERT INTO comm.transaction_F555115
(
FiscalMonth, fsc_code, source_cd, WSDGL__gl_date, transaction_amt, WSLNID_line_number, WSDOCO_salesorder_number, WSVR01_reference, 
WS$OSC_order_source_code, WSLITM_item_number, WSSOQS_quantity_shipped, WSPROV_price_override_code, WSDSC1_description, fsc_salesperson_key_id, 
fsc_comm_plan_id, fsc_comm_amt, WS$UNC_sales_order_cost_markup, WSCYCL_cycle_count_category, fsc_comm_group_cd, fsc_comm_rt, 
ess_salesperson_key_id, gp_ext_amt, WSDCTO_order_type, ess_comm_plan_id, ess_comm_group_cd, ess_comm_rt, ess_comm_amt, WSSHAN_shipto, 
WSSRP1_major_product_class, WSSRP2_sub_major_product_class, WSSRP3_minor_product_class, WSSRP4_sub_minor_product_class, 
WS$ESS_equipment_specialist_code, WSCAG__cagess_code, WSAN8__billto, WSAC10_division_code, WSASN__adjustment_schedule, WSSRP6_manufacturer, 
WS$PMC_promotion_code_price_method)
SELECT        
--	TOP (10) 
	fiscal_yearmo_num,
	LEFT(salesperson_cd,5),
	LEFT(source_cd,3),
	transaction_dt,
	transaction_amt,
	line_id,
	doc_id,
	ISNULL(reference_order_txt,''),
	order_source_cd,
	LEFT(item_id,10),
	shipped_qty,
	price_override_ind,
	transaction_txt,
	salesperson_key_id,
	comm_plan_id,
	comm_amt,
	cost_unit_amt,
	item_label_cd,
	item_comm_group_cd,
	item_comm_rt,
	ess_salesperson_key_id,
	gp_ext_amt,
	doc_type_cd,
	ess_comm_plan_id,
	ess_comm_group_cd,
	ess_comm_rt,
	ess_comm_amt,
	hsi_shipto_id,
	IMCLMJ,
	IMCLSJ,
	IMCLMC,
	IMCLSM,
	LEFT(ess_salesperson_cd,5),
	LEFT(pmts_salesperson_cd,5),
	hsi_billto_id,
	hsi_shipto_div_cd,
	vpa_cd,
	manufact_cd,
	price_method_cd

FROM            
	DEV_CommBE.dbo.comm_transaction
WHERE        
	(hsi_shipto_div_cd NOT IN ('AZA', 'AZE')) AND 
	(fiscal_yearmo_num = '201711')

--201708 NEW format

-- Delete FROM            comm.transaction_F555115 where (FiscalMonth = 201601)

SELECT DISTINCT source_cd 
FROM comm.transaction_F555115
WHERE FiscalMonth = 201708

update comm.transaction_F555115
set source_cd = 'JDE'
WHERE FiscalMonth = 201708

update comm.transaction_F555115
set WSDCTO_order_type = 'AA'
WHERE source_cd <> 'JDE'

SELECT        WSDCTO_order_type, source_cd, COUNT(*) AS Expr1
FROM            comm.transaction_F555115
GROUP BY WSDCTO_order_type, source_cd


