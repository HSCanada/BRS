SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE pricing.etl_post_proc
	@bDebug as smallint = 1
AS

/******************************************************************************
**	File: 
**	Name: pricing.etl_post_proc
**	Desc: update pricing tables after ETL pull from JDE 
**
**              
**	Return values:  @@Error
**
**	Called by:   pricing job
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**	
**
**	Auth: tmc
**	Date: 14 Feb 20
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	31 Aug 20	tmc		Fix bug where supplier too big -- Left 6 it to fit
*******************************************************************************/

Declare @nErrorCode int, @nTranCount int
Declare @sMessage varchar(255)

Set @nErrorCode = @@Error
Set @nTranCount = @@Trancount

SET NOCOUNT ON;
if (@bDebug <> 0)
	SET NOCOUNT OFF;

if (@bDebug <> 0) 
Begin
	Print '---------------------------------------------------------'
	Print 'Proc: pricing.etl_post_proc'
	Print 'Desc: copy pricing from stage to prod'
	Print 'Mode: DEBUG'
	Print '---------------------------------------------------------'
End

------------------------------------------------------------------------------------------------------------
-- Init routines.  
------------------------------------------------------------------------------------------------------------

-- Start transaction
if (@nTranCount = 0)
	Begin Tran mytran
Else
	Save Tran mytran

------------------------------------------------------------------------------------------------------------
-- Update routines.  
------------------------------------------------------------------------------------------------------------

