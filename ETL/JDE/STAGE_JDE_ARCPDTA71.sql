
--------------------------------------------------------------------------------
-- DROP TABLE STAGE_JDE_ARCPDTA71_F4072_price_adjustment_detail
--------------------------------------------------------------------------------

-- 7m

SELECT 

--    Top 5 
    "ADAST" AS ADAST__adjustment_name,
	"ADITM" AS ADITM__item_number_short,
	"ADLITM" AS ADLITM_item_number,
	"ADAITM" AS ADAITM__3rd_item_number,
	"ADAN8" AS ADAN8__billto,
	"ADICID" AS ADICID_itemcustomer_key_id,
	"ADSDGR" AS ADSDGR_order_detail_group,
	"ADSDV1" AS ADSDV1_sales_detail_value_01,
	"ADSDV2" AS ADSDV2_sales_detail_value_02,
	"ADSDV3" AS ADSDV3_sales_detail_value_03,
	"ADCRCD" AS ADCRCD_currency_code,
	"ADUOM" AS ADUOM__um,
	"ADMNQ" AS ADMNQ__quantity_from,
	"ADEFTJ" AS ADEFTJ_effective_date,
	"ADEXDJ" AS ADEXDJ_expired_date,
	"ADBSCD" AS ADBSCD_basis,
	"ADLEDG" AS ADLEDG_cost_method,
	"ADFRMN" AS ADFRMN_formula_name,
	"ADFVTR" AS ADFVTR_factor_value,
	"ADFGY" AS ADFGY__free_goods_yn,
	"ADATID" AS ADATID_price_adjustment_key_id,
	"ADURCD" AS ADURCD_user_reserved_code,
	"ADURDT" AS ADURDT_user_reserved_date_JDT,
	"ADURAT" AS ADURAT_user_reserved_amount,
	"ADURAB" AS ADURAB_user_reserved_number,
	"ADURRF" AS ADURRF_user_reserved_reference,
	"ADUSER" AS ADUSER_user_id,
	"ADPID" AS ADPID__program_id,
	"ADJOBN" AS ADJOBN_work_station_id,
	"ADUPMJ" AS ADUPMJ_date_updated,
	"ADTDAY" AS ADTDAY_time_of_day 

INTO 
	STAGE_JDE_ARCPDTA71_F4072_price_adjustment_detail

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
		CASE WHEN ADEFTJ IS NOT NULL THEN DATE(DIGITS(DEC(ADEFTJ+ 1900000,7,0))) ELSE NULL END AS ADEFTJ,
		CASE WHEN ADEXDJ IS NOT NULL THEN DATE(DIGITS(DEC(ADEXDJ+ 1900000,7,0))) ELSE NULL END AS ADEXDJ,
		ADBSCD,
		ADLEDG,
		ADFRMN,
		CAST((ADFVTR)/10000.0 AS DEC(15,4)) AS ADFVTR,
		ADFGY,
		ADATID,
		ADURCD,
		ADURDT,
		CAST((ADURAT)/100.0 AS DEC(15,2)) AS ADURAT,
		ADURAB,
		ADURRF,
		ADUSER,
		ADPID,
		ADJOBN,
		CASE WHEN ADUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(ADUPMJ+ 1900000,7,0))) ELSE NULL END AS ADUPMJ,
ADTDAY

	FROM
		ARCPDTA71.F4072
    WHERE
		ADEFTJ <= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)), SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) AND 		
		ADEXDJ >= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)), SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3))  		
--    ORDER BY
--        <insert custom code here>
')



--------------------------------------------------------------------------------
-- DROP TABLE STAGE_JDE_ARCPDTA71_F4101_item_master
--------------------------------------------------------------------------------

-- 2.5 min
SELECT 

--    Top 5 
    "IMITM" AS IMITM__item_number_short,
	"IMLITM" AS IMLITM_item_number,
	"IMAITM" AS IMAITM__3rd_item_number,
	"IMDSC1" AS IMDSC1_description,
	"IMDSC2" AS IMDSC2_description_2,
	"IMSRTX" AS IMSRTX_search_text,
	"IMALN" AS IMALN__search_text_compressed,
	"IMSRP1" AS IMSRP1_sales_catalog_section,
	"IMSRP2" AS IMSRP2_sub_section,
	"IMSRP3" AS IMSRP3_sales_category_code_3,
	"IMSRP4" AS IMSRP4_sales_category_code_4,
	"IMSRP5" AS IMSRP5_sales_category_code_5,
	"IMSRP6" AS IMSRP6_category_code_6,
	"IMSRP7" AS IMSRP7_category_code_7,
	"IMSRP8" AS IMSRP8_category_code_8,
	"IMSRP9" AS IMSRP9_category_code_9,
	"IMSRP0" AS IMSRP0_category_code_10,
	"IMPRP1" AS IMPRP1_commodity_class,
	"IMPRP2" AS IMPRP2_commodity_sub_class,
	"IMPRP3" AS IMPRP3_supplier_rebate_code,
	"IMPRP4" AS IMPRP4_master_planning_family,
	"IMPRP5" AS IMPRP5_landed_cost_rule,
	"IMPRP6" AS IMPRP6_item_dimension_group,
	"IMPRP7" AS IMPRP7_warehouse_process_grp_1,
	"IMPRP8" AS IMPRP8_warehouse_process_grp_2,
	"IMPRP9" AS IMPRP9_warehouse_process_grp_3,
	"IMPRP0" AS IMPRP0_item_pool_code,
	"IMCDCD" AS IMCDCD_commodity_code,
	"IMPDGR" AS IMPDGR_product_group,
	"IMDSGP" AS IMDSGP_dispatch_group,
	"IMPRGR" AS IMPRGR_item_price_group,
	"IMRPRC" AS IMRPRC_basket_reprice_group,
	"IMORPR" AS IMORPR_order_reprice_group,
	"IMBUYR" AS IMBUYR_buyer_number,
	"IMDRAW" AS IMDRAW_drawing_number,
	"IMRVNO" AS IMRVNO_last_revision_no,
	"IMDSZE" AS IMDSZE_drawing_size,
	"IMVCUD" AS IMVCUD_volume_cubic_dimensions,
	"IMCARS" AS IMCARS_carrier_number,
	"IMCARP" AS IMCARP_preferred_carrier_purchasing,
	"IMSHCN" AS IMSHCN_shipping_conditions_code,
	"IMSHCM" AS IMSHCM_shipping_commodity_class,
	"IMUOM1" AS IMUOM1_unit_of_measure,
	"IMUOM2" AS IMUOM2_secondary_uom,
	"IMUOM3" AS IMUOM3_purchasing_uom,
	"IMUOM4" AS IMUOM4_pricing_uom,
	"IMUOM6" AS IMUOM6_shipping_uom,
	"IMUOM8" AS IMUOM8_production_uom,
	"IMUOM9" AS IMUOM9_component_uom,
	"IMUWUM" AS IMUWUM_unit_of_measure_weight,
	"IMUVM1" AS IMUVM1_unit_of_measure_volume,
	"IMSUTM" AS IMSUTM_stocking_um,
	"IMUMVW" AS IMUMVW_psauvolume_or_weight,
	"IMCYCL" AS IMCYCL_cycle_count_category,
	"IMGLPT" AS IMGLPT_gl_category,
	"IMPLEV" AS IMPLEV_sales_price_level,
	"IMPPLV" AS IMPPLV_purchase_price_level,
	"IMCLEV" AS IMCLEV_inventory_cost_level,
	"IMPRPO" AS IMPRPO_gradepotency_pricing,
	"IMCKAV" AS IMCKAV_check_availability_yn,
	"IMBPFG" AS IMBPFG_bulkpacked_flag,
	"IMSRCE" AS IMSRCE_layer_code_source,
	"IMOT1Y" AS IMOT1Y_potency_control,
	"IMOT2Y" AS IMOT2Y_grade_control,
	"IMSTDP" AS IMSTDP_standard_potency,
	"IMFRMP" AS IMFRMP_from_potency,
	"IMTHRP" AS IMTHRP_thru_potency,
	"IMSTDG" AS IMSTDG_standard_grade,
	"IMFRGD" AS IMFRGD_from_grade,
	"IMTHGD" AS IMTHGD_thru_grade,
	"IMCOTY" AS IMCOTY_component_type,
	"IMSTKT" AS IMSTKT_stocking_type,
	"IMLNTY" AS IMLNTY_line_type,
	"IMCONT" AS IMCONT_contract_item,
	"IMBACK" AS IMBACK_backorders_allowed_yn,
	"IMIFLA" AS IMIFLA_item_flash_message,
	"IMTFLA" AS IMTFLA_std_uom_conversion,
	"IMINMG" AS IMINMG_print_message,
	"IMABCS" AS IMABCS_abc_code_1_sales,
	"IMABCM" AS IMABCM_abc_code_2_margin,
	"IMABCI" AS IMABCI_abc_code_3_investment,
	"IMOVR" AS IMOVR__abc_code_override_indicator,
	"IMWARR" AS IMWARR_warranty_item_group,
	"IMCMCG" AS IMCMCG_commission_category,
	"IMSRNR" AS IMSRNR_serial_no_required,
	"IMPMTH" AS IMPMTH_kit_pricing_method,
	"IMFIFO" AS IMFIFO_fifo_processing,
	"IMLOTS" AS IMLOTS_lot_status_code,
	"IMSLD" AS IMSLD__shelf_life_days,
	"IMANPL" AS IMANPL_planner_number,
	"IMMPST" AS IMMPST_planning_code,
	"IMPCTM" AS IMPCTM_percent_margin,
	"IMMMPC" AS IMMMPC_margin_maintenance_pct,
	"IMPTSC" AS IMPTSC_material_status,
	"IMSNS" AS IMSNS__round_to_whole_number,
	"IMLTLV" AS IMLTLV_leadtime_level,
	"IMLTMF" AS IMLTMF_leadtime_manufacturing,
	"IMLTCM" AS IMLTCM_leadtime_cumulative,
	"IMOPC" AS IMOPC__order_policy_code,
	"IMOPV" AS IMOPV__value_order_policy,
	"IMACQ" AS IMACQ__accounting_cost_quantity,
	"IMMLQ" AS IMMLQ__mfg_leadtime_quantity,
	"IMLTPU" AS IMLTPU_leadtime_per_unit,
	"IMMPSP" AS IMMPSP_planning_fence_rule,
	"IMMRPP" AS IMMRPP_fixedvariable_leadtime,
	"IMITC" AS IMITC__issue_type_code,
	"IMORDW" AS IMORDW_order_with_yn,
	"IMMTF1" AS IMMTF1_planning_fence,
	"IMMTF2" AS IMMTF2_freeze_fence,
	"IMMTF3" AS IMMTF3_message_display_fence,
	"IMMTF4" AS IMMTF4_time_fence,
	"IMMTF5" AS IMMTF5_shipment_leadtime_offset,
	"IMEXPD" AS IMEXPD_expedite_damper_days,
	"IMDEFD" AS IMDEFD_defer_damper_days,
	"IMSFLT" AS IMSFLT_safety_leadtime,
	"IMMAKE" AS IMMAKE_makebuy_code,
	"IMCOBY" AS IMCOBY_cobyproductintermediate,
	"IMLLX" AS IMLLX__low_level_code,
	"IMCMGL" AS IMCMGL_commitment_method,
	"IMCOMH" AS IMCOMH_specific_commitment_days,
	"IMCSNN" AS IMCSNN_configured_string_id_next_number,
	"IMURCD" AS IMURCD_user_reserved_code,
	"IMURDT" AS IMURDT_user_reserved_date,
	"IMURAT" AS IMURAT_user_reserved_amount,
	"IMURAB" AS IMURAB_user_reserved_number,
	"IMURRF" AS IMURRF_user_reserved_reference,
	"IMUSER" AS IMUSER_user_id,
	"IMPID" AS IMPID__program_id,
	"IMJOBN" AS IMJOBN_work_station_id,
	"IMUPMJ" AS IMUPMJ_date_updated,
	"IMTDAY" AS IMTDAY_time_of_day 

INTO STAGE_JDE_ARCPDTA71_F4101_item_master

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
		CASE WHEN IMURDT IS NOT NULL THEN DATE(DIGITS(DEC(IMURDT+ 1900000,7,0))) ELSE NULL END AS IMURDT,
		CAST((IMURAT)/100.0 AS DEC(15,2)) AS IMURAT,
		IMURAB,
		IMURRF,
		IMUSER,
		IMPID,
		IMJOBN,
		CASE WHEN IMUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(IMUPMJ+ 1900000,7,0))) ELSE NULL END AS IMUPMJ,
		IMTDAY

	FROM
		ARCPDTA71.F4101
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')



--------------------------------------------------------------------------------
-- DROP TABLE STAGE_JDE_ARCPDTA71_F5613_product_extension_file
--------------------------------------------------------------------------------

-- 1.5 min
SELECT 

--    Top 5 
    "QNITM" AS QNITM__item_number_short,
	"QNLITM" AS QNLITM_item_number,
	"QNAITM" AS QNAITM__3rd_item_number,
	"QN$FIN" AS QN$FIN_force_item_notes,
	"QN$FRT" AS QN$FRT_freightable_item,
	"QN$IVP" AS QN$IVP_inventory_percentage,
	"QN$CEM" AS QN$CEM_ce_mark,
	"QN$CER" AS QN$CER_ce_mark_required,
	"QN$RPK" AS QN$RPK_repack,
	"QN$SPC" AS QN$SPC_supplier_code,
	"QN$SZE" AS QN$SZE_size_packaged_units,
	"QN$STR" AS QN$STR_strength,
	"QN$MDC" AS QN$MDC_multiple_drug_classes,
	"QN$STU" AS QN$STU_status,
	"QN$DS" AS QN$DS__drop_ship,
	"QN$IFP" AS QN$IFP_inbound_frt_adj_pct,
	"QN$IFD" AS QN$IFD_inbound_frt_adj_amt,
	"QN$SOM" AS QN$SOM_sales_order_markup,
	"QNLTDT" AS QNLTDT_transit_days,
	"QNINMG" AS QNINMG_print_message,
	"QNUSER" AS QNUSER_user_id,
	"QNPID" AS QNPID__program_id,
	"QNJOBN" AS QNJOBN_work_station_id,
	"QNUPMJ" AS QNUPMJ_date_updated,
	"QNTDAY" AS QNTDAY_time_of_day 

INTO 
	STAGE_JDE_ARCPDTA71_F5613_product_extension_file

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
		CASE WHEN QNUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(QNUPMJ+ 1900000,7,0))) ELSE NULL END AS QNUPMJ,
		QNTDAY

	FROM
		ARCPDTA71.F5613
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')


