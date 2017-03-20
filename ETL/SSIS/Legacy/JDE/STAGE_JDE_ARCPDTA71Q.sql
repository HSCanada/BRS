
--------------------------------------------------------------------------------
-- DROP TABLE STAGE_JDE_ARCPDTA71Q_F4072_price_adjustment_detail 
--------------------------------------------------------------------------------

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
	STAGE_JDE_ARCPDTA71Q_F4072_price_adjustment_detail

FROM 
    OPENQUERY (ESYS_QA, '

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
		DATE(DIGITS(DEC(ADEFTJ+ 1900000,7,0))) AS ADEFTJ,
		DATE(DIGITS(DEC(ADEXDJ+ 1900000,7,0))) AS ADEXDJ,
		ADBSCD,
		ADLEDG,
		ADFRMN,
		CAST((ADFVTR)/10000.0 AS DEC(15,4)) AS ADFVTR,
		ADFGY,
		ADATID,
		ADURCD,
		ADURDT AS ADURDT,
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
		ADEFTJ <= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) AND 		
		ADEXDJ >= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3))  		
--    ORDER BY
--        <insert custom code here>
')



--------------------------------------------------------------------------------
-- DROP TABLE STAGE_JDE_ARCPDTA71Q_F4073_free_goods_master_file
--------------------------------------------------------------------------------
- xxx
SELECT 

--    Top 5 
    "FGAST" AS FGAST__adjustment_name,
	"FGATID" AS FGATID_price_adjustment_key_id,
	"FGITMR" AS FGITMR_related_short_item_number,
	"FGLITM" AS FGLITM_item_number,
	"FGAITM" AS FGAITM__3rd_item_number,
	"FGUORG" AS FGUORG_quantity,
	"FGUOM" AS FGUOM__um,
	"FGRPRI" AS FGRPRI_related_price,
	"FGUNCS" AS FGUNCS_unit_cost,
	"FGGLC" AS FGGLC__gl_offset,
	"FGLNTY" AS FGLNTY_line_type,
	"FGFQTY" AS FGFQTY_quantity_per,
	"FGFGTY" AS FGFGTY_free_good_type,
	"FGFP01" AS FGFP01_free_good_process_code_01,
	"FGFP02" AS FGFP02_free_good_process_code_02,
	"FGFP03" AS FGFP03_free_good_process_code_03,
	"FGUSER" AS FGUSER_user_id,
	"FGPID" AS FGPID__program_id,
	"FGJOBN" AS FGJOBN_work_station_id,
	"FGUPMJ" AS FGUPMJ_date_updated,
	"FGTDAY" AS FGTDAY_time_of_day 

INTO 
	STAGE_JDE_ARCPDTA71Q_F4073_free_goods_master_file

FROM 
    OPENQUERY (ESYS_QA, '

	SELECT
		FGAST,
		FGATID,
		FGITMR,
		FGLITM,
		FGAITM,
		FGUORG,
		FGUOM,
		CAST((FGRPRI)/10000.0 AS DEC(15,4)) AS FGRPRI,
		CAST((FGUNCS)/10000.0 AS DEC(15,4)) AS FGUNCS,
		FGGLC,
		FGLNTY,
		CAST((FGFQTY)/100.0 AS DEC(15,2)) AS FGFQTY,
		FGFGTY,
		FGFP01,
		FGFP02,
		FGFP03,
		FGUSER,
		FGPID,
		FGJOBN,
		CASE WHEN FGUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(FGUPMJ+ 1900000,7,0))) ELSE NULL END AS FGUPMJ,
		FGTDAY

	FROM
		ARCPDTA71.F4073
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')



--------------------------------------------------------------------------------
-- DROP TABLE STAGE_JDE_ARCPDTA71Q_F554072_price_adjustment_detail_extension
--------------------------------------------------------------------------------

SELECT 