-- print 'Pricing update (RI sensitive order), 13 Jan 18, 60s'

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '1. clear stage tables'

		truncate table [Pricing].[item_customer_keyid_master_file_F4094]
		truncate table [Pricing].[price_marketing_program_enroll_F40308]
		truncate table [Pricing].[price_adjustment_schedule_F4070]
		truncate table [Pricing].[supplier_catalog_price_file_F41061]
		truncate table [Pricing].[price_adjustment_enroll]
		truncate table [Pricing].[price_adjustment_enroll_F40314]
		truncate table [Pricing].[item_extension_file_F5613]
		truncate table [Pricing].[price_adjustment_detail_F4072]
		truncate table [Pricing].[free_goods_master_file_F4073]

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '2. update Pricing.item_master_F4101'

		UPDATE
			Pricing.item_master_F4101
		SET
			IMLITM_item_number  = s.IMLITM_item_number ,
			IMAITM__3rd_item_number  = s.IMAITM__3rd_item_number ,
			IMDSC1_description  = s.IMDSC1_description ,
			IMSRTX_search_text  = s.IMSRTX_search_text ,
			IMALN__search_text_compressed  = s.IMALN__search_text_compressed ,
			IMSRP1_major_product_class  = s.IMSRP1_major_product_class ,
			IMSRP2_sub_major_product_class  = s.IMSRP2_sub_major_product_class ,
			IMSRP3_minor_product_class  = s.IMSRP3_minor_product_class ,
			IMSRP4_sub_minor_product_class  = s.IMSRP4_sub_minor_product_class ,
			IMSRP5_hazardous_class  = s.IMSRP5_hazardous_class ,
			IMSRP6_manufacturer  = s.IMSRP6_manufacturer ,
			IMSRP7_drug_class  = s.IMSRP7_drug_class ,
			IMSRP8_manuf_dspsearch  = s.IMSRP8_manuf_dspsearch ,
			IMSRP9_category_code_9  = s.IMSRP9_category_code_9 ,
			IMSRP0_category_code_10  = s.IMSRP0_category_code_10 ,
			IMPRP1_commodity_class  = s.IMPRP1_commodity_class ,
			IMPRP2_commodity_sub_class  = s.IMPRP2_commodity_sub_class ,
			IMPRP3_supplier_rebate_code  = s.IMPRP3_supplier_rebate_code ,
			IMPRP4_tax_classification  = s.IMPRP4_tax_classification ,
			IMPRP5_landed_cost_rule  = s.IMPRP5_landed_cost_rule ,
			IMPRP6_item_dimension_group  = s.IMPRP6_item_dimension_group ,
			IMPRP7_warehouse_process_grp_1  = s.IMPRP7_warehouse_process_grp_1 ,
			IMPRP8_warehouse_process_grp_2  = s.IMPRP8_warehouse_process_grp_2 ,
			IMPRP9_warehouse_process_grp_3  = s.IMPRP9_warehouse_process_grp_3 ,
			IMPRP0_commodity_code  = s.IMPRP0_commodity_code ,
			IMCDCD_commodity_code  = s.IMCDCD_commodity_code ,
			IMPDGR_product_group  = s.IMPDGR_product_group ,
			IMDSGP_dispatch_group  = s.IMDSGP_dispatch_group ,
			IMPRGR_item_price_group  = s.IMPRGR_item_price_group ,
			IMRPRC_basket_reprice_group  = s.IMRPRC_basket_reprice_group ,
			IMORPR_order_reprice_group  = s.IMORPR_order_reprice_group ,
			IMBUYR_buyer_number  = s.IMBUYR_buyer_number ,
			IMDRAW_drawing_number  = s.IMDRAW_drawing_number ,
			IMRVNO_last_revision_no  = s.IMRVNO_last_revision_no ,
			IMDSZE_drawing_size  = s.IMDSZE_drawing_size ,
			IMVCUD_volume_cubic_dimensions  = s.IMVCUD_volume_cubic_dimensions ,
			IMCARS_carrier_number  = s.IMCARS_carrier_number ,
			IMCARP_preferred_carrier_purchasing  = s.IMCARP_preferred_carrier_purchasing ,
			IMSHCN_shipping_conditions_code  = s.IMSHCN_shipping_conditions_code ,
			IMSHCM_shipping_commodity_class  = s.IMSHCM_shipping_commodity_class ,
			IMUOM1_unit_of_measure  = s.IMUOM1_unit_of_measure ,
			IMUOM2_secondary_uom  = s.IMUOM2_secondary_uom ,
			IMUOM3_purchasing_uom  = s.IMUOM3_purchasing_uom ,
			IMUOM4_pricing_uom  = s.IMUOM4_pricing_uom ,
			IMUOM6_shipping_uom  = s.IMUOM6_shipping_uom ,
			IMUOM8_production_uom  = s.IMUOM8_production_uom ,
			IMUOM9_component_uom  = s.IMUOM9_component_uom ,
			IMUWUM_unit_of_measure_weight  = s.IMUWUM_unit_of_measure_weight ,
			IMUVM1_unit_of_measure_volume  = s.IMUVM1_unit_of_measure_volume ,
			IMSUTM_stocking_um  = s.IMSUTM_stocking_um ,
			IMUMVW_psauvolume_or_weight  = s.IMUMVW_psauvolume_or_weight ,
			IMCYCL_cycle_count_category  = s.IMCYCL_cycle_count_category ,
			IMGLPT_gl_category  = s.IMGLPT_gl_category ,
			IMPLEV_sales_price_level  = s.IMPLEV_sales_price_level ,
			IMPPLV_purchase_price_level  = s.IMPPLV_purchase_price_level ,
			IMCLEV_inventory_cost_level  = s.IMCLEV_inventory_cost_level ,
			IMPRPO_gradepotency_pricing  = s.IMPRPO_gradepotency_pricing ,
			IMCKAV_check_availability_yn  = s.IMCKAV_check_availability_yn ,
			IMBPFG_bulkpacked_flag  = s.IMBPFG_bulkpacked_flag ,
			IMSRCE_layer_code_source  = s.IMSRCE_layer_code_source ,
			IMOT1Y_potency_control  = s.IMOT1Y_potency_control ,
			IMOT2Y_grade_control  = s.IMOT2Y_grade_control ,
			IMSTDP_standard_potency  = s.IMSTDP_standard_potency ,
			IMFRMP_from_potency  = s.IMFRMP_from_potency ,
			IMTHRP_thru_potency  = s.IMTHRP_thru_potency ,
			IMSTDG_standard_grade  = s.IMSTDG_standard_grade ,
			IMFRGD_from_grade  = s.IMFRGD_from_grade ,
			IMTHGD_thru_grade  = s.IMTHGD_thru_grade ,
			IMCOTY_component_type  = s.IMCOTY_component_type ,
			IMSTKT_stocking_type  = s.IMSTKT_stocking_type ,
			IMLNTY_line_type  = s.IMLNTY_line_type ,
			IMCONT_contract_item  = s.IMCONT_contract_item ,
			IMBACK_backorders_allowed_yn  = s.IMBACK_backorders_allowed_yn ,
			IMIFLA_item_flash_message  = s.IMIFLA_item_flash_message ,
			IMTFLA_std_uom_conversion  = s.IMTFLA_std_uom_conversion ,
			IMINMG_print_message  = s.IMINMG_print_message ,
			IMABCS_abc_code_1_sales  = s.IMABCS_abc_code_1_sales ,
			IMABCM_abc_code_2_margin  = s.IMABCM_abc_code_2_margin ,
			IMABCI_abc_code_3_investment  = s.IMABCI_abc_code_3_investment ,
			IMOVR__abc_code_override_indicator  = s.IMOVR__abc_code_override_indicator ,
			IMWARR_warranty_item_group  = s.IMWARR_warranty_item_group ,
			IMCMCG_commission_category  = s.IMCMCG_commission_category ,
			IMSRNR_serial_no_required  = s.IMSRNR_serial_no_required ,
			IMPMTH_kit_pricing_method  = s.IMPMTH_kit_pricing_method ,
			IMFIFO_fifo_processing  = s.IMFIFO_fifo_processing ,
			IMLOTS_lot_status_code  = s.IMLOTS_lot_status_code ,
			IMSLD__shelf_life_days  = s.IMSLD__shelf_life_days ,
			IMANPL_planner_number  = s.IMANPL_planner_number ,
			IMMPST_planning_code  = s.IMMPST_planning_code ,
			IMPCTM_percent_margin  = s.IMPCTM_percent_margin ,
			IMMMPC_margin_maintenance_pct  = s.IMMMPC_margin_maintenance_pct ,
			IMPTSC_part_status_code  = s.IMPTSC_part_status_code ,
			IMSNS__round_to_whole_number  = s.IMSNS__round_to_whole_number ,
			IMLTLV_leadtime_level  = s.IMLTLV_leadtime_level ,
			IMLTMF_leadtime_manufacturing  = s.IMLTMF_leadtime_manufacturing ,
			IMLTCM_leadtime_cumulative  = s.IMLTCM_leadtime_cumulative ,
			IMOPC__order_policy_code  = s.IMOPC__order_policy_code ,
			IMOPV__value_order_policy  = s.IMOPV__value_order_policy ,
			IMACQ__accounting_cost_quantity  = s.IMACQ__accounting_cost_quantity ,
			IMMLQ__mfg_leadtime_quantity  = s.IMMLQ__mfg_leadtime_quantity ,
			IMLTPU_leadtime_per_unit  = s.IMLTPU_leadtime_per_unit ,
			IMMPSP_planning_fence_rule  = s.IMMPSP_planning_fence_rule ,
			IMMRPP_fixedvariable_leadtime  = s.IMMRPP_fixedvariable_leadtime ,
			IMITC__issue_type_code  = s.IMITC__issue_type_code ,
			IMORDW_order_with_yn  = s.IMORDW_order_with_yn ,
			IMMTF1_planning_fence  = s.IMMTF1_planning_fence ,
			IMMTF2_freeze_fence  = s.IMMTF2_freeze_fence ,
			IMMTF3_message_display_fence  = s.IMMTF3_message_display_fence ,
			IMMTF4_time_fence  = s.IMMTF4_time_fence ,
			IMMTF5_shipment_leadtime_offset  = s.IMMTF5_shipment_leadtime_offset ,
			IMMTF6_supply_time_fence  = s.IMMTF6_supply_time_fence ,
			IMEXPD_expedite_damper_days  = s.IMEXPD_expedite_damper_days ,
			IMDEFD_defer_damper_days  = s.IMDEFD_defer_damper_days ,
			IMSFLT_safety_leadtime  = s.IMSFLT_safety_leadtime ,
			IMMAKE_makebuy_code  = s.IMMAKE_makebuy_code ,
			IMCOBY_cobyproductintermediate  = s.IMCOBY_cobyproductintermediate ,
			IMLLX__low_level_code  = s.IMLLX__low_level_code ,
			IMCMGL_commitment_method  = s.IMCMGL_commitment_method ,
			IMCOMH_specific_commitment_days  = s.IMCOMH_specific_commitment_days ,
			IMCSNN_configured_string_id_next_number  = s.IMCSNN_configured_string_id_next_number ,
			IMURCD_user_reserved_code  = s.IMURCD_user_reserved_code ,
			IMURDT_user_reserved_date  = s.IMURDT_user_reserved_date ,
			IMURAT_user_reserved_amount  = s.IMURAT_user_reserved_amount ,
			IMURAB_user_reserved_number  = s.IMURAB_user_reserved_number ,
			IMURRF_user_reserved_reference  = s.IMURRF_user_reserved_reference ,
			IMAVRT_average_queue_hours  = s.IMAVRT_average_queue_hours ,
			IMUPCN_upc_number  = s.IMUPCN_upc_number ,
			IMSCC0_aggregate_scc_code_pi0  = s.IMSCC0_aggregate_scc_code_pi0 ,
			IMUMUP_unit_of_measure_upc  = s.IMUMUP_unit_of_measure_upc ,
			IMUMDF_unit_of_measure_aggregate_upc  = s.IMUMDF_unit_of_measure_aggregate_upc ,
			IMUMS0_unit_of_measure_sccpi0  = s.IMUMS0_unit_of_measure_sccpi0 ,
			IMUMS1_unit_of_measure_sccpi1  = s.IMUMS1_unit_of_measure_sccpi1 ,
			IMUMS2_unit_of_measure_sccpi2  = s.IMUMS2_unit_of_measure_sccpi2 ,
			IMUMS3_unit_of_measure_sccpi3  = s.IMUMS3_unit_of_measure_sccpi3 ,
			IMUMS4_unit_of_measure_sccpi4  = s.IMUMS4_unit_of_measure_sccpi4 ,
			IMUMS5_unit_of_measure_sccpi5  = s.IMUMS5_unit_of_measure_sccpi5 ,
			IMUMS6_unit_of_measure_sccpi6  = s.IMUMS6_unit_of_measure_sccpi6 ,
			IMUMS7_unit_of_measure_sccpi7  = s.IMUMS7_unit_of_measure_sccpi7 ,
			IMUMS8_unit_of_measure_sccpi8  = s.IMUMS8_unit_of_measure_sccpi8 ,
			IMPILT_purchasing_internal_lead_time  = s.IMPILT_purchasing_internal_lead_time ,
			IMWTRQ_item_weight_required_yn  = s.IMWTRQ_item_weight_required_yn ,
			IMPOC__i  = s.IMPOC__i ,
			IMEXPI_explode_item_10  = s.IMEXPI_explode_item_10 ,
			IMCONI_constraint_item_10  = s.IMCONI_constraint_item_10 ,
			IMORSP_allow_order_split_10  = s.IMORSP_allow_order_split_10 ,
			IMCNSD_consolidation_days  = s.IMCNSD_consolidation_days ,
			IMCMDM_commitment_date_method  = s.IMCMDM_commitment_date_method ,
			IMLECM_exp_date_calc_method  = s.IMLECM_exp_date_calc_method ,
			IMBBDD_best_before_default_days  = s.IMBBDD_best_before_default_days ,
			IMSBDD_sell_by_default_days  = s.IMSBDD_sell_by_default_days ,
			IMLEDD_mfg_lot_effective_days  = s.IMLEDD_mfg_lot_effective_days ,
			IMPEFD_purchasing_lot_effective_days  = s.IMPEFD_purchasing_lot_effective_days ,
			IMU1DD_user_lot_date_1_default_days  = s.IMU1DD_user_lot_date_1_default_days ,
			IMU2DD_user_lot_date_2_default_days  = s.IMU2DD_user_lot_date_2_default_days ,
			IMU3DD_user_lot_date_3_default_days  = s.IMU3DD_user_lot_date_3_default_days ,
			IMU4DD_user_lot_date_4_default_days  = s.IMU4DD_user_lot_date_4_default_days ,
			IMU5DD_user_lot_date_5_default_days  = s.IMU5DD_user_lot_date_5_default_days ,
			IMTORG_transaction_originator  = s.IMTORG_transaction_originator ,
			IMUSER_user_id  = s.IMUSER_user_id ,
			IMPID__program_id  = s.IMPID__program_id ,
			IMJOBN_work_station_id  = s.IMJOBN_work_station_id ,
			IMUPMJ_date_updated  = s.IMUPMJ_date_updated ,
			IMTDAY_time_of_day  = s.IMTDAY_time_of_day ,
			IMDSC2_description_2 = s.IMDSC2_description_2
		FROM
			Integration.F4101_item_master_Staging AS s 
			INNER JOIN Pricing.item_master_F4101 
			ON s.IMITM__item_number_short = Pricing.item_master_F4101.IMITM__item_number_short
		WHERE
			EXISTS
			(
				Select *
				FROM 
					(SELECT IMITM__item_number_short, CHECKSUM(*) csd FROM [Pricing].[item_master_F4101]) AS dd
					INNER JOIN (SELECT IMITM__item_number_short, CHECKSUM(*) css FROM Integration.F4101_item_master_Staging) AS ss
					ON dd.IMITM__item_number_short = ss.IMITM__item_number_short AND
						css<>csd AND
						s.IMITM__item_number_short = ss.IMITM__item_number_short
			)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '3. add new [Pricing].[item_master_F4101]'

		INSERT INTO Pricing.item_master_F4101
		(
			IMITM__item_number_short,
			IMLITM_item_number,
			IMAITM__3rd_item_number,
			IMDSC1_description,
			IMDSC2_description_2,
			IMSRTX_search_text,
			IMALN__search_text_compressed,
			IMSRP1_major_product_class,
			IMSRP2_sub_major_product_class,
			IMSRP3_minor_product_class,
			IMSRP4_sub_minor_product_class,
			IMSRP5_hazardous_class,
			IMSRP6_manufacturer,
			IMSRP7_drug_class,
			IMSRP8_manuf_dspsearch,
			IMSRP9_category_code_9,
			IMSRP0_category_code_10,
			IMPRP1_commodity_class,
			IMPRP2_commodity_sub_class,
			IMPRP3_supplier_rebate_code,
			IMPRP4_tax_classification,
			IMPRP5_landed_cost_rule,
			IMPRP6_item_dimension_group,
			IMPRP7_warehouse_process_grp_1,
			IMPRP8_warehouse_process_grp_2,
			IMPRP9_warehouse_process_grp_3,
			IMPRP0_commodity_code,
			IMCDCD_commodity_code,
			IMPDGR_product_group,
			IMDSGP_dispatch_group,
			IMPRGR_item_price_group,
			IMRPRC_basket_reprice_group,
			IMORPR_order_reprice_group,
			IMBUYR_buyer_number,
			IMDRAW_drawing_number,
			IMRVNO_last_revision_no,
			IMDSZE_drawing_size,
			IMVCUD_volume_cubic_dimensions,
			IMCARS_carrier_number,
			IMCARP_preferred_carrier_purchasing,
 			IMSHCN_shipping_conditions_code,
			IMSHCM_shipping_commodity_class,
			IMUOM1_unit_of_measure,
			IMUOM2_secondary_uom,
			IMUOM3_purchasing_uom,
 			IMUOM4_pricing_uom,
			IMUOM6_shipping_uom,
			IMUOM8_production_uom,
			IMUOM9_component_uom,
			IMUWUM_unit_of_measure_weight,
 			IMUVM1_unit_of_measure_volume,
			IMSUTM_stocking_um,
			IMUMVW_psauvolume_or_weight,
			IMCYCL_cycle_count_category,
			IMGLPT_gl_category,
 			IMPLEV_sales_price_level,
			IMPPLV_purchase_price_level,
			IMCLEV_inventory_cost_level,
			IMPRPO_gradepotency_pricing,
			IMCKAV_check_availability_yn,
 			IMBPFG_bulkpacked_flag,
			IMSRCE_layer_code_source,
			IMOT1Y_potency_control,
			IMOT2Y_grade_control,
			IMSTDP_standard_potency,
			IMFRMP_from_potency,
 			IMTHRP_thru_potency,
			IMSTDG_standard_grade,
			IMFRGD_from_grade,
			IMTHGD_thru_grade,
			IMCOTY_component_type,
			IMSTKT_stocking_type,
			IMLNTY_line_type,
 			IMCONT_contract_item,
			IMBACK_backorders_allowed_yn,
			IMIFLA_item_flash_message,
			IMTFLA_std_uom_conversion,
			IMINMG_print_message,
 			IMABCS_abc_code_1_sales,
			IMABCM_abc_code_2_margin,
			IMABCI_abc_code_3_investment,
			IMOVR__abc_code_override_indicator,
 			IMWARR_warranty_item_group,
			IMCMCG_commission_category,
			IMSRNR_serial_no_required,
			IMPMTH_kit_pricing_method,
			IMFIFO_fifo_processing,
 			IMLOTS_lot_status_code,
			IMSLD__shelf_life_days,
			IMANPL_planner_number,
			IMMPST_planning_code,
			IMPCTM_percent_margin,
 			IMMMPC_margin_maintenance_pct,
			IMPTSC_part_status_code,
			IMSNS__round_to_whole_number,
			IMLTLV_leadtime_level,
			IMLTMF_leadtime_manufacturing,
 			IMLTCM_leadtime_cumulative,
			IMOPC__order_policy_code,
			IMOPV__value_order_policy,
			IMACQ__accounting_cost_quantity,
			IMMLQ__mfg_leadtime_quantity,
 			IMLTPU_leadtime_per_unit,
			IMMPSP_planning_fence_rule,
			IMMRPP_fixedvariable_leadtime,
			IMITC__issue_type_code,
			IMORDW_order_with_yn,
 			IMMTF1_planning_fence,
			IMMTF2_freeze_fence,
			IMMTF3_message_display_fence,
			IMMTF4_time_fence,
			IMMTF5_shipment_leadtime_offset,
 			IMMTF6_supply_time_fence,
			IMEXPD_expedite_damper_days,
			IMDEFD_defer_damper_days,
			IMSFLT_safety_leadtime,
			IMMAKE_makebuy_code,
 			IMCOBY_cobyproductintermediate,
			IMLLX__low_level_code,
			IMCMGL_commitment_method,
			IMCOMH_specific_commitment_days,
 			IMCSNN_configured_string_id_next_number,
			IMURCD_user_reserved_code,
			IMURDT_user_reserved_date,
			IMURAT_user_reserved_amount,
 			IMURAB_user_reserved_number,
			IMURRF_user_reserved_reference,
			IMAVRT_average_queue_hours,
			IMUPCN_upc_number,
			IMSCC0_aggregate_scc_code_pi0,
 			IMUMUP_unit_of_measure_upc,
			IMUMDF_unit_of_measure_aggregate_upc,
			IMUMS0_unit_of_measure_sccpi0,
			IMUMS1_unit_of_measure_sccpi1,
			IMUMS2_unit_of_measure_sccpi2,
			IMUMS3_unit_of_measure_sccpi3,
			IMUMS4_unit_of_measure_sccpi4,
			IMUMS5_unit_of_measure_sccpi5,
			IMUMS6_unit_of_measure_sccpi6,
			IMUMS7_unit_of_measure_sccpi7,
			IMUMS8_unit_of_measure_sccpi8,
			IMPILT_purchasing_internal_lead_time,
			IMWTRQ_item_weight_required_yn,
			IMPOC__i,
			IMEXPI_explode_item_10,
			IMCONI_constraint_item_10,
			IMORSP_allow_order_split_10,
			IMCNSD_consolidation_days,
			IMCMDM_commitment_date_method,
			IMLECM_exp_date_calc_method,
			IMBBDD_best_before_default_days,
			IMSBDD_sell_by_default_days,
			IMLEDD_mfg_lot_effective_days,
			IMPEFD_purchasing_lot_effective_days,
			IMU1DD_user_lot_date_1_default_days,
			IMU2DD_user_lot_date_2_default_days,
			IMU3DD_user_lot_date_3_default_days,
			IMU4DD_user_lot_date_4_default_days,
			IMU5DD_user_lot_date_5_default_days,
			IMTORG_transaction_originator,
			IMUSER_user_id,
			IMPID__program_id,
			IMJOBN_work_station_id,
			IMUPMJ_date_updated,
			IMTDAY_time_of_day
		)
		SELECT        
			IMITM__item_number_short,
			LEFT(IMLITM_item_number,10),
			IMAITM__3rd_item_number,
			IMDSC1_description,
			IMDSC2_description_2,
			IMSRTX_search_text,
			IMALN__search_text_compressed,
			IMSRP1_major_product_class,
			IMSRP2_sub_major_product_class,
			IMSRP3_minor_product_class,
			IMSRP4_sub_minor_product_class,
			IMSRP5_hazardous_class,
			IMSRP6_manufacturer,
			IMSRP7_drug_class,
			IMSRP8_manuf_dspsearch,
			IMSRP9_category_code_9,
			IMSRP0_category_code_10,
			IMPRP1_commodity_class,
			IMPRP2_commodity_sub_class,
			IMPRP3_supplier_rebate_code,
			IMPRP4_tax_classification,
			IMPRP5_landed_cost_rule,
			IMPRP6_item_dimension_group,
			IMPRP7_warehouse_process_grp_1,
			IMPRP8_warehouse_process_grp_2,
			IMPRP9_warehouse_process_grp_3,
			IMPRP0_commodity_code,
			IMCDCD_commodity_code,
			IMPDGR_product_group,
			IMDSGP_dispatch_group,
			IMPRGR_item_price_group,
			IMRPRC_basket_reprice_group,
			IMORPR_order_reprice_group,
			IMBUYR_buyer_number,
			IMDRAW_drawing_number,
			IMRVNO_last_revision_no,
			IMDSZE_drawing_size,
			IMVCUD_volume_cubic_dimensions,
			IMCARS_carrier_number,
			IMCARP_preferred_carrier_purchasing,
			IMSHCN_shipping_conditions_code,
			IMSHCM_shipping_commodity_class,
			IMUOM1_unit_of_measure,
			IMUOM2_secondary_uom,
			IMUOM3_purchasing_uom,
			IMUOM4_pricing_uom,
			IMUOM6_shipping_uom,
			IMUOM8_production_uom,
			IMUOM9_component_uom,
			IMUWUM_unit_of_measure_weight,
			IMUVM1_unit_of_measure_volume,
			IMSUTM_stocking_um,
			IMUMVW_psauvolume_or_weight,
			IMCYCL_cycle_count_category,
			IMGLPT_gl_category,
			IMPLEV_sales_price_level,
			IMPPLV_purchase_price_level,
			IMCLEV_inventory_cost_level,
			IMPRPO_gradepotency_pricing,
			IMCKAV_check_availability_yn,
			IMBPFG_bulkpacked_flag,
			IMSRCE_layer_code_source,
			IMOT1Y_potency_control,
			IMOT2Y_grade_control,
			IMSTDP_standard_potency,
			IMFRMP_from_potency,
			IMTHRP_thru_potency,
			IMSTDG_standard_grade,
			IMFRGD_from_grade,
			IMTHGD_thru_grade,
			IMCOTY_component_type,
			IMSTKT_stocking_type,
			IMLNTY_line_type,
			IMCONT_contract_item,
			IMBACK_backorders_allowed_yn,
			IMIFLA_item_flash_message,
			IMTFLA_std_uom_conversion,
			IMINMG_print_message,
			IMABCS_abc_code_1_sales,
			IMABCM_abc_code_2_margin,
			IMABCI_abc_code_3_investment,
			IMOVR__abc_code_override_indicator,
			IMWARR_warranty_item_group,
			IMCMCG_commission_category,
			IMSRNR_serial_no_required,
			IMPMTH_kit_pricing_method,
			IMFIFO_fifo_processing,
			IMLOTS_lot_status_code,
			IMSLD__shelf_life_days,
			IMANPL_planner_number,
			IMMPST_planning_code,
			IMPCTM_percent_margin,
			IMMMPC_margin_maintenance_pct,
			IMPTSC_part_status_code,
			IMSNS__round_to_whole_number,
			IMLTLV_leadtime_level,
			IMLTMF_leadtime_manufacturing,
			IMLTCM_leadtime_cumulative,
			IMOPC__order_policy_code,
			IMOPV__value_order_policy,
			IMACQ__accounting_cost_quantity,
			IMMLQ__mfg_leadtime_quantity,
			IMLTPU_leadtime_per_unit,
			IMMPSP_planning_fence_rule,
			IMMRPP_fixedvariable_leadtime,
			IMITC__issue_type_code,
			IMORDW_order_with_yn,
			IMMTF1_planning_fence,
			IMMTF2_freeze_fence,
			IMMTF3_message_display_fence,
			IMMTF4_time_fence,
			IMMTF5_shipment_leadtime_offset,
			IMMTF6_supply_time_fence,
			IMEXPD_expedite_damper_days,
			IMDEFD_defer_damper_days,
			IMSFLT_safety_leadtime,
			IMMAKE_makebuy_code,
			IMCOBY_cobyproductintermediate,
			IMLLX__low_level_code,
			IMCMGL_commitment_method,
			IMCOMH_specific_commitment_days,
			IMCSNN_configured_string_id_next_number,
			IMURCD_user_reserved_code,
			IMURDT_user_reserved_date,
			IMURAT_user_reserved_amount,
			IMURAB_user_reserved_number,
			IMURRF_user_reserved_reference,
			IMAVRT_average_queue_hours,
			IMUPCN_upc_number,
			IMSCC0_aggregate_scc_code_pi0,
			IMUMUP_unit_of_measure_upc,
			IMUMDF_unit_of_measure_aggregate_upc,
			IMUMS0_unit_of_measure_sccpi0,
			IMUMS1_unit_of_measure_sccpi1,
			IMUMS2_unit_of_measure_sccpi2,
			IMUMS3_unit_of_measure_sccpi3,
			IMUMS4_unit_of_measure_sccpi4,
			IMUMS5_unit_of_measure_sccpi5,
			IMUMS6_unit_of_measure_sccpi6,
			IMUMS7_unit_of_measure_sccpi7,
			IMUMS8_unit_of_measure_sccpi8,
			IMPILT_purchasing_internal_lead_time,
			IMWTRQ_item_weight_required_yn,
			IMPOC__i,
			IMEXPI_explode_item_10,
			IMCONI_constraint_item_10,
			IMORSP_allow_order_split_10,
			IMCNSD_consolidation_days,
			IMCMDM_commitment_date_method,
			IMLECM_exp_date_calc_method,
			IMBBDD_best_before_default_days,
			IMSBDD_sell_by_default_days,
			IMLEDD_mfg_lot_effective_days,
			IMPEFD_purchasing_lot_effective_days,
			IMU1DD_user_lot_date_1_default_days,
			IMU2DD_user_lot_date_2_default_days,
			IMU3DD_user_lot_date_3_default_days,
			IMU4DD_user_lot_date_4_default_days,
			IMU5DD_user_lot_date_5_default_days,
			IMTORG_transaction_originator,
			IMUSER_user_id,
			IMPID__program_id,
			IMJOBN_work_station_id,
			IMUPMJ_date_updated,
			IMTDAY_time_of_day
		FROM            
			Integration.F4101_item_master_Staging AS s
		WHERE
			NOT EXISTS 
			(
				SELECT * FROM Pricing.item_master_F4101 d 
				WHERE s.IMITM__item_number_short = d.IMITM__item_number_short
			)

		Set @nErrorCode = @@Error
	End

	-- not merge updating this table as it is slowly changing
	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '4. add new [Pricing].[price_adjustment_name_F4071]'

		INSERT INTO Pricing.price_adjustment_name_F4071
		(
			ATAST__adjustment_name,
			ATPRGR_item_price_group,
			ATCPGP_customer_price_group,
			ATSDGR_order_detail_group,
			ATPRFR_preference_type,
			ATLBT__level_break_type,
			ATGLC__gl_offset,
			ATSBIF_subledger_in_gl,
			ATACNT_adjustment_control_code,
			ATLNTY_line_type,
			ATMDED_manual_addchange_yn,
			ATABAS_override_price_yn,
			ATOLVL_adjustment_level,
			ATTXB__taxable_yn,
			ATPA01_rebate_beneficiary,
			ATPA02_mandatory_adjustment,
			ATPA03_exclude_from_payment_discount,
			ATPA04_target_application,
			ATPA05_include_in_margin_calc,
			ATPA06_final_price,
			ATPA07_processing_type_free_good,
			ATPA08_price_adjustment_code_08,
			ATPA09_price_adjustment_code_09,
			ATPA10_price_adjustment_code_10,
			ATEFCN_excl_from_curr_net,
			ATPTC__payment_terms,
			ATURCD_user_reserved_code,
			ATURDT_user_reserved_date_JDT,
			ATURAT_user_reserved_amount,
			ATURAB_user_reserved_number,
			ATURRF_user_reserved_reference,
			ATUSER_user_id,
			ATPID__program_id,
			ATJOBN_work_station_id,
			ATUPMJ_date_updated,
			ATTDAY_time_of_day
		)
		SELECT
			ATAST__adjustment_name,
			ATPRGR_item_price_group,
			ATCPGP_customer_price_group,
			ATSDGR_order_detail_group,
			ATPRFR_preference_type,
			ATLBT__level_break_type,
			ATGLC__gl_offset,
			ATSBIF_subledger_in_gl,
			ATACNT_adjustment_control_code,
			ATLNTY_line_type,
			ATMDED_manual_addchange_yn,
			ATABAS_override_price_yn,
			ATOLVL_adjustment_level,
			ATTXB__taxable_yn,
			ATPA01_rebate_beneficiary,
			ATPA02_mandatory_adjustment,
			ATPA03_exclude_from_payment_discount,
			ATPA04_target_application,
			ATPA05_include_in_margin_calc,
			ATPA06_final_price,
			ATPA07_processing_type_free_good,
			ATPA08_price_adjustment_code_08,
			ATPA09_price_adjustment_code_09,
			ATPA10_price_adjustment_code_10,
			ATEFCN_excl_from_curr_net,
			ATPTC__payment_terms,
			ATURCD_user_reserved_code,
			ATURDT_user_reserved_date_JDT,
			ATURAT_user_reserved_amount,
			ATURAB_user_reserved_number,
			ATURRF_user_reserved_reference,
			ATUSER_user_id,
			ATPID__program_id,
			ATJOBN_work_station_id,
			ATUPMJ_date_updated,
			ATTDAY_time_of_day
		FROM
			Integration.F4071_price_adjustment_name_Staging as s
		WHERE
			NOT EXISTS 
			(
				SELECT * FROM Pricing.price_adjustment_name_F4071 d 
				WHERE s.[ATAST__adjustment_name] = d.[ATAST__adjustment_name]
			)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '5. add all [Pricing].[free_goods_master_file_F4073]'

		INSERT INTO Pricing.free_goods_master_file_F4073
		(
			FGAST__adjustment_name,
			FGATID_price_adjustment_key_id,
			FGITMR_related_short_item_number,
			FGLITM_item_number,
			FGAITM__3rd_item_number,
			FGUORG_quantity,
			FGUOM__um,
			FGRPRI_related_price,
			FGUNCS_unit_cost,
			FGGLC__gl_offset,
			FGLNTY_line_type,
			FGFQTY_quantity_per,
			FGFGTY_free_good_type,
			FGFP01_free_good_process_code_01,
			FGFP02_free_good_process_code_02,
			FGFP03_free_good_process_code_03,
			FGUSER_user_id,
			FGPID__program_id,
			FGJOBN_work_station_id,FGUPMJ_date_updated,
			FGTDAY_time_of_day
		)
		SELECT
			FGAST__adjustment_name,
			FGATID_price_adjustment_key_id,
			FGITMR_related_short_item_number,
			LEFT(FGLITM_item_number,10),
			FGAITM__3rd_item_number,
			FGUORG_quantity,
			FGUOM__um,
			FGRPRI_related_price,
			FGUNCS_unit_cost,
			FGGLC__gl_offset,
			FGLNTY_line_type,
			FGFQTY_quantity_per,
			FGFGTY_free_good_type,
			FGFP01_free_good_process_code_01,
			FGFP02_free_good_process_code_02,
			FGFP03_free_good_process_code_03,
			FGUSER_user_id,
			FGPID__program_id,
			FGJOBN_work_station_id,
			DATEADD (day,FGUPMJ_date_updated_JDT%1000-1,
				DATEADD(year,FGUPMJ_date_updated_JDT/1000,0 ) ) AS FGUPMJ_date_updated,
			FGTDAY_time_of_day
	
		FROM
			Integration.F4073_free_goods_master_file_Staging s
		WHERE 
			EXISTS 
			(
				SELECT		
					MAX(s2.ID) AS id_unique
				FROM        
					Integration.F4073_free_goods_master_file_Staging s2
				GROUP BY	
					FGAST__adjustment_name, 
					FGATID_price_adjustment_key_id, 
					FGLITM_item_number
				HAVING 
					s.[ID] = MAX(s2.ID)
			) AND
		--	FGAST__adjustment_name = 'PRORDFG' AND FGATID_price_adjustment_key_id = 0 AND FGLITM_item_number = '5877802' AND 
			1=1

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '6. add all [Pricing].[price_adjustment_detail_F4072]'

		-- do not load bad shipto enrolled (fix at source)
		INSERT INTO Pricing.price_adjustment_detail_F4072
		(
			ADAST__adjustment_name,
			ADITM__item_number_short,
			ADLITM_item_number,
			ADAITM__3rd_item_number,
			ADAN8__billto,
			ADICID_itemcustomer_key_id,
			ADSDGR_order_detail_group,
			ADSDV1_sales_detail_value_01,
			ADSDV2_sales_detail_value_02,
			ADSDV3_sales_detail_value_03,
			ADCRCD_currency_code,
			ADUOM__um,
			ADMNQ__quantity_from,
			ADEFTJ_effective_date,
			ADEXDJ_expired_date,
			ADBSCD_basis,
			ADLEDG_cost_method,
			ADFRMN_formula_name,
			ADFCNM_function_name,
			ADFVTR_factor_value,
			ADFGY__free_goods_yn,
			ADATID_price_adjustment_key_id,
			ADURCD_user_reserved_code,
			ADURDT_user_reserved_date_JDT,
			ADURAT_user_reserved_amount,
			ADURAB_user_reserved_number,
			ADURRF_user_reserved_reference,
			ADASTN_adjustment_for_net_price,
			ADUSER_user_id,
			ADPID__program_id,
			ADJOBN_work_station_id,
			ADUPMJ_date_updated,
			ADTDAY_time_of_day,
			ADUPAJ_date_added,
			ADTENT_time_entered
		)
		SELECT
			ADAST__adjustment_name,
			ADITM__item_number_short,
			LEFT(ADLITM_item_number,10) AS item_number,
			ADAITM__3rd_item_number,
			ADAN8__billto,
			ADICID_itemcustomer_key_id,
			ADSDGR_order_detail_group,
			ADSDV1_sales_detail_value_01,
			ADSDV2_sales_detail_value_02,
			ADSDV3_sales_detail_value_03,
			ADCRCD_currency_code,
			ADUOM__um,
			ADMNQ__quantity_from,
			ADEFTJ_effective_date,
			ADEXDJ_expired_date,
			ADBSCD_basis,
			ADLEDG_cost_method,
			ADFRMN_formula_name,
			ADFCNM_function_name,
			ADFVTR_factor_value,
			ADFGY__free_goods_yn,
			ADATID_price_adjustment_key_id,
			ADURCD_user_reserved_code,
			ADURDT_user_reserved_date_JDT,
			ADURAT_user_reserved_amount,
			ADURAB_user_reserved_number,
			ADURRF_user_reserved_reference,
			ADASTN_adjustment_for_net_price,
			ADUSER_user_id,
			ADPID__program_id,
			ADJOBN_work_station_id,
			DATEADD (day,ADUPMJ_date_updated_JDT%1000-1,
				DATEADD(year,ADUPMJ_date_updated_JDT/1000,0 ) ) AS ADUPMJ_date_updated,
			ADTDAY_time_of_day,
			DATEADD (day,ADUPAJ_date_added_JDT%1000-1,
				DATEADD(year,ADUPAJ_date_added_JDT/1000,0 ) ) AS ADUPAJ_date_added,
			ADTENT_time_entered
		FROM
			Integration.F4072_price_adjustment_detail_Staging s
		WHERE
			EXISTS 
			(
				SELECT * FROM [dbo].[BRS_CustomerBT] b 
				WHERE b.BillTo = s.[ADAN8__billto]
			) 

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '7. add all [Pricing].[item_extension_file_F5613]'

		INSERT INTO
		Pricing.item_extension_file_F5613
		(
			QNITM__item_number_short,
			QNLITM_item_number,
			QNAITM__3rd_item_number,
			QN$FIN_force_item_notes,
			QN$FRT_freightable_item,
			QN$IVP_inventory_percentage,
			QN$CEM_ce_mark,
			QN$CER_ce_mark_required,
			QN$RPK_repack,
			QN$SPC_supplier_code,
			QN$SZE_size_packaged_units,
			QN$STR_strength,
			QN$MDC_multiple_drug_classes,
			QN$STU_status,
			QN$DS__drop_ship,
			QN$IFP_inbound_frt_adj_pct,
			QN$IFD_inbound_frt_adj_amt,
			QN$SOM_sales_order_markup,
			QNLTDT_transit_days,
			QNINMG_print_message,
			QNUSER_user_id,
			QNPID__program_id,
			QNJOBN_work_station_id,
			QNUPMJ_date_updated,
			QNTDAY_time_of_day
		)
		SELECT
			QNITM__item_number_short,
			LEFT(QNLITM_item_number,10),
			QNAITM__3rd_item_number,
			QN$FIN_force_item_notes,
			QN$FRT_freightable_item,
			QN$IVP_inventory_percentage,
			QN$CEM_ce_mark,
			QN$CER_ce_mark_required,
			QN$RPK_repack,
			QN$SPC_supplier_code,
			QN$SZE_size_packaged_units,
			QN$STR_strength,
			QN$MDC_multiple_drug_classes,
			QN$STU_status,
			QN$DS__drop_ship,
			QN$IFP_inbound_frt_adj_pct,
			QN$IFD_inbound_frt_adj_amt,
			QN$SOM_sales_order_markup,
			QNLTDT_transit_days,
			QNINMG_print_message,
			QNUSER_user_id,
			QNPID__program_id,
			QNJOBN_work_station_id,
			QNUPMJ_date_updated,
			QNTDAY_time_of_day
		FROM
			Integration.F5613_product_extension_file_Staging

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '8. add new BRS_CustomerVPA'

		INSERT INTO 
			BRS_CustomerVPA (VPA)
		SELECT	
			distinct (SNASN__adjustment_schedule)
		FROM	
			Integration.F4070_price_adjustment_schedule_Staging s
		WHERE	
			NOT EXISTS
			(
				SELECT * FROM [dbo].[BRS_CustomerVPA] 
				WHERE [VPA]=S.SNASN__adjustment_schedule
			)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '9. add all [Pricing].[price_adjustment_enroll_F40314]'

		INSERT INTO
		Pricing.price_adjustment_enroll_F40314
		(
			PJAN8__billto,
			PJCS14_customer_group_price_adjustment_sched,
			PJITM__item_number_short,
			PJIT14_item_group_price_adjustment_schedule,
			PJEFTJ_effective_date,
			PJEXDJ_expired_date,
			PJMNQ__quantity_from,
			PJMXQ__quantity_thru,
			PJUOM__um,
			PJTXID_text_id_number,
			PJSTPR_preference_status,
			PJOSEQ_sequence_number,
			PJMCU__business_unit,
			PJASN__adjustment_schedule,
			PJURCD_user_reserved_code,
			PJURDT_user_reserved_date_JDT,
			PJURAT_user_reserved_amount,
			PJURAB_user_reserved_number,
			PJURRF_user_reserved_reference,
			PJUSER_user_id,
			PJPID__program_id,
			PJJOBN_work_station_id,
			PJUPMJ_date_updated,
			PJTDAY_time_of_day
		)
		SELECT
			PJAN8__billto,
			PJCS14_customer_group_price_adjustment_sched,
			PJITM__item_number_short,
			PJIT14_item_group_price_adjustment_schedule,
			PJEFTJ_effective_date,
			PJEXDJ_expired_date,
			PJMNQ__quantity_from,
			PJMXQ__quantity_thru,
			PJUOM__um,
			PJTXID_text_id_number,
			PJSTPR_preference_status,
			PJOSEQ_sequence_number,
			PJMCU__business_unit,
			PJASN__adjustment_schedule,
			PJURCD_user_reserved_code,
			PJURDT_user_reserved_date_JDT,
			PJURAT_user_reserved_amount,
			PJURAB_user_reserved_number,
			PJURRF_user_reserved_reference,
			PJUSER_user_id,
			PJPID__program_id,
			PJJOBN_work_station_id,
			PJUPMJ_date_updated,
			PJTDAY_time_of_day
		FROM
			Integration.F40314_preference_price_adjustment_schedule_Staging


		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '10. add all [Pricing].[supplier_catalog_price_file_F41061]'

		-- de-dup
		INSERT INTO
		Pricing.supplier_catalog_price_file_F41061
		(
			CBMCU__business_unit,
			CBAN8__billto,
			CBITM__item_number_short,
			CBLITM_item_number,
			CBAITM__3rd_item_number,
			CBCATN_catalog,
			CBDMCT_agreement_nbr,
			CBDMCS_agreement_supplement,
			CBKCOO_order_company,
			CBDOCO_salesorder_number,
			CBDCTO_order_type,
			CBLNID_line_number,
			CBCRCD_currency_code,
			CBUOM__um,
			CBPRRC_unit_cost,
			CBUORG_quantity,
			CBEFTJ_effective_date,
			CBEXDJ_expired_date,
			CBUSER_user_id,
			CBPID__program_id,
			CBJOBN_work_station_id,
			CBUPMJ_date_updated,
			CBTDAY_time_of_day
		)
		SELECT
			CBMCU__business_unit,
			CBAN8__billto,
			CBITM__item_number_short,
			LEFT(CBLITM_item_number,10),
			CBAITM__3rd_item_number,
			CBCATN_catalog,
			CBDMCT_agreement_nbr,
			CBDMCS_agreement_supplement,
			CBKCOO_order_company,
			CBDOCO_salesorder_number,
			CBDCTO_order_type,
			CBLNID_line_number,
			CBCRCD_currency_code,
			CBUOM__um,
			CBPRRC_unit_cost,
			CBUORG_quantity,
			CBEFTJ_effective_date,
			CBEXDJ_expired_date,
			CBUSER_user_id,
			CBPID__program_id,
			CBJOBN_work_station_id,
			CBUPMJ_date_updated,
			CBTDAY_time_of_day
		FROM
			Integration.F41061_supplier_catalog_price_file_Staging AS s
		WHERE EXISTS 
		(
			SELECT		
				MAX(s2.IdKey) AS id_unique
			FROM        
				Integration.F41061_supplier_catalog_price_file_Staging s2
			GROUP BY	
				CBMCU__business_unit, 
				CBAN8__billto, 
				CBITM__item_number_short, 
				CBCATN_catalog, 
				CBCRCD_currency_code, 
				CBUOM__um, 
				CBUORG_quantity, 
				CBEXDJ_expired_date
			HAVING 
				s.[IdKey] = MAX(s2.IdKey)
		) 

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '11. add all [Pricing].[price_adjustment_schedule_F4070]'

		INSERT INTO
		Pricing.price_adjustment_schedule_F4070
		(
			SNASN__adjustment_schedule,
			SNOSEQ_sequence_number,
			SNAST__adjustment_name,
			SNURCD_user_reserved_code,
			SNURDT_user_reserved_date_JDT,
			SNURAT_user_reserved_amount,
			SNURAB_user_reserved_number,
			SNURRF_user_reserved_reference,
			SNUSER_user_id,
			SNPID__program_id,
			SNJOBN_work_station_id,
			SNUPMJ_date_updated,
			SNTDAY_time_of_day
		)
		SELECT
			SNASN__adjustment_schedule,
			SNOSEQ_sequence_number,
			SNAST__adjustment_name,
			SNURCD_user_reserved_code,
			SNURDT_user_reserved_date_JDT,
			SNURAT_user_reserved_amount,
			SNURAB_user_reserved_number,
			SNURRF_user_reserved_reference,
			SNUSER_user_id,
			SNPID__program_id,
			SNJOBN_work_station_id,DATEADD (day ,SNUPMJ_date_updated_JDT%1000-1,
				DATEADD(year,SNUPMJ_date_updated_JDT/1000,0 ) ) AS SNUPMJ_date_updated,
			SNTDAY_time_of_day
		FROM
			Integration.F4070_price_adjustment_schedule_Staging
		WHERE
			EXISTS 
			(
				SELECT * 
				FROM [Pricing].[price_adjustment_name_F4071] b 
				WHERE b.ATAST__adjustment_name = SNAST__adjustment_name
			) 

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '12. add all [Pricing].[price_marketing_program_enroll_F40308]'

		INSERT INTO
		Pricing.price_marketing_program_enroll_F40308
		(
			GSAN8__billto,
			GSCS08_customer_group_grade_and_potency,
			GSITM__item_number_short,
			GSIT08_item_group_grade_and_potency,
			GSEFTJ_effective_date,
			GSEXDJ_expired_date,
			GSMNQ__quantity_from,
			GSMXQ__quantity_thru,
			GSUOM__um,
			GSTXID_text_id_number,
			GSSTPR_preference_status,
			GSOSEQ_sequence_number,
			GSFRGD_from_grade,
			GSTHGD_thru_grade,
			GSFRMP_from_potency,
			GSTHRP_thru_potency,
			GSEXDP_days_before_expiration,
			GSURCD_user_reserved_code,
			GSURDT_user_reserved_date_JDT,
			GSURAT_user_reserved_amount,
			GSURAB_user_reserved_number,
			GSURRF_user_reserved_reference,
			GSUSER_user_id,
			GSPID__program_id,
			GSJOBN_work_station_id,GSUPMJ_date_updated,
			GSTDAY_time_of_day
		)
		SELECT
			GSAN8__billto,
			GSCS08_customer_group_grade_and_potency,
			GSITM__item_number_short,
			GSIT08_item_group_grade_and_potency,
			DATEADD (day ,GSEFTJ_effective_date_JDT%1000-1,
				DATEADD(year,GSEFTJ_effective_date_JDT/1000,0 ) ) AS GSEFTJ_effective_date,
			GSEXDJ_expired_date,
			GSMNQ__quantity_from,
			GSMXQ__quantity_thru,
			GSUOM__um,
			GSTXID_text_id_number,
			GSSTPR_preference_status,
			GSOSEQ_sequence_number,
			GSFRGD_from_grade,
			GSTHGD_thru_grade,
			GSFRMP_from_potency,
			GSTHRP_thru_potency,
			GSEXDP_days_before_expiration,
			GSURCD_user_reserved_code,
			GSURDT_user_reserved_date_JDT,
			GSURAT_user_reserved_amount,
			GSURAB_user_reserved_number,
			GSURRF_user_reserved_reference,
			GSUSER_user_id,
			GSPID__program_id,
			GSJOBN_work_station_id,
			DATEADD (day ,GSUPMJ_date_updated_JDT%1000-1,
				DATEADD(year,GSUPMJ_date_updated_JDT/1000,0 ) ) AS GSUPMJ_date_updated,
			GSTDAY_time_of_day
		FROM
			Integration.F40308_preference_profile_grade_and_potency_Staging AS s
		WHERE
			EXISTS 
			(
				SELECT * 
				FROM [dbo].[BRS_CustomerBT] b 
				WHERE b.BillTo = s.[GSAN8__billto]
			)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '13. add all [Pricing].[item_customer_keyid_master_file_F4094]'

		INSERT INTO
		Pricing.item_customer_keyid_master_file_F4094
		(
			KIPRGR_item_price_group,
			KIIGP1_item_group_category_code_01,
			KIIGP2_item_group_category_code_02,
			KIIGP3_item_group_category_code_03,
			KIIGP4_item_group_category_code_04,
			KICPGP_customer_price_group,
			KICGP1_customer_group_category_code_01,
			KICGP2_customer_group_category_code_02,
			KICGP3_customer_group_category_code_03,
			KICGP4_customer_group_category_code_04,
			KIICID_itemcustomer_key_id
		)
		SELECT
			KIPRGR_item_price_group,
			KIIGP1_item_group_category_code_01,
			KIIGP2_item_group_category_code_02,
			KIIGP3_item_group_category_code_03,
			KIIGP4_item_group_category_code_04,
			KICPGP_customer_price_group,
			KICGP1_customer_group_category_code_01,
			KICGP2_customer_group_category_code_02,
			KICGP3_customer_group_category_code_03,
			KICGP4_customer_group_category_code_04,
			KIICID_itemcustomer_key_id
		FROM
			Integration.F4094_item_customer_keyid_master_file_Staging AS s


		Set @nErrorCode = @@Error
	End

	-- see end of script if this section breaks.  
	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '14. add Class Contract Map 1 of 3 -- [Pricing].[price_adjustment_enroll]'

		INSERT INTO 
		Pricing.price_adjustment_enroll
		(
			BillTo,
			SNAST__adjustment_name,
			PJASN__adjustment_schedule,
			PJEFTJ_effective_date,
			PJEXDJ_expired_date,
			PJUPMJ_date_updated,
			PJUSER_user_id,
			EnrollSource,
			PriceMethod
		)
		SELECT        
			pj.PJAN8__billto AS BillTo, 
			sn.SNAST__adjustment_name, 
			pj.PJASN__adjustment_schedule, 
			pj.PJEFTJ_effective_date, 
			pj.PJEXDJ_expired_date, 
			pj.PJUPMJ_date_updated, 
			pj.PJUSER_user_id, 
			'CLACTR' AS EnrollSource, 
			'C' AS PriceMethod
		FROM            
			Pricing.price_adjustment_enroll_F40314 AS pj 

			INNER JOIN Pricing.price_adjustment_schedule_F4070 AS sn 
			ON pj.PJASN__adjustment_schedule = sn.SNASN__adjustment_schedule 

			INNER JOIN Pricing.price_adjustment_name_F4071 AS atn 
			ON sn.SNAST__adjustment_name = atn.ATAST__adjustment_name

			INNER JOIN [dbo].[BRS_CustomerBT] as bt
			ON pj.PJAN8__billto = bt.BillTo
		WHERE        
			(atn.ATPRFR_preference_type = 'IG') AND 
			(atn.ATPRGR_item_price_group = '') AND 
			(atn.ATCPGP_customer_price_group = '') AND 
			(atn.ATSDGR_order_detail_group = '') AND 
			(atn.ATLBT__level_break_type = 1) AND
			-- terrible work-around for terrible pricing practices, 7 Dec 18
			sn.SNAST__adjustment_name not in('USENDDCC', 'USEND123', 'ADC02ALT', 'USENDALT', 'USENDJAF', 'ADC02RID', 'ADC01CUM', 'ADC03CDS') AND
			pj.PJAN8__billto not in(3823581) AND
			pj.PJAN8__billto = 1670163 AND
			(1 = 1)
		ORDER BY 1

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '15. add Contract Map 2 of 3 -- [Pricing].[price_adjustment_enroll]'

		INSERT INTO Pricing.price_adjustment_enroll
		(
			BillTo,
			SNAST__adjustment_name,
			PJASN__adjustment_schedule,
			PJEFTJ_effective_date,
			PJEXDJ_expired_date,
			PJUPMJ_date_updated,
			PJUSER_user_id,
			EnrollSource,
			PriceMethod
		)
		SELECT 
			p.ADAN8__billto					AS BillTo
			,MIN(p.ADAST__adjustment_name)	AS ADAST__adjustment_name
			-- No Sales Plan for Special Pricing
			,''								AS PJASN__adjustment_schedule
			,MIN(p.ADEFTJ_effective_date)	AS PJEFTJ_effective_date
			,MAX(p.ADEXDJ_expired_date)		AS PJEXDJ_expired_date
			,MAX(p.ADUPMJ_date_updated)		AS PJUPMJ_date_updated
			,MAX(p.ADUSER_user_id)			AS PJUSER_user_id
			,'CUSCONTR'						AS EnrollSource
			,'C'							AS PriceMethod

		FROM            
			[Pricing].[price_adjustment_detail_F4072]  p

			INNER JOIN [Pricing].price_adjustment_name_F4071 n
			ON p.ADAST__adjustment_name = n.ATAST__adjustment_name

			INNER JOIN [dbo].[BRS_CustomerBT] as bt
			ON p.ADAN8__billto = bt.BillTo
		WHERE
			n.ATPRFR_preference_type IN ('C') AND
			p.ADAST__adjustment_name = 'CUSCONTR' AND
			ADAN8__billto > 0 AND
			p.ADBSCD_basis = 5 AND
			p.ADMNQ__quantity_from = 1 AND

			-- remove reference were class contract to avoid double counting. bad data 
			NOT EXISTS (SELECT * 
						FROM [Pricing].[price_adjustment_enroll] b 
						WHERE b.BillTo = p.[ADAN8__billto]
						) AND
			(1=1)
		GROUP BY
			p.ADAN8__billto

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '16. add Special Pricing Map 3 of 3 -- [Pricing].[price_adjustment_enroll]'

		INSERT INTO Pricing.price_adjustment_enroll
		(
			BillTo,
			SNAST__adjustment_name,
			PJASN__adjustment_schedule,
			PJEFTJ_effective_date,
			PJEXDJ_expired_date,
			PJUPMJ_date_updated,
			PJUSER_user_id,
			EnrollSource,
			PriceMethod
		)
		SELECT 
			p.ADAN8__billto					AS BillTo
			,MIN(p.ADAST__adjustment_name)	AS ADAST__adjustment_name
			-- No Sales Plan for Special Pricing
			,''								AS PJASN__adjustment_schedule
			,MIN(p.ADEFTJ_effective_date)	AS PJEFTJ_effective_date
			,MAX(p.ADEXDJ_expired_date)		AS PJEXDJ_expired_date
			,MAX(p.ADUPMJ_date_updated)		AS PJUPMJ_date_updated
			,MAX(p.ADUSER_user_id)			AS PJUSER_user_id
			,'SPLPRICE'						AS EnrollSource
			,'S'							AS PriceMethod

		FROM            
			[Pricing].[price_adjustment_detail_F4072]  p

			INNER JOIN [Pricing].price_adjustment_name_F4071 n
			ON p.ADAST__adjustment_name = n.ATAST__adjustment_name

			INNER JOIN [dbo].[BRS_CustomerBT] as bt
			ON p.ADAN8__billto = bt.BillTo

		WHERE
			n.ATPRFR_preference_type IN ('C') AND
			p.ADAST__adjustment_name = 'SPLPRICE' AND
			ADAN8__billto > 0 AND
			p.ADBSCD_basis = 5 AND
			p.ADMNQ__quantity_from = 1 AND
			(1=1)
		GROUP BY
			p.ADAN8__billto

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '17. update wcs item'

		UPDATE
			Pricing.item_wcs_unique_fields_file_F5656
		SET
			QVAITM__3rd_item_number =s.QVAITM__3rd_item_number,
			QV$AVC_availability_code =s.QV$AVC_availability_code,
			QV$RQT_restricted_qty =s.QV$RQT_restricted_qty ,
			QV$CCD_case_code =s.QV$CCD_case_code ,
			QV$CCQ_case_qty =s.QV$CCQ_case_qty ,
			QV$ITH_item_height =s.QV$ITH_item_height ,

			QV$ITW_item_width =s.QV$ITW_item_width ,
			QV$ITL_item_length =s.QV$ITL_item_length ,
			QV$CLC_classification_code =s.QV$CLC_classification_code ,
			QV$PRI_pricing_info =s.QV$PRI_pricing_info ,
			QV$MMC_mix_match_code =s.QV$MMC_mix_match_code ,
			QV$VCD_vendor_code =s.QV$VCD_vendor_code ,
			QV$LCT_location_type =s.QV$LCT_location_type ,
			QV$PPL_print_on_pickticket =s.QV$PPL_print_on_pickticket ,

			QV$BKD_backorder_date_JDT =s.QV$BKD_backorder_date_JDT ,
			QV$ABD_abbr_descr =s.QV$ABD_abbr_descr ,
			QV$ASR_abbreviated_strength =s.QV$ASR_abbreviated_strength ,
			QVUSER_user_id =s.QVUSER_user_id ,
			QVPID__program_id =s.QVPID__program_id ,
			QVJOBN_work_station_id =s.QVJOBN_work_station_id ,
			QVUPMJ_date_updated =s.QVUPMJ_date_updated ,
			QVTDAY_time_of_day =s.QVTDAY_time_of_day ,

			QV$IDC_importdomestic = s.QV$IDC_importdomestic

		FROM
			Pricing.item_wcs_unique_fields_file_F5656 d
			INNER JOIN Integration.F5656_wcs_unique_fields_file_Staging AS s 
			ON d.QVITM__item_number_short = s.QVITM__item_number_short AND