--------------------------------------------------------------------------------
-- DROP TABLE STAGE_JDE_ARCPDTA71_F4094_item_customer_keyid_master_file
--------------------------------------------------------------------------------

-- 1 min
SELECT 

--    Top 5 
    "KIPRGR" AS KIPRGR_item_price_group,
	"KIIGP1" AS KIIGP1_item_group_category_code_01,
	"KIIGP2" AS KIIGP2_item_group_category_code_02,
	"KIIGP3" AS KIIGP3_item_group_category_code_03,
	"KIIGP4" AS KIIGP4_item_group_category_code_04,
	"KICPGP" AS KICPGP_customer_price_group,
	"KICGP1" AS KICGP1_customer_group_category_code_01,
	"KICGP2" AS KICGP2_customer_group_category_code_02,
	"KICGP3" AS KICGP3_customer_group_category_code_03,
	"KICGP4" AS KICGP4_customer_group_category_code_04,
	"KIICID" AS KIICID_itemcustomer_key_id 

INTO 
	STAGE_JDE_ARCPDTA71_F4094_item_customer_keyid_master_file

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
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')



--------------------------------------------------------------------------------
-- DROP TABLE STAGE_JDE_ARCPDTA71_F41061_supplier_catalog_price_file
--------------------------------------------------------------------------------

-- 1 min
SELECT 

--    Top 5 
    "CBMCU" AS CBMCU__business_unit,
	"CBAN8" AS CBAN8__billto,
	"CBITM" AS CBITM__item_number_short,
	"CBLITM" AS CBLITM_item_number,
	"CBAITM" AS CBAITM__3rd_item_number,
	"CBCATN" AS CBCATN_catalog,
	"CBDMCT" AS CBDMCT_agreement_nbr,
	"CBDMCS" AS CBDMCS_agreement_supplement,
	"CBKCOO" AS CBKCOO_order_company,
	"CBDOCO" AS CBDOCO_salesorder_number,
	"CBDCTO" AS CBDCTO_order_type,
	"CBLNID" AS CBLNID_line_number,
	"CBCRCD" AS CBCRCD_currency_code,
	"CBUOM" AS CBUOM__um,
	"CBPRRC" AS CBPRRC_unit_cost,
	"CBUORG" AS CBUORG_quantity,
	"CBEFTJ" AS CBEFTJ_effective_date,
	"CBEXDJ" AS CBEXDJ_expired_date,
	"CBUSER" AS CBUSER_user_id,
	"CBPID" AS CBPID__program_id,
	"CBJOBN" AS CBJOBN_work_station_id,
	"CBUPMJ" AS CBUPMJ_date_updated,
	"CBTDAY" AS CBTDAY_time_of_day 

INTO 
	STAGE_JDE_ARCPDTA71_F41061_supplier_catalog_price_file

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
		CASE WHEN CBEFTJ IS NOT NULL THEN DATE(DIGITS(DEC(CBEFTJ+ 1900000,7,0))) ELSE NULL END AS CBEFTJ,
		CASE WHEN CBEXDJ IS NOT NULL THEN DATE(DIGITS(DEC(CBEXDJ+ 1900000,7,0))) ELSE NULL END AS CBEXDJ,
		CBUSER,
		CBPID,
		CBJOBN,
		CASE WHEN CBUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(CBUPMJ+ 1900000,7,0))) ELSE NULL END AS CBUPMJ,
		CBTDAY

	FROM
		ARCPDTA71.F41061
    WHERE
		CBEFTJ <= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)), SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) AND 		
		CBEXDJ >= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)), SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3))  		
--    ORDER BY
--        <insert custom code here>
')



--------------------------------------------------------------------------------
-- DROP TABLE STAGE_JDE_ARCPDTA71_F4071_price_adjustment_name
--------------------------------------------------------------------------------

-- 0 min

SELECT 

--    Top 5 
    "ATAST" AS ATAST__adjustment_name,
	"ATPRGR" AS ATPRGR_item_price_group,
	"ATCPGP" AS ATCPGP_customer_price_group,
	"ATSDGR" AS ATSDGR_order_detail_group,
	"ATPRFR" AS ATPRFR_preference_type,
	"ATLBT" AS ATLBT__level_break_type,
	"ATGLC" AS ATGLC__gl_offset,
	"ATSBIF" AS ATSBIF_subledger_in_gl,
	"ATACNT" AS ATACNT_adjustment_control_code,
	"ATLNTY" AS ATLNTY_line_type,
	"ATMDED" AS ATMDED_manual_addchange_yn,
	"ATABAS" AS ATABAS_override_price_yn,
	"ATOLVL" AS ATOLVL_adjustment_level,
	"ATTXB" AS ATTXB__taxable_yn,
	"ATPA01" AS ATPA01_rebate_beneficiary,
	"ATPA02" AS ATPA02_mandatory_adjustment,
	"ATPA03" AS ATPA03_exclude_from_payment_discount,
	"ATPA04" AS ATPA04_target_application,
	"ATPA05" AS ATPA05_include_in_margin_calc,
	"ATURCD" AS ATURCD_user_reserved_code,
	"ATURDT" AS ATURDT_user_reserved_date_JDT,
	"ATURAT" AS ATURAT_user_reserved_amount,
	"ATURAB" AS ATURAB_user_reserved_number,
	"ATURRF" AS ATURRF_user_reserved_reference,
	"ATUSER" AS ATUSER_user_id,
	"ATPID" AS ATPID__program_id,
	"ATJOBN" AS ATJOBN_work_station_id,
	"ATUPMJ" AS ATUPMJ_date_updated,
	"ATTDAY" AS ATTDAY_time_of_day 

INTO 
	STAGE_JDE_ARCPDTA71_F4071_price_adjustment_name

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		ATAST,
		ATPRGR,
		ATCPGP,
		ATSDGR,
		ATPRFR,
		ATLBT,
		ATGLC,
		ATSBIF,
		ATACNT,
		ATLNTY,
		ATMDED,
		ATABAS,
		ATOLVL,
		ATTXB,
		ATPA01,
		ATPA02,
		ATPA03,
		ATPA04,
		ATPA05,
		ATURCD,
		ATURDT,
		CAST((ATURAT)/100.0 AS DEC(15,2)) AS ATURAT,
		ATURAB,
		ATURRF,
		ATUSER,
		ATPID,
		ATJOBN,
		CASE WHEN ATUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(ATUPMJ+ 1900000,7,0))) ELSE NULL END AS ATUPMJ,
		ATTDAY

	FROM
		ARCPDTA71.F4071
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')



--------------------------------------------------------------------------------
-- DROP TABLE STAGE_JDE_ARCPDTA71_F4070_price_adjustment_schedule
--------------------------------------------------------------------------------
-- x min

SELECT 

--    Top 5 
    "SNASN" AS SNASN__adjustment_schedule,
	"SNOSEQ" AS SNOSEQ_sequence_number,
	"SNAST" AS SNAST__adjustment_name,
	"SNURCD" AS SNURCD_user_reserved_code,
	"SNURDT" AS SNURDT_user_reserved_date_JDT,
	"SNURAT" AS SNURAT_user_reserved_amount,
	"SNURAB" AS SNURAB_user_reserved_number,
	"SNURRF" AS SNURRF_user_reserved_reference,
	"SNUSER" AS SNUSER_user_id,
	"SNPID" AS SNPID__program_id,
	"SNJOBN" AS SNJOBN_work_station_id,
	"SNUPMJ" AS SNUPMJ_date_updated_JDT,
	"SNTDAY" AS SNTDAY_time_of_day 

INTO 
	STAGE_JDE_ARCPDTA71_F4070_price_adjustment_schedule

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		SNASN,
		SNOSEQ,
		SNAST,
		SNURCD,
		SNURDT,
		CAST((SNURAT)/100.0 AS DEC(15,2)) AS SNURAT,
		SNURAB,
		SNURRF,
		SNUSER,
		SNPID,
		SNJOBN,
		SNUPMJ,
		SNTDAY

	FROM
		ARCPDTA71.F4070
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')



--------------------------------------------------------------------------------
-- DROP TABLE STAGE_JDE_ARCPDTA71_F4072A_price_adjustment_detail_audit_file
--------------------------------------------------------------------------------

--SELECT 

--    Top 5 
--    "AEACTN" AS AEACTN_action_code,
--	"AEBFAF" AS AEBFAF_beforeafter,
--	"AEAST" AS AEAST__adjustment_name,
--	"AEITM" AS AEITM__item_number_short,
--	"AEAN8" AS AEAN8__billto,
--	"AEICID" AS AEICID_itemcustomer_key_id,
--	"AESDV1" AS AESDV1_sales_detail_value_01,
--	"AESDV2" AS AESDV2_sales_detail_value_02,
--	"AESDV3" AS AESDV3_sales_detail_value_03,
--	"AECRCD" AS AECRCD_currency_code,
--	"AEUOM" AS AEUOM__um,
--	"AEMNQ" AS AEMNQ__quantity_from,
--	"AEEFTJ" AS AEEFTJ_effective_date,
--	"AEEXDJ" AS AEEXDJ_expired_date,
--	"AEBSCD" AS AEBSCD_basis,
--	"AELEDG" AS AELEDG_cost_method,
--	"AEFRMN" AS AEFRMN_formula_name,
--	"AEFVTR" AS AEFVTR_factor_value,
--	"AEFGY" AS AEFGY__free_goods_yn,
--	"AEURCD" AS AEURCD_user_reserved_code,
--	"AEURDT" AS AEURDT_user_reserved_date,
--	"AEURAT" AS AEURAT_user_reserved_amount,
--	"AEURAB" AS AEURAB_user_reserved_number,
--	"AEURRF" AS AEURRF_user_reserved_reference,
--	"AEUSER" AS AEUSER_user_id,
--	"AEPID" AS AEPID__program_id,
--	"AEJOBN" AS AEJOBN_work_station_id,
--	"AEUPMJ" AS AEUPMJ_date_updated,
--	"AETDAY" AS AETDAY_time_of_day 

---- INTO STAGE_JDE_ARCPDTA71_F4072A_<instert_friendly_name_here>

--FROM 
--    OPENQUERY (ESYS_PROD, '

--	SELECT
--		AEACTN,
--		AEBFAF,
--		AEAST,
--		AEITM,
--		AEAN8,
--		AEICID,
--		AESDV1,
--		AESDV2,
--		AESDV3,
--		AECRCD,
--		AEUOM,
--		AEMNQ,
--		CASE WHEN AEEFTJ IS NOT NULL THEN DATE(DIGITS(DEC(AEEFTJ+ 1900000,7,0))) ELSE NULL END AS AEEFTJ,
--		CASE WHEN AEEXDJ IS NOT NULL THEN DATE(DIGITS(DEC(AEEXDJ+ 1900000,7,0))) ELSE NULL END AS AEEXDJ,
--		AEBSCD,
--		AELEDG,
--		AEFRMN,
--		CAST((AEFVTR)/10000.0 AS DEC(15,4)) AS AEFVTR,
--		AEFGY,
--		AEURCD,
--		CASE WHEN AEURDT IS NOT NULL THEN DATE(DIGITS(DEC(AEURDT+ 1900000,7,0))) ELSE NULL END AS AEURDT,
--		CAST((AEURAT)/100.0 AS DEC(15,2)) AS AEURAT,
--		AEURAB,
--		AEURRF,
--		AEUSER,
--		AEPID,
--		AEJOBN,
--		CASE WHEN AEUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(AEUPMJ+ 1900000,7,0))) ELSE NULL END AS AEUPMJ,
--		AETDAY

--	FROM
--		ARCPDTA71.F4072A
--    WHERE
--		AEEFTJ <= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)), SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) AND 		
--		AEEXDJ >= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)), SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3))  		
----    ORDER BY
----        <insert custom code here>
--')



--------------------------------------------------------------------------------
-- DROP TABLE STAGE_JDE_ARCPDTA71_F554071_adjustment_name_extension
--------------------------------------------------------------------------------

-- 0 min
SELECT 

--    Top 5 
    "QTAST" AS QTAST__adjustment_name,
	"QT$ATP" AS QT$ATP_adjustment_type,
	"QT$OOF" AS QT$OOF_override_flag,
	"QT$RAF" AS QT$RAF_rebate_applicable_flag,
	"QTAN8" AS QTAN8__billto,
	"QT$DAF" AS QT$DAF_discount_applicable_flag,
	"QTINMG" AS QTINMG_print_message,
	"QTURCD" AS QTURCD_user_reserved_code,
	"QTURDT" AS QTURDT_user_reserved_date_JDT,
	"QTURAT" AS QTURAT_user_reserved_amount,
	"QTURAB" AS QTURAB_user_reserved_number,
	"QTURRF" AS QTURRF_user_reserved_reference,
	"QTUSER" AS QTUSER_user_id,
	"QTPID" AS QTPID__program_id,
	"QTJOBN" AS QTJOBN_work_station_id,
	"QTUPMJ" AS QTUPMJ_date_updated,
	"QTTDAY" AS QTTDAY_time_of_day 

INTO 
	STAGE_JDE_ARCPDTA71_F554071_adjustment_name_extension

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		QTAST,
		QT$ATP,
		QT$OOF,
		QT$RAF,
		QTAN8,
		QT$DAF,
		QTINMG,
		QTURCD,
		QTURDT,
		CAST((QTURAT)/100.0 AS DEC(15,2)) AS QTURAT,
		QTURAB,
		QTURRF,
		QTUSER,
		QTPID,
		QTJOBN,
		CASE WHEN QTUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(QTUPMJ+ 1900000,7,0))) ELSE NULL END AS QTUPMJ,
		QTTDAY

	FROM
		ARCPDTA71.F554071
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')


--------------------------------------------------------------------------------
-- DROP TABLE STAGE_JDE_ARCPDTA71_F554070_adjustment_schedule_extension
--------------------------------------------------------------------------------

-- 0 min

SELECT 

--    Top 5 
    "QNASN" AS QNASN__adjustment_schedule,
	"QNAC10" AS QNAC10_category_code_10,
	"QN$PAF" AS QN$PAF_promotion_allowed_flag,
	"QN$AMS" AS QN$AMS_adjustment_schedule_status,
	"QNCRTU" AS QNCRTU_created_by_user,
	"QNEFTJ" AS QNEFTJ_effective_date,
	"QNEXDJ" AS QNEXDJ_expired_date,
	"QN$CBS" AS QN$CBS_chargeback_sync_flag,
	"QNURCD" AS QNURCD_user_reserved_code,
	"QNURDT" AS QNURDT_user_reserved_date_JDT,
	"QNURAT" AS QNURAT_user_reserved_amount,
	"QNURAB" AS QNURAB_user_reserved_number,
	"QNURRF" AS QNURRF_user_reserved_reference,
	"QNUSER" AS QNUSER_user_id,
	"QNPID" AS QNPID__program_id,
	"QNJOBN" AS QNJOBN_work_station_id,
	"QNUPMJ" AS QNUPMJ_date_updated,
	"QNTDAY" AS QNTDAY_time_of_day 