--    Top 5 
    "QXAST" AS QXAST__adjustment_name,
	"QXATID" AS QXATID_price_adjustment_key_id,
	"QX$PLT" AS QX$PLT_promotional_limit,
	"QX$SPE" AS QX$SPE_special_processing_code,
	"QX$APM" AS QX$APM_additional_promotion_code,
	"QX$PMU" AS QX$PMU_premium_point_multiplier,
	"QXURCD" AS QXURCD_user_reserved_code,
	"QXURDT" AS QXURDT_user_reserved_date_JDT,
	"QXURAT" AS QXURAT_user_reserved_amount,
	"QXURAB" AS QXURAB_user_reserved_number,
	"QXURRF" AS QXURRF_user_reserved_reference,
	"QXUSER" AS QXUSER_user_id,
	"QXPID" AS QXPID__program_id,
	"QXJOBN" AS QXJOBN_work_station_id,
	"QXUPMJ" AS QXUPMJ_date_updated,
	"QXTDAY" AS QXTDAY_time_of_day 

INTO 
	STAGE_JDE_ARCPDTA71Q_F554072_price_adjustment_detail_extension

FROM 
    OPENQUERY (ESYS_QA, '

	SELECT
		QXAST,
		QXATID,
		QX$PLT,
		QX$SPE,
		QX$APM,
		CAST((QX$PMU)/100.0 AS DEC(15,2)) AS QX$PMU,
		QXURCD,
		QXURDT AS QXURDT,
		CAST((QXURAT)/100.0 AS DEC(15,2)) AS QXURAT,
		QXURAB,
		QXURRF,
		QXUSER,
		QXPID,
		QXJOBN,
		CASE WHEN QXUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(QXUPMJ+ 1900000,7,0))) ELSE NULL END AS QXUPMJ,
		QXTDAY

	FROM
		ARCPDTA71.F554072
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')


--------------------------------------------------------------------------------
-- DROP TABLE STAGE_JDE_ARCPDTA71Q_F40314_preference_price_adjustment_schedule
--------------------------------------------------------------------------------

SELECT 

--    Top 5 
    "PJAN8" AS PJAN8__billto,
	"PJCS14" AS PJCS14_customer_group_price_adjustment_sched,
	"PJITM" AS PJITM__item_number_short,
	"PJIT14" AS PJIT14_item_group_price_adjustment_schedule,
	"PJEFTJ" AS PJEFTJ_effective_date,
	"PJEXDJ" AS PJEXDJ_expired_date,
	"PJMNQ" AS PJMNQ__quantity_from,
	"PJMXQ" AS PJMXQ__quantity_thru,
	"PJUOM" AS PJUOM__um,
	"PJTXID" AS PJTXID_text_id_number,
	"PJSTPR" AS PJSTPR_preference_status,
	"PJOSEQ" AS PJOSEQ_sequence_number,
	"PJMCU" AS PJMCU__business_unit,
	"PJASN" AS PJASN__adjustment_schedule,
	"PJURCD" AS PJURCD_user_reserved_code,
	"PJURDT" AS PJURDT_user_reserved_date_JDT,
	"PJURAT" AS PJURAT_user_reserved_amount,
	"PJURAB" AS PJURAB_user_reserved_number,
	"PJURRF" AS PJURRF_user_reserved_reference,
	"PJUSER" AS PJUSER_user_id,
	"PJPID" AS PJPID__program_id,
	"PJJOBN" AS PJJOBN_work_station_id,
	"PJUPMJ" AS PJUPMJ_date_updated,
	"PJTDAY" AS PJTDAY_time_of_day 

INTO 
	STAGE_JDE_ARCPDTA71Q_F40314_preference_price_adjustment_schedule

FROM 
    OPENQUERY (ESYS_QA, '

	SELECT
		PJAN8,
		PJCS14,
		PJITM,
		PJIT14,
		DATE(DIGITS(DEC(PJEFTJ+ 1900000,7,0))) AS PJEFTJ,
		DATE(DIGITS(DEC(PJEXDJ+ 1900000,7,0))) AS PJEXDJ,
		PJMNQ,
		PJMXQ,
		PJUOM,
		PJTXID,
		PJSTPR,
		PJOSEQ,
		PJMCU,
		PJASN,
		PJURCD,
		PJURDT AS PJURDT,
		CAST((PJURAT)/100.0 AS DEC(15,2)) AS PJURAT,
		PJURAB,
		PJURRF,
		PJUSER,
		PJPID,
		PJJOBN,
		CASE WHEN PJUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(PJUPMJ+ 1900000,7,0))) ELSE NULL END AS PJUPMJ,
		PJTDAY

	FROM
		ARCPDTA71.F40314
    WHERE
 		PJEFTJ <= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) AND 		
		PJEXDJ >= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3))  		
