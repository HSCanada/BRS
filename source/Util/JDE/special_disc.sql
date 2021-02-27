/*

-- 7m
-- DROP TABLE STAGE_JDE_F4072  
SELECT 

--    Top 5 
	"ADAST" AS adjustment_name, 
	"ADITM" AS item_number_short, 
	"ADLITM" AS item_number, 
	"ADAITM" AS _3rd_item_number, 
	"ADAN8" AS billto, 
	"ADICID" AS itemcustomer_key_id, 
	"ADSDGR" AS order_detail_group, 
	"ADSDV1" AS sales_detail_value_01, 
	"ADSDV2" AS sales_detail_value_02, 
	"ADSDV3" AS sales_detail_value_03, 
	"ADCRCD" AS currency_code, 
	"ADUOM" AS um, 
	"ADMNQ" AS quantity_from, 
	"ADEFTJ" AS effective_date, 
	"ADEXDJ" AS expired_date, 
	"ADBSCD" AS basis, 
	"ADLEDG" AS cost_method, 
	"ADFRMN" AS formula_name, 
	"ADFVTR" AS factor_value, 
	"ADFGY" AS free_goods_yn, 
	"ADATID" AS price_adjustment_key_id, 
	"ADURCD" AS user_reserved_code, 
	"ADURDT_JDT" AS user_reserved_date_JDT, 
	"ADURAT" AS user_reserved_amount, 
	"ADURAB" AS user_reserved_number, 
	"ADURRF" AS user_reserved_reference, 
	"ADUSER" AS user_id, 
	"ADPID" AS program_id, 
	"ADJOBN" AS work_station_id, 
	"ADUPMJ" AS date_updated, 
	"ADTDAY" AS time_of_day 

INTO STAGE_JDE_F4072    

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		ADAST, 
		ADITM, 
		ADLITM, 
		ADAITM, 
		ADAN8, 
		ADICID, 
		ADSDGR, 
		ADSDV1, 
		ADSDV2, 
		ADSDV3, 
		ADCRCD, 
		ADUOM, 
		ADMNQ, 
		DATE(DIGITS(DEC(ADEFTJ+ 1900000,7,0))) ADEFTJ, 
		DATE(DIGITS(DEC(ADEXDJ+ 1900000,7,0))) ADEXDJ, 
		ADBSCD, 
		ADLEDG, 
		ADFRMN, 
		CAST((ADFVTR)/10000.0 AS DEC(15,4)) AS ADFVTR, 
		ADFGY, 
		ADATID, 
		ADURCD, 
		ADURDT AS ADURDT_JDT, 
		CAST((ADURAT)/100.0 AS DEC(15,2)) AS ADURAT, 
		ADURAB, 
		ADURRF, 
		ADUSER, 
		ADPID, 
		ADJOBN, 
		CHAR((DATE(DIGITS(DEC(ADUPMJ+ 1900000,7,0))))) ADUPMJ, 
		ADTDAY

	FROM
		ARCPDTA71.F4072
	WHERE
--		ADAST NOT IN (''CORPRICE'', ''DIVPRICE'', ''MSRPPRC'', '' '') AND
		ADEFTJ <= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT_DATE)),3,2)), SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT_DATE))),8,3)) AND 		
		ADEXDJ >= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT_DATE)),3,2)), SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT_DATE))),8,3))  		
		
')


-- x 3m
-- DROP TABLE STAGE_JDE_F4101

SELECT 

    "IMITM" AS item_number_short, 
	"IMLITM" AS item_number, 
	"IMAITM" AS _3rd_item_number, 
	"IMDSC1" AS description, 
	"IMDSC2" AS description_2, 
	"IMSRTX" AS search_text, 
	"IMALN" AS search_text_compressed, 
	"IMSRP1" AS sales_catalog_section, 
	"IMSRP2" AS sub_section, 
	"IMSRP3" AS sales_category_code_3, 
	"IMSRP4" AS sales_category_code_4, 
	"IMSRP5" AS sales_category_code_5, 
	"IMSRP6" AS category_code_6, 
	"IMSRP7" AS category_code_7, 
	"IMSRP8" AS category_code_8, 
	"IMSRP9" AS category_code_9, 
	"IMSRP0" AS category_code_10, 
	"IMPRP1" AS commodity_class, 
	"IMPRP2" AS commodity_sub_class, 
	"IMPRP3" AS supplier_rebate_code, 
	"IMPRP4" AS master_planning_family, 
	"IMPRP5" AS landed_cost_rule, 
	"IMPRP6" AS item_dimension_group, 
	"IMPRP7" AS warehouse_process_grp_1, 
	"IMPRP8" AS warehouse_process_grp_2, 
	"IMPRP9" AS warehouse_process_grp_3, 
	"IMPRP0" AS item_pool_code, 
	"IMCDCD" AS commodity_code, 
	"IMPDGR" AS product_group, 
	"IMDSGP" AS dispatch_group, 
	"IMPRGR" AS item_price_group, 
	"IMRPRC" AS basket_reprice_group, 
	"IMORPR" AS order_reprice_group, 
	"IMBUYR" AS buyer_number, 
	"IMDRAW" AS drawing_number, 
	"IMRVNO" AS last_revision_no, 
	"IMDSZE" AS drawing_size, 
	"IMVCUD" AS volume_cubic_dimensions, 
	"IMCARS" AS carrier_number, 
	"IMCARP" AS preferred_carrier_purchasing, 
	"IMSHCN" AS shipping_conditions_code, 
	"IMSHCM" AS shipping_commodity_class, 
	"IMUOM1" AS unit_of_measure, 
	"IMUOM2" AS secondary_uom, 
	"IMUOM3" AS purchasing_uom, 
	"IMUOM4" AS pricing_uom, 
	"IMUOM6" AS shipping_uom, 
	"IMUOM8" AS production_uom, 
	"IMUOM9" AS component_uom, 
	"IMUWUM" AS unit_of_measure_weight, 
	"IMUVM1" AS unit_of_measure_volume, 
	"IMSUTM" AS stocking_um, 
	"IMUMVW" AS psauvolume_or_weight, 
	"IMCYCL" AS cycle_count_category, 
	"IMGLPT" AS gl_category, 
	"IMPLEV" AS sales_price_level, 
	"IMPPLV" AS purchase_price_level, 
	"IMCLEV" AS inventory_cost_level, 
	"IMPRPO" AS gradepotency_pricing, 
	"IMCKAV" AS check_availability_yn, 
	"IMBPFG" AS bulkpacked_flag, 
	"IMSRCE" AS layer_code_source, 
	"IMOT1Y" AS potency_control, 
	"IMOT2Y" AS grade_control, 
	"IMSTDP" AS standard_potency, 
	"IMFRMP" AS from_potency, 
	"IMTHRP" AS thru_potency, 
	"IMSTDG" AS standard_grade, 
	"IMFRGD" AS from_grade, 
	"IMTHGD" AS thru_grade, 
	"IMCOTY" AS component_type, 
	"IMSTKT" AS stocking_type, 
	"IMLNTY" AS line_type, 
	"IMCONT" AS contract_item, 
	"IMBACK" AS backorders_allowed_yn, 
	"IMIFLA" AS item_flash_message, 
	"IMTFLA" AS std_uom_conversion, 
	"IMINMG" AS print_message, 
	"IMABCS" AS abc_code_1_sales, 
	"IMABCM" AS abc_code_2_margin, 
	"IMABCI" AS abc_code_3_investment, 
	"IMOVR" AS abc_code_override_indicator, 
	"IMWARR" AS warranty_item_group, 
	"IMCMCG" AS commission_category, 
	"IMSRNR" AS serial_no_required, 
	"IMPMTH" AS kit_pricing_method, 
	"IMFIFO" AS fifo_processing, 
	"IMLOTS" AS lot_status_code, 
	"IMSLD" AS shelf_life_days, 
	"IMANPL" AS planner_number, 
	"IMMPST" AS planning_code, 
	"IMPCTM" AS percent_margin, 
	"IMMMPC" AS margin_maintenance_pct, 
	"IMPTSC" AS material_status, 
	"IMSNS" AS round_to_whole_number, 
	"IMLTLV" AS leadtime_level, 
	"IMLTMF" AS leadtime_manufacturing, 
	"IMLTCM" AS leadtime_cumulative, 
	"IMOPC" AS order_policy_code, 
	"IMOPV" AS value_order_policy, 
	"IMACQ" AS accounting_cost_quantity, 
	"IMMLQ" AS mfg_leadtime_quantity, 
	"IMLTPU" AS leadtime_per_unit, 
	"IMMPSP" AS planning_fence_rule, 
	"IMMRPP" AS fixedvariable_leadtime, 
	"IMITC" AS issue_type_code, 
	"IMORDW" AS order_with_yn, 
	"IMMTF1" AS planning_fence, 
	"IMMTF2" AS freeze_fence, 
	"IMMTF3" AS message_display_fence, 
	"IMMTF4" AS time_fence, 
	"IMMTF5" AS shipment_leadtime_offset, 
	"IMEXPD" AS expedite_damper_days, 
	"IMDEFD" AS defer_damper_days, 
	"IMSFLT" AS safety_leadtime, 
	"IMMAKE" AS makebuy_code, 
	"IMCOBY" AS cobyproductintermediate, 
	"IMLLX" AS low_level_code, 
	"IMCMGL" AS commitment_method, 
	"IMCOMH" AS specific_commitment_days, 
	"IMCSNN" AS configured_string_id_next_number, 
	"IMURCD" AS user_reserved_code, 
	"IMURDT" AS user_reserved_date, 
	"IMURAT" AS user_reserved_amount, 
	"IMURAB" AS user_reserved_number, 
	"IMURRF" AS user_reserved_reference, 
	"IMUSER" AS user_id, 
	"IMPID" AS program_id, 
	"IMJOBN" AS work_station_id, 
	"IMUPMJ" AS date_updated, 
	"IMTDAY" AS time_of_day 

INTO STAGE_JDE_F4101

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		IMITM,
		IMLITM,
		IMAITM,
		IMDSC1,
		IMDSC2,
		IMSRTX,
		IMALN,
		IMSRP1,
		IMSRP2,
		IMSRP3,
		IMSRP4,
		IMSRP5,
		IMSRP6,
		IMSRP7,
		IMSRP8,
		IMSRP9,
		IMSRP0,
		IMPRP1,
		IMPRP2,
		IMPRP3,
		IMPRP4,
		IMPRP5,
		IMPRP6,
		IMPRP7,
		IMPRP8,
		IMPRP9,
		IMPRP0,
		IMCDCD,
		IMPDGR,
		IMDSGP,
		IMPRGR,
		IMRPRC,
		IMORPR,
		IMBUYR,
		IMDRAW,
		IMRVNO,
		IMDSZE,
		CAST((IMVCUD)/10000.0 AS DEC(15,4)) AS IMVCUD,
		IMCARS,
		IMCARP,
		IMSHCN,
		IMSHCM,
		IMUOM1,
		IMUOM2,
		IMUOM3,
		IMUOM4,
		IMUOM6,
		IMUOM8,
		IMUOM9,
		IMUWUM,
		IMUVM1,
		IMSUTM,
		IMUMVW,
		IMCYCL,
		IMGLPT,
		IMPLEV,
		IMPPLV,
		IMCLEV,
		IMPRPO,
		IMCKAV,
		IMBPFG,
		IMSRCE,
		IMOT1Y,
		IMOT2Y,
		CAST((IMSTDP)/1000.0 AS DEC(15,3)) AS IMSTDP,
		CAST((IMFRMP)/1000.0 AS DEC(15,3)) AS IMFRMP,
		CAST((IMTHRP)/1000.0 AS DEC(15,3)) AS IMTHRP,
		IMSTDG,
		IMFRGD,
		IMTHGD,
		IMCOTY,
		IMSTKT,
		IMLNTY,
		IMCONT,
		IMBACK,
		IMIFLA,
		IMTFLA,
		IMINMG,
		IMABCS,
		IMABCM,
		IMABCI,
		IMOVR,
		IMWARR,
		IMCMCG,
		IMSRNR,
		IMPMTH,
		IMFIFO,
		IMLOTS,
		IMSLD,
		IMANPL,
		IMMPST,
		CAST((IMPCTM)/1000.0 AS DEC(15,3)) AS IMPCTM,
		CAST((IMMMPC)/1000.0 AS DEC(15,3)) AS IMMMPC,
		IMPTSC,
		IMSNS,
		IMLTLV,
		IMLTMF,
		IMLTCM,
		IMOPC,
		IMOPV,
		IMACQ,
		IMMLQ,
		CAST((IMLTPU)/100.0 AS DEC(15,2)) AS IMLTPU,
		IMMPSP,
		IMMRPP,
		IMITC,
		IMORDW,
		IMMTF1,
		IMMTF2,
		IMMTF3,
		IMMTF4,
		IMMTF5,
		IMEXPD,
		IMDEFD,
		IMSFLT,
		IMMAKE,
		IMCOBY,
		IMLLX,
		IMCMGL,
		IMCOMH,
		IMCSNN,
		IMURCD,
		DATE(DIGITS(DEC(IMURDT+ 1900000,7,0))) IMURDT,
		CAST((IMURAT)/100.0 AS DEC(15,2)) AS IMURAT,
		IMURAB,
		IMURRF,
		IMUSER,
		IMPID,
		IMJOBN,
		DATE(DIGITS(DEC(IMUPMJ+ 1900000,7,0))) IMUPMJ,
		IMTDAY


	FROM
		ARCPDTA71.F4101
')

--

-- 1.5m
-- DROP TABLE STAGE_JDE_F5613

SELECT 

    "QNITM" AS item_number_short,
	"QNLITM" AS item_number,
	"QNAITM" AS _3rd_item_number,
	"QN$FIN" AS force_item_notes,
	"QN$FRT" AS freightable_item,
	"QN$IVP" AS inventory_percentage,
	"QN$CEM" AS ce_mark,
	"QN$CER" AS ce_mark_required,
	"QN$RPK" AS repack,
	"QN$SPC" AS supplier_code,
	"QN$SZE" AS size_packaged_units,
	"QN$STR" AS strength,
	"QN$MDC" AS multiple_drug_classes,
	"QN$STU" AS status,
	"QN$DS" AS drop_ship,
	"QN$IFP" AS inbound_frt_adj_pct,
	"QN$IFD" AS inbound_frt_adj_amt,
	"QN$SOM" AS sales_order_markup,
	"QNLTDT" AS transit_days,
	"QNINMG" AS print_message,
	"QNUSER" AS user_id,
	"QNPID" AS program_id,
	"QNJOBN" AS work_station_id,
	"QNUPMJ" AS date_updated,
	"QNTDAY" AS time_of_day 

INTO STAGE_JDE_F5613

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		QNITM,
		QNLITM,
		QNAITM,
		QN$FIN,
		QN$FRT,
		CAST((QN$IVP)/1000.0 AS DEC(15,3)) AS QN$IVP,
		QN$CEM,
		QN$CER,
		QN$RPK,
		QN$SPC,
		QN$SZE,
		QN$STR,
		QN$MDC,
		QN$STU,
		QN$DS,
		QN$IFP,
		QN$IFD,
		CAST((QN$SOM)/10000.0 AS DEC(15,4)) AS QN$SOM,
		QNLTDT,
		QNINMG,
		QNUSER,
		QNPID,
		QNJOBN,
		DATE(DIGITS(DEC(QNUPMJ+ 1900000,7,0))) QNUPMJ,
		QNTDAY

	FROM
		ARCPDTA71.F5613
')



-- 1.5m
-- DROP TABLE STAGE_JDE_F4094

SELECT 

    "KIPRGR" AS item_price_group,
	"KIIGP1" AS item_group_category_code_01,
	"KIIGP2" AS item_group_category_code_02,
	"KIIGP3" AS item_group_category_code_03,
	"KIIGP4" AS item_group_category_code_04,
	"KICPGP" AS customer_price_group,
	"KICGP1" AS customer_group_category_code_01,
	"KICGP2" AS customer_group_category_code_02,
	"KICGP3" AS customer_group_category_code_03,
	"KICGP4" AS customer_group_category_code_04,
	"KIICID" AS itemcustomer_key_id 

INTO STAGE_JDE_F4094

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		KIPRGR,
		KIIGP1,
		KIIGP2,
		KIIGP3,
		KIIGP4,
		KICPGP,
		KICGP1,
		KICGP2,
		KICGP3,
		KICGP4,
		KIICID

	FROM
		ARCPDTA71.F4094
')

--


-- 8.3m
-- DROP TABLE STAGE_JDE_F41061

SELECT 

    "CBMCU" AS business_unit,
	"CBAN8" AS billto,
	"CBITM" AS item_number_short,
	"CBLITM" AS item_number,
	"CBAITM" AS _3rd_item_number,
	"CBCATN" AS catalog,
	"CBDMCT" AS agreement_nbr,
	"CBDMCS" AS agreement_supplement,
	"CBKCOO" AS order_company,
	"CBDOCO" AS salesorder_number,
	"CBDCTO" AS order_type,
	"CBLNID" AS line_number,
	"CBCRCD" AS currency_code,
	"CBUOM" AS um,
	"CBPRRC" AS unit_cost,
	"CBUORG" AS quantity,
	"CBEFTJ" AS effective_date,
	"CBEXDJ" AS expired_date,
	"CBUSER" AS user_id,
	"CBPID" AS program_id,
	"CBJOBN" AS work_station_id,
	"CBUPMJ" AS date_updated,
	"CBTDAY" AS time_of_day 

INTO STAGE_JDE_F41061

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		CBMCU,
		CBAN8,
		CBITM,
		CBLITM,
		CBAITM,
		CBCATN,
		CBDMCT,
		CBDMCS,
		CBKCOO,
		CBDOCO,
		CBDCTO,
		CAST((CBLNID)/1000.0 AS DEC(15,3)) AS CBLNID,
		CBCRCD,
		CBUOM,
		CAST((CBPRRC)/10000.0 AS DEC(15,4)) AS CBPRRC,
		CBUORG,
		DATE(DIGITS(DEC(CBEFTJ+ 1900000,7,0))) CBEFTJ,
		DATE(DIGITS(DEC(CBEXDJ+ 1900000,7,0))) CBEXDJ,
		CBUSER,
		CBPID,
		CBJOBN,
		DATE(DIGITS(DEC(CBUPMJ+ 1900000,7,0))) CBUPMJ,
		CBTDAY

	FROM
		ARCPDTA71.F41061

	-- add eff day filter
')
--


-- ** Fix date fields **

-- DROP TABLE STAGE_JDE_F5830

SELECT 
	top 10

	"VA$CN2" AS contract_number,
	"VAKCOO" AS order_company,
	"VA$EON" AS manufacturers_external_contract_number,
	"VADESC" AS description,
	"VA$FD" AS start_date,
	"VA$TD" AS end_date,
	"VAEFTB" AS start_effective_date,
	"VA$DCA" AS date_contract_activated,
	"VAODDJ" AS original_due_date,
	"VADGCG" AS change_date,
	"VACNDJ" AS cancel_date,
	"VAEXDJ" AS expired_date,
	"VASRP6" AS category_code_6,
	"VA$MA1" AS alternate_manufacturer_1,
	"VA$MA2" AS alternate_manufacturer_2,
	"VA$MA3" AS alternate_manufacturer_3,
	"VA$MA4" AS alternate_manufacturer_4,
	"VA$MA5" AS alternate_manufacturer_5,
	"VA$MA6" AS alternate_manufacturer_6,
	"VAUSA1" AS address_number_1_user,
	"VAGCNT" AS contract_number_gpo,
	"VACRTU" AS created_by_user,
	"VACRDJ" AS creation_date,
	"VAUPMB" AS updated_by,
	"VA$SLM" AS sales_approval,
	"VA$VAP" AS vendor_approval,
	"VA$OTY" AS transaction_type,
	"VA$PCF" AS chargeback_cycle,
	"VA$AFC" AS admin_fee_cycle,
	"VA$OTP" AS chargeback_output_type,
	"VA$CST" AS status_chargebacks,
	"VA$FGY" AS multi_purpose_flag,
	"VA$CRN" AS number_contract_cross_reference,
	"VA$IAS" AS status_include_all_sales,
	"VA$FMT" AS edi_document_format,
	"VA$HIN" AS hindea_required,
	"VA$CPT" AS chargeback_payment_type,
	"VA$SCG" AS service_charge_percent_admin_fee,
	"VA$PC1" AS chargeback_percent_factors_1,
	"VA$FC1" AS chargeback_dollar_factors_1,
	"VA$RET" AS retro,
	"VA$RPV" AS retro_processed_values,
	"VA$RD" AS reset_chargeback_data,
	"VA$RC" AS recurring_chargeback,
	"VA$CL" AS chargeback_calc_type,
	"VA$TOC" AS type_of_cost,
	"VA$CAL" AS contract_accumulation_level,
	"VA$BIS" AS bid_incoming_sequence_number,
	"VA$CLV" AS contract_level,
	"VALINN" AS line_number,
	"VABA" AS beginning_gl_account_number,
	"VARP07" AS line_of_business,
	"VARP10" AS category_code_10,
	"VA$FG1" AS flag_1,
	"VA$CMT" AS comment,
	"VACONC" AS compressed_contract_name,
	"VAPH2" AS phone_number,
	"VAEML" AS email_address,
	"VAURAT" AS user_reserved_amount,
	"VAURCD" AS user_reserved_code,
	"VAURDT" AS user_reserved_date,
	"VAURAB" AS user_reserved_number,
	"VAURRF" AS user_reserved_reference,
	"VA$RV1" AS user_reserved_field,
	"VA$RV2" AS user_reserved_field_2,
	"VA$RV3" AS user_reserved_field_3,
	"VA$RV4" AS user_reserved_field_4,
	"VA$RV5" AS user_reserved_field_5,
	"VAURC1" AS user_reserved_code_2,
	"VAURC2" AS user_reserved_code_3,
	"VAUSD1" AS user_date_1,
	"VAUSD2" AS user_date_2,
	"VAUSD3" AS user_date_3,
	"VAUDC1" AS user_defined_code__1,
	"VAUDC2" AS user_defined_code__2,
	"VAUDC3" AS user_defined_code__3,
	"VA$AM1" AS user_amount_future_1,
	"VA$AM2" AS user_amount_future_2,
	"VA$AM3" AS user_amount_future_3,
	"VAUSER" AS user_id,
	"VAJOBN" AS work_station_id,
	"VAPID" AS program_id,
	"VAUPMJ" AS date_updated,
	"VATDAY" AS time_of_day 

-- INTO STAGE_JDE_F5830

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		VA$CN2,
		VAKCOO,
		VA$EON,
		VADESC,
		CASE WHEN VA$FD IS NOT NULL THEN DATE(DIGITS(DEC(VA$FD+ 1900000,7,0))) ELSE NULL END AS VA$FD,
		CASE WHEN VA$TD IS NOT NULL THEN DATE(DIGITS(DEC(VA$TD+ 1900000,7,0))) ELSE NULL END AS VA$TD,
		CASE WHEN VAEFTB IS NOT NULL THEN DATE(DIGITS(DEC(VAEFTB+ 1900000,7,0))) ELSE NULL END AS VAEFTB,
		CASE WHEN VA$DCA IS NOT NULL THEN DATE(DIGITS(DEC(VA$DCA+ 1900000,7,0))) ELSE NULL END AS VA$DCA,
		CASE WHEN VAODDJ IS NOT NULL THEN DATE(DIGITS(DEC(VAODDJ+ 1900000,7,0))) ELSE NULL END AS VAODDJ,
		CASE WHEN VADGCG IS NOT NULL THEN DATE(DIGITS(DEC(VADGCG+ 1900000,7,0))) ELSE NULL END AS VADGCG,
		CASE WHEN VACNDJ IS NOT NULL THEN DATE(DIGITS(DEC(VACNDJ+ 1900000,7,0))) ELSE NULL END AS VACNDJ,
		CASE WHEN VAEXDJ IS NOT NULL THEN DATE(DIGITS(DEC(VAEXDJ+ 1900000,7,0))) ELSE NULL END AS VAEXDJ,
		VASRP6,
		VA$MA1,
		VA$MA2,
		VA$MA3,
		VA$MA4,
		VA$MA5,
		VA$MA6,
		VAUSA1,
		VAGCNT,
		VACRTU,
		CASE WHEN VACRDJ IS NOT NULL THEN DATE(DIGITS(DEC(VACRDJ+ 1900000,7,0))) ELSE NULL END AS VACRDJ,
		VAUPMB,
		VA$SLM,
		VA$VAP,
		VA$OTY,
		VA$PCF,
		VA$AFC,
		VA$OTP,
		VA$CST,
		VA$FGY,
		VA$CRN,
		VA$IAS,
		VA$FMT,
		VA$HIN,
		VA$CPT,
		CAST((VA$SCG)/10.0 AS DEC(15,1)) AS VA$SCG,
		CAST((VA$PC1)/100.0 AS DEC(15,2)) AS VA$PC1,
		CAST((VA$FC1)/100.0 AS DEC(15,2)) AS VA$FC1,
		VA$RET,
		VA$RPV,
		VA$RD,
		VA$RC,
		VA$CL,
		VA$TOC,
		VA$CAL,
		VA$BIS,
		VA$CLV,
		CAST((VALINN)/1000.0 AS DEC(15,3)) AS VALINN,
		VABA,
		VARP07,
		VARP10,
		VA$FG1,
		VA$CMT,
		VACONC,
		VAPH2,
		VAEML,
		CAST((VAURAT)/100.0 AS DEC(15,2)) AS VAURAT,
		VAURCD,
		CASE WHEN VAURDT IS NOT NULL THEN DATE(DIGITS(DEC(VAURDT+ 1900000,7,0))) ELSE NULL END AS VAURDT,
		VAURAB,
		VAURRF,
		VA$RV1,
		VA$RV2,
		VA$RV3,
		VA$RV4,
		VA$RV5,
		VAURC1,
		VAURC2,
		CASE WHEN VAUSD1 IS NOT NULL THEN DATE(DIGITS(DEC(VAUSD1+ 1900000,7,0))) ELSE NULL END AS VAUSD1,
		CASE WHEN VAUSD2 IS NOT NULL THEN DATE(DIGITS(DEC(VAUSD2+ 1900000,7,0))) ELSE NULL END AS VAUSD2,
		CASE WHEN VAUSD3 IS NOT NULL THEN DATE(DIGITS(DEC(VAUSD3+ 1900000,7,0))) ELSE NULL END AS VAUSD3,
		VAUDC1,
		VAUDC2,
		VAUDC3,
		CAST((VA$AM1)/100.0 AS DEC(15,2)) AS VA$AM1,
		CAST((VA$AM2)/100.0 AS DEC(15,2)) AS VA$AM2,
		CAST((VA$AM3)/100.0 AS DEC(15,2)) AS VA$AM3,
		VAUSER,
		VAJOBN,
		VAPID,
		CASE WHEN VAUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(VAUPMJ+ 1900000,7,0))) ELSE NULL END AS VAUPMJ,
		VATDAY


	FROM
		ARCPDTA71.F5830
')

--



-- ** Fix bad date **
-- DROP TABLE STAGE_JDE_F5831

SELECT 
	top 10

    "VB$CN2" AS contract_number,
	"VBKCOO" AS order_company,
	"VB$EON" AS manufacturers_external_contract_number,
	"VBSRP6" AS category_code_6,
	"VBLITM" AS item_number,
	"VBCITM" AS customersupplier_item_number,
	"VBSRP1" AS sales_catalog_section,
	"VBSRP2" AS sub_section,
	"VBSRP3" AS sales_category_code_3,
	"VBSRP4" AS sales_category_code_4,
	"VBLINN" AS line_number,
	"VB$FD" AS start_date,
	"VB$TD" AS end_date,
	"VB$CCC" AS cost_contract_cost_chargebacks,
	"VB$FC1" AS chargeback_dollar_factors_1,
	"VB$PC1" AS chargeback_percent_factors_1,
	"VB$MNC" AS manual_cost_chargebacks,
	"VB$IS" AS contract_item_status,
	"VBCRTU" AS created_by_user,
	"VBCRDJ" AS creation_date,
	"VBDGCG" AS change_date,
	"VBUPMB" AS updated_by,
	"VB$CRN" AS number_contract_cross_reference,
	"VBAC10" AS category_code_10,
	"VBSIC" AS industry_classification,
	"VBURAT" AS user_reserved_amount,
	"VBURCD" AS user_reserved_code,
	"VBURDT" AS user_reserved_date,
	"VBURAB" AS user_reserved_number,
	"VBURRF" AS user_reserved_reference,
	"VB$RV1" AS user_reserved_field_1,
	"VB$RV2" AS user_reserved_field_2,
	"VB$RV3" AS user_reserved_field_3,
	"VB$RV4" AS user_reserved_field_4,
	"VB$RV5" AS user_reserved_field_5,
	"VBURC1" AS user_reserved_code_1,
	"VBURC2" AS user_reserved_code_2,
	"VBUSD1" AS user_date_1,
	"VBUSD2" AS user_date_2,
	"VBUSD3" AS user_date_3,
	"VBUDC1" AS user_defined_code_1,
	"VBUDC2" AS user_defined_code_2,
	"VBUDC3" AS user_defined_code_3,
	"VB$AM1" AS user_amount_future_1,
	"VB$AM2" AS user_amount_future_2,
	"VB$AM3" AS user_amount_future_3,
	"VBUSER" AS user_id,
	"VBJOBN" AS work_station_id,
	"VBPID" AS program_id,
	"VBUPMJ" AS date_updated,
	"VBTDAY" AS time_of_day 

-- INTO STAGE_JDE_F5831

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		VB$CN2,
		VBKCOO,
		VB$EON,
		VBSRP6,
		VBLITM,
		VBCITM,
		VBSRP1,
		VBSRP2,
		VBSRP3,
		VBSRP4,
		CAST((VBLINN)/1000.0 AS DEC(15,3)) AS VBLINN,
		CASE WHEN VB$FD IS NOT NULL THEN DATE(DIGITS(DEC(VB$FD+ 1900000,7,0))) ELSE NULL END AS VB$FD,
		CASE WHEN VB$TD IS NOT NULL THEN DATE(DIGITS(DEC(VB$TD+ 1900000,7,0))) ELSE NULL END AS VB$TD,
		CAST((VB$CCC)/100.0 AS DEC(15,2)) AS VB$CCC,
		CAST((VB$FC1)/100.0 AS DEC(15,2)) AS VB$FC1,
		CAST((VB$PC1)/100.0 AS DEC(15,2)) AS VB$PC1,
		CAST((VB$MNC)/100.0 AS DEC(15,2)) AS VB$MNC,
		VB$IS,
		VBCRTU,
		CASE WHEN VBCRDJ IS NOT NULL THEN DATE(DIGITS(DEC(VBCRDJ+ 1900000,7,0))) ELSE NULL END AS VBCRDJ,
		CASE WHEN VBDGCG IS NOT NULL THEN DATE(DIGITS(DEC(VBDGCG+ 1900000,7,0))) ELSE NULL END AS VBDGCG,
		VBUPMB,
		VB$CRN,
		VBAC10,
		VBSIC,
		CAST((VBURAT)/100.0 AS DEC(15,2)) AS VBURAT,
		VBURCD,
		CASE WHEN VBURDT IS NOT NULL THEN DATE(DIGITS(DEC(VBURDT+ 1900000,7,0))) ELSE NULL END AS VBURDT,
		VBURAB,
		VBURRF,
		VB$RV1,
		VB$RV2,
		VB$RV3,
		VB$RV4,
		VB$RV5,
		VBURC1,
		VBURC2,
		CASE WHEN VBUSD1 IS NOT NULL THEN DATE(DIGITS(DEC(VBUSD1+ 1900000,7,0))) ELSE NULL END AS VBUSD1,
		CASE WHEN VBUSD2 IS NOT NULL THEN DATE(DIGITS(DEC(VBUSD2+ 1900000,7,0))) ELSE NULL END AS VBUSD2,
		CASE WHEN VBUSD3 IS NOT NULL THEN DATE(DIGITS(DEC(VBUSD3+ 1900000,7,0))) ELSE NULL END AS VBUSD3,
		VBUDC1,
		VBUDC2,
		VBUDC3,
		CAST((VB$AM1)/100.0 AS DEC(15,2)) AS VB$AM1,
		CAST((VB$AM2)/100.0 AS DEC(15,2)) AS VB$AM2,
		CAST((VB$AM3)/100.0 AS DEC(15,2)) AS VB$AM3,
		VBUSER,
		VBJOBN,
		VBPID,
		CASE WHEN VBUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(VBUPMJ+ 1900000,7,0))) ELSE NULL END AS VBUPMJ,
		VBTDAY


	FROM
		ARCPDTA71.F5831
	order by VBUPMJ desc
')


--

--

-- DROP TABLE STAGE_JDE_F5832

SELECT 
	top 10

	"VE$CN2" AS contract_number,
	"VE$EON" AS manufacturers_external_contract_number,
	"VEKCOO" AS order_company,
	"VE$CAL" AS contract_accumulation_level,
	"VE$SNB" AS sequence_number,
	"VEASN" AS adjustment_schedule,
	"VE$CGP" AS customer_group_id,
	"VEAC10" AS category_code_10,
	"VEAC02" AS account_representative,
	"VESIC" AS industry_classification,
	"VELINN" AS line_number,
	"VECRTU" AS created_by_user,
	"VECRDJ" AS creation_date,
	"VERCDS" AS record_status,
	"VEUPMB" AS updated_by,
	"VEDGCG" AS change_date,
	"VEURAT" AS user_reserved_amount,
	"VEURCD" AS user_reserved_code,
	"VEURDT" AS user_reserved_date,
	"VEURAB" AS user_reserved_number,
	"VEURRF" AS user_reserved_reference,
	"VE$RV1" AS user_reserved_field,
	"VE$RV2" AS user_reserved_field,
	"VE$RV3" AS user_reserved_field,
	"VE$RV4" AS user_reserved_field,
	"VE$RV5" AS user_reserved_field,
	"VEURC1" AS user_reserved_code,
	"VEURC2" AS user_reserved_code,
	"VEUSD1" AS user_date_1,
	"VEUSD2" AS user_date_2,
	"VEUSD3" AS user_date_3,
	"VEUDC1" AS user_defined_code__1,
	"VEUDC2" AS user_defined_code__2,
	"VEUDC3" AS user_defined_code__3,
	"VE$AM1" AS user_amount_future_1,
	"VE$AM2" AS user_amount_future_2,
	"VE$AM3" AS user_amount_future_3,
	"VEUSER" AS user_id,
	"VEPID" AS program_id,
	"VEJOBN" AS work_station_id,
	"VEUPMJ" AS date_updated,
	"VETDAY" AS time_of_day 

-- INTO STAGE_JDE_F5832

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		VE$CN2,
		VE$EON,
		VEKCOO,
		VE$CAL,
		CAST((VE$SNB)/100.0 AS DEC(15,2)) AS VE$SNB,
		VEASN,
		VE$CGP,
		VEAC10,
		VEAC02,
		VESIC,
		CAST((VELINN)/1000.0 AS DEC(15,3)) AS VELINN,
		VECRTU,
		CASE WHEN VECRDJ IS NOT NULL THEN DATE(DIGITS(DEC(VECRDJ+ 1900000,7,0))) ELSE NULL END AS VECRDJ,
		VERCDS,
		VEUPMB,
		CASE WHEN VEDGCG IS NOT NULL THEN DATE(DIGITS(DEC(VEDGCG+ 1900000,7,0))) ELSE NULL END AS VEDGCG,
		CAST((VEURAT)/100.0 AS DEC(15,2)) AS VEURAT,
		VEURCD,
		CASE WHEN VEURDT IS NOT NULL THEN DATE(DIGITS(DEC(VEURDT+ 1900000,7,0))) ELSE NULL END AS VEURDT,
		VEURAB,
		VEURRF,
		VE$RV1,
		VE$RV2,
		VE$RV3,
		VE$RV4,
		VE$RV5,
		VEURC1,
		VEURC2,
		CASE WHEN VEUSD1 IS NOT NULL THEN DATE(DIGITS(DEC(VEUSD1+ 1900000,7,0))) ELSE NULL END AS VEUSD1,
		CASE WHEN VEUSD2 IS NOT NULL THEN DATE(DIGITS(DEC(VEUSD2+ 1900000,7,0))) ELSE NULL END AS VEUSD2,
		CASE WHEN VEUSD3 IS NOT NULL THEN DATE(DIGITS(DEC(VEUSD3+ 1900000,7,0))) ELSE NULL END AS VEUSD3,
		VEUDC1,
		VEUDC2,
		VEUDC3,
		CAST((VE$AM1)/100.0 AS DEC(15,2)) AS VE$AM1,
		CAST((VE$AM2)/100.0 AS DEC(15,2)) AS VE$AM2,
		CAST((VE$AM3)/100.0 AS DEC(15,2)) AS VE$AM3,
		VEUSER,
		VEPID,
		VEJOBN,
		CASE WHEN VEUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(VEUPMJ+ 1900000,7,0))) ELSE NULL END AS VEUPMJ,
		VETDAY


	FROM
		ARCPDTA71.F5832
')

--



--



-- DROP TABLE STAGE_JDE_F564201

SELECT 

    *


FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		*
	FROM
		QSYS2.SYSTABLES
	WHERE
--		TABLE_NAME = ''F564201'' AND
		TABLE_SCHEMA = ''HSIPDTA93'' AND
		TABLE_TYPE = ''P''
')

*/