INTO 
	STAGE_JDE_ARCPDTA71_F554070_adjustment_schedule_extension

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		QNASN,
		QNAC10,
		QN$PAF,
		QN$AMS,
		QNCRTU,
		CASE WHEN QNEFTJ IS NOT NULL THEN DATE(DIGITS(DEC(QNEFTJ+ 1900000,7,0))) ELSE NULL END AS QNEFTJ,
		CASE WHEN QNEXDJ IS NOT NULL THEN DATE(DIGITS(DEC(QNEXDJ+ 1900000,7,0))) ELSE NULL END AS QNEXDJ,
		QN$CBS,
		QNURCD,
		QNURDT,
		CAST((QNURAT)/100.0 AS DEC(15,2)) AS QNURAT,
		QNURAB,
		QNURRF,
		QNUSER,
		QNPID,
		QNJOBN,
		CASE WHEN QNUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(QNUPMJ+ 1900000,7,0))) ELSE NULL END AS QNUPMJ,
		QNTDAY

	FROM
		ARCPDTA71.F554070
    WHERE
		QNEFTJ <= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)), SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) AND 		
		QNEXDJ >= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)), SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3))  		
--    ORDER BY
--        <insert custom code here>
')


--------------------------------------------------------------------------------
-- DROP TABLE STAGE_JDE_ARCPDTA71_F0301_customer_master
--------------------------------------------------------------------------------

--SELECT 

--    Top 5 
--    "A5AN8" AS A5AN8__billto,
--	"A5ARC" AS A5ARC__gl_class,
--	"A5MCUR" AS A5MCUR_business_unit_ar_default,
--	"A5OBAR" AS A5OBAR_object_ar_default,
--	"A5AIDR" AS A5AIDR_subsidiary_ar_default,
--	"A5KCOR" AS A5KCOR_ar_model_document_company,
--	"A5DCAR" AS A5DCAR_ar_model_je_document,
--	"A5DTAR" AS A5DTAR_ar_model_je_document_type,
--	"A5CRCD" AS A5CRCD_currency_code,
--	"A5TXA1" AS A5TXA1_tax_ratearea,
--	"A5EXR1" AS A5EXR1_tax_expl_code,
--	"A5ACL" AS A5ACL__credit_limit,
--	"A5HDAR" AS A5HDAR_hold_invoices,
--	"A5TRAR" AS A5TRAR_payment_terms_ar,
--	"A5ARPY" AS A5ARPY_alternate_payor,
--	"A5STTO" AS A5STTO_send_statement_to,
--	"A5RYIN" AS A5RYIN_payment_instrument,
--	"A5STMT" AS A5STMT_print_statement_yn,
--	"A5ATCS" AS A5ATCS_auto_receipt_yn,
--	"A5SITO" AS A5SITO_send_invoice_to,
--	"A5SQNL" AS A5SQNL_ledger_inq_sequence,
--	"A5ALGM" AS A5ALGM_auto_receipt_algorithm,
--	"A5CYCN" AS A5CYCN_statement_cycle,
--	"A5BO" AS A5BO___balance_forwardopen_item,
--	"A5TSTA" AS A5TSTA_temporary_credit_message,
--	"A5CKHC" AS A5CKHC_credit_check_handling_code,
--	"A5DLC" AS A5DLC__date_of_last_credit_review,
--	"A5DNLT" AS A5DNLT_delinquency_notice_yn,
--	"A5PLCR" AS A5PLCR_last_reviewed_by,
--	"A5RVDJ" AS A5RVDJ_recall_for_review_date,
--	"A5DSO" AS A5DSO__days_sales_outstanding,
--	"A5CMGR" AS A5CMGR_credit_manager,
--	"A5CLMG" AS A5CLMG_collection_manager,
--	"A5DLQT" AS A5DLQT_no_of_dunning_letters_sent,
--	"A5DLQJ" AS A5DLQJ_last_dunning_letter_date,
--	"A5NBRR" AS A5NBRR_number_of_reminders_to_send,
--	"A5COLL" AS A5COLL_collection_report_yn,
--	"A5NBR1" AS A5NBR1_no_of_sent_reminders_1,
--	"A5NBR2" AS A5NBR2_no_of_sent_reminders_2,
--	"A5NBR3" AS A5NBR3_no_of_sent_reminders_3,
--	"A5NBCL" AS A5NBCL_no_of_invoices_to_collection_report,
--	"A5AFC" AS A5AFC__apply_finance_charges_yn,
--	"A5FD" AS A5FD___apply_finance_charge_days,
--	"A5FP" AS A5FP___percentage_factor,
--	"A5CFCE" AS A5CFCE_crt_finance_chrg_entries_yn,
--	"A5AB2" AS A5AB2__pending_cash_receipts,
--	"A5DT1J" AS A5DT1J_last_statement_date,
--	"A5DFIJ" AS A5DFIJ_date_of_first_invoice,
--	"A5DLIJ" AS A5DLIJ_last_invoice_date,
--	"A5ABC1" AS A5ABC1_abc_code_sales,
--	"A5ABC2" AS A5ABC2_abc_code_margin,
--	"A5ABC3" AS A5ABC3_abc_code_average_days,
--	"A5FNDJ" AS A5FNDJ_financial_stmts_on_hand,
--	"A5DHBJ" AS A5DHBJ_date_of_high_balance,
--	"A5DLP" AS A5DLP__date_last_paid,
--	"A5DB" AS A5DB___dun_bradstreet,
--	"A5DNBJ" AS A5DNBJ_dun_bradstreet_date,
--	"A5TRW" AS A5TRW__experian_rating,
--	"A5TWDJ" AS A5TWDJ_experian_date,
--	"A5AVD" AS A5AVD__average_days_late,
--	"A5CRCA" AS A5CRCA_currency_code_ab_amounts,
--	"A5AD" AS A5AD___amount_due,
--	"A5AFCP" AS A5AFCP_prior_year_finance_charges,
--	"A5AFCY" AS A5AFCY_ytd_finance_charges,
--	"A5ASTY" AS A5ASTY_invoiced_this_year,
--	"A5SPYE" AS A5SPYE_invoiced_prior_year,
--	"A5AHB" AS A5AHB__high_balance,
--	"A5ALP" AS A5ALP__last_applied_amount,
--	"A5ABAM" AS A5ABAM_address_book_amount,
--	"A5ABA1" AS A5ABA1_address_book_amount,
--	"A5APRC" AS A5APRC_open_order_amount,
--	"A5MINO" AS A5MINO_minimum_order_value,
--	"A5MAXO" AS A5MAXO_maximum_order_value,
--	"A5OYTD" AS A5OYTD_yeartodate_orders,
--	"A5OPY" AS A5OPY__prior_year_orders,
--	"A5POPN" AS A5POPN_person_opening_account,
--	"A5DAOJ" AS A5DAOJ_date_account_opened,
--	"A5AN8R" AS A5AN8R_related_address_number,
--	"A5BADT" AS A5BADT_billing_address_type,
--	"A5CPGP" AS A5CPGP_customer_price_group,
--	"A5ORTP" AS A5ORTP_order_template,
--	"A5TRDC" AS A5TRDC_trade_discount,
--	"A5INMG" AS A5INMG_print_message,
--	"A5EXHD" AS A5EXHD_exempt_from_credit_hold,
--	"A5HOLD" AS A5HOLD_hold_orders_code,
--	"A5ROUT" AS A5ROUT_route_code,
--	"A5STOP" AS A5STOP_stop_code,
--	"A5ZON" AS A5ZON__zone_number,
--	"A5CARS" AS A5CARS_carrier_number,
--	"A5DEL1" AS A5DEL1_delivery_instructions,
--	"A5DEL2" AS A5DEL2_delivery_instructions,
--	"A5LTDT" AS A5LTDT_transit_days,
--	"A5FRTH" AS A5FRTH_freight_handling_code,
--	"A5AFT" AS A5AFT__apply_freight_yn,
--	"A5APTS" AS A5APTS_partial_shipments_allowed_yn,
--	"A5SBAL" AS A5SBAL_substitutes_allowed_yn,
--	"A5BACK" AS A5BACK_backorders_allowed_yn,
--	"A5PORQ" AS A5PORQ_customer_po_required,
--	"A5PRIO" AS A5PRIO_priority_processing_code,
--	"A5ARTO" AS A5ARTO_credit_check_level,
--	"A5INVC" AS A5INVC_invoice_copies,
--	"A5ICON" AS A5ICON_invoice_consolidation,
--	"A5BLFR" AS A5BLFR_billing_frequency,
--	"A5NIVD" AS A5NIVD_next_invoice_date,
--	"A5LEDJ" AS A5LEDJ_license_expiration_date,
--	"A5PLST" AS A5PLST_price_pick_list_yn,
--	"A5MORD" AS A5MORD_merge_orders_yn,
--	"A5PALC" AS A5PALC_pallet_control,
--	"A5CMC1" AS A5CMC1_commission_code_1,
--	"A5CMR1" AS A5CMR1_commission_rate_1,
--	"A5CMC2" AS A5CMC2_commission_code_2,
--	"A5CMR2" AS A5CMR2_commission_rate_2,
--	"A5WUMD" AS A5WUMD_weight_display_um,
--	"A5VUMD" AS A5VUMD_volume_display_um,
--	"A5EDPM" AS A5EDPM_batch_processing_mode,
--	"A5EDCI" AS A5EDCI_customer_type_identifier,
--	"A5EDII" AS A5EDII_item_type_identifier,
--	"A5EDQD" AS A5EDQD_quantity_decimals,
--	"A5EDAD" AS A5EDAD_amount_decimals,
--	"A5EDF1" AS A5EDF1_delivery_note_yn,
--	"A5EDF2" AS A5EDF2_item_restrictions,
--	"A5SI01" AS A5SI01_partial_order_shipments_allowed_yn,
--	"A5SI02" AS A5SI02_coa_print_yn,
--	"A5SI03" AS A5SI03_special_instruction_03,
--	"A5SI04" AS A5SI04_special_instruction_04,
--	"A5SI05" AS A5SI05_special_instruction_05,
--	"A5URCD" AS A5URCD_user_reserved_code,
--	"A5URDT" AS A5URDT_user_reserved_date,
--	"A5URAT" AS A5URAT_user_reserved_amount,
--	"A5URAB" AS A5URAB_user_reserved_number,
--	"A5URRF" AS A5URRF_user_reserved_reference,
--	"A5USER" AS A5USER_user_id,
--	"A5PID" AS A5PID__program_id,
--	"A5JOBN" AS A5JOBN_work_station_id,
--	"A5UPMJ" AS A5UPMJ_date_updated,
--	"A5UPMT" AS A5UPMT_time_last_updated,
--	"A5ASN" AS A5ASN__adjustment_schedule,
--	"A5CP01" AS A5CP01_sales_price_based_on_date,
--	"A5DSPA" AS A5DSPA_adjustment_on_invoice,
--	"A5CRMD" AS A5CRMD_send_method 

---- INTO STAGE_JDE_ARCPDTA71_F0301_customer_master