--  ORDER BY
--        <insert custom code here>
')



--------------------------------------------------------------------------------
-- DROP TABLE STAGE_JDE_ARCPDTA71Q_F4101_item_master
--------------------------------------------------------------------------------

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

INTO 
	STAGE_JDE_ARCPDTA71Q_F4101_item_master

FROM 
    OPENQUERY (ESYS_QA, '

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
-- DROP TABLE STAGE_JDE_ARCPDTA71Q_F5613_product_extension_file
--------------------------------------------------------------------------------

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
	STAGE_JDE_ARCPDTA71Q_F5613_product_extension_file

FROM 
    OPENQUERY (ESYS_QA, '

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
-- DROP TABLE STAGE_JDE_ARCPDTA71Q_F0101_address_book_master
--------------------------------------------------------------------------------

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
	STAGE_JDE_ARCPDTA71Q_F0101_address_book_master

FROM 
    OPENQUERY (ESYS_QA, '

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
		ABEFTB AS ABEFTB,
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
		ABPDI AS ABPDI,
		ABMSGA,
		ABRMK,
		ABTXCT,
		ABTX2,
		ABALP1,
		ABURCD,
		ABURDT AS ABURDT,
		CAST((ABURAT)/100.0 AS DEC(15,2)) AS ABURAT,
		ABURAB,
		ABURRF,
		ABUSER,
		ABPID,
		ABUPMJ AS ABUPMJ,
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
-- DROP TABLE STAGE_JDE_ARCPDTA71Q_F5831_vendor_chargeback_detail
--------------------------------------------------------------------------------

SELECT 

 --   Top 50
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
	"VBCRDJ" AS VBCRDJ_creation_date_JDT,
	"VBDGCG" AS VBDGCG_change_date_JDT,
	"VBUPMB" AS VBUPMB_updated_by,
	"VB$CRN" AS VB$CRN_number_contract_cross_reference,
	"VBAC10" AS VBAC10_category_code_10,
	"VBSIC" AS VBSIC__industry_classification,
	"VBURAT" AS VBURAT_user_reserved_amount,
	"VBURCD" AS VBURCD_user_reserved_code,
	"VBURDT" AS VBURDT_user_reserved_date_JDT,
	"VBURAB" AS VBURAB_user_reserved_number,
	"VBURRF" AS VBURRF_user_reserved_reference,
	"VB$RV1" AS VB$RV1_user_reserved_field,
	"VB$RV2" AS VB$RV2_user_reserved_field,
	"VB$RV3" AS VB$RV3_user_reserved_field,
	"VB$RV4" AS VB$RV4_user_reserved_field,
	"VB$RV5" AS VB$RV5_user_reserved_field,
	"VBURC1" AS VBURC1_user_reserved_code,
	"VBURC2" AS VBURC2_user_reserved_code,
	"VBUSD1" AS VBUSD1_user_date_1_JDT,
	"VBUSD2" AS VBUSD2_user_date_2_JDT,
	"VBUSD3" AS VBUSD3_user_date_3_JDT,
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

INTO 
	STAGE_JDE_ARCPDTA71Q_F5831_vendor_chargeback_detail

FROM 
    OPENQUERY (ESYS_QA, '

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
		DATE(DIGITS(DEC(VB$FD+ 1900000,7,0))) AS VB$FD,
		DATE(DIGITS(DEC(VB$TD+ 1900000,7,0))) AS VB$TD,
		CAST((VB$CCC)/100.0 AS DEC(15,2)) AS VB$CCC,
		CAST((VB$FC1)/100.0 AS DEC(15,2)) AS VB$FC1,
		CAST((VB$PC1)/100.0 AS DEC(15,2)) AS VB$PC1,
		CAST((VB$MNC)/100.0 AS DEC(15,2)) AS VB$MNC,
		VB$IS,
		VBCRTU,
		VBCRDJ AS VBCRDJ,
		VBDGCG AS VBDGCG,
		VBUPMB,
		VB$CRN,
		VBAC10,
		VBSIC,
		CAST((VBURAT)/100.0 AS DEC(15,2)) AS VBURAT,
		VBURCD,
		VBURDT AS VBURDT,
		VBURAB,
		VBURRF,
		VB$RV1,
		VB$RV2,
		VB$RV3,
		VB$RV4,
		VB$RV5,
		VBURC1,
		VBURC2,
		VBUSD1 AS VBUSD1,
		VBUSD2 AS VBUSD2,
		VBUSD3 AS VBUSD3,
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
    WHERE
 		VB$FD <= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) AND 		
		VB$TD >= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3))  		
--    ORDER BY
--        <insert custom code here>
')


--------------------------------------------------------------------------------
-- DROP TABLE STAGE_JDE_ARCPDTA71Q_F554079_rebate_history_by_sales_detail_extension
--------------------------------------------------------------------------------

SELECT 

--    Top 50
    "REAN8" AS REAN8__billto,
	"RESHAN" AS RESHAN_shipto,
	"REITM" AS REITM__item_number_short,
	"REICID" AS REICID_itemcustomer_key_id,
	"REAST" AS REAST__adjustment_name,
	"REASN" AS REASN__adjustment_schedule,
	"REEFTJ" AS REEFTJ_effective_date,
	"REEXDJ" AS REEXDJ_expired_date,
	"REDGL" AS REDGL__gl_date,
	"RELITM" AS RELITM_item_number,
	"RESOQS" AS RESOQS_quantity_shipped,
	"REUPRC" AS REUPRC_unit_price,
	"REDOCO" AS REDOCO_salesorder_number,
	"REDCTO" AS REDCTO_order_type,
	"REKCOO" AS REKCOO_order_company,
	"RELNID" AS RELNID_line_number,
	"RETOSA" AS RETOSA_total_sales_amt,
	"RECRCD" AS RECRCD_currency_code,
	"RETOQN" AS RETOQN_total_sales_qty,
	"REUOM" AS REUOM__um,
	"RETOWT" AS RETOWT_total_sales_wt,
	"REWTUM" AS REWTUM_weight_unit_of_measure,
	"RERORN" AS RERORN_related_order_number,
	"RERCTO" AS RERCTO_related_order_type,
	"RERKCO" AS RERKCO_related_order_key_company,
	"RERLLN" AS RERLLN_related_poso_line_number,
	"REURDT" AS REURDT_user_reserved_date_JDT,
	"REURAT" AS REURAT_user_reserved_amount,
	"REURC1" AS REURC1_user_reserved_code,
	"REURRF" AS REURRF_user_reserved_reference,
	"RE$FG1" AS RE$FG1_flag_1,
	"RE$FG2" AS RE$FG2_flag_2,
	"REATID" AS REATID_price_adjustment_key_id,
	"RESO09" AS RESO09_price_adj_history_indicator,
	"REACTF" AS REACTF_activity_flag,
	"RETPLN" AS RETPLN_to_plan_id,
	"REKY" AS REKY___user_defined_code,
	"REDENT" AS REDENT_date_entered,
	"REFPLN" AS REFPLN_from_plan_id,
	"REKYFN" AS REKYFN_key_field,
	"REDTUD" AS REDTUD_user_defined_date,
	"REUSER" AS REUSER_user_id,
	"REPID" AS REPID__program_id,
	"REJOBN" AS REJOBN_work_station_id,
	"REUPMJ" AS REUPMJ_date_updated,
	"RETDAY" AS RETDAY_time_of_day 

INTO 
	STAGE_JDE_ARCPDTA71Q_F554079_rebate_history_by_sales_detail_extension

FROM 
    OPENQUERY (ESYS_QA, '

	SELECT
		REAN8,
		RESHAN,
		REITM,
		REICID,
		REAST,
		REASN,
		DATE(DIGITS(DEC(REEFTJ+ 1900000,7,0))) AS REEFTJ,
		DATE(DIGITS(DEC(REEXDJ+ 1900000,7,0))) AS REEXDJ,
		DATE(DIGITS(DEC(REDGL+ 1900000,7,0))) AS REDGL,
		RELITM,
		RESOQS,
		CAST((REUPRC)/10000.0 AS DEC(15,4)) AS REUPRC,
		REDOCO,
		REDCTO,
		REKCOO,
		CAST((RELNID)/1000.0 AS DEC(15,3)) AS RELNID,
		CAST((RETOSA)/100.0 AS DEC(15,2)) AS RETOSA,
		RECRCD,
		RETOQN,
		REUOM,
		RETOWT,
		REWTUM,
		RERORN,
		RERCTO,
		RERKCO,
		CAST((RERLLN)/1000.0 AS DEC(15,3)) AS RERLLN,
		REURDT AS REURDT,
		CAST((REURAT)/100.0 AS DEC(15,2)) AS REURAT,
		REURC1,
		REURRF,
		RE$FG1,
		RE$FG2,
		REATID,
		RESO09,
		REACTF,
		RETPLN,
		REKY,
		REDENT AS REDENT,
		REFPLN,
		REKYFN,
		REDTUD AS REDTUD,
		REUSER,
		REPID,
		REJOBN,
		CASE WHEN REUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(REUPMJ+ 1900000,7,0))) ELSE NULL END AS REUPMJ,
		RETDAY

			FROM
				ARCPDTA71.F554079
		    WHERE
 				REEFTJ = CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(''2016-06-26'')),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(''2016-06-26''))),8,3)) AND
				REASN = ''DR12FRS''
		--    ORDER BY
		--        <insert custom code here>
		')