--				CHECKSUM(s.*) <> CHECKSUM(d.*) AND
				(1=1)
	

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '18. add wcs item'

		INSERT INTO Pricing.item_wcs_unique_fields_file_F5656
								 (QVITM__item_number_short, QVLITM_item_number, QVAITM__3rd_item_number, QV$AVC_availability_code, QV$RQT_restricted_qty, QV$CCD_case_code, QV$CCQ_case_qty, QV$ITH_item_height, QV$ITW_item_width, 
								 QV$ITL_item_length, QV$IDC_importdomestic, QV$CLC_classification_code, QV$PRI_pricing_info, QV$MMC_mix_match_code, QV$VCD_vendor_code, QV$LCT_location_type, QV$PPL_print_on_pickticket, 
								 QV$BKD_backorder_date_JDT, QV$ABD_abbr_descr, QV$ASR_abbreviated_strength, QVUSER_user_id, QVPID__program_id, QVJOBN_work_station_id, QVUPMJ_date_updated, QVTDAY_time_of_day)
		SELECT        QVITM__item_number_short, QVLITM_item_number, QVAITM__3rd_item_number, QV$AVC_availability_code, QV$RQT_restricted_qty, QV$CCD_case_code, QV$CCQ_case_qty, QV$ITH_item_height, QV$ITW_item_width, 
								 QV$ITL_item_length, QV$IDC_importdomestic, QV$CLC_classification_code, QV$PRI_pricing_info, QV$MMC_mix_match_code, QV$VCD_vendor_code, QV$LCT_location_type, QV$PPL_print_on_pickticket, 
								 QV$BKD_backorder_date_JDT, QV$ABD_abbr_descr, QV$ASR_abbreviated_strength, QVUSER_user_id, QVPID__program_id, QVJOBN_work_station_id, QVUPMJ_date_updated, QVTDAY_time_of_day
		FROM            Integration.F5656_wcs_unique_fields_file_Staging AS d
		WHERE
			NOT EXISTS
			(
				Select *
				FROM 
					[Pricing].item_wcs_unique_fields_file_F5656 AS s
				WHERE
					s.QVITM__item_number_short = d.QVITM__item_number_short AND
					(1=1)
			)


		Set @nErrorCode = @@Error
	End