--FROM 
--    OPENQUERY (ESYS_PROD, '

--	SELECT
--		A5AN8,
--		A5ARC,
--		A5MCUR,
--		A5OBAR,
--		A5AIDR,
--		A5KCOR,
--		A5DCAR,
--		A5DTAR,
--		A5CRCD,
--		A5TXA1,
--		A5EXR1,
--		A5ACL,
--		A5HDAR,
--		A5TRAR,
--		A5ARPY,
--		A5STTO,
--		A5RYIN,
--		A5STMT,
--		A5ATCS,
--		A5SITO,
--		A5SQNL,
--		A5ALGM,
--		A5CYCN,
--		A5BO,
--		A5TSTA,
--		A5CKHC,
--		CASE WHEN A5DLC IS NOT NULL THEN DATE(DIGITS(DEC(A5DLC+ 1900000,7,0))) ELSE NULL END AS A5DLC,
--		A5DNLT,
--		A5PLCR,
--		CASE WHEN A5RVDJ IS NOT NULL THEN DATE(DIGITS(DEC(A5RVDJ+ 1900000,7,0))) ELSE NULL END AS A5RVDJ,
--		A5DSO,
--		A5CMGR,
--		A5CLMG,
--		A5DLQT,
--		CASE WHEN A5DLQJ IS NOT NULL THEN DATE(DIGITS(DEC(A5DLQJ+ 1900000,7,0))) ELSE NULL END AS A5DLQJ,
--		A5NBRR,
--		A5COLL,
--		A5NBR1,
--		A5NBR2,
--		A5NBR3,
--		A5NBCL,
--		A5AFC,
--		A5FD,
--		CAST((A5FP)/1000000.0 AS DEC(15,6)) AS A5FP,
--		A5CFCE,
--		A5AB2,
--		CASE WHEN A5DT1J IS NOT NULL THEN DATE(DIGITS(DEC(A5DT1J+ 1900000,7,0))) ELSE NULL END AS A5DT1J,
--		CASE WHEN A5DFIJ IS NOT NULL THEN DATE(DIGITS(DEC(A5DFIJ+ 1900000,7,0))) ELSE NULL END AS A5DFIJ,
--		CASE WHEN A5DLIJ IS NOT NULL THEN DATE(DIGITS(DEC(A5DLIJ+ 1900000,7,0))) ELSE NULL END AS A5DLIJ,
--		A5ABC1,
--		A5ABC2,
--		A5ABC3,
--		CASE WHEN A5FNDJ IS NOT NULL THEN DATE(DIGITS(DEC(A5FNDJ+ 1900000,7,0))) ELSE NULL END AS A5FNDJ,
--		CASE WHEN A5DHBJ IS NOT NULL THEN DATE(DIGITS(DEC(A5DHBJ+ 1900000,7,0))) ELSE NULL END AS A5DHBJ,
--		CASE WHEN A5DLP IS NOT NULL THEN DATE(DIGITS(DEC(A5DLP+ 1900000,7,0))) ELSE NULL END AS A5DLP,
--		A5DB,
--		CASE WHEN A5DNBJ IS NOT NULL THEN DATE(DIGITS(DEC(A5DNBJ+ 1900000,7,0))) ELSE NULL END AS A5DNBJ,
--		A5TRW,
--		CASE WHEN A5TWDJ IS NOT NULL THEN DATE(DIGITS(DEC(A5TWDJ+ 1900000,7,0))) ELSE NULL END AS A5TWDJ,
--		A5AVD,
--		A5CRCA,
--		CAST((A5AD)/100.0 AS DEC(15,2)) AS A5AD,
--		CAST((A5AFCP)/100.0 AS DEC(15,2)) AS A5AFCP,
--		CAST((A5AFCY)/100.0 AS DEC(15,2)) AS A5AFCY,
--		CAST((A5ASTY)/100.0 AS DEC(15,2)) AS A5ASTY,
--		CAST((A5SPYE)/100.0 AS DEC(15,2)) AS A5SPYE,
--		CAST((A5AHB)/100.0 AS DEC(15,2)) AS A5AHB,
--		CAST((A5ALP)/100.0 AS DEC(15,2)) AS A5ALP,
--		CAST((A5ABAM)/100.0 AS DEC(15,2)) AS A5ABAM,
--		CAST((A5ABA1)/100.0 AS DEC(15,2)) AS A5ABA1,
--		CAST((A5APRC)/100.0 AS DEC(15,2)) AS A5APRC,
--		A5MINO,
--		A5MAXO,
--		A5OYTD,
--		A5OPY,
--		A5POPN,
--		CASE WHEN A5DAOJ IS NOT NULL THEN DATE(DIGITS(DEC(A5DAOJ+ 1900000,7,0))) ELSE NULL END AS A5DAOJ,
--		A5AN8R,
--		A5BADT,
--		A5CPGP,
--		A5ORTP,
--		CAST((A5TRDC)/1000.0 AS DEC(15,3)) AS A5TRDC,
--		A5INMG,
--		A5EXHD,
--		A5HOLD,
--		A5ROUT,
--		A5STOP,
--		A5ZON,
--		A5CARS,
--		A5DEL1,
--		A5DEL2,
--		A5LTDT,
--		A5FRTH,
--		A5AFT,
--		A5APTS,
--		A5SBAL,
--		A5BACK,
--		A5PORQ,
--		A5PRIO,
--		A5ARTO,
--		A5INVC,
--		A5ICON,
--		A5BLFR,
--		CASE WHEN A5NIVD IS NOT NULL THEN DATE(DIGITS(DEC(A5NIVD+ 1900000,7,0))) ELSE NULL END AS A5NIVD,
--		CASE WHEN A5LEDJ IS NOT NULL THEN DATE(DIGITS(DEC(A5LEDJ+ 1900000,7,0))) ELSE NULL END AS A5LEDJ,
--		A5PLST,
--		A5MORD,
--		A5PALC,
--		A5CMC1,
--		CAST((A5CMR1)/1000.0 AS DEC(15,3)) AS A5CMR1,
--		A5CMC2,
--		CAST((A5CMR2)/1000.0 AS DEC(15,3)) AS A5CMR2,
--		A5WUMD,
--		A5VUMD,
--		A5EDPM,
--		A5EDCI,
--		A5EDII,
--		A5EDQD,
--		A5EDAD,
--		A5EDF1,
--		A5EDF2,
--		A5SI01,
--		A5SI02,
--		A5SI03,
--		A5SI04,
--		A5SI05,
--		A5URCD,
--		CASE WHEN A5URDT IS NOT NULL THEN DATE(DIGITS(DEC(A5URDT+ 1900000,7,0))) ELSE NULL END AS A5URDT,
--		CAST((A5URAT)/100.0 AS DEC(15,2)) AS A5URAT,
--		A5URAB,
--		A5URRF,
--		A5USER,
--		A5PID,
--		A5JOBN,
--		CASE WHEN A5UPMJ IS NOT NULL THEN DATE(DIGITS(DEC(A5UPMJ+ 1900000,7,0))) ELSE NULL END AS A5UPMJ,
--		A5UPMT,
--		A5ASN,
--		A5CP01,
--		A5DSPA,
--		A5CRMD

--	FROM
--		ARCPDTA71.F0301
----    WHERE
----        <insert custom code here>
----    ORDER BY
----        <insert custom code here>
--')



--------------------------------------------------------------------------------
-- DROP TABLE STAGE_JDE_ARCPDTA71_F0101_address_book_master
--------------------------------------------------------------------------------

-- 2.5 min

SELECT 

--    Top 5 
    "ABAN8" AS ABAN8__billto,
	"ABALKY" AS ABALKY_long_address_number,
	"ABTAX" AS ABTAX__tax_id,
	"ABALPH" AS ABALPH_alpha_name,
	"ABDC" AS ABDC___description_compressed,
	"ABMCU" AS ABMCU__business_unit,
	"ABSIC" AS ABSIC__industry_classification,
	"ABLNGP" AS ABLNGP_language,
	"ABAT1" AS ABAT1__search_type,
	"ABCM" AS ABCM___credit_message,
	"ABTAXC" AS ABTAXC_personcorporation_code,
	"ABAT2" AS ABAT2__arap_netting_y,
	"ABAT3" AS ABAT3__address_type_3_yn,
	"ABAT4" AS ABAT4__address_type_4_yn,
	"ABAT5" AS ABAT5__address_type_5_yn,
	"ABATP" AS ABATP__payables_ynm,
	"ABATR" AS ABATR__receivables_yn,
	"ABATPR" AS ABATPR_status,
	"ABAB3" AS ABAB3__miscellaneous_code,
	"ABATE" AS ABATE__employee_yn,
	"ABSBLI" AS ABSBLI_subledger_inactive_code,
	"ABEFTB" AS ABEFTB_start_effective_date_JDT,
	"ABAN81" AS ABAN81__1st_address_number,
	"ABAN82" AS ABAN82__2nd_address_number,
	"ABAN83" AS ABAN83__3rd_address_number,
	"ABAN84" AS ABAN84__4th_address_number,
	"ABAN86" AS ABAN86__5th_address_number,
	"ABAN85" AS ABAN85_factorspecial_payee_hard_coded,
	"ABAC01" AS ABAC01_customer_profession,
	"ABAC02" AS ABAC02_account_representative,
	"ABAC03" AS ABAC03_category_code_03,
	"ABAC04" AS ABAC04_geographic_region,
	"ABAC05" AS ABAC05_category_code_05,
	"ABAC06" AS ABAC06_category_code_06,
	"ABAC07" AS ABAC07__1099_reporting,
	"ABAC08" AS ABAC08_category_code_08,
	"ABAC09" AS ABAC09_category_code_09,
	"ABAC10" AS ABAC10_category_code_10,
	"ABAC11" AS ABAC11_sales_region,
	"ABAC12" AS ABAC12_category_code_12,
	"ABAC13" AS ABAC13_line_of_business,
	"ABAC14" AS ABAC14_foreign_country_code,
	"ABAC15" AS ABAC15_category_code_15,
	"ABAC16" AS ABAC16_category_code_16,
	"ABAC17" AS ABAC17_category_code_17,
	"ABAC18" AS ABAC18_category_code_18,
	"ABAC19" AS ABAC19_category_code_19,
	"ABAC20" AS ABAC20_category_code_20,
	"ABAC21" AS ABAC21_category_code_21,
	"ABAC22" AS ABAC22_category_code_22,
	"ABAC23" AS ABAC23_category_code_23,
	"ABAC24" AS ABAC24_category_code_24,
	"ABAC25" AS ABAC25_category_code_25,
	"ABAC26" AS ABAC26_category_code_26,
	"ABAC27" AS ABAC27_category_code_27,
	"ABAC28" AS ABAC28_category_code_28,
	"ABAC29" AS ABAC29_category_code_29,
	"ABAC30" AS ABAC30_category_code_30,
	"ABGLBA" AS ABGLBA_gl_bank_account,
	"ABPTI" AS ABPTI__time_scheduled_in,
	"ABPDI" AS ABPDI__date_scheduled_in_JDT,
	"ABMSGA" AS ABMSGA_cleared_y,
	"ABRMK" AS ABRMK__remark,
	"ABTXCT" AS ABTXCT_certificate,
	"ABTX2" AS ABTX2__addl_ind_tax_id,
	"ABALP1" AS ABALP1_secondary_alpha_name,
	"ABURCD" AS ABURCD_user_reserved_code,
	"ABURDT" AS ABURDT_user_reserved_date_JDT,
	"ABURAT" AS ABURAT_user_reserved_amount,
	"ABURAB" AS ABURAB_user_reserved_number,
	"ABURRF" AS ABURRF_user_reserved_reference,
	"ABUSER" AS ABUSER_user_id,
	"ABPID" AS ABPID__program_id,
	"ABUPMJ" AS ABUPMJ_date_updated_JDT,
	"ABJOBN" AS ABJOBN_work_station_id,
	"ABUPMT" AS ABUPMT_time_last_updated 

INTO 
	STAGE_JDE_ARCPDTA71_F0101_address_book_master

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		ABAN8,
		ABALKY,
		ABTAX,
		ABALPH,
		ABDC,
		ABMCU,
		ABSIC,
		ABLNGP,
		ABAT1,
		ABCM,
		ABTAXC,
		ABAT2,
		ABAT3,
		ABAT4,
		ABAT5,
		ABATP,
		ABATR,
		ABATPR,
		ABAB3,
		ABATE,
		ABSBLI,
		ABEFTB,
--		CASE WHEN ABEFTB IS NOT NULL THEN DATE(DIGITS(DEC(ABEFTB+ 1900000,7,0))) ELSE NULL END AS ABEFTB,
		ABAN81,
		ABAN82,
		ABAN83,
		ABAN84,
		ABAN86,
		ABAN85,
		ABAC01,
		ABAC02,
		ABAC03,
		ABAC04,
		ABAC05,
		ABAC06,
		ABAC07,
		ABAC08,
		ABAC09,
		ABAC10,
		ABAC11,
		ABAC12,
		ABAC13,
		ABAC14,
		ABAC15,
		ABAC16,
		ABAC17,
		ABAC18,
		ABAC19,
		ABAC20,
		ABAC21,
		ABAC22,
		ABAC23,
		ABAC24,
		ABAC25,
		ABAC26,
		ABAC27,
		ABAC28,
		ABAC29,
		ABAC30,
		ABGLBA,
		ABPTI,
		ABPDI,
--		CASE WHEN ABPDI IS NOT NULL THEN DATE(DIGITS(DEC(ABPDI+ 1900000,7,0))) ELSE NULL END AS ABPDI,
		ABMSGA,
		ABRMK,
		ABTXCT,
		ABTX2,
		ABALP1,
		ABURCD,
		ABURDT,
		CAST((ABURAT)/100.0 AS DEC(15,2)) AS ABURAT,
		ABURAB,
		ABURRF,
		ABUSER,
		ABPID,
		ABUPMJ,
--		CASE WHEN ABUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(ABUPMJ+ 1900000,7,0))) ELSE NULL END AS ABUPMJ,
		ABJOBN,
		ABUPMT

	FROM
		ARCPDTA71.F0101
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')




--------------------------------------------------------------------------------
-- DROP TABLE STAGE_JDE_ARCPDTA71_F4201_<instert_friendly_name_here>
--------------------------------------------------------------------------------
-- x min; no rights

--SELECT 

--    Top 5 
--    "SHKCOO" AS SHKCOO_order_company, "SHDOCO" AS SHDOCO_salesorder_number, "SHDCTO" AS SHDCTO_order_type, "SHSFXO" AS SHSFXO_order_suffix, "SHMCU" AS SHMCU__business_unit, "SHCO" AS SHCO___company, "SHOKCO" AS SHOKCO_original_order_document_company, "SHOORN" AS SHOORN_original_order_number, "SHOCTO" AS SHOCTO_original_order_type, "SHRKCO" AS SHRKCO_related_order_key_company, "SHRORN" AS SHRORN_related_order_number, "SHRCTO" AS SHRCTO_related_order_type, "SHAN8" AS SHAN8__billto, "SHSHAN" AS SHSHAN_shipto, "SHPA8" AS SHPA8__parent_number, "SHDRQJ" AS SHDRQJ_requested, "SHTRDJ" AS SHTRDJ_order_date, "SHPDDJ" AS SHPDDJ_scheduled_pick, "SHOPDJ" AS SHOPDJ_original_promised, "SHADDJ" AS SHADDJ_actual_ship, "SHCNDJ" AS SHCNDJ_cancel_date, "SHPEFJ" AS SHPEFJ_price_effective, "SHPPDJ" AS SHPPDJ_ship, "SHPSDJ" AS SHPSDJ_projected_available, "SHVR01" AS SHVR01_reference, "SHVR02" AS SHVR02_reference_2, "SHDEL1" AS SHDEL1_delivery_instructions, "SHDEL2" AS SHDEL2_delivery_instructions, "SHINMG" AS SHINMG_print_message, "SHPTC" AS SHPTC__payment_terms, "SHRYIN" AS SHRYIN_payment_instrument, "SHASN" AS SHASN__adjustment_schedule, "SHPRGP" AS SHPRGP_pricing_group, "SHTRDC" AS SHTRDC_trade_discount, "SHPCRT" AS SHPCRT_retainage_pct, "SHTXA1" AS SHTXA1_tax_ratearea, "SHEXR1" AS SHEXR1_tax_expl_code, "SHTXCT" AS SHTXCT_certificate, "SHATXT" AS SHATXT_associated_text, "SHPRIO" AS SHPRIO_priority_processing_code, "SHBACK" AS SHBACK_backorders_allowed_yn, "SHSBAL" AS SHSBAL_substitutes_allowed_yn, "SHHOLD" AS SHHOLD_hold_orders_code, "SHPLST" AS SHPLST_price_pick_list_yn, "SHINVC" AS SHINVC_invoice_copies, "SHNTR" AS SHNTR__nature_of_transaction, "SHANBY" AS SHANBY_buyer_number, "SHCARS" AS SHCARS_carrier_number, "SHMOT" AS SHMOT__mode_of_trn, "SHCOT" AS SHCOT__conditions_of_transport, "SHROUT" AS SHROUT_route_code, "SHSTOP" AS SHSTOP_stop_code, "SHZON" AS SHZON__zone_number, "SHCNID" AS SHCNID_container_id, "SHFRTH" AS SHFRTH_freight_handling_code, "SHAFT" AS SHAFT__apply_freight_yn, "SHFUF1" AS SHFUF1_aia_document, "SHFRTC" AS SHFRTC_freight_calculated_yn, "SHMORD" AS SHMORD_merge_orders_yn, "SHCMC1" AS SHCMC1_commission_code_1, "SHCMR1" AS SHCMR1_commission_rate_1, "SHCMC2" AS SHCMC2_commission_code_2, "SHCMR2" AS SHCMR2_commission_rate_2, "SHRCD" AS SHRCD__reason_code, "SHFUF2" AS SHFUF2_post_quantities, "SHOTOT" AS SHOTOT_order_gross_amount, "SHTOTC" AS SHTOTC_total_cost, "SHWUMD" AS SHWUMD_weight_display_um, "SHVUMD" AS SHVUMD_volume_display_um, "SHAUTN" AS SHAUTN_authorization_number_credit_approval, "SHCACT" AS SHCACT_creditbank_account_number, "SHCEXP" AS SHCEXP_expired_date_creditbank_acct, "SHSBLI" AS SHSBLI_subledger_inactive_code, "SHCRMD" AS SHCRMD_send_method, "SHCRRM" AS SHCRRM_mode_f, "SHCRCD" AS SHCRCD_currency_code, "SHCRR" AS SHCRR__exchange_rate, "SHLNGP" AS SHLNGP_language, "SHFAP" AS SHFAP__foreign_open_amount, "SHFCST" AS SHFCST_foreign_total_cost, "SHORBY" AS SHORBY_ordered_by, "SHTKBY" AS SHTKBY_order_taken_by, "SHURCD" AS SHURCD_user_reserved_code, "SHURDT" AS SHURDT_user_reserved_date, "SHURAT" AS SHURAT_user_reserved_amount, "SHURAB" AS SHURAB_user_reserved_number, "SHURRF" AS SHURRF_user_reserved_reference, "SHUSER" AS SHUSER_user_id, "SHPID" AS SHPID__program_id, "SHJOBN" AS SHJOBN_work_station_id, "SHUPMJ" AS SHUPMJ_date_updated, "SHTDAY" AS SHTDAY_time_of_day 