--------------------------------------------------------------------------------
-- DROP TABLE STAGE_JDE_ARCPDTA71Q_F40308_preference_profile_grade_and_potency
--------------------------------------------------------------------------------

SELECT 

--    Top 50
    "GSAN8" AS GSAN8__billto,
	"GSCS08" AS GSCS08_customer_group_grade_and_potency,
	"GSITM" AS GSITM__item_number_short,
	"GSIT08" AS GSIT08_item_group_grade_and_potency,
	"GSEFTJ" AS GSEFTJ_effective_date,
	"GSEXDJ" AS GSEXDJ_expired_date,
	"GSMNQ" AS GSMNQ__quantity_from,
	"GSMXQ" AS GSMXQ__quantity_thru,
	"GSUOM" AS GSUOM__um,
	"GSTXID" AS GSTXID_text_id_number,
	"GSSTPR" AS GSSTPR_preference_status,
	"GSFRGD" AS GSFRGD_from_grade,
	"GSTHGD" AS GSTHGD_thru_grade,
	"GSFRMP" AS GSFRMP_from_potency,
	"GSTHRP" AS GSTHRP_thru_potency,
	"GSEXDP" AS GSEXDP_days_before_expiration,
	"GSURCD" AS GSURCD_user_reserved_code,
	"GSURDT" AS GSURDT_user_reserved_date_JDT,
	"GSURAT" AS GSURAT_user_reserved_amount,
	"GSURAB" AS GSURAB_user_reserved_number,
	"GSURRF" AS GSURRF_user_reserved_reference,
	"GSUSER" AS GSUSER_user_id,
	"GSPID" AS GSPID__program_id,
	"GSJOBN" AS GSJOBN_work_station_id,
	"GSUPMJ" AS GSUPMJ_date_updated,
	"GSTDAY" AS GSTDAY_time_of_day 