-- DROP TABLE STAGE_JDE_F4072

SELECT 

    Top 5 "ADAST" AS ADAST_adjustment_name, "ADITM" AS ADITM_item_number_short, "ADLITM" AS ADLITM_item_number, "ADAITM" AS ADAITM__3rd_item_number, "ADAN8" AS ADAN8_billto, "ADICID" AS ADICID_itemcustomer_key_id, "ADSDGR" AS ADSDGR_order_detail_group, "ADSDV1" AS ADSDV1_sales_detail_value_01, "ADSDV2" AS ADSDV2_sales_detail_value_02, "ADSDV3" AS ADSDV3_sales_detail_value_03, "ADCRCD" AS ADCRCD_currency_code, "ADUOM" AS ADUOM_um, "ADMNQ" AS ADMNQ_quantity_from, "ADEFTJ" AS ADEFTJ_effective_date, "ADEXDJ" AS ADEXDJ_expired_date, "ADBSCD" AS ADBSCD_basis, "ADLEDG" AS ADLEDG_cost_method, "ADFRMN" AS ADFRMN_formula_name, "ADFVTR" AS ADFVTR_factor_value, "ADFGY" AS ADFGY_free_goods_yn, "ADATID" AS ADATID_price_adjustment_key_id, "ADURCD" AS ADURCD_user_reserved_code, "ADURDT" AS ADURDT_user_reserved_date, "ADURAT" AS ADURAT_user_reserved_amount, "ADURAB" AS ADURAB_user_reserved_number, "ADURRF" AS ADURRF_user_reserved_reference, "ADUSER" AS ADUSER_user_id, "ADPID" AS ADPID_program_id, "ADJOBN" AS ADJOBN_work_station_id, "ADUPMJ" AS ADUPMJ_date_updated, "ADTDAY" AS ADTDAY_time_of_day 