--
	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '19. append e3.profile_E3PRFL'

		INSERT INTO e3.profile_E3PRFL
			(PBIRDT_birth_date, PPTYPE_profile_type, PNAME__profile_name, PPERD__periodicity, PMESG__message_switch, PUSEDT_use_date, PIX01__seasonal_index, PIX02__seasonal_index, PIX03__seasonal_index, 
			PIX04__seasonal_index, PIX05__seasonal_index, PIX06__seasonal_index, PIX07__seasonal_index, PIX08__seasonal_index, PIX09__seasonal_index, PIX10__seasonal_index, PIX11__seasonal_index, 
			PIX12__seasonal_index, PIX13__seasonal_index, PIX14__seasonal_index, PIX15__seasonal_index, PIX16__seasonal_index, PIX17__seasonal_index, PIX18__seasonal_index, PIX19__seasonal_index, 
			PIX20__seasonal_index, PIX21__seasonal_index, PIX22__seasonal_index, PIX23__seasonal_index, PIX24__seasonal_index, PIX25__seasonal_index, PIX26__seasonal_index, PIX27__seasonal_index, 
			PIX28__seasonal_index, PIX29__seasonal_index, PIX30__seasonal_index, PIX31__seasonal_index, PIX32__seasonal_index, PIX33__seasonal_index, PIX34__seasonal_index, PIX35__seasonal_index, 
			PIX36__seasonal_index, PIX37__seasonal_index, PIX38__seasonal_index, PIX39__seasonal_index, PIX40__seasonal_index, PIX41__seasonal_index, PIX42__seasonal_index, PIX43__seasonal_index, 
			PIX44__seasonal_index, PIX45__seasonal_index, PIX46__seasonal_index, PIX47__seasonal_index, PIX48__seasonal_index, PIX49__seasonal_index, PIX50__seasonal_index, PIX51__seasonal_index, 
			PIX52__seasonal_index, PMSGSW_message_switch, PPRFL__profile_id)
		SELECT
			PBIRDT_birth_date, PPTYPE_profile_type, PNAME__profile_name, PPERD__periodicity, PMESG__message_switch, PUSEDT_use_date, PIX01__seasonal_index, PIX02__seasonal_index, PIX03__seasonal_index, 
			PIX04__seasonal_index, PIX05__seasonal_index, PIX06__seasonal_index, PIX07__seasonal_index, PIX08__seasonal_index, PIX09__seasonal_index, PIX10__seasonal_index, PIX11__seasonal_index, 
			PIX12__seasonal_index, PIX13__seasonal_index, PIX14__seasonal_index, PIX15__seasonal_index, PIX16__seasonal_index, PIX17__seasonal_index, PIX18__seasonal_index, PIX19__seasonal_index, 
			PIX20__seasonal_index, PIX21__seasonal_index, PIX22__seasonal_index, PIX23__seasonal_index, PIX24__seasonal_index, PIX25__seasonal_index, PIX26__seasonal_index, PIX27__seasonal_index, 
			PIX28__seasonal_index, PIX29__seasonal_index, PIX30__seasonal_index, PIX31__seasonal_index, PIX32__seasonal_index, PIX33__seasonal_index, PIX34__seasonal_index, PIX35__seasonal_index, 
			PIX36__seasonal_index, PIX37__seasonal_index, PIX38__seasonal_index, PIX39__seasonal_index, PIX40__seasonal_index, PIX41__seasonal_index, PIX42__seasonal_index, PIX43__seasonal_index, 
			PIX44__seasonal_index, PIX45__seasonal_index, PIX46__seasonal_index, PIX47__seasonal_index, PIX48__seasonal_index, PIX49__seasonal_index, PIX50__seasonal_index, PIX51__seasonal_index, 
			PIX52__seasonal_index, PMSGSW_message_switch, PPRFL__profile_id
		FROM
			Integration.E3PRFL_profile_Staging AS s
		WHERE 
			NOT EXISTS (SELECT * from e3.profile_E3PRFL d where s.PPRFL__profile_id = d.PPRFL__profile_id)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '20. update e3.profile_E3PRFL'

		UPDATE
			e3.profile_E3PRFL
		SET                
			  [PBIRDT_birth_date]		= s.[PBIRDT_birth_date]
			  ,[PPTYPE_profile_type]	= s.[PPTYPE_profile_type] 
			  ,[PNAME__profile_name]	= s.[PNAME__profile_name]
			  ,[PPERD__periodicity]		= s.[PPERD__periodicity]
			  ,[PMESG__message_switch]	= s.[PMESG__message_switch]
			  ,[PUSEDT_use_date]		= s.[PUSEDT_use_date]
			  ,[PIX01__seasonal_index]	= s.[PIX01__seasonal_index]
			  ,[PIX02__seasonal_index]	= s.[PIX02__seasonal_index]
			  ,[PIX03__seasonal_index]	= s.[PIX03__seasonal_index]
			  ,[PIX04__seasonal_index]	= s.[PIX04__seasonal_index]
			  ,[PIX05__seasonal_index]	= s.[PIX05__seasonal_index]
			  ,[PIX06__seasonal_index]	= s.[PIX06__seasonal_index]
			  ,[PIX07__seasonal_index]	= s.[PIX07__seasonal_index]
			  ,[PIX08__seasonal_index]	= s.[PIX08__seasonal_index]
			  ,[PIX09__seasonal_index]	= s.[PIX09__seasonal_index]
			  ,[PIX10__seasonal_index]	= s.[PIX10__seasonal_index]
			  ,[PIX11__seasonal_index]	= s.[PIX11__seasonal_index]
			  ,[PIX12__seasonal_index]	= s.[PIX12__seasonal_index]
			  ,[PIX13__seasonal_index]	= s.[PIX13__seasonal_index]
			  ,[PIX14__seasonal_index]	= s.[PIX14__seasonal_index]
			  ,[PIX15__seasonal_index]	= s.[PIX15__seasonal_index]
			  ,[PIX16__seasonal_index]	= s.[PIX16__seasonal_index]
			  ,[PIX17__seasonal_index]	= s.[PIX17__seasonal_index]
			  ,[PIX18__seasonal_index]	= s.[PIX18__seasonal_index]
			  ,[PIX19__seasonal_index]	= s.[PIX19__seasonal_index]
			  ,[PIX20__seasonal_index]	= s.[PIX20__seasonal_index]
			  ,[PIX21__seasonal_index]	= s.[PIX21__seasonal_index]
			  ,[PIX22__seasonal_index]	= s.[PIX22__seasonal_index]
			  ,[PIX23__seasonal_index]	= s.[PIX23__seasonal_index]
			  ,[PIX24__seasonal_index]	= s.[PIX24__seasonal_index]
			  ,[PIX25__seasonal_index]	= s.[PIX25__seasonal_index]
			  ,[PIX26__seasonal_index]	= s.[PIX26__seasonal_index]
			  ,[PIX27__seasonal_index]	= s.[PIX27__seasonal_index]
			  ,[PIX28__seasonal_index]	= s.[PIX28__seasonal_index]
			  ,[PIX29__seasonal_index]	= s.[PIX29__seasonal_index]
			  ,[PIX30__seasonal_index]	= s.[PIX30__seasonal_index]
			  ,[PIX31__seasonal_index]	= s.[PIX31__seasonal_index]
			  ,[PIX32__seasonal_index]	= s.[PIX32__seasonal_index]
			  ,[PIX33__seasonal_index]	= s.[PIX33__seasonal_index]
			  ,[PIX34__seasonal_index]	= s.[PIX34__seasonal_index]
			  ,[PIX35__seasonal_index]	= s.[PIX35__seasonal_index]
			  ,[PIX36__seasonal_index]	= s.[PIX36__seasonal_index]
			  ,[PIX37__seasonal_index]	= s.[PIX37__seasonal_index]
			  ,[PIX38__seasonal_index]	= s.[PIX38__seasonal_index]
			  ,[PIX39__seasonal_index]	= s.[PIX39__seasonal_index]
			  ,[PIX40__seasonal_index]	= s.[PIX40__seasonal_index]
			  ,[PIX41__seasonal_index]	= s.[PIX41__seasonal_index]
			  ,[PIX42__seasonal_index]	= s.[PIX42__seasonal_index]
			  ,[PIX43__seasonal_index]	= s.[PIX43__seasonal_index]
			  ,[PIX44__seasonal_index]	= s.[PIX44__seasonal_index]
			  ,[PIX45__seasonal_index]	= s.[PIX45__seasonal_index]
			  ,[PIX46__seasonal_index]	= s.[PIX46__seasonal_index]
			  ,[PIX47__seasonal_index]	= s.[PIX47__seasonal_index]
			  ,[PIX48__seasonal_index]	= s.[PIX48__seasonal_index]
			  ,[PIX49__seasonal_index]	= s.[PIX49__seasonal_index]
			  ,[PIX50__seasonal_index]	= s.[PIX50__seasonal_index]
			  ,[PIX51__seasonal_index]	= s.[PIX51__seasonal_index]
			  ,[PIX52__seasonal_index]	= s.[PIX52__seasonal_index]
			  ,[PMSGSW_message_switch]	= s.[PMSGSW_message_switch]
		FROM
			Integration.E3PRFL_profile_Staging AS s 
			INNER JOIN e3.profile_E3PRFL ON 
			s.PPRFL__profile_id = e3.profile_E3PRFL.PPRFL__profile_id

		Set @nErrorCode = @@Error
	End


	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '21. append BRS_ItemSupplier'

		INSERT INTO [dbo].[BRS_ItemSupplier]
		(
			[Supplier]
		)
		SELECT DISTINCT
			LEFT(IVNDR__vendor_id,6)
		FROM
			Integration.E3ITEMA_trim_Staging s
		WHERE
			NOT EXISTS 
			(
				SELECT *
				FROM [dbo].[BRS_ItemSupplier] d
				WHERE
					d.[Supplier] = s.IVNDR__vendor_id AND
					(1=1)
			)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '22. append BRS_Item'

		INSERT INTO [dbo].[BRS_Item]
		(
			[Item]
		)
		SELECT DISTINCT
			[IITEM__item_id]
		FROM
			Integration.E3ITEMA_trim_Staging s
		WHERE
			NOT EXISTS 
			(
				SELECT *
				FROM [dbo].[BRS_Item] d
				WHERE
					d.[Item] = s.[IITEM__item_id] AND
					(1=1)
			)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '23. append e3.demand_E3ITEMA_dimension'

		INSERT INTO [e3].[demand_E3ITEMA_dimension]
		(
			IVNDR__vendor_id, 
			ISUBV__subvendor_id, 
			IBUYR__buyer_id, 
			IDMPRF_item_demand_profile_id
		)
		SELECT DISTINCT
			LEFT(IVNDR__vendor_id,6), 
			ISUBV__subvendor_id, 
			IBUYR__buyer_id, 
			IDMPRF_item_demand_profile_id
		FROM
			Integration.E3ITEMA_trim_Staging s
		WHERE
			NOT EXISTS 
			(
				SELECT *
				FROM [e3].[demand_E3ITEMA_dimension] d
				WHERE
					d.IVNDR__vendor_id = s.IVNDR__vendor_id AND
					d.ISUBV__subvendor_id = s.ISUBV__subvendor_id AND
					d.IBUYR__buyer_id = s.IBUYR__buyer_id AND
					d.IDMPRF_item_demand_profile_id = s.IDMPRF_item_demand_profile_id AND
					(1=1)
			)

		Set @nErrorCode = @@Error
	End

	-- there is a lot going on here:  reduce data size & pivot seasonality
	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '24. append e3.demand_E3ITEMA'

		INSERT INTO [e3].[demand_E3ITEMA]
		(
			[SalesDay],
			[ItemKey],
			[IWHSE__warehouse_id],
			[IDEM52_demand_forecast_weekly],
			[PIX_seasonal_index],
			[demand_dim_id]
		)
		SELECT
			CAST( [SalesDateLastWeekly] as date) dt,
			i.ItemKey, 
			CAST(s.IWHSE__warehouse_id as tinyint) whse, 
			s.IDEM52_demand_forecast_weekly, 
			CASE 
				WHEN idx.PPRFL__profile_id = '' 
				THEN 1.0 
				ELSE idx.current_index 
			END AS seasonal_index,
			d.demand_dim_id
		FROM
			Integration.E3ITEMA_trim_Staging AS s 
			INNER JOIN e3.demand_E3ITEMA_dimension AS d 
			ON LEFT(s.IVNDR__vendor_id,6) = d.IVNDR__vendor_id AND 
				s.ISUBV__subvendor_id = d.ISUBV__subvendor_id AND 
				s.IBUYR__buyer_id = d.IBUYR__buyer_id AND
				s.IDMPRF_item_demand_profile_id = d.IDMPRF_item_demand_profile_id

			INNER JOIN [dbo].[BRS_Item] i
			ON s.IITEM__item_id = i.Item

			CROSS JOIN 
			[dbo].[BRS_Config] c

			INNER JOIN
			(
				SELECT 
					[PPRFL__profile_id], 
					seasonal_index as current_index
				FROM 
				(
					SELECT 
						[PPRFL__profile_id]
						,[PIX01__seasonal_index]
						,[PIX02__seasonal_index]
						,[PIX03__seasonal_index]
						,[PIX04__seasonal_index]
						,[PIX05__seasonal_index]
						,[PIX06__seasonal_index]
						,[PIX07__seasonal_index]
						,[PIX08__seasonal_index]
						,[PIX09__seasonal_index]
						,[PIX10__seasonal_index]
						,[PIX11__seasonal_index]
						,[PIX12__seasonal_index]
						,[PIX13__seasonal_index]
						,[PIX14__seasonal_index]
						,[PIX15__seasonal_index]
						,[PIX16__seasonal_index]
						,[PIX17__seasonal_index]
						,[PIX18__seasonal_index]
						,[PIX19__seasonal_index]
						,[PIX20__seasonal_index]
						,[PIX21__seasonal_index]
						,[PIX22__seasonal_index]
						,[PIX23__seasonal_index]
						,[PIX24__seasonal_index]
						,[PIX25__seasonal_index]
						,[PIX26__seasonal_index]
						,[PIX27__seasonal_index]
						,[PIX28__seasonal_index]
						,[PIX29__seasonal_index]
						,[PIX30__seasonal_index]
						,[PIX31__seasonal_index]
						,[PIX32__seasonal_index]
						,[PIX33__seasonal_index]
						,[PIX34__seasonal_index]
						,[PIX35__seasonal_index]
						,[PIX36__seasonal_index]
						,[PIX37__seasonal_index]
						,[PIX38__seasonal_index]
						,[PIX39__seasonal_index]
						,[PIX40__seasonal_index]
						,[PIX41__seasonal_index]
						,[PIX42__seasonal_index]
						,[PIX43__seasonal_index]
						,[PIX44__seasonal_index]
						,[PIX45__seasonal_index]
						,[PIX46__seasonal_index]
						,[PIX47__seasonal_index]
						,[PIX48__seasonal_index]
						,[PIX49__seasonal_index]
						,[PIX50__seasonal_index]
						,[PIX51__seasonal_index]
						,[PIX52__seasonal_index]
						,[PMSGSW_message_switch]
				  FROM 
					e3.[profile_E3PRFL]
				) piv
				UNPIVOT 
				(
					seasonal_index FOR weeks in
					(
						[PIX01__seasonal_index]
						,[PIX02__seasonal_index]
						,[PIX03__seasonal_index]
						,[PIX04__seasonal_index]
						,[PIX05__seasonal_index]
						,[PIX06__seasonal_index]
						,[PIX07__seasonal_index]
						,[PIX08__seasonal_index]
						,[PIX09__seasonal_index]
						,[PIX10__seasonal_index]
						,[PIX11__seasonal_index]
						,[PIX12__seasonal_index]
						,[PIX13__seasonal_index]
						,[PIX14__seasonal_index]
						,[PIX15__seasonal_index]
						,[PIX16__seasonal_index]
						,[PIX17__seasonal_index]
						,[PIX18__seasonal_index]
						,[PIX19__seasonal_index]
						,[PIX20__seasonal_index]
						,[PIX21__seasonal_index]
						,[PIX22__seasonal_index]
						,[PIX23__seasonal_index]
						,[PIX24__seasonal_index]
						,[PIX25__seasonal_index]
						,[PIX26__seasonal_index]
						,[PIX27__seasonal_index]
						,[PIX28__seasonal_index]
						,[PIX29__seasonal_index]
						,[PIX30__seasonal_index]
						,[PIX31__seasonal_index]
						,[PIX32__seasonal_index]
						,[PIX33__seasonal_index]
						,[PIX34__seasonal_index]
						,[PIX35__seasonal_index]
						,[PIX36__seasonal_index]
						,[PIX37__seasonal_index]
						,[PIX38__seasonal_index]
						,[PIX39__seasonal_index]
						,[PIX40__seasonal_index]
						,[PIX41__seasonal_index]
						,[PIX42__seasonal_index]
						,[PIX43__seasonal_index]
						,[PIX44__seasonal_index]
						,[PIX45__seasonal_index]
						,[PIX46__seasonal_index]
						,[PIX47__seasonal_index]
						,[PIX48__seasonal_index]
						,[PIX49__seasonal_index]
						,[PIX50__seasonal_index]
						,[PIX51__seasonal_index]
						,[PIX52__seasonal_index]
					  )
				  ) AS unpvt
				WHERE
					CAST(SUBSTRING(weeks,4,2) as int) = 
					(
						SELECT [CalWeek] 
						FROM [dbo].[BRS_Config], [dbo].[BRS_SalesDay] d 
						WHERE [SalesDateLastWeekly] = d.[SalesDate]
					) 
			) idx
			ON 
			d.IDMPRF_item_demand_profile_id = idx.PPRFL__profile_id AND
			(1=1)
			WHERE 
				NOT EXISTS 
				(
					SELECT * 
					FROM [e3].[demand_E3ITEMA] dest
					WHERE c.SalesDateLastWeekly = dest.SalesDay
				)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '25. append dbo.BRS_FSC_Rollup'

		INSERT INTO [dbo].[BRS_FSC_Rollup]
		(
			[TerritoryCd]
			,[Branch]
		)
		SELECT 
			[GD$TER_territory_code], ''
		FROM 
			[Integration].[F5553_territory_Staging] s
		WHERE
			[GDCO___company]='02000' AND
			NOT EXISTS 
			(
				SELECT *
				FROM [dbo].[BRS_FSC_Rollup] d
				WHERE
					d.[TerritoryCd] = s.[GD$TER_territory_code]
			)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '26. update dbo.BRS_FSC_Rollup'

		UPDATE
			BRS_FSC_Rollup
		SET
			group_type = [GD$GTY_group_type]
			,LastReviewDate = [GDUPMJ_date_updated]
		FROM
			Integration.F5553_territory_Staging AS s 
			INNER JOIN BRS_FSC_Rollup d
			ON s.GD$TER_territory_code = d.TerritoryCd
		WHERE
			(s.GDCO___company = '02000') AND
			(d.TerritoryCd =s.GD$TER_territory_code) AND
			(
				([GD$GTY_group_type] <> d.group_type) OR
				([GDUPMJ_date_updated] <> LastReviewDate) 
			)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '27. append Pricing.entered_by'

		INSERT INTO [Pricing].[entered_by]
		(
			[entered_by_code]
		)
		SELECT 
			DISTINCT [QPUSER_user_id]
		FROM 
			[Integration].[F5527_price_adjustment_history_Staging] s
		WHERE
			NOT EXISTS 
			(
				SELECT *
				FROM [Pricing].[entered_by] d
				WHERE
					d.[entered_by_code] = s.[QPUSER_user_id]
			)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '28. append Pricing.entered_by-Auth'

		INSERT INTO [Pricing].[entered_by]
		(
			[entered_by_code]
		)
		SELECT 
			DISTINCT [QP$AID_authorized_id]
		FROM 
			[Integration].[F5527_price_adjustment_history_Staging] s
		WHERE
			NOT EXISTS 
			(
				SELECT *
				FROM [Pricing].[entered_by] d
				WHERE
					d.[entered_by_code] = s.[QP$AID_authorized_id]
			)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '29. append Pricing.price_adjustment_history_F5527'

		INSERT INTO [Pricing].[price_adjustment_history_F5527]
		(
		  [QPUPMJ_date_updated]
		  ,[Item]
		  ,[QPOVPR_override_price]
		  ,[QP$RSC_reason_code]
		  ,[QP$CTR_competitor]
		  ,[QP$AID_authorized_id]
		  ,[QPUSER_user_id]
		  ,[QPTDAY_time_of_day]
		  ,[QPAC08_market_segment]
		  ,[QPUOM4_pricing_uom]
		  ,[QP$TO__total_number_of_orders]
		  ,[QPCO___company]
		  ,[QPITM__item_number_short]
		  ,[QPPID__program_id]
		  ,[QPJOBN_work_station_id]
		)
		SELECT 