---- INTO STAGE_JDE_ARCPDTA71_F4201_<instert_friendly_name_here>

--FROM 
--    OPENQUERY (ESYS_PROD, '

--	SELECT
--		SHKCOO, SHDOCO, SHDCTO, SHSFXO, SHMCU, SHCO, SHOKCO, SHOORN, SHOCTO, SHRKCO, SHRORN, SHRCTO, SHAN8, SHSHAN, SHPA8, CASE WHEN SHDRQJ IS NOT NULL THEN DATE(DIGITS(DEC(SHDRQJ+ 1900000,7,0))) ELSE NULL END AS SHDRQJ, CASE WHEN SHTRDJ IS NOT NULL THEN DATE(DIGITS(DEC(SHTRDJ+ 1900000,7,0))) ELSE NULL END AS SHTRDJ, CASE WHEN SHPDDJ IS NOT NULL THEN DATE(DIGITS(DEC(SHPDDJ+ 1900000,7,0))) ELSE NULL END AS SHPDDJ, CASE WHEN SHOPDJ IS NOT NULL THEN DATE(DIGITS(DEC(SHOPDJ+ 1900000,7,0))) ELSE NULL END AS SHOPDJ, CASE WHEN SHADDJ IS NOT NULL THEN DATE(DIGITS(DEC(SHADDJ+ 1900000,7,0))) ELSE NULL END AS SHADDJ, CASE WHEN SHCNDJ IS NOT NULL THEN DATE(DIGITS(DEC(SHCNDJ+ 1900000,7,0))) ELSE NULL END AS SHCNDJ, CASE WHEN SHPEFJ IS NOT NULL THEN DATE(DIGITS(DEC(SHPEFJ+ 1900000,7,0))) ELSE NULL END AS SHPEFJ, CASE WHEN SHPPDJ IS NOT NULL THEN DATE(DIGITS(DEC(SHPPDJ+ 1900000,7,0))) ELSE NULL END AS SHPPDJ, CASE WHEN SHPSDJ IS NOT NULL THEN DATE(DIGITS(DEC(SHPSDJ+ 1900000,7,0))) ELSE NULL END AS SHPSDJ, SHVR01, SHVR02, SHDEL1, SHDEL2, SHINMG, SHPTC, SHRYIN, SHASN, SHPRGP, CAST((SHTRDC)/1000.0 AS DEC(15,3)) AS SHTRDC, CAST((SHPCRT)/1000.0 AS DEC(15,3)) AS SHPCRT, SHTXA1, SHEXR1, SHTXCT, SHATXT, SHPRIO, SHBACK, SHSBAL, SHHOLD, SHPLST, SHINVC, SHNTR, SHANBY, SHCARS, SHMOT, SHCOT, SHROUT, SHSTOP, SHZON, SHCNID, SHFRTH, SHAFT, SHFUF1, SHFRTC, SHMORD, SHCMC1, CAST((SHCMR1)/1000.0 AS DEC(15,3)) AS SHCMR1, SHCMC2, CAST((SHCMR2)/1000.0 AS DEC(15,3)) AS SHCMR2, SHRCD, SHFUF2, CAST((SHOTOT)/100.0 AS DEC(15,2)) AS SHOTOT, CAST((SHTOTC)/100.0 AS DEC(15,2)) AS SHTOTC, SHWUMD, SHVUMD, SHAUTN, SHCACT, CASE WHEN SHCEXP IS NOT NULL THEN DATE(DIGITS(DEC(SHCEXP+ 1900000,7,0))) ELSE NULL END AS SHCEXP, SHSBLI, SHCRMD, SHCRRM, SHCRCD, SHCRR, SHLNGP, CAST((SHFAP)/100.0 AS DEC(15,2)) AS SHFAP, CAST((SHFCST)/100.0 AS DEC(15,2)) AS SHFCST, SHORBY, SHTKBY, SHURCD, CASE WHEN SHURDT IS NOT NULL THEN DATE(DIGITS(DEC(SHURDT+ 1900000,7,0))) ELSE NULL END AS SHURDT, CAST((SHURAT)/100.0 AS DEC(15,2)) AS SHURAT, SHURAB, SHURRF, SHUSER, SHPID, SHJOBN, CASE WHEN SHUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(SHUPMJ+ 1900000,7,0))) ELSE NULL END AS SHUPMJ, SHTDAY

--	FROM
--		ARCPDTA71.F4201
----    WHERE
----        <insert custom code here>
----    ORDER BY
----        <insert custom code here>
--')



--------------------------------------------------------------------------------
-- DROP TABLE STAGE_JDE_ARCPDTA71_F4211_sales_order_detail_file
--------------------------------------------------------------------------------

-- 2 min per 7 days

SELECT 

--    Top 5 
    "SDKCOO" AS SDKCOO_order_company,
	"SDDOCO" AS SDDOCO_salesorder_number,
	"SDDCTO" AS SDDCTO_order_type,
	"SDLNID" AS SDLNID_line_number,
	"SDSFXO" AS SDSFXO_order_suffix,
	"SDMCU" AS SDMCU__business_unit,
	"SDCO" AS SDCO___company,
	"SDOKCO" AS SDOKCO_original_order_document_company,
	"SDOORN" AS SDOORN_original_order_number,
	"SDOCTO" AS SDOCTO_original_order_type,
	"SDOGNO" AS SDOGNO_original_line_number,
	"SDRKCO" AS SDRKCO_related_order_key_company,
	"SDRORN" AS SDRORN_related_order_number,
	"SDRCTO" AS SDRCTO_related_order_type,
	"SDRLLN" AS SDRLLN_related_poso_line_number,
	"SDDMCT" AS SDDMCT_agreement_nbr,
	"SDDMCS" AS SDDMCS_agreement_supplement,
	"SDBALU" AS SDBALU_contract_balances_updated_yn,
	"SDAN8" AS SDAN8__billto,
	"SDSHAN" AS SDSHAN_shipto,
	"SDPA8" AS SDPA8__parent_number,

	"SDDRQJ" AS SDDRQJ_requested_JTD,
	"SDTRDJ" AS SDTRDJ_order_date,
	"SDPDDJ" AS SDPDDJ_scheduled_pick_JTD,
	"SDOPDJ" AS SDOPDJ_original_promised_JTD,
	"SDADDJ" AS SDADDJ_actual_ship_JTD,
	"SDIVD" AS SDIVD__invoice_date_JTD,
	"SDCNDJ" AS SDCNDJ_cancel_date_JTD,
	"SDDGL" AS SDDGL__gl_date,
	"SDRSDJ" AS SDRSDJ_promised_delivery_JTD,
	"SDPEFJ" AS SDPEFJ_price_effective_JTD,
	"SDPPDJ" AS SDPPDJ_ship_JTD,
	"SDPSDJ" AS SDPSDJ_projected_available_JTD,

	"SDVR01" AS SDVR01_reference,
	"SDVR02" AS SDVR02_reference_2,
	"SDITM" AS SDITM__item_number_short,
	"SDLITM" AS SDLITM_item_number,
	"SDAITM" AS SDAITM__3rd_item_number,
	"SDLOCN" AS SDLOCN_location,
	"SDLOTN" AS SDLOTN_lotsn,
	"SDFRGD" AS SDFRGD_from_grade,
	"SDTHGD" AS SDTHGD_thru_grade,
	"SDFRMP" AS SDFRMP_from_potency,
	"SDTHRP" AS SDTHRP_thru_potency,
	"SDEXDP" AS SDEXDP_days_before_expiration,
	"SDDSC1" AS SDDSC1_description,
	"SDDSC2" AS SDDSC2_description_2,
	"SDLNTY" AS SDLNTY_line_type,
	"SDNXTR" AS SDNXTR_status_code_next,
	"SDLTTR" AS SDLTTR_status_code_last,
	"SDEMCU" AS SDEMCU_header_business_unit,
	"SDRLIT" AS SDRLIT_related_item_number_kit,
	"SDKTLN" AS SDKTLN_kit_master_line_number,
	"SDCPNT" AS SDCPNT_component_line_number,
	"SDRKIT" AS SDRKIT_related_kit_component,
	"SDKTP" AS SDKTP__number_of_component_per_parent,
	"SDSRP1" AS SDSRP1_sales_catalog_section,
	"SDSRP2" AS SDSRP2_sub_section,
	"SDSRP3" AS SDSRP3_sales_category_code_3,
	"SDSRP4" AS SDSRP4_sales_category_code_4,
	"SDSRP5" AS SDSRP5_sales_category_code_5,
	"SDPRP1" AS SDPRP1_commodity_class,
	"SDPRP2" AS SDPRP2_commodity_sub_class,
	"SDPRP3" AS SDPRP3_supplier_rebate_code,
	"SDPRP4" AS SDPRP4_master_planning_family,
	"SDPRP5" AS SDPRP5_landed_cost_rule,
	"SDUOM" AS SDUOM__um,
	"SDUORG" AS SDUORG_quantity,
	"SDSOQS" AS SDSOQS_quantity_shipped,
	"SDSOBK" AS SDSOBK_quantity_backordered,
	"SDSOCN" AS SDSOCN_quantity_canceled,
	"SDSONE" AS SDSONE_future_quantity_committed,
	"SDUOPN" AS SDUOPN_quantity_open,
	"SDQTYT" AS SDQTYT_quantity_shipped_to_date,
	"SDQRLV" AS SDQRLV_quantity_relieved,
	"SDCOMM" AS SDCOMM_committed_hs,
	"SDOTQY" AS SDOTQY_other_quantity_12,
	"SDUPRC" AS SDUPRC_unit_price,
	"SDAEXP" AS SDAEXP_extended_price,
	"SDAOPN" AS SDAOPN_amount_open,
	"SDPROV" AS SDPROV_price_override_code,
	"SDTPC" AS SDTPC__temporary_price_yn,
	"SDAPUM" AS SDAPUM_entered_unit_of_measure_for_unit_price,
	"SDLPRC" AS SDLPRC_unit_list_price,
	"SDUNCS" AS SDUNCS_unit_cost,
	"SDECST" AS SDECST_extended_cost,
	"SDCSTO" AS SDCSTO_cost_override_code,
	"SDTCST" AS SDTCST_transfer_cost,
	"SDINMG" AS SDINMG_print_message,
	"SDPTC" AS SDPTC__payment_terms,
	"SDRYIN" AS SDRYIN_payment_instrument,
	"SDDTBS" AS SDDTBS_based_on_date,
	"SDTRDC" AS SDTRDC_trade_discount,
	"SDFUN2" AS SDFUN2_trade_discount_old,
	"SDASN" AS SDASN__adjustment_schedule,
	"SDPRGR" AS SDPRGR_item_price_group,
	"SDCLVL" AS SDCLVL_pricing_category_level,
	"SDDSPR" AS SDDSPR_discount_factor,
	"SDDSFT" AS SDDSFT_discount_factor_type_amt_orpct,
	"SDFAPP" AS SDFAPP_discount_application_type,
	"SDCADC" AS SDCADC_cash_discount_pct,
	"SDKCO" AS SDKCO__document_company,
	"SDDOC" AS SDDOC__document_number,
	"SDDCT" AS SDDCT__document_type,
	"SDODOC" AS SDODOC_original_document_no,
	"SDODCT" AS SDODCT_original_document_type,
	"SDOKC" AS SDOKC__original_document_company,
	"SDPSN" AS SDPSN__pick_slip_number,
	"SDDELN" AS SDDELN_delivery_number,
	"SDPRMO" AS SDPRMO_promotion_number,
	"SDDFTN" AS SDDFTN_draft_number,
	"SDTAX1" AS SDTAX1_sales_taxable,
	"SDTXA1" AS SDTXA1_tax_ratearea,
	"SDEXR1" AS SDEXR1_tax_expl_code,
	"SDATXT" AS SDATXT_associated_text,
	"SDPRIO" AS SDPRIO_priority_processing_code,
	"SDRESL" AS SDRESL_printed_code,
	"SDBACK" AS SDBACK_backorders_allowed_yn,
	"SDSBAL" AS SDSBAL_substitutes_allowed_yn,
	"SDAPTS" AS SDAPTS_partial_shipments_allowed_yn,
	"SDLOB" AS SDLOB__line_of_business,
	"SDEUSE" AS SDEUSE_end_use,
	"SDDTYS" AS SDDTYS_duty_status,
	"SDCDCD" AS SDCDCD_commodity_code,
	"SDNTR" AS SDNTR__nature_of_transaction,
	"SDVEND" AS SDVEND_primary_last_supplier_number,
	"SDANBY" AS SDANBY_buyer_number,
	"SDCARS" AS SDCARS_carrier_number,
	"SDMOT" AS SDMOT__mode_of_trn,
	"SDCOT" AS SDCOT__conditions_of_transport,
	"SDROUT" AS SDROUT_route_code,
	"SDSTOP" AS SDSTOP_stop_code,
	"SDZON" AS SDZON__zone_number,
	"SDCNID" AS SDCNID_container_id,
	"SDFRTH" AS SDFRTH_freight_handling_code,
	"SDAFT" AS SDAFT__apply_freight_yn,
	"SDFUF1" AS SDFUF1_aia_document,
	"SDFRTC" AS SDFRTC_freight_calculated_yn,
	"SDFRAT" AS SDFRAT_rate_code_freightmisc,
	"SDRATT" AS SDRATT_rate_type_freightmisc,
	"SDSHCM" AS SDSHCM_shipping_commodity_class,
	"SDSHCN" AS SDSHCN_shipping_conditions_code,
	"SDSERN" AS SDSERN_lot_serial_number,
	"SDUOM1" AS SDUOM1_unit_of_measure,
	"SDPQOR" AS SDPQOR_quantity_ordered,
	"SDUOM2" AS SDUOM2_secondary_uom,
	"SDSQOR" AS SDSQOR_secondary_quantity_ordered,
	"SDUOM4" AS SDUOM4_pricing_uom,
	"SDITWT" AS SDITWT_unit_weight,
	"SDWTUM" AS SDWTUM_weight_unit_of_measure,
	"SDITVL" AS SDITVL_unit_volume,
	"SDVLUM" AS SDVLUM_volume_unit_of_measure,
	"SDRPRC" AS SDRPRC_basket_reprice_group,
	"SDORPR" AS SDORPR_order_reprice_group,
	"SDORP" AS SDORP__order_repriced_indicator,
	"SDCMGP" AS SDCMGP_inventory_costing_method,
	"SDCMGL" AS SDCMGL_commitment_method,
	"SDGLC" AS SDGLC__gl_offset,
	"SDCTRY" AS SDCTRY_century,
	"SDFY" AS SDFY___fiscal_year,
	"SDSTTS" AS SDSTTS_line_status,
	"SDSO01" AS SDSO01_inter_branch_sales,
	"SDSO02" AS SDSO02_on_hand_updated,
	"SDSO03" AS SDSO03_configurator_print_flag,
	"SDSO04" AS SDSO04_sales_order_status_04,
	"SDSO05" AS SDSO05_substitute_item_indicator,
	"SDSO06" AS SDSO06_preference_commitment_indicator,
	"SDSO07" AS SDSO07_ship_date_overridden,
	"SDSO08" AS SDSO08_price_adjustment_line_indicator,
	"SDSO09" AS SDSO09_price_adj_history_indicator,
	"SDSO10" AS SDSO10_preference_product_allocation,
	"SDSO11" AS SDSO11_transferdirect_ship_flag,
	"SDSO12" AS SDSO12_sales_order_status_12,
	"SDSO13" AS SDSO13_euro_conversion_status,
	"SDSO14" AS SDSO14_order_promising_flag,
	"SDSO15" AS SDSO15_sales_order_status_15,
	"SDSLSM" AS SDSLSM_salesperson_code_01,
	"SDSLCM" AS SDSLCM_salesperson_commission_1,
	"SDSLM2" AS SDSLM2_salesperson_code_02,
	"SDSLC2" AS SDSLC2_salesperson_commission_2,
	"SDACOM" AS SDACOM_apply_commission_yn,
	"SDCMCG" AS SDCMCG_commission_category,
	"SDRCD" AS SDRCD__reason_code,
	"SDGRWT" AS SDGRWT_gross_weight,
	"SDGWUM" AS SDGWUM_gross_weight_unit_of_measure,
	"SDANI" AS SDANI__account_number,
	"SDAID" AS SDAID__account_id,
	"SDOMCU" AS SDOMCU_project_cost_center,
	"SDOBJ" AS SDOBJ__object_account,
	"SDSUB" AS SDSUB__subsidiary,
	"SDLT" AS SDLT___ledger_type,
	"SDSBL" AS SDSBL__subledger,
	"SDSBLT" AS SDSBLT_subledger_type,
	"SDLCOD" AS SDLCOD_loc_tax_code,
	"SDUPC1" AS SDUPC1_price_code_1,
	"SDUPC2" AS SDUPC2_price_code_2,
	"SDUPC3" AS SDUPC3_price_code_3,
	"SDSWMS" AS SDSWMS_warehouse_status_code,
	"SDUNCD" AS SDUNCD_freeze_code,
	"SDCRMD" AS SDCRMD_send_method,
	"SDCRCD" AS SDCRCD_currency_code,
	"SDCRR" AS SDCRR__exchange_rate,
	"SDFPRC" AS SDFPRC_foreign_list_price,
	"SDFUP" AS SDFUP__foreign_unit_price,
	"SDFEA" AS SDFEA__foreign_extended_price,
	"SDFUC" AS SDFUC__foreign_unit_cost,
	"SDFEC" AS SDFEC__foreign_extended_cost,
	"SDURCD" AS SDURCD_user_reserved_code,
	"SDURDT" AS SDURDT_user_reserved_date_JDT,
	"SDURAT" AS SDURAT_user_reserved_amount,
	"SDURAB" AS SDURAB_user_reserved_number,
	"SDURRF" AS SDURRF_user_reserved_reference,
	"SDTORG" AS SDTORG_transaction_originator,
	"SDUSER" AS SDUSER_user_id,
	"SDPID" AS SDPID__program_id,
	"SDJOBN" AS SDJOBN_work_station_id,
	"SDUPMJ" AS SDUPMJ_date_updated,
	"SDTDAY" AS SDTDAY_time_of_day 