-- INTO STAGE_JDE_F4072

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		ADAST, ADITM, ADLITM, ADAITM, ADAN8, ADICID, ADSDGR, ADSDV1, ADSDV2, ADSDV3, ADCRCD, ADUOM, ADMNQ, CASE WHEN ADEFTJ IS NOT NULL THEN DATE(DIGITS(DEC(ADEFTJ+ 1900000,7,0))) ELSE NULL END AS ADEFTJ, CASE WHEN ADEXDJ IS NOT NULL THEN DATE(DIGITS(DEC(ADEXDJ+ 1900000,7,0))) ELSE NULL END AS ADEXDJ, ADBSCD, ADLEDG, ADFRMN, CAST((ADFVTR)/10000.0 AS DEC(15,4)) AS ADFVTR, ADFGY, ADATID, ADURCD, CASE WHEN ADURDT IS NOT NULL THEN DATE(DIGITS(DEC(ADURDT+ 1900000,7,0))) ELSE NULL END AS ADURDT, CAST((ADURAT)/100.0 AS DEC(15,2)) AS ADURAT, ADURAB, ADURRF, ADUSER, ADPID, ADJOBN, CASE WHEN ADUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(ADUPMJ+ 1900000,7,0))) ELSE NULL END AS ADUPMJ, ADTDAY


	FROM
		ARCPDTA71.F4072
')