INTO 
	STAGE_JDE_ARCPDTA71Q_F40308_preference_profile_grade_and_potency

FROM 
    OPENQUERY (ESYS_QA, '

	SELECT
		GSAN8,
		GSCS08,
		GSITM,
		GSIT08,
		CASE WHEN GSEFTJ IS NOT NULL THEN DATE(DIGITS(DEC(GSEFTJ+ 1900000,7,0))) ELSE NULL END AS GSEFTJ,
		CASE WHEN GSEXDJ IS NOT NULL THEN DATE(DIGITS(DEC(GSEXDJ+ 1900000,7,0))) ELSE NULL END AS GSEXDJ,
		GSMNQ,
		GSMXQ,
		GSUOM,
		GSTXID,
		GSSTPR,
		GSFRGD,
		GSTHGD,
		CAST((GSFRMP)/1000.0 AS DEC(15,3)) AS GSFRMP,
		CAST((GSTHRP)/1000.0 AS DEC(15,3)) AS GSTHRP,
		GSEXDP,
		GSURCD,
		GSURDT AS GSURDT,
		CAST((GSURAT)/100.0 AS DEC(15,2)) AS GSURAT,
		GSURAB,
		GSURRF,
		GSUSER,
		GSPID,
		GSJOBN,
		CASE WHEN GSUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(GSUPMJ+ 1900000,7,0))) ELSE NULL END AS GSUPMJ,
		GSTDAY

	FROM
		ARCPDTA71.F40308
    WHERE
		GSEFTJ <= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) AND 		
		GSEXDJ >= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3))  		