INTO 
	STAGE_JDE_ARCPDTA71_F4211_sales_order_detail_file

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		SDKCOO,
		SDDOCO,
		SDDCTO,
		CAST((SDLNID)/1000.0 AS DEC(15,3)) AS SDLNID,
		SDSFXO,
		SDMCU,
		SDCO,
		SDOKCO,
		SDOORN,
		SDOCTO,
		CAST((SDOGNO)/1000.0 AS DEC(15,3)) AS SDOGNO,
		SDRKCO,
		SDRORN,
		SDRCTO,
		CAST((SDRLLN)/1000.0 AS DEC(15,3)) AS SDRLLN,
		SDDMCT,
		SDDMCS,
		SDBALU,
		SDAN8,
		SDSHAN,
		SDPA8,

		SDDRQJ,
		CASE WHEN SDTRDJ IS NOT NULL THEN DATE(DIGITS(DEC(SDTRDJ+ 1900000,7,0))) ELSE NULL END AS SDTRDJ,
		SDPDDJ,
		SDOPDJ,
		SDADDJ,
		SDIVD,
		SDCNDJ,
		CASE WHEN SDDGL IS NOT NULL THEN DATE(DIGITS(DEC(SDDGL+ 1900000,7,0))) ELSE NULL END AS SDDGL,
		SDRSDJ,
		SDPEFJ,
		SDPPDJ,
		SDPSDJ,

		--CASE WHEN SDDRQJ IS NOT NULL THEN DATE(DIGITS(DEC(SDDRQJ+ 1900000,7,0))) ELSE NULL END AS SDDRQJ,
		--CASE WHEN SDTRDJ IS NOT NULL THEN DATE(DIGITS(DEC(SDTRDJ+ 1900000,7,0))) ELSE NULL END AS SDTRDJ,
		--CASE WHEN SDPDDJ IS NOT NULL THEN DATE(DIGITS(DEC(SDPDDJ+ 1900000,7,0))) ELSE NULL END AS SDPDDJ,
		--CASE WHEN SDOPDJ IS NOT NULL THEN DATE(DIGITS(DEC(SDOPDJ+ 1900000,7,0))) ELSE NULL END AS SDOPDJ,
		--CASE WHEN SDADDJ IS NOT NULL THEN DATE(DIGITS(DEC(SDADDJ+ 1900000,7,0))) ELSE NULL END AS SDADDJ,
		--CASE WHEN SDIVD IS NOT NULL THEN DATE(DIGITS(DEC(SDIVD+ 1900000,7,0))) ELSE NULL END AS SDIVD,
		--CASE WHEN SDCNDJ IS NOT NULL THEN DATE(DIGITS(DEC(SDCNDJ+ 1900000,7,0))) ELSE NULL END AS SDCNDJ,
		--CASE WHEN SDDGL IS NOT NULL THEN DATE(DIGITS(DEC(SDDGL+ 1900000,7,0))) ELSE NULL END AS SDDGL,
		--CASE WHEN SDRSDJ IS NOT NULL THEN DATE(DIGITS(DEC(SDRSDJ+ 1900000,7,0))) ELSE NULL END AS SDRSDJ,
		--CASE WHEN SDPEFJ IS NOT NULL THEN DATE(DIGITS(DEC(SDPEFJ+ 1900000,7,0))) ELSE NULL END AS SDPEFJ,
		--CASE WHEN SDPPDJ IS NOT NULL THEN DATE(DIGITS(DEC(SDPPDJ+ 1900000,7,0))) ELSE NULL END AS SDPPDJ,
		--CASE WHEN SDPSDJ IS NOT NULL THEN DATE(DIGITS(DEC(SDPSDJ+ 1900000,7,0))) ELSE NULL END AS SDPSDJ,

		SDVR01,
		SDVR02,
		SDITM,
		SDLITM,
		SDAITM,
		SDLOCN,
		SDLOTN,
		SDFRGD,
		SDTHGD,
		CAST((SDFRMP)/1000.0 AS DEC(15,3)) AS SDFRMP,
		CAST((SDTHRP)/1000.0 AS DEC(15,3)) AS SDTHRP,
		SDEXDP,
		SDDSC1,
		SDDSC2,
		SDLNTY,
		SDNXTR,
		SDLTTR,
		SDEMCU,
		SDRLIT,
		CAST((SDKTLN)/1000.0 AS DEC(15,3)) AS SDKTLN,
		CAST((SDCPNT)/10.0 AS DEC(15,1)) AS SDCPNT,
		SDRKIT,
		SDKTP,
		SDSRP1,
		SDSRP2,
		SDSRP3,
		SDSRP4,
		SDSRP5,
		SDPRP1,
		SDPRP2,
		SDPRP3,
		SDPRP4,
		SDPRP5,
		SDUOM,
		SDUORG,
		SDSOQS,
		SDSOBK,
		SDSOCN,
		SDSONE,
		SDUOPN,
		SDQTYT,
		SDQRLV,
		SDCOMM,
		SDOTQY,
		CAST((SDUPRC)/10000.0 AS DEC(15,4)) AS SDUPRC,
		CAST((SDAEXP)/100.0 AS DEC(15,2)) AS SDAEXP,
		CAST((SDAOPN)/100.0 AS DEC(15,2)) AS SDAOPN,
		SDPROV,
		SDTPC,
		SDAPUM,
		CAST((SDLPRC)/10000.0 AS DEC(15,4)) AS SDLPRC,
		CAST((SDUNCS)/10000.0 AS DEC(15,4)) AS SDUNCS,
		CAST((SDECST)/100.0 AS DEC(15,2)) AS SDECST,
		SDCSTO,
		CAST((SDTCST)/10000.0 AS DEC(15,4)) AS SDTCST,
		SDINMG,
		SDPTC,
		SDRYIN,
		SDDTBS,
		CAST((SDTRDC)/1000.0 AS DEC(15,3)) AS SDTRDC,
		CAST((SDFUN2)/10000.0 AS DEC(15,4)) AS SDFUN2,
		SDASN,
		SDPRGR,
		SDCLVL,
		CAST((SDDSPR)/10000.0 AS DEC(15,4)) AS SDDSPR,
		SDDSFT,
		SDFAPP,
		CAST((SDCADC)/1000.0 AS DEC(15,3)) AS SDCADC,
		SDKCO,
		SDDOC,
		SDDCT,
		SDODOC,
		SDODCT,
		SDOKC,
		SDPSN,
		SDDELN,
		SDPRMO,
		SDDFTN,
		SDTAX1,
		SDTXA1,
		SDEXR1,
		SDATXT,
		SDPRIO,
		SDRESL,
		SDBACK,
		SDSBAL,
		SDAPTS,
		SDLOB,
		SDEUSE,
		SDDTYS,
		SDCDCD,
		SDNTR,
		SDVEND,
		SDANBY,
		SDCARS,
		SDMOT,
		SDCOT,
		SDROUT,
		SDSTOP,
		SDZON,
		SDCNID,
		SDFRTH,
		SDAFT,
		SDFUF1,
		SDFRTC,
		SDFRAT,
		SDRATT,
		SDSHCM,
		SDSHCN,
		SDSERN,
		SDUOM1,
		SDPQOR,
		SDUOM2,
		SDSQOR,
		SDUOM4,
		CAST((SDITWT)/10000.0 AS DEC(15,4)) AS SDITWT,
		SDWTUM,
		CAST((SDITVL)/10000.0 AS DEC(15,4)) AS SDITVL,
		SDVLUM,
		SDRPRC,
		SDORPR,
		SDORP,
		SDCMGP,
		SDCMGL,
		SDGLC,
		SDCTRY,
		SDFY,
		SDSTTS,
		SDSO01,
		SDSO02,
		SDSO03,
		SDSO04,
		SDSO05,
		SDSO06,
		SDSO07,
		SDSO08,
		SDSO09,
		SDSO10,
		SDSO11,
		SDSO12,
		SDSO13,
		SDSO14,
		SDSO15,
		SDSLSM,
		CAST((SDSLCM)/1000.0 AS DEC(15,3)) AS SDSLCM,
		SDSLM2,
		CAST((SDSLC2)/1000.0 AS DEC(15,3)) AS SDSLC2,
		SDACOM,
		SDCMCG,
		SDRCD,
		CAST((SDGRWT)/10000.0 AS DEC(15,4)) AS SDGRWT,
		SDGWUM,
		SDANI,
		SDAID,
		SDOMCU,
		SDOBJ,
		SDSUB,
		SDLT,
		SDSBL,
		SDSBLT,
		SDLCOD,
		SDUPC1,
		SDUPC2,
		SDUPC3,
		SDSWMS,
		SDUNCD,
		SDCRMD,
		SDCRCD,
		SDCRR,
		CAST((SDFPRC)/10000.0 AS DEC(15,4)) AS SDFPRC,
		CAST((SDFUP)/10000.0 AS DEC(15,4)) AS SDFUP,
		CAST((SDFEA)/100.0 AS DEC(15,2)) AS SDFEA,
		CAST((SDFUC)/10000.0 AS DEC(15,4)) AS SDFUC,
		CAST((SDFEC)/100.0 AS DEC(15,2)) AS SDFEC,
		SDURCD,
		SDURDT,