--		top 10
		  [QPUPMJ_date_updated]
		  ,i.IMLITM_item_number
		  ,[QPOVPR_override_price]
		  ,[QP$RSC_reason_code]
		  ,[QP$CTR_competitor]
		  ,[QP$AID_authorized_id]
		  ,[QPUSER_user_id]
		  ,[QPTDAY_time_of_day]
		  ,[QPAC08_market_segment]
		  ,[QPUOM4_pricing_uom]
		  ,[QP$TO__total_number_of_orders]
		  ,[QPCO___company]
		  ,[QPITM__item_number_short]
		  ,[QPPID__program_id]
		  ,[QPJOBN_work_station_id]
		FROM 
			[Integration].[F5527_price_adjustment_history_Staging] s,
			[Pricing].[item_master_F4101] i
		WHERE
			(s.QPITM__item_number_short = i.IMITM__item_number_short) AND
			NOT EXISTS 
			(
				SELECT *
				FROM [Pricing].[price_adjustment_history_F5527] d
				WHERE
					(d.[QPUPMJ_date_updated] = s.[QPUPMJ_date_updated]) AND
					(d.[QPTDAY_time_of_day] = s.[QPTDAY_time_of_day]) AND
					(1=1)
			)


		Set @nErrorCode = @@Error
	End