--    ORDER BY
--        <insert custom code here>
')




--------------------------------------------------------------------------------
-- DROP TABLE STAGE_JDE_ARCPDTA71Q_F5830_chargeback_header
--------------------------------------------------------------------------------

SELECT 

--    Top 50
    "VA$CN2" AS VA$CN2_contract_number,
	"VAKCOO" AS VAKCOO_order_company,
	"VA$EON" AS VA$EON_manufacturers_external_contract_number,
	"VADESC" AS VADESC_description,
	"VA$FD" AS VA$FD__start_date,
	"VA$TD" AS VA$TD__end_date,
	"VAEFTB" AS VAEFTB_start_effective_date_JDT,
	"VA$DCA" AS VA$DCA_date_contract_activated_JDT,
	"VAODDJ" AS VAODDJ_original_due_date_JDT,
	"VADGCG" AS VADGCG_change_date_JDT,
	"VACNDJ" AS VACNDJ_cancel_date_JDT,
	"VAEXDJ" AS VAEXDJ_expired_date_JDT,
	"VASRP6" AS VASRP6_category_code_6,
	"VA$MA1" AS VA$MA1_alternate_manufacturer_1,
	"VA$MA2" AS VA$MA2_alternate_manufacturer_2,
	"VA$MA3" AS VA$MA3_alternate_manufacturer_3,
	"VA$MA4" AS VA$MA4_alternate_manufacturer_4,
	"VA$MA5" AS VA$MA5_alternate_manufacturer_5,
	"VA$MA6" AS VA$MA6_alternate_manufacturer_6,
	"VAUSA1" AS VAUSA1_address_number_1_user,
	"VAGCNT" AS VAGCNT_contract_number,
	"VACRTU" AS VACRTU_created_by_user,
	"VACRDJ" AS VACRDJ_creation_date_JDT,
	"VAUPMB" AS VAUPMB_updated_by,
	"VA$SLM" AS VA$SLM_sales_approval,
	"VA$VAP" AS VA$VAP_vendor_approval,
	"VA$OTY" AS VA$OTY_transaction_type,
	"VA$PCF" AS VA$PCF_chargeback_cycle,
	"VA$AFC" AS VA$AFC_admin_fee_cycle,
	"VA$OTP" AS VA$OTP_chargeback_output_type,
	"VA$CST" AS VA$CST_status_chargebacks,
	"VA$FGY" AS VA$FGY_multi_purpose_flag,
	"VA$CRN" AS VA$CRN_number_contract_cross_reference,
	"VA$IAS" AS VA$IAS_status_include_all_sales,
	"VA$FMT" AS VA$FMT_edi_document_format,
	"VA$HIN" AS VA$HIN_hindea_required,
	"VA$CPT" AS VA$CPT_chargeback_payment_type,
	"VA$SCG" AS VA$SCG_service_charge_percent_admin_fee,
	"VA$PC1" AS VA$PC1_chargeback_percent_factors_1,
	"VA$FC1" AS VA$FC1_chargeback_dollar_factors_1,
	"VA$RET" AS VA$RET_retro,
	"VA$RPV" AS VA$RPV_retro_processed_values,
	"VA$RD" AS VA$RD__reset_chargeback_data,
	"VA$RC" AS VA$RC__recurring_chargeback,
	"VA$CL" AS VA$CL__chargeback_calc_type,
	"VA$TOC" AS VA$TOC_type_of_cost,
	"VA$CAL" AS VA$CAL_contract_accumulation_level,
	"VA$BIS" AS VA$BIS_bid_incoming_sequence_number,
	"VA$CLV" AS VA$CLV_contract_level,
	"VALINN" AS VALINN_line_number,
	"VABA" AS VABA___beginning_gl_account_number,
	"VARP07" AS VARP07_line_of_business,
	"VARP10" AS VARP10_category_code_10,
	"VA$FG1" AS VA$FG1_flag_1,
	"VA$CMT" AS VA$CMT_comment,
	"VACONC" AS VACONC_compressed_contract_name,
	"VAPH2" AS VAPH2__phone_number,
	"VAEML" AS VAEML__email_address,
	"VAURAT" AS VAURAT_user_reserved_amount,
	"VAURCD" AS VAURCD_user_reserved_code,
	"VAURDT" AS VAURDT_user_reserved_date_JDT,
	"VAURAB" AS VAURAB_user_reserved_number,
	"VAURRF" AS VAURRF_user_reserved_reference,
	"VA$RV1" AS VA$RV1_user_reserved_field,
	"VA$RV2" AS VA$RV2_user_reserved_field,
	"VA$RV3" AS VA$RV3_user_reserved_field,
	"VA$RV4" AS VA$RV4_user_reserved_field,
	"VA$RV5" AS VA$RV5_user_reserved_field,
	"VAURC1" AS VAURC1_user_reserved_code,
	"VAURC2" AS VAURC2_user_reserved_code,
	"VAUSD1" AS VAUSD1_user_date_1_JDT,
	"VAUSD2" AS VAUSD2_user_date_2_JDT,
	"VAUSD3" AS VAUSD3_user_date_3_JDT,
	"VAUDC1" AS VAUDC1_user_defined_code__1,
	"VAUDC2" AS VAUDC2_user_defined_code__2,
	"VAUDC3" AS VAUDC3_user_defined_code__3,
	"VA$AM1" AS VA$AM1_user_amount_future_1,
	"VA$AM2" AS VA$AM2_user_amount_future_2,
	"VA$AM3" AS VA$AM3_user_amount_future_3,
	"VAUSER" AS VAUSER_user_id,
	"VAJOBN" AS VAJOBN_work_station_id,
	"VAPID" AS VAPID__program_id,
	"VAUPMJ" AS VAUPMJ_date_updated,
	"VATDAY" AS VATDAY_time_of_day 

INTO 
	STAGE_JDE_ARCPDTA71Q_F5830_chargeback_header

FROM 
    OPENQUERY (ESYS_QA, '

	SELECT
		VA$CN2,
		VAKCOO,
		VA$EON,
		VADESC,
		VA$FD AS VA$FD,
		VA$TD AS VA$TD,
		VAEFTB AS VAEFTB,
		VA$DCA AS VA$DCA,
		VAODDJ AS VAODDJ,
		VADGCG AS VADGCG,
		VACNDJ AS VACNDJ,
		VAEXDJ AS VAEXDJ,
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
		VACRDJ AS VACRDJ,
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
		VAURDT AS VAURDT,
		VAURAB,
		VAURRF,
		VA$RV1,
		VA$RV2,
		VA$RV3,
		VA$RV4,
		VA$RV5,
		VAURC1,
		VAURC2,
		VAUSD1 AS VAUSD1,
		VAUSD2 AS VAUSD2,
		VAUSD3 AS VAUSD3,
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
    WHERE
		VA$FD <= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) AND 		
		VA$TD >= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3))  		
--    ORDER BY
--        <insert custom code here>
')