--		CASE WHEN SDURDT IS NOT NULL THEN DATE(DIGITS(DEC(SDURDT+ 1900000,7,0))) ELSE NULL END AS SDURDT,
		CAST((SDURAT)/100.0 AS DEC(15,2)) AS SDURAT,
		SDURAB,
		SDURRF,
		SDTORG,
		SDUSER,
		SDPID,
		SDJOBN,
		CASE WHEN SDUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(SDUPMJ+ 1900000,7,0))) ELSE NULL END AS SDUPMJ,
		SDTDAY

	FROM
		ARCPDTA71.F4211
    WHERE
--		ADEFTJ <= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)), SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) AND 		

		SDDGL >= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)), SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE)-7)),8,3)) AND 		
		SDDGL <= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)), SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) 
--    ORDER BY
--        <insert custom code here>
')



--------------------------------------------------------------------------------
-- DROP TABLE STAGE_JDE_ARCPDTA71_F4104_item_cross_reference_file
--------------------------------------------------------------------------------

SELECT 

    Top 5 
    "IVAN8" AS IVAN8__billto, "IVXRT" AS IVXRT__cross_reference_type_code, "IVITM" AS IVITM__item_number_short, "IVEXDJ" AS IVEXDJ_expired_date, "IVEFTJ" AS IVEFTJ_effective_date, "IVMCU" AS IVMCU__business_unit, "IVCITM" AS IVCITM_customersupplier_item_number, "IVDSC1" AS IVDSC1_description, "IVDSC2" AS IVDSC2_description_2, "IVALN" AS IVALN__search_text_compressed, "IVLITM" AS IVLITM_item_number, "IVAITM" AS IVAITM__3rd_item_number, "IVURCD" AS IVURCD_user_reserved_code, "IVURDT" AS IVURDT_user_reserved_date, "IVURAT" AS IVURAT_user_reserved_amount, "IVURAB" AS IVURAB_user_reserved_number, "IVURRF" AS IVURRF_user_reserved_reference, "IVUSER" AS IVUSER_user_id, "IVPID" AS IVPID__program_id, "IVJOBN" AS IVJOBN_work_station_id, "IVUPMJ" AS IVUPMJ_date_updated, "IVTDAY" AS IVTDAY_time_of_day 

-- INTO STAGE_JDE_ARCPDTA71_F4104_item_cross_reference_file

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		IVAN8, IVXRT, IVITM, CASE WHEN IVEXDJ IS NOT NULL THEN DATE(DIGITS(DEC(IVEXDJ+ 1900000,7,0))) ELSE NULL END AS IVEXDJ, CASE WHEN IVEFTJ IS NOT NULL THEN DATE(DIGITS(DEC(IVEFTJ+ 1900000,7,0))) ELSE NULL END AS IVEFTJ, IVMCU, IVCITM, IVDSC1, IVDSC2, IVALN, IVLITM, IVAITM, IVURCD, CASE WHEN IVURDT IS NOT NULL THEN DATE(DIGITS(DEC(IVURDT+ 1900000,7,0))) ELSE NULL END AS IVURDT, CAST((IVURAT)/100.0 AS DEC(15,2)) AS IVURAT, IVURAB, IVURRF, IVUSER, IVPID, IVJOBN, CASE WHEN IVUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(IVUPMJ+ 1900000,7,0))) ELSE NULL END AS IVUPMJ, IVTDAY

	FROM
		ARCPDTA71.F4104
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')



--------------------------------------------------------------------------------
-- DROP TABLE STAGE_JDE_ARCPDTA71_F5505_address_override
--------------------------------------------------------------------------------

SELECT 

    Top 5 
    "GIDOCO" AS GIDOCO_salesorder_number, "GIDCTO" AS GIDCTO_order_type, "GIKCOO" AS GIKCOO_order_company, "GILNID" AS GILNID_line_number, "GI$ANT" AS GI$ANT_address_number_type, "GI$SPS" AS GI$SPS_sequence_number_ship, "GIMLNM" AS GIMLNM_mailing_name, "GIADD1" AS GIADD1_address_line_1, "GIADD2" AS GIADD2_address_line_2, "GIADD3" AS GIADD3_address_line_3, "GIADD4" AS GIADD4_address_line_4, "GIADDZ" AS GIADDZ_postal_code, "GICTY1" AS GICTY1_city, "GICOUN" AS GICOUN_county, "GIADDS" AS GIADDS_state, "GICTR" AS GICTR__country, "GI$TCN" AS GI$TCN_number_transportation_control, "GI$DRN" AS GI$DRN_number_dock_receiver, "GI$TPC" AS GI$TPC_code_transportation_priority, "GI$FFY" AS GI$FFY_fleet_fast_pay, "GIUSER" AS GIUSER_user_id, "GIPID" AS GIPID__program_id, "GIJOBN" AS GIJOBN_work_station_id, "GIUPMJ" AS GIUPMJ_date_updated, "GITDAY" AS GITDAY_time_of_day 

-- INTO STAGE_JDE_ARCPDTA71_F5505_address_override

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		GIDOCO, GIDCTO, GIKCOO, CAST((GILNID)/1000.0 AS DEC(15,3)) AS GILNID, GI$ANT, GI$SPS, GIMLNM, GIADD1, GIADD2, GIADD3, GIADD4, GIADDZ, GICTY1, GICOUN, GIADDS, GICTR, GI$TCN, GI$DRN, GI$TPC, GI$FFY, GIUSER, GIPID, GIJOBN, CASE WHEN GIUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(GIUPMJ+ 1900000,7,0))) ELSE NULL END AS GIUPMJ, GITDAY

	FROM
		ARCPDTA71.F5505
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')



--------------------------------------------------------------------------------
-- DROP TABLE STAGE_JDE_ARCPDTA71_F4101J@_item_join_file_F4101_F5613_F5656
--------------------------------------------------------------------------------

-- 2.5 min

SELECT 

--    Top 5 
    "IMITM" AS IMITM__item_number_short,
	"IMLITM" AS IMLITM_item_number,
	"IMAITM" AS IMAITM__3rd_item_number,
	"IMDSC1" AS IMDSC1_description,
	"IMDSC2" AS IMDSC2_description_2,
	"IMSRTX" AS IMSRTX_search_text,
	"IMALN" AS IMALN__search_text_compressed,
	"IMSRP1" AS IMSRP1_sales_catalog_section,
	"IMSRP2" AS IMSRP2_sub_section,
	"IMSRP3" AS IMSRP3_sales_category_code_3,
	"IMSRP4" AS IMSRP4_sales_category_code_4,
	"IMSRP5" AS IMSRP5_sales_category_code_5,
	"IMSRP6" AS IMSRP6_category_code_6,
	"IMSRP7" AS IMSRP7_category_code_7,
	"IMSRP8" AS IMSRP8_category_code_8,
	"IMSRP9" AS IMSRP9_category_code_9,
	"IMSRP0" AS IMSRP0_category_code_10,
	"IMPRP1" AS IMPRP1_commodity_class,
	"IMPRP2" AS IMPRP2_commodity_sub_class,
	"IMPRP3" AS IMPRP3_supplier_rebate_code,
	"IMPRP4" AS IMPRP4_master_planning_family,
	"IMPRP5" AS IMPRP5_landed_cost_rule,
	"IMPRP6" AS IMPRP6_item_dimension_group,
	"IMPRP7" AS IMPRP7_warehouse_process_grp_1,
	"IMPRP8" AS IMPRP8_warehouse_process_grp_2,
	"IMPRP9" AS IMPRP9_warehouse_process_grp_3,
	"IMPRP0" AS IMPRP0_item_pool_code,
	"IMCDCD" AS IMCDCD_commodity_code,
	"IMPDGR" AS IMPDGR_product_group,
	"IMDSGP" AS IMDSGP_dispatch_group,
	"IMPRGR" AS IMPRGR_item_price_group,
	"IMRPRC" AS IMRPRC_basket_reprice_group,
	"IMORPR" AS IMORPR_order_reprice_group,
	"IMBUYR" AS IMBUYR_buyer_number,
	"IMDRAW" AS IMDRAW_drawing_number,
	"IMRVNO" AS IMRVNO_last_revision_no,
	"IMDSZE" AS IMDSZE_drawing_size,
	"IMVCUD" AS IMVCUD_volume_cubic_dimensions,
	"IMCARS" AS IMCARS_carrier_number,
	"IMCARP" AS IMCARP_preferred_carrier_purchasing,
	"IMSHCN" AS IMSHCN_shipping_conditions_code,
	"IMSHCM" AS IMSHCM_shipping_commodity_class,
	"IMUOM1" AS IMUOM1_unit_of_measure,
	"IMUOM2" AS IMUOM2_secondary_uom,
	"IMUOM3" AS IMUOM3_purchasing_uom,
	"IMUOM4" AS IMUOM4_pricing_uom,
	"IMUOM6" AS IMUOM6_shipping_uom,
	"IMUOM8" AS IMUOM8_production_uom,
	"IMUOM9" AS IMUOM9_component_uom,
	"IMUWUM" AS IMUWUM_unit_of_measure_weight,
	"IMUVM1" AS IMUVM1_unit_of_measure_volume,
	"IMSUTM" AS IMSUTM_stocking_um,
	"IMUMVW" AS IMUMVW_psauvolume_or_weight,
	"IMCYCL" AS IMCYCL_cycle_count_category,
	"IMGLPT" AS IMGLPT_gl_category,
	"IMPLEV" AS IMPLEV_sales_price_level,
	"IMPPLV" AS IMPPLV_purchase_price_level,
	"IMCLEV" AS IMCLEV_inventory_cost_level,
	"IMPRPO" AS IMPRPO_gradepotency_pricing,
	"IMCKAV" AS IMCKAV_check_availability_yn,
	"IMBPFG" AS IMBPFG_bulkpacked_flag,
	"IMSRCE" AS IMSRCE_layer_code_source,
	"IMOT1Y" AS IMOT1Y_potency_control,
	"IMOT2Y" AS IMOT2Y_grade_control,
	"IMSTDP" AS IMSTDP_standard_potency,
	"IMFRMP" AS IMFRMP_from_potency,
	"IMTHRP" AS IMTHRP_thru_potency,
	"IMSTDG" AS IMSTDG_standard_grade,
	"IMFRGD" AS IMFRGD_from_grade,
	"IMTHGD" AS IMTHGD_thru_grade,
	"IMCOTY" AS IMCOTY_component_type,
	"IMSTKT" AS IMSTKT_stocking_type,
	"IMLNTY" AS IMLNTY_line_type,
	"IMCONT" AS IMCONT_contract_item,
	"IMBACK" AS IMBACK_backorders_allowed_yn,
	"IMIFLA" AS IMIFLA_item_flash_message,
	"IMTFLA" AS IMTFLA_std_uom_conversion,
	"IMINMG" AS IMINMG_print_message,
	"IMABCS" AS IMABCS_abc_code_1_sales,
	"IMABCM" AS IMABCM_abc_code_2_margin,
	"IMABCI" AS IMABCI_abc_code_3_investment,
	"IMOVR" AS IMOVR__abc_code_override_indicator,
	"IMWARR" AS IMWARR_warranty_item_group,
	"IMCMCG" AS IMCMCG_commission_category,
	"IMSRNR" AS IMSRNR_serial_no_required,
	"IMPMTH" AS IMPMTH_kit_pricing_method,
	"IMFIFO" AS IMFIFO_fifo_processing,
	"IMLOTS" AS IMLOTS_lot_status_code,
	"IMSLD" AS IMSLD__shelf_life_days,
	"IMANPL" AS IMANPL_planner_number,
	"IMMPST" AS IMMPST_planning_code,
	"IMPCTM" AS IMPCTM_percent_margin,
	"IMMMPC" AS IMMMPC_margin_maintenance_pct,
	"IMPTSC" AS IMPTSC_material_status,
	"IMSNS" AS IMSNS__round_to_whole_number,
	"IMLTLV" AS IMLTLV_leadtime_level,
	"IMLTMF" AS IMLTMF_leadtime_manufacturing,
	"IMLTCM" AS IMLTCM_leadtime_cumulative,
	"IMOPC" AS IMOPC__order_policy_code,
	"IMOPV" AS IMOPV__value_order_policy,
	"IMACQ" AS IMACQ__accounting_cost_quantity,
	"IMMLQ" AS IMMLQ__mfg_leadtime_quantity,
	"IMLTPU" AS IMLTPU_leadtime_per_unit,
	"IMMPSP" AS IMMPSP_planning_fence_rule,
	"IMMRPP" AS IMMRPP_fixedvariable_leadtime,
	"IMITC" AS IMITC__issue_type_code,
	"IMORDW" AS IMORDW_order_with_yn,
	"IMMTF1" AS IMMTF1_planning_fence,
	"IMMTF2" AS IMMTF2_freeze_fence,
	"IMMTF3" AS IMMTF3_message_display_fence,
	"IMMTF4" AS IMMTF4_time_fence,
	"IMMTF5" AS IMMTF5_shipment_leadtime_offset,
	"IMEXPD" AS IMEXPD_expedite_damper_days,
	"IMDEFD" AS IMDEFD_defer_damper_days,
	"IMSFLT" AS IMSFLT_safety_leadtime,
	"IMMAKE" AS IMMAKE_makebuy_code,
	"IMCOBY" AS IMCOBY_cobyproductintermediate,
	"IMLLX" AS IMLLX__low_level_code,
	"IMCMGL" AS IMCMGL_commitment_method,
	"IMCOMH" AS IMCOMH_specific_commitment_days,
	"IMCSNN" AS IMCSNN_configured_string_id_next_number,
	"IMURCD" AS IMURCD_user_reserved_code,
	"IMURDT" AS IMURDT_user_reserved_date_JDT,
	"IMURAT" AS IMURAT_user_reserved_amount,
	"IMURAB" AS IMURAB_user_reserved_number,
	"IMURRF" AS IMURRF_user_reserved_reference,
	"QN$FIN" AS QN$FIN_force_item_notes,
	"QN$FRT" AS QN$FRT_freightable_item,
	"QN$IVP" AS QN$IVP_inventory_percentage,
	"QN$CEM" AS QN$CEM_ce_mark,
	"QN$CER" AS QN$CER_ce_mark_required,
	"QN$RPK" AS QN$RPK_repack,
	"QN$SPC" AS QN$SPC_supplier_code,
	"QN$SZE" AS QN$SZE_size_packaged_units,
	"QN$STR" AS QN$STR_strength,
	"QN$MDC" AS QN$MDC_multiple_drug_classes,
	"QN$STU" AS QN$STU_status,
	"QN$DS" AS QN$DS__drop_ship,
	"QN$IFP" AS QN$IFP_inbound_frt_adj_pct,
	"QN$IFD" AS QN$IFD_inbound_frt_adj_amt,
	"QN$SOM" AS QN$SOM_sales_order_markup,
	"QNLTDT" AS QNLTDT_transit_days,
	"QV$AVC" AS QV$AVC_availability_code,
	"QV$RQT" AS QV$RQT_restricted_qty,
	"QV$CCD" AS QV$CCD_case_code,
	"QV$CCQ" AS QV$CCQ_case_qty,
	"QV$ITH" AS QV$ITH_item_height,
	"QV$ITW" AS QV$ITW_item_width,
	"QV$ITL" AS QV$ITL_item_length,
	"QV$IDC" AS QV$IDC_importdomestic,
	"QV$CLC" AS QV$CLC_classification_code,
	"QV$PRI" AS QV$PRI_pricing_info,
	"QV$MMC" AS QV$MMC_mix_match_code,
	"QV$VCD" AS QV$VCD_vendor_code,
	"QV$LCT" AS QV$LCT_location_type,
	"QV$PPL" AS QV$PPL_print_on_pickticket,
	"QV$BKD" AS QV$BKD_backorder_date_JDT,
	"QV$ABD" AS QV$ABD_abbr_descr,
	"QV$ASR" AS QV$ASR_abbreviated_strength 