------------------------------------------------------------------------------------------------------------
-- Wrap-up routines.  
------------------------------------------------------------------------------------------------------------


if (@bDebug <> 0)
	Set @nErrorCode = 512

-- Call error message on Error
if (@nErrorCode <> 0)
Begin
	Set @sMessage = 'pricing.etl_post_proc'
	Set @sMessage = @sMessage + ': ' + convert(varchar, @bDebug)

	RAISERROR ('%s', 9, 1, @sMessage )
	Rollback Tran mytran

	return @nErrorCode
End

-- Commit tran on Success
if (@nTranCount = 0)
Begin
	Commit Tran
End

Return @nErrorCode
GO


--fix 14
/*
-- dup fix
		SELECT        
			pj.PJAN8__billto AS BillTo
			,min(sn.SNAST__adjustment_name) min_adj
			,max(sn.SNAST__adjustment_name) max_adj

		FROM            
			Pricing.price_adjustment_enroll_F40314 AS pj 

			INNER JOIN Pricing.price_adjustment_schedule_F4070 AS sn 
			ON pj.PJASN__adjustment_schedule = sn.SNASN__adjustment_schedule 

			INNER JOIN Pricing.price_adjustment_name_F4071 AS atn 
			ON sn.SNAST__adjustment_name = atn.ATAST__adjustment_name

			INNER JOIN [dbo].[BRS_CustomerBT] as bt
			ON pj.PJAN8__billto = bt.BillTo
		WHERE        
			(atn.ATPRFR_preference_type = 'IG') AND 
			(atn.ATPRGR_item_price_group = '') AND 
			(atn.ATCPGP_customer_price_group = '') AND 
			(atn.ATSDGR_order_detail_group = '') AND 
			(atn.ATLBT__level_break_type = 1) AND
			-- terrible work-around for terrible pricing practices, 7 Dec 18
			sn.SNAST__adjustment_name not in('USENDDCC', 'USEND123', 'ADC02ALT', 'USENDALT', 'USENDJAF', 'ADC02RID', 'ADC01CUM', 'ADC03CDS') AND
			-- test
			pj.PJAN8__billto not in(3823581) AND
			(1 = 1)
		Group BY pj.PJAN8__billto 
		Having count(*) > 1
*/


-- prod
-- EXECUTE [Pricing].[etl_post_proc] @bDebug=0

-- debug
-- EXECUTE [Pricing].[etl_post_proc] @bDebug=1
-- 184927 rows
-- org 1m57s
-- new 1m55s