INTO 
	STAGE_JDE_ARCPDTA71_F4101J@_item_join_file_F4101_F5613_F5656

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
		IMURDT,
--		CASE WHEN IMURDT IS NOT NULL THEN DATE(DIGITS(DEC(IMURDT+ 1900000,7,0))) ELSE NULL END AS IMURDT,
		CAST((IMURAT)/100.0 AS DEC(15,2)) AS IMURAT,
		IMURAB,
		IMURRF,
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
		QV$AVC,
		QV$RQT,
		QV$CCD,
		QV$CCQ,
		CAST((QV$ITH)/10.0 AS DEC(15,1)) AS QV$ITH,
		CAST((QV$ITW)/10.0 AS DEC(15,1)) AS QV$ITW,
		CAST((QV$ITL)/10.0 AS DEC(15,1)) AS QV$ITL,
		QV$IDC,
		QV$CLC,
		QV$PRI,
		QV$MMC,
		QV$VCD,
		QV$LCT,
		QV$PPL,
		QV$BKD,
--		CASE WHEN QV$BKD IS NOT NULL THEN DATE(DIGITS(DEC(QV$BKD+ 1900000,7,0))) ELSE NULL END AS QV$BKD,
		QV$ABD,
		QV$ASR

	FROM
		ARCPDTA71.F4101J@
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')



--------------------------------------------------------------------------------
-- DROP TABLE STAGE_JDE_ARCPDTA71_F5656_wcs_unique_fields_file
--------------------------------------------------------------------------------

-- x min

SELECT 

--    Top 5 
    "QVITM" AS QVITM__item_number_short,
	"QVLITM" AS QVLITM_item_number,
	"QVAITM" AS QVAITM__3rd_item_number,
	"QV$AVC" AS QV$AVC_availability_code,
	"QV$RQT" AS QV$RQT_restricted_qty,
	"QV$CCD" AS QV$CCD_case_code,
	"QV$CCQ" AS QV$CCQ_case_qty,
	"QV$ITH" AS QV$ITH_item_height,
	"QV$ITW" AS QV$ITW_item_width,
	"QV$ITL" AS QV$ITL_item_length,
	"QV$IDC" AS QV$IDC_importdomestic,
	"QV$CLC" AS QV$CLC_classification_code,
	"QV$PRI" AS QV$PRI_pricing_info,
	"QV$MMC" AS QV$MMC_mix_match_code,
	"QV$VCD" AS QV$VCD_vendor_code,
	"QV$LCT" AS QV$LCT_location_type,
	"QV$PPL" AS QV$PPL_print_on_pickticket,
	"QV$BKD" AS QV$BKD_backorder_date_JDT,
	"QV$ABD" AS QV$ABD_abbr_descr,
	"QV$ASR" AS QV$ASR_abbreviated_strength,
	"QVUSER" AS QVUSER_user_id,
	"QVPID" AS QVPID__program_id,
	"QVJOBN" AS QVJOBN_work_station_id,
	"QVUPMJ" AS QVUPMJ_date_updated,
	"QVTDAY" AS QVTDAY_time_of_day 

INTO 
	STAGE_JDE_ARCPDTA71_F5656_wcs_unique_fields_file

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		QVITM,
		QVLITM,
		QVAITM,
		QV$AVC,
		QV$RQT,
		QV$CCD,
		QV$CCQ,
		CAST((QV$ITH)/10.0 AS DEC(15,1)) AS QV$ITH,
		CAST((QV$ITW)/10.0 AS DEC(15,1)) AS QV$ITW,
		CAST((QV$ITL)/10.0 AS DEC(15,1)) AS QV$ITL,
		QV$IDC,
		QV$CLC,
		QV$PRI,
		QV$MMC,
		QV$VCD,
		QV$LCT,
		QV$PPL,
		QV$BKD,
--		CASE WHEN QV$BKD IS NOT NULL THEN DATE(DIGITS(DEC(QV$BKD+ 1900000,7,0))) ELSE NULL END AS QV$BKD,
		QV$ABD,
		QV$ASR,
		QVUSER,
		QVPID,
		QVJOBN,
		CASE WHEN QVUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(QVUPMJ+ 1900000,7,0))) ELSE NULL END AS QVUPMJ,
		QVTDAY

	FROM
		ARCPDTA71.F5656
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')


--------------------------------------------------------------------------------
-- DROP TABLE STAGE_JDE_ARCPDTA71_F5503_canned_message_file_parameters
--------------------------------------------------------------------------------

SELECT 

    Top 5 
    "Q3KCOO" AS Q3KCOO_order_company,
	"Q3DCTO" AS Q3DCTO_order_type,
	"Q3DOCO" AS Q3DOCO_salesorder_number,
	"Q3LNID" AS Q3LNID_line_number,
	"Q3$APC" AS Q3$APC_application_code,
	"Q3$PMQ" AS Q3$PMQ_program_parameter,
	"Q3LNGP" AS Q3LNGP_language,
	"Q3INMG" AS Q3INMG_print_message,
	"Q3$SNB" AS Q3$SNB_sequence_number 

INTO 
	STAGE_JDE_ARCPDTA71_F5503_canned_message_file_parameters

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		Q3KCOO,
		Q3DCTO,
		Q3DOCO,
		CAST((Q3LNID)/1000.0 AS DEC(15,3)) AS Q3LNID,
		Q3$APC,
		Q3$PMQ,
		Q3LNGP,
		Q3INMG,
		CAST((Q3$SNB)/100.0 AS DEC(15,2)) AS Q3$SNB

	FROM
		ARCPDTA71.F5503
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')



--------------------------------------------------------------------------------
-- DROP TABLE STAGE_JDE_ARCPDTA71_F5832_vendor_chargeback_customer_accumulation_file
--------------------------------------------------------------------------------

-- x min 
SELECT 

--    Top 50 
    "VE$CN2" AS VE$CN2_contract_number,
	"VE$EON" AS VE$EON_manufacturers_external_contract_number,
	"VEKCOO" AS VEKCOO_order_company,
	"VE$CAL" AS VE$CAL_contract_accumulation_level,
	"VE$SNB" AS VE$SNB_sequence_number,
	"VEASN" AS VEASN__adjustment_schedule,
	"VE$CGP" AS VE$CGP_customer_group_id,
	"VEAC10" AS VEAC10_category_code_10,
	"VEAC02" AS VEAC02_account_representative,
	"VESIC" AS VESIC__industry_classification,
	"VELINN" AS VELINN_line_number,
	"VECRTU" AS VECRTU_created_by_user,
	"VECRDJ" AS VECRDJ_creation_date,
	"VERCDS" AS VERCDS_record_status,
	"VEUPMB" AS VEUPMB_updated_by,
	"VEDGCG" AS VEDGCG_change_date_JDT,
	"VEURAT" AS VEURAT_user_reserved_amount,
	"VEURCD" AS VEURCD_user_reserved_code,
	"VEURDT" AS VEURDT_user_reserved_date_JDT,
	"VEURAB" AS VEURAB_user_reserved_number,
	"VEURRF" AS VEURRF_user_reserved_reference,
	"VE$RV1" AS VE$RV1_user_reserved_field,
	"VE$RV2" AS VE$RV2_user_reserved_field,
	"VE$RV3" AS VE$RV3_user_reserved_field,
	"VE$RV4" AS VE$RV4_user_reserved_field,
	"VE$RV5" AS VE$RV5_user_reserved_field,
	"VEURC1" AS VEURC1_user_reserved_code,
	"VEURC2" AS VEURC2_user_reserved_code,
	"VEUSD1" AS VEUSD1_user_date_1_JDT,
	"VEUSD2" AS VEUSD2_user_date_2_JDT,
	"VEUSD3" AS VEUSD3_user_date_3_JDT,
	"VEUDC1" AS VEUDC1_user_defined_code__1,
	"VEUDC2" AS VEUDC2_user_defined_code__2,
	"VEUDC3" AS VEUDC3_user_defined_code__3,
	"VE$AM1" AS VE$AM1_user_amount_future_1,
	"VE$AM2" AS VE$AM2_user_amount_future_2,
	"VE$AM3" AS VE$AM3_user_amount_future_3,
	"VEUSER" AS VEUSER_user_id,
	"VEPID" AS VEPID__program_id,
	"VEJOBN" AS VEJOBN_work_station_id,
	"VEUPMJ" AS VEUPMJ_date_updated,
	"VETDAY" AS VETDAY_time_of_day 

INTO STAGE_JDE_ARCPDTA71_F5832_vendor_chargeback_customer_accumulation_file

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
		VEDGCG,
--		CASE WHEN VEDGCG IS NOT NULL THEN DATE(DIGITS(DEC(VEDGCG+ 1900000,7,0))) ELSE NULL END AS VEDGCG,
		CAST((VEURAT)/100.0 AS DEC(15,2)) AS VEURAT,
		VEURCD,
		VEURDT,
--		CASE WHEN VEURDT IS NOT NULL THEN DATE(DIGITS(DEC(VEURDT+ 1900000,7,0))) ELSE NULL END AS VEURDT,
		VEURAB,
		VEURRF,
		VE$RV1,
		VE$RV2,
		VE$RV3,
		VE$RV4,
		VE$RV5,
		VEURC1,
		VEURC2,
		VEUSD1,
		VEUSD2,
		VEUSD3,

--		CASE WHEN VEUSD1 IS NOT NULL THEN DATE(DIGITS(DEC(VEUSD1+ 1900000,7,0))) ELSE NULL END AS VEUSD1,
--		CASE WHEN VEUSD2 IS NOT NULL THEN DATE(DIGITS(DEC(VEUSD2+ 1900000,7,0))) ELSE NULL END AS VEUSD2,
--		CASE WHEN VEUSD3 IS NOT NULL THEN DATE(DIGITS(DEC(VEUSD3+ 1900000,7,0))) ELSE NULL END AS VEUSD3,

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
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')




--------------------------------------------------------------------------------
-- DROP TABLE STAGE_JDE_ARCPDTA71_F5831_vendor_chargeback_detail
--------------------------------------------------------------------------------

SELECT 

    Top 5 
    "VB$CN2" AS VB$CN2_contract_number,
	"VBKCOO" AS VBKCOO_order_company,
	"VB$EON" AS VB$EON_manufacturers_external_contract_number,
	"VBSRP6" AS VBSRP6_category_code_6,
	"VBLITM" AS VBLITM_item_number,
	"VBCITM" AS VBCITM_customersupplier_item_number,
	"VBSRP1" AS VBSRP1_sales_catalog_section,
	"VBSRP2" AS VBSRP2_sub_section,
	"VBSRP3" AS VBSRP3_sales_category_code_3,
	"VBSRP4" AS VBSRP4_sales_category_code_4,
	"VBLINN" AS VBLINN_line_number,
	"VB$FD" AS VB$FD__start_date,
	"VB$TD" AS VB$TD__end_date,
	"VB$CCC" AS VB$CCC_cost_contract_cost_chargebacks,
	"VB$FC1" AS VB$FC1_chargeback_dollar_factors_1,
	"VB$PC1" AS VB$PC1_chargeback_percent_factors_1,
	"VB$MNC" AS VB$MNC_manual_cost_chargebacks,
	"VB$IS" AS VB$IS__contract_item_status,
	"VBCRTU" AS VBCRTU_created_by_user,
	"VBCRDJ" AS VBCRDJ_creation_date,
	"VBDGCG" AS VBDGCG_change_date,
	"VBUPMB" AS VBUPMB_updated_by,
	"VB$CRN" AS VB$CRN_number_contract_cross_reference,
	"VBAC10" AS VBAC10_category_code_10,
	"VBSIC" AS VBSIC__industry_classification,
	"VBURAT" AS VBURAT_user_reserved_amount,
	"VBURCD" AS VBURCD_user_reserved_code,
	"VBURDT" AS VBURDT_user_reserved_date,
	"VBURAB" AS VBURAB_user_reserved_number,
	"VBURRF" AS VBURRF_user_reserved_reference,
	"VB$RV1" AS VB$RV1_user_reserved_field,
	"VB$RV2" AS VB$RV2_user_reserved_field,
	"VB$RV3" AS VB$RV3_user_reserved_field,
	"VB$RV4" AS VB$RV4_user_reserved_field,
	"VB$RV5" AS VB$RV5_user_reserved_field,
	"VBURC1" AS VBURC1_user_reserved_code,
	"VBURC2" AS VBURC2_user_reserved_code,
	"VBUSD1" AS VBUSD1_user_date_1,
	"VBUSD2" AS VBUSD2_user_date_2,
	"VBUSD3" AS VBUSD3_user_date_3,
	"VBUDC1" AS VBUDC1_user_defined_code__1,
	"VBUDC2" AS VBUDC2_user_defined_code__2,
	"VBUDC3" AS VBUDC3_user_defined_code__3,
	"VB$AM1" AS VB$AM1_user_amount_future_1,
	"VB$AM2" AS VB$AM2_user_amount_future_2,
	"VB$AM3" AS VB$AM3_user_amount_future_3,
	"VBUSER" AS VBUSER_user_id,
	"VBJOBN" AS VBJOBN_work_station_id,
	"VBPID" AS VBPID__program_id,
	"VBUPMJ" AS VBUPMJ_date_updated,
	"VBTDAY" AS VBTDAY_time_of_day 

-- INTO STAGE_JDE_ARCPDTA71_F5831_vendor_chargeback_detail

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
--    WHERE
--		SDDGL >= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)), SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE)-7)),8,3)) AND 		
--		SDDGL <= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)), SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) 
--    ORDER BY
--        <insert custom code here>
')



