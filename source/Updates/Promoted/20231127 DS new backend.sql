-- DS patch process, tmc 27 Nov 23

-- JDE pull from Kurt
--


/****** Object:  Schema [e3]    Script Date: 11/23/2023 10:54:23 AM ******/
CREATE SCHEMA [ds]
GO


-- DS trans - fix dates Julian, etc

-- drop table [Integration].[F55520_daily_sales_order_header_detail_workfile]

CREATE TABLE [Integration].[F55520_daily_sales_order_header_detail_workfile](
	[WODOCO_salesorder_number] [numeric](8, 0) NOT NULL,
	[WODCTO_order_type] [char](2) NOT NULL,
	[WOKCOO_order_number_document_company] [char](5) NOT NULL,
	[WOLNID_line_number] [numeric](15, 3) NOT NULL,

	[WOSFXO_order_suffix] [char](3) NULL,
	[WOMCU__business_unit] [char](12) NULL,
	[WOCO___company] [char](5) NULL,
	[WOOKCO_original_order_document_company] [char](5) NULL,
	[WOOORN_original_order_number] [char](8) NULL,
	[WOOCTO_original_order_type] [char](2) NULL,
	[WOOGNO_original_line_number] [numeric](15, 3) NULL,
	[WORKCO_related_order_key_company] [char](5) NULL,
	[WORORN_related_posowo_number] [char](8) NULL,
	[WORCTO_related_posowo_order_type] [char](2) NULL,
	[WORLLN_related_poso_line_number] [numeric](15, 3) NULL,
	[WODMCT_contract_number] [char](12) NULL,
	[WODMCS_contract_supplement] [numeric](3, 0) NULL,
	[WOBALU_contract_balances_updated_yn] [char](1) NULL,
	[WOAN8__billto] [numeric](8, 0) NULL,
	[WOSHAN_shipto] [numeric](8, 0) NULL,
	[WOPA8__parent_number] [numeric](8, 0) NULL,
	[WODRQJ_requested] [numeric](6, 0) NULL,
	[WOTRDJ_order_date] [date] NULL,
	[WOPDDJ_promised] [numeric](6, 0) NULL,
	[WOADDJ_actual_ship] [numeric](6, 0) NULL,
	[WOIVD__invoice_date] [numeric](6, 0) NULL,
	[WOCNDJ_cancel_date] [numeric](6, 0) NULL,
	[WODGL__gl_date] [date] NULL,
	[WORSDJ_promised_delivery] [numeric](6, 0) NULL,
	[WOPEFJ_price_effective] [numeric](6, 0) NULL,
	[WOPPDJ_future_use_1] [numeric](6, 0) NULL,
	[WOPSDJ_future_use_2] [numeric](6, 0) NULL,
	[WOVR01_reference] [char](25) NULL,
	[WOVR02_reference_2] [char](25) NULL,
	[WOITM__item_number_short] [numeric](8, 0) NULL,
	[WOLITM_item_number] [char](25) NULL,
	[WOAITM__3rd_item_number] [char](25) NULL,
	[WOLOTN_lot] [char](30) NULL,
	[WOEXDP_days_before_expiration] [numeric](5, 0) NULL,
	[WODSC1_description] [char](30) NULL,
	[WODSC2_description_2] [char](30) NULL,
	[WOLNTY_line_type] [char](2) NULL,
	[WONXTR_status_code_next] [char](3) NULL,
	[WOLTTR_status_code_last] [char](3) NULL,
	[WOEMCU_header_business_unit] [char](12) NULL,
	[WORLIT_related_item_number_kit] [char](8) NULL,
	[WOKTLN_kit_master_line_number] [numeric](15, 3) NULL,
	[WOCPNT_component_line_number] [numeric](15, 1) NULL,
	[WORKIT_related_kit_component] [numeric](8, 0) NULL,
	[WOKTP__number_of_component_per_parent] [numeric](15, 0) NULL,
	[WOSRP1_major_product_class] [char](3) NULL,
	[WOSRP2_sub_major_product_class] [char](3) NULL,
	[WOSRP3_minor_product_class] [char](3) NULL,
	[WOSRP4_sub_minor_product_class] [char](3) NULL,
	[WOSRP5_hazardous_class] [char](3) NULL,
	[WOPRP1_commodity_class] [char](3) NULL,
	[WOPRP2_commodity_sub_class] [char](3) NULL,
	[WOPRP3_supplier_rebate_code] [char](3) NULL,
	[WOPRP4_tax_classification] [char](3) NULL,
	[WOPRP5_landed_cost_rule] [char](3) NULL,
	[WOUOM__um] [char](2) NULL,
	[WOUORG_quantity] [numeric](15, 0) NULL,
	[WOSOQS_quantity_shipped] [numeric](15, 0) NULL,
	[WOSOBK_quantity_backordered] [numeric](15, 0) NULL,
	[WOSOCN_quantity_canceled] [numeric](15, 0) NULL,
	[WOSONE_future_quantity_committed] [numeric](15, 0) NULL,
	[WOUOPN_quantity_open] [numeric](15, 0) NULL,
	[WOQTYT_quantity_shipped_to_date] [numeric](15, 0) NULL,
	[WOQRLV_quantity_relieved] [numeric](15, 0) NULL,
	[WOCOMM_committed_hs] [char](1) NULL,
	[WOOTQY_other_quantity_12] [char](1) NULL,
	[WOUPRC_unit_price] [numeric](15, 4) NULL,
	[WOAEXP_extended_price] [numeric](15, 2) NULL,
	[WOAOPN_amount_open] [numeric](15, 2) NULL,
	[WOPROV_price_override_code] [char](1) NULL,
	[WOTPC__temporary_price_yn] [char](1) NULL,
	[WOAPUM_entered_unit_of_measure_for_unit_price] [char](2) NULL,
	[WOLPRC_unit_list_price] [numeric](15, 4) NULL,
	[WOUNCS_unit_cost] [numeric](15, 4) NULL,
	[WOECST_extended_cost] [numeric](15, 2) NULL,
	[WOCSTO_cost_override_code] [char](1) NULL,
	[WOTCST_transfer_cost] [numeric](15, 4) NULL,
	[WOINMG_print_message] [char](10) NULL,
	[WOPTC__payment_terms] [char](3) NULL,
	[WORYIN_payment_instrument] [char](1) NULL,
	[WODTBS_based_on_date] [char](1) NULL,
	[WOTRDC_trade_discount] [numeric](15, 3) NULL,
	[WOFUN2_trade_discount_old] [numeric](15, 4) NULL,
	[WOASN__adjustment_schedule] [char](8) NULL,
	[WOPRGR_item_price_group] [char](8) NULL,
	[WOCLVL_pricing_category_level] [char](3) NULL,
	[WODSPR_discount_factor] [numeric](15, 4) NULL,
	[WODSFT_discount_factor_type_amt_orpct] [char](1) NULL,
	[WOFAPP_discount_application_type] [char](1) NULL,
	[WOCADC_cash_discount_pct] [numeric](15, 3) NULL,
	[WOKCO__document_company] [char](5) NULL,
	[WODOC__document_number] [numeric](8, 0) NULL,
	[WODCT__document_type] [char](2) NULL,
	[WOODOC_original_document_no] [numeric](8, 0) NULL,
	[WOODCT_original_document_type] [char](2) NULL,
	[WOOKC__original_document_company] [char](5) NULL,
	[WOPSN__pick_slip_number] [numeric](8, 0) NULL,
	[WODELN_delivery_number] [numeric](8, 0) NULL,
	[WOPRMO_promotion_number] [char](8) NULL,
	[WOTAX1_sales_taxable] [char](1) NULL,
	[WOTXA1_tax_ratearea] [char](10) NULL,
	[WOEXR1_tax_expl_code] [char](2) NULL,
	[WOPRIO_priority_processing_code] [char](1) NULL,
	[WORESL_printed_code] [char](1) NULL,
	[WOBACK_backorders_allowed_yn] [char](1) NULL,
	[WOSBAL_substitutes_allowed_yn] [char](1) NULL,
	[WOAPTS_partial_shipments_allowed_yn] [char](1) NULL,
	[WOLOB__line_of_business] [char](3) NULL,
	[WOEUSE_end_use] [char](3) NULL,
	[WODTYS_duty_status] [char](2) NULL,
	[WOCDCD_commodity_code] [char](15) NULL,
	[WONTR__nature_of_transaction] [char](2) NULL,
	[WOVEND_primary_last_supplier_number] [numeric](8, 0) NULL,
	[WOANBY_buyer_number] [numeric](8, 0) NULL,
	[WOCARS_carrier_number] [numeric](8, 0) NULL,
	[WOMOT__mode_of_trn] [char](3) NULL,
	[WOCOT__conditions_of_transport] [char](3) NULL,
	[WOROUT_ship_method] [char](3) NULL,
	[WOSTOP_stop_code] [char](3) NULL,
	[WOZON__zone_number] [char](3) NULL,
	[WOCNID_container_id] [char](20) NULL,
	[WOFRTH_freight_handling_code] [char](3) NULL,
	[WOAFT__apply_freight_yn] [char](1) NULL,
	[WOFRTC_freight_calculated_yn] [char](1) NULL,
	[WOFRAT_rate_code_freightmisc] [char](10) NULL,
	[WORATT_rate_type_freightmisc] [char](1) NULL,
	[WOSHCM_shipping_commodity_class] [char](3) NULL,
	[WOSHCN_shipping_conditions_code] [char](3) NULL,
	[WOSERN_lot_serial_number] [char](30) NULL,
	[WOUOM1_unit_of_measure] [char](2) NULL,
	[WOPQOR_quantity_ordered] [numeric](15, 0) NULL,
	[WOUOM2_secondary_uom] [char](2) NULL,
	[WOUOM4_pricing_uom] [char](2) NULL,
	[WOITWT_unit_weight] [numeric](15, 4) NULL,
	[WOWTUM_weight_unit_of_measure] [char](2) NULL,
	[WOITVL_unit_volume] [numeric](15, 4) NULL,
	[WOVLUM_volume_unit_of_measure] [char](2) NULL,
	[WORPRC_basket_reprice_group] [char](8) NULL,
	[WOORPR_order_reprice_group] [char](8) NULL,
	[WOORP__order_repriced_indicator] [char](1) NULL,
	[WOCMGP_inventory_costing_method] [char](2) NULL,
	[WOCMGL_commitment_method] [char](1) NULL,
	[WOGLC__gl_offset] [char](4) NULL,
	[WOFY___fiscal_year] [numeric](2, 0) NULL,
	[WOSTTS_line_status] [char](2) NULL,
	[WOSO01_inter_branch_sales] [char](1) NULL,
	[WOSO04_sales_order_status_04] [char](1) NULL,
	[WOSO05_substitute_item_indicator] [char](1) NULL,
	[WOSO06_preference_commitment_indicator] [char](1) NULL,
	[WOSO07_ship_date_overridden] [char](1) NULL,
	[WOSO08_price_adjustment_line_indicator] [char](1) NULL,
	[WOSO09_sales_order_status_09] [char](1) NULL,
	[WOSO10_preference_product_allocation] [char](1) NULL,
	[WOSO11_sales_order_status_11] [char](1) NULL,
	[WOSO12_sales_order_status_12] [char](1) NULL,
	[WOSO13_sales_order_status_13] [char](1) NULL,
	[WOSO14_sales_order_status_14] [char](1) NULL,
	[WOSO15_sales_order_status_15] [char](1) NULL,
	[WOSLSM_salesperson_code_01] [numeric](8, 0) NULL,
	[WOSLCM_salesperson_commission_1] [numeric](15, 3) NULL,
	[WOSLM2_salesperson_code_02] [numeric](8, 0) NULL,
	[WOSLC2_salesperson_commission_2] [numeric](15, 3) NULL,
	[WOACOM_apply_commission_yn] [char](1) NULL,
	[WOCMCG_commission_category] [char](8) NULL,
	[WORCD__reason_code] [char](3) NULL,
	[WOANI__account_number] [char](29) NULL,
	[WOAID__account_id] [char](8) NULL,
	[WOOMCU_project_cost_center] [char](12) NULL,
	[WOOBJ__object_account] [char](6) NULL,
	[WOSUB__subsidiary] [char](8) NULL,
	[WOLT___ledger_type] [char](2) NULL,
	[WOSBL__subledger] [char](8) NULL,
	[WOSBLT_subledger_type] [char](1) NULL,
	[WOLCOD_loc_tax_code] [char](2) NULL,
	[WOUPC1_price_code_1] [char](2) NULL,
	[WOUPC2_price_code_2] [char](2) NULL,
	[WOUPC3_price_code_3] [char](2) NULL,
	[WOCRMD_send_method] [char](1) NULL,
	[WOCRCD_currency_code] [char](3) NULL,
	[WOCRR__exchange_rate] [numeric](15, 7) NULL,
	[WOFPRC_foreign_list_price] [numeric](15, 4) NULL,
	[WOFUP__foreign_unit_price] [numeric](15, 4) NULL,
	[WOFEA__foreign_extended_price] [numeric](15, 2) NULL,
	[WOFUC__foreign_unit_cost] [numeric](15, 4) NULL,
	[WOFEC__foreign_extended_cost] [numeric](15, 2) NULL,
	[WOURCD_user_reserved_code] [char](2) NULL,
	[WOURDT_user_reserved_date] [numeric](6, 0) NULL,
	[WOURAT_user_reserved_amount] [numeric](15, 2) NULL,
	[WOURAB_user_reserved_number] [numeric](8, 0) NULL,
	[WOURRF_user_reserved_reference] [char](15) NULL,
	[WOTORG_transaction_originator] [char](10) NULL,
	[WO$TRT_tax_rate] [numeric](7, 3) NULL,
	[WOSTAM_tax] [numeric](15, 2) NULL,
	[WO$EFA_estimated_freight_amount] [numeric](15, 2) NULL,
	[WO$AHC_apply_hazardous_charges] [char](1) NULL,
	[WO$AC2_address_code_future_2] [char](3) NULL,
	[WO$ODN_other_document_number] [char](12) NULL,
	[WO$ODT_other_document_type] [char](2) NULL,
	[WOCACT_creditbank_account_number] [char](25) NULL,
	[WO$CCT_credit_card_type] [char](8) NULL,
	[WOCEXP_expired_date_creditbank_acct] [numeric](6, 0) NULL,
	[WO$CBA_chargeback_amount] [numeric](15, 2) NULL,
	[WO$NTC_net_cost_chargebacks] [numeric](15, 2) NULL,
	[WO$LDC_landed_cost] [numeric](15, 2) NULL,
	[WO$FCS_file_cost] [numeric](15, 2) NULL,
	[WO$AGC_average_cost] [numeric](15, 2) NULL,
	[WOENTB_entered_by] [char](10) NULL,
	[WO$SPS_sequence_number_ship] [numeric](3, 0) NULL,
	[WO$PRM_promotion_code] [char](3) NULL,
	[WO$UNC_sales_order_cost_markup] [numeric](15, 4) NULL,
	[WOXRT__cross_reference_type_code] [char](2) NULL,
	[WOCITM_customersupplier_item_number] [char](25) NULL,
	[WO$AID_authorized_id] [char](10) NULL,
	[WOOVPR_override_price] [numeric](15, 2) NULL,
	[WO$OCR_original_computer_resale] [numeric](15, 4) NULL,
	[WO$PMC_promotion_code_price_method] [char](2) NULL,
	[WO$LDP_line_discount_pct] [numeric](15, 3) NULL,
	[WO$PPM_price_promotion_code] [char](2) NULL,
	[WO$VPM_volume_promotion_code] [char](2) NULL,
	[WO$US2_status_pricing_added_line] [char](1) NULL,
	[WO$MSG_message_code] [char](3) NULL,
	[WOPRP6_item_dimension_group] [char](6) NULL,
	[WOPRP7_warehouse_process_grp_1] [char](6) NULL,
	[WOPRP8_warehouse_process_grp_2] [char](6) NULL,
	[WOPRP9_warehouse_process_grp_3] [char](6) NULL,
	[WOPRP0_commodity_code] [char](6) NULL,
	[WOSRP6_manufacturer] [char](6) NULL,
	[WOSRP7_drug_class] [char](6) NULL,
	[WOSRP8_manuf_dspsearch] [char](6) NULL,
	[WOSRP9_category_code_9] [char](6) NULL,
	[WOSRP0_category_code_10] [char](6) NULL,
	[WO$XRN_cross_reference_number] [char](20) NULL,
	[WO$AC1_special_handling_code] [char](3) NULL,
	[WO$OSC_order_source_code] [char](1) NULL,
	[WO$FA__total_amount_freight] [numeric](15, 2) NULL,
	[WO$ASC_apply_small_order_charges] [char](1) NULL,
	[WO$DEA_dea_number] [char](9) NULL,
	[WO$DEX_dea_expiration_date] [numeric](6, 0) NULL,
	[WOSIC__speciality] [char](10) NULL,
	[WO$PLN_prof_lic] [char](20) NULL,
	[WO$LEX_license_expiration_date] [numeric](6, 0) NULL,
	[WO$DPC_document_print_code] [char](3) NULL,
	[WO$DC__primary_warehouse_override] [char](12) NULL,
	[WO$DCO_order_consolidation_warehouse] [char](12) NULL,
	[WO$ACS_accept_cross_shipments] [char](1) NULL,
	[WO$A02_freight_charge_level] [char](1) NULL,
	[WO$A03_carrier_override_code] [char](1) NULL,
	[WO$SPM_secondary_promotion_code] [char](3) NULL,
	[WO$ODP_order_discount_pct] [numeric](15, 3) NULL,
	[WO$IDT_invoice_discount_amount_taken] [numeric](15, 2) NULL,
	[WO$DTD_discount_taken_to_date] [numeric](15, 2) NULL,
	[WO$SDA_sales_plan_discount_amount] [numeric](15, 2) NULL,
	[WO$SDP_sales_plan_discount_pct] [numeric](15, 3) NULL,
	[WO$PDI_promotion_dollar_incentive] [numeric](15, 2) NULL,
	[WO$CVA_convention_discount_amount] [numeric](15, 2) NULL,
	[WOAC01_customer_profession] [char](3) NULL,
	[WOAC02_customer_sub_profession] [char](3) NULL,
	[WOAC03_type_of_paying_customer] [char](3) NULL,
	[WOAC04_practice_type] [char](3) NULL,
	[WOAC05_category_code_address_05] [char](3) NULL,
	[WOAC06_category_code_address_06] [char](3) NULL,
	[WOAC07_category_code_address_07] [char](3) NULL,
	[WOAC08_market_segment] [char](3) NULL,
	[WOAC09_reserved_hsi_interface_reporting_req] [char](3) NULL,
	[WOAC10_category_code_10] [char](3) NULL,
	[WOAC11_return_rate_of_customer] [char](3) NULL,
	[WOAC12_regency_frequency_monetery] [char](3) NULL,
	[WOAC13_foreign_domestic_code] [char](3) NULL,
	[WOAC14_foreign_country_code] [char](3) NULL,
	[WOAC15_category_code_15] [char](3) NULL,
	[WOAC16_category_code_16] [char](3) NULL,
	[WOAC17_category_code_17] [char](3) NULL,
	[WOAC18_category_code_18] [char](3) NULL,
	[WOAC19_category_code_19] [char](3) NULL,
	[WOAC20_category_code_20] [char](3) NULL,
	[WOAC21_category_code_21] [char](3) NULL,
	[WOAC22_category_code_22] [char](3) NULL,
	[WOAC23_category_code_23] [char](3) NULL,
	[WOAC24_category_code_24] [char](3) NULL,
	[WOAC25_category_code_25] [char](3) NULL,
	[WOAC26_category_code_26] [char](3) NULL,
	[WOAC27_area] [char](3) NULL,
	[WOAC28_category_code_28] [char](3) NULL,
	[WOAC29_category_code_29] [char](3) NULL,
	[WOAC30_category_code_30] [char](3) NULL,
	[WOPRGP_pricing_group] [char](8) NULL,
	[WOTXCT_certificate] [char](20) NULL,
	[WOFUF2_post_quantities] [char](1) NULL,
	[WOOTOT_order_gross_amount] [numeric](15, 2) NULL,
	[WOTOTC_total_cost] [numeric](15, 2) NULL,
	[WOSBLI_subledger_inactive_code] [char](1) NULL,
	[WOFAP__foreign_open_amount] [numeric](15, 2) NULL,
	[WOFCST_foreign_total_cost] [numeric](15, 2) NULL,
	[WOORBY_ordered_by] [char](10) NULL,
	[WOTKBY_order_taken_by] [char](10) NULL
) ON [USERDATA]
GO


BEGIN TRANSACTION
GO
ALTER TABLE Integration.F55520_daily_sales_order_header_detail_workfile ADD CONSTRAINT
	PK_F55520_daily_sales_order_header_detail_workfile PRIMARY KEY CLUSTERED 
	(
	WODOCO_salesorder_number,
	WODCTO_order_type,
	WOLNID_line_number
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE Integration.F55520_daily_sales_order_header_detail_workfile SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--

BEGIN TRANSACTION
GO
ALTER TABLE Integration.F55520_daily_sales_order_header_detail_workfile ADD
	ID_source_ref int NULL
GO
ALTER TABLE Integration.F55520_daily_sales_order_header_detail_workfile ADD CONSTRAINT
	FK_F55520_daily_sales_order_header_detail_workfile_BRS_Transaction FOREIGN KEY
	(
	ID_source_ref
	) REFERENCES dbo.BRS_Transaction
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE Integration.F55520_daily_sales_order_header_detail_workfile SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


BEGIN TRANSACTION
GO
ALTER TABLE Integration.F55520_daily_sales_order_header_detail_workfile ADD
	ID_source_dw_ref int NULL
GO
ALTER TABLE Integration.F55520_daily_sales_order_header_detail_workfile ADD CONSTRAINT
	FK_F55520_daily_sales_order_header_detail_workfile_BRS_TransactionDW FOREIGN KEY
	(
	ID_source_dw_ref
	) REFERENCES dbo.BRS_TransactionDW
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE Integration.F55520_daily_sales_order_header_detail_workfile SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


--

select count (*) from Integration.F55520_daily_sales_order_header_detail_workfile
-- 113774

-- Create new namespace for daily sales (DS)

select  distinct WODOCO_salesorder_number, WODCTO_order_type from Integration.F55520_daily_sales_order_header_detail_workfile where WODCTO_order_type in ('SO', 'SE')


-- Territory FSC

--------------------------------------------------------------------------------
-- DROP TABLE Integration.F5554_territory_description
--------------------------------------------------------------------------------

SELECT 

--    Top 5 
	"GECO" AS GECO___company
	,"GE$GTY" AS GE$GTY_group_type
	,"GE$VNO" AS GE$VNO_number_version
	,"GE$LID" AS GE$LID_level_id
	,"GE$L01" AS GE$L01_level_code_01
	,"GEDSC1" AS GEDSC1_description
	,"GETKBY" AS GETKBY_order_taken_by
	,"GEUSER" AS GEUSER_user_id
	,"GEPID" AS GEPID__program_id
	,"GEJOBN" AS GEJOBN_work_station_id
	,"GEUPMJ" AS GEUPMJ_date_updated
	,"GEUPMT" AS GEUPMT_time_last_updated 

 INTO Integration.F5554_territory_description

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		GECO
	,GE$GTY
	,GE$VNO
	,GE$LID
	,GE$L01
	,GEDSC1
	,GETKBY
	,GEUSER
	,GEPID
	,GEJOBN
	,CASE WHEN GEUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(GEUPMJ+ 1900000,7,0))) ELSE NULL END AS GEUPMJ
	,GEUPMT

	FROM
		ARCPDTA71.F5554
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------
-- DROP TABLE Integration.F55510_territory_master
--------------------------------------------------------------------------------

SELECT 

--    Top 5 
		"WRCO" AS WRCO___company
		,"WR$GTC" AS WR$GTC_group_type_category
		,"WR$GTY" AS WR$GTY_group_type
		,"WR$VNO" AS WR$VNO_number_version
		,"WR$SLO" AS WR$SLO_sales_organization
		,"WRAC10" AS WRAC10_division_code
		,"WR$TER" AS WR$TER_territory_code
		,"WR$L01" AS WR$L01_level_code_01
		,"WR$L02" AS WR$L02_level_code_02
		,"WR$L03" AS WR$L03_level_code_03
		,"WR$L04" AS WR$L04_level_code_04
		,"WR$L05" AS WR$L05_level_code_05
		,"WR$L06" AS WR$L06_level_code_06
		,"WR$L07" AS WR$L07_level_code_07
		,"WR$L08" AS WR$L08_level_code_08
		,"WR$L09" AS WR$L09_level_code_09
		,"WR$L10" AS WR$L10_level_code_10
		,"WR$K01" AS WR$K01_level_id01
		,"WR$K02" AS WR$K02_level_id02
		,"WR$K03" AS WR$K03_level_id03
		,"WR$K04" AS WR$K04_level_id04
		,"WR$K05" AS WR$K05_level_id05
		,"WR$K06" AS WR$K06_level_id06
		,"WR$K07" AS WR$K07_level_id07
		,"WR$K08" AS WR$K08_level_id08
		,"WR$K09" AS WR$K09_level_id09
		,"WR$K10" AS WR$K10_level_id10
		,"WRTKBY" AS WRTKBY_order_taken_by
		,"WR$CGN" AS WR$CGN_customer_group
		,"WR$CLS" AS WR$CLS_classification_code
		,"WRAN8" AS WRAN8__billto
		,"WRSHAN" AS WRSHAN_shipto
		,"WRNAME" AS WRNAME_name
		,"WREFFF" AS WREFFF_effective_from_date
		,"WREFFT" AS WREFFT_effective_thru_date
		,"WRUSER" AS WRUSER_user_id
		,"WRPID" AS WRPID__program_id
		,"WRJOBN" AS WRJOBN_work_station_id
		,"WRUPMJ" AS WRUPMJ_date_updated
		,"WRUPMT" AS WRUPMT_time_last_updated 

 INTO Integration.F55510_territory_master

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		WRCO
		,WR$GTC
		,WR$GTY
		,WR$VNO
		,WR$SLO
		,WRAC10
		,WR$TER
		,WR$L01
		,WR$L02
		,WR$L03
		,WR$L04
		,WR$L05
		,WR$L06
		,WR$L07
		,WR$L08
		,WR$L09
		,WR$L10
		,WR$K01
		,WR$K02
		,WR$K03
		,WR$K04
		,WR$K05
		,WR$K06
		,WR$K07
		,WR$K08
		,WR$K09
		,WR$K10
		,WRTKBY
		,WR$CGN
		,WR$CLS
		,WRAN8
		,WRSHAN
		,WRNAME
		,CASE WHEN WREFFF IS NOT NULL THEN DATE(DIGITS(DEC(WREFFF+ 1900000,7,0))) ELSE NULL END AS WREFFF
		,CASE WHEN WREFFT IS NOT NULL THEN DATE(DIGITS(DEC(WREFFT+ 1900000,7,0))) ELSE NULL END AS WREFFT
		,WRUSER
		,WRPID
		,WRJOBN
		,CASE WHEN WRUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(WRUPMJ+ 1900000,7,0))) ELSE NULL END AS WRUPMJ
		,WRUPMT

	FROM
		ARCPDTA71.F55510
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

-- 249 632 @ 2m50s

--------------------------------------------------------------------------------
-- FSC Terr test (w/f Kevin R to run A_TERR_BLD

SELECT top 10        WRCO___company, WR$GTC_group_type_category, WR$GTY_group_type, WR$VNO_number_version, WR$SLO_sales_organization, WRAC10_division_code, WR$TER_territory_code, WR$L01_level_code_01, 
                         WR$L02_level_code_02, WR$L03_level_code_03, WR$L04_level_code_04, WR$L05_level_code_05, WR$L06_level_code_06, WR$L07_level_code_07, WR$L08_level_code_08, WR$L09_level_code_09, 
                         WR$L10_level_code_10, WR$K01_level_id01, WR$K02_level_id02, WR$K03_level_id03, WR$K04_level_id04, WR$K05_level_id05, WR$K06_level_id06, WR$K07_level_id07, WR$K08_level_id08, WR$K09_level_id09, 
                         WR$K10_level_id10, WRTKBY_order_taken_by, WR$CGN_customer_group, WR$CLS_classification_code, WRAN8__billto, WRSHAN_shipto, WRNAME_name, WREFFF_effective_from_date, WREFFT_effective_thru_date, 
                         WRUSER_user_id, WRPID__program_id, WRJOBN_work_station_id, WRUPMJ_date_updated, WRUPMT_time_last_updated
FROM            Integration.F55510_territory_master
where 
WR$GTY_group_type = 'AAFS' and  
--WRSHAN_shipto=2292385 and
(1=1)
order by  WREFFF_effective_from_date desc
--order by  WRUPMT_time_last_updated desc
GO


/*
		TABLE_SCHEMA = ''ARCPDTA71'' AND
		TABLE_NAME in(''F5554'', ''F55510'') AND
*/

-- arcPDTA71/F55341T, arcPDTA71/F5602



-- build up the field list correcly using python...

-- drop table Integration.F55341T_customer_master
 SELECT 
--    Top 5 
*
 INTO Integration.F55341T_customer_master

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
*	FROM
		ARCPDTA71.F55341T
--    WHERE
--        SHIP_TO = 4230226
--    ORDER BY
--        <insert custom code here>
')

select top 10 count (*) from Integration.F55341T_customer_master group by SHIP_TO order by 1 desc

select top 10 * from Integration.F55341T_customer_master where SHIP_TO = 4230226

BEGIN TRANSACTION
GO
ALTER TABLE Integration.F55341T_customer_master ADD CONSTRAINT
	F55341T_customer_master_c_pk PRIMARY KEY CLUSTERED 
	(
	SHIP_TO
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE Integration.F55341T_customer_master SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

/*
--update vpa, one-off

SELECT
	s.SHIP_TO
	,s.address_Number
	,s.SPECIALTY_CODE
	,s.SLS_PLAN
	,s.SLS_PLN_ENROLL_DTE
	,s.SLS_PLN_EXPIRE_DTE
	,s.DIVISION

	,d.BillTo
	,d.Specialty

	,d.VPA
	,d.SalesDivision,d.PracticeName

FROM            Integration.F55341T_customer_master AS s INNER JOIN
                         BRSales.dbo.BRS_Customer AS d ON s.SHIP_TO = d.ShipTo
where 
(d.SalesDivision<>'AZA') and
(s.division <> 'DSL') and
(s.SLS_PLAN not in ('DFTALC', 'DFTAIN')) AND

--(s.SLS_PLAN <> d.VPA) and
(s.division <> d.SalesDivision) and
 (1=1)
GO


SELECT
	distinct s.SLS_PLAN, s.ship_to

FROM            Integration.F55341T_customer_master AS s INNER JOIN
                         BRSales.dbo.BRS_Customer AS d ON s.SHIP_TO = d.ShipTo
where 
(d.SalesDivision<>'AZA') and
(s.division <> 'DSL') and
(s.SLS_PLAN not in ('DFTALC', 'DFTAIN')) AND
--(s.SLS_PLAN in ('RIDCOMSV',  'ROSHARM',   'VYASELDI',  'WRHA')) and
--(s.SPECIALTY_CODE <> d.Specialty) and

--(s.SLS_PLAN <> d.VPA) and

--(s.division <> d.SalesDivision) and
-- (d.vpa <> '0')
not exists(select * from BRSales.dbo.BRS_CustomerVPA where s.SLS_PLAN = vpa) AND
 (1=1)
 order by 1

GO


-- backup 
SELECT        ShipTo, VPA, SalesDivision
INTO              BRS_Customer_20231128
FROM            BRSales.dbo.BRS_Customer


-- update div
UPDATE       BRSales.dbo.BRS_Customer
SET
VPA = s.SLS_PLAN
FROM
DEV_BRSales.Integration.F55341T_customer_master AS s 
INNER JOIN dbo.BRS_Customer 
ON s.SHIP_TO = dbo.BRS_Customer.ShipTo 

WHERE
(BRS_Customer.SalesDivision <> 'AZA') AND 
(s.DIVISION <> 'DSL') AND 
(s.SLS_PLAN NOT IN ('DFTALC', 'DFTAIN')) AND
(s.SLS_PLAN <> dbo.BRS_Customer.VPA) and
--(s.DIVISION <> BRSales.dbo.BRS_Customer.SalesDivision) AND
(1 = 1)

-- Terr (view)
SELECT 
    Top 5 
	*
FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		WRCO
		,WR$GTC
		,WR$GTY
		,WR$VNO
		,WR$SLO
		,WRAC10
		,WR$TER
		,WR$L01
		,WR$L02
		,WR$L03
		,WR$L04
		,WR$L05
		,WR$L06
		,WR$K01
		,WR$K02
		,WR$K03
		,WR$K04
		,WR$K05
		,WR$K06
		,WRTKBY
		,WR$CGN
		,WR$CLS
		,WRAN8
		,WRSHAN
		,WRNAME
		,WREFFF
		,WREFFT
		,WRUSER
		,WRPID
		,WRJOBN
		,WRUPMJ
		,WRUPMT


	FROM
		ARCPDTA71.F55510
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')
*/

/*order by  WRUPMT_time_last_updated desc*/
SELECT
TOP (10) 
s.WRCO___company
,s.WRSHAN_shipto
,s.WR$TER_territory_code
,d.TerritoryCd
,d.TsTerritoryCd

,s.WR$GTC_group_type_category
,s.WR$GTY_group_type
,s.WRAC10_division_code
,s.WR$L01_level_code_01
,s.WR$L02_level_code_02
,
s.WR$L03_level_code_03
,s.WR$L04_level_code_04
,s.WR$K10_level_id10
,s.WRTKBY_order_taken_by
,s.WR$CGN_customer_group
,s.WRNAME_name
,s.WREFFF_effective_from_date
,s.WREFFT_effective_thru_date
FROM            Integration.F55510_territory_master AS s INNER JOIN
                         BRSales.dbo.BRS_Customer AS d ON s.WRSHAN_shipto = d.ShipTo
WHERE        (s.WR$GTY_group_type = 'DDTS') AND 
--(s.WRSHAN_shipto = 2292385) AND 
--(s.WR$TER_territory_code='') And
(s.WR$TER_territory_code<>d.TsTerritoryCd) And
(1 = 1)
ORDER BY 
s.WREFFF_effective_from_date DESC
GO


-- update FSC
UPDATE
	BRSales.dbo.BRS_Customer
SET
	TerritoryCd = s.WR$TER_territory_code
FROM
	Integration.F55510_territory_master AS s 
	INNER JOIN BRSales.dbo.BRS_Customer ON 
	s.WRSHAN_shipto = BRSales.dbo.BRS_Customer.ShipTo AND 
	s.WR$TER_territory_code <> BRSales.dbo.BRS_Customer.TerritoryCd
WHERE
	(s.WR$GTY_group_type = 'AAFS') AND 
	(TerritoryCd <> s.WR$TER_territory_code) AND
	(1 = 1)
GO


-- update ISR
UPDATE
	BRSales.dbo.BRS_Customer
SET
	TsTerritoryCd = s.WR$TER_territory_code
FROM
	Integration.F55510_territory_master AS s 
	INNER JOIN BRSales.dbo.BRS_Customer ON 
	s.WRSHAN_shipto = BRSales.dbo.BRS_Customer.ShipTo AND 
	s.WR$TER_territory_code <> BRSales.dbo.BRS_Customer.TerritoryCd
WHERE
	(s.WR$GTY_group_type = 'DDTS') AND 
	(TsTerritoryCd <> s.WR$TER_territory_code) AND
	(1 = 1)
GO


-- upate customer

SELECT        top 10 *
FROM            Integration.F55341T_customer_master 


SELECT        top 10 s.SHIP_TO, s.PARENT_NUMBER, d.BillTo, s.ADDRESS_NUMBER
FROM            Integration.F55341T_customer_master AS s INNER JOIN
                         BRS_Customer AS d ON s.SHIP_TO = d.ShipTo


-- truncate table BRSAles.[dbo].[STAGE_BRS_CustomerFull]

-- customer
INSERT INTO BRSAles.[dbo].[STAGE_BRS_CustomerFull]
(
	[ShipToID]
	,[ShipTo]
	,[BillToID]
	,[BillTo]
	,[PracticeName]
	,[MailingName]
	,[AddressLine1]
	,[AddressLine3]
	,[AddressLine4]
	,[City]
	,[Province]
	,[Country]
	,[PostalCode]
	,[PhoneNo]
	,[AccountType]
	,[TerritoryCd]
	,[VPA]
	,[DateAccountOpened]
	,[Specialty]
	,[PracticeType]
	,[SalesDivision]
	,[DentalGeoBranch]
	,[FlyerMailOutFlag]
	,[SpecialHandlingInstCd]
	,[ParentCustomerNumberID]
	,[ParentCustomerNumber]
	,[TsTerritoryCd]
	,[EstTerritoryCd]
	,[PrivilegesCode]
	,[ApplyFreightInd]
	,[ApplySmallOrderChargesInd]
)
SELECT
--top 10
0	 AS CUID
,SHIP_TO	 AS ADNOID
,0	 AS BTCUID
,SUBSTRING (ADDRESS_NUMBER,2,255) AS BTADNO
,SHIP_TO_NAME	 AS CUPRNA
,SHIP_TO_NAME	 AS CUMLNA
,ADDR_1	 AS ADLN1TT
,ADDR_3	 AS ADLN3TT
,ADDR_4	 AS ADLN4TT
,CITY	 AS CINA
,STATE	 AS STATECDID
,COUNTRY	 AS CNCDID
,'.'	 AS POCD
,PHONE	 AS TCPHNO
,'.'	 AS ACTYCDID
,'.'	 AS FLD_TERTRY_CD
,SLS_PLAN	 AS SPCDID
, '' AS CUACOPDT
,SPECIALTY_CODE	 AS SPCCDID
,'.'	 AS PRTYCDID
,DIVISION	 AS SDCDID
,'.'	 AS ZIPCNTRCD
,'N'	 AS MLAPRCD
,'.'	 AS SPHDCDID
,0	 AS PACUID
,SUBSTRING(PARENT_NUMBER,2,255)	 AS PACUADNOID
,'.'	 AS TLE_TERTRY_CD
,'.'	 AS MLSPCCD
,'.'	 AS PVCD
,APPLY_FREIGHT	 AS CUAPFRIN
,APPLD_HANDLNG_FLG	 AS APSMORCHIN
FROM
Integration.F55341T_customer_master 


--

-- update FSC
UPDATE
	BRSAles.[dbo].[STAGE_BRS_CustomerFull]
SET
	TerritoryCd = s.WR$TER_territory_code
FROM
	Integration.F55510_territory_master AS s 
	INNER JOIN BRSAles.[dbo].[STAGE_BRS_CustomerFull] ON 
	s.WRSHAN_shipto = ShipTo 
WHERE
	(s.WR$GTY_group_type = 'AAFS') AND 
	(TerritoryCd <> s.WR$TER_territory_code) AND
	(1 = 1)
GO


-- update ISR
UPDATE
	BRSAles.[dbo].[STAGE_BRS_CustomerFull]
SET
	TsTerritoryCd = s.WR$TER_territory_code
FROM
	Integration.F55510_territory_master AS s 
	INNER JOIN BRSAles.[dbo].[STAGE_BRS_CustomerFull] ON 
	s.WRSHAN_shipto = ShipTo 
WHERE
	(s.WR$GTY_group_type = 'DDTS') AND 
	(TsTerritoryCd <> s.WR$TER_territory_code) AND
	(1 = 1)
GO


-- update defaults (do not replace good data with nothing on ETL)
UPDATE
	BRSAles.[dbo].[STAGE_BRS_CustomerFull]
SET

AccountType = s.AccountType
,DateAccountOpened = s.DateAccountOpened
,FlyerMailOutFlag = s.FlyerMailOutFlag
,EstTerritoryCd = s.[est_code]
,PostalCode = s.PostalCode
,PracticeType = s.PracticeType
,PrivilegesCode = s.PrivilegesCode
,SpecialHandlingInstCd = s.SpecialHandlingInstCd
,DentalGeoBranch = s.DentalGeoBranch

FROM
	[dbo].[BRS_Customer] AS s 
	INNER JOIN BRSAles.[dbo].[STAGE_BRS_CustomerFull] ON 
	s.shipto = BRSAles.[dbo].[STAGE_BRS_CustomerFull].ShipTo 
GO

-- set DB to prod

select 
distinct DateAccountOpened 
From
	[STAGE_BRS_CustomerFull]
order by 1


select * from BRSAles.[dbo].[STAGE_BRS_CustomerFull]

INSERT INTO [dbo].[BRS_CustomerSpecialty]
(specialty)
select distinct [Specialty] from [STAGE_BRS_CustomerFull] where not exists (select * from [dbo].[BRS_CustomerSpecialty] where [dbo].[BRS_CustomerSpecialty].Specialty= [STAGE_BRS_CustomerFull].Specialty)

INSERT INTO [dbo].[BRS_SalesDivision]
(SalesDivision, SalesDivisionDesc)
select distinct SalesDivision, '.' from [STAGE_BRS_CustomerFull] where not exists (select * from [dbo].[BRS_SalesDivision] where [dbo].[BRS_SalesDivision].SalesDivision = [STAGE_BRS_CustomerFull].SalesDivision)


-- dev
EXECUTE [dbo].[BRS_BE_Dimension_load_proc] 
   @bClearStage=0
  ,@bDebug=1
GO

-- prod
EXECUTE [dbo].[BRS_BE_Dimension_load_proc] 
   @bClearStage=0
  ,@bDebug=0
GO


-- update SM
EXECUTE [dbo].[BRS_BE_Transaction_post_proc] 
   @bDebug=0

/*
-- fix st & item
insert into BRS_Customer
(shipto)
select distinct [shipto] from[Integration].[open_order_opordrpt] s where not exists (select * from BRS_Customer where s.shipto = shipto)


insert into BRS_item
(item)
select distinct [item] from[Integration].[open_order_opordrpt] s where not exists (select * from BRS_Item where s.Item = Item)


-- fix st & item

insert into BRS_Customer
(shipto)
select distinct [shipto] from [Integration].[open_order_prorepr] s where not exists (select * from BRS_Customer where s.shipto = shipto)


-- test

insert into BRS_Customer
(shipto)
select distinct [shipto] from[Integration].[open_order_opordrpt] s where not exists (select * from BRS_Customer where s.shipto = shipto)


insert into BRS_item
(item)
select distinct [item] from[Integration].[open_order_opordrpt] s where not exists (select * from BRS_Item where s.Item = Item)


insert into [BRS_FSC_Rollup]
([TerritoryCd], Branch)
select distinct [fsc_code], '' from[Integration].[open_order_opordrpt] s where not exists (select * from [dbo].[BRS_FSC_Rollup] where s.[fsc_code] = [TerritoryCd])
union
select distinct [ess_code], '' from[Integration].[open_order_opordrpt] s where not exists (select * from [dbo].[BRS_FSC_Rollup] where s.[ess_code] = [TerritoryCd])
union
select distinct [dts_code], '' from[Integration].[open_order_opordrpt] s where not exists (select * from [dbo].[BRS_FSC_Rollup] where s.[dts_code] = [TerritoryCd])
union
select distinct [cps_code], '' from[Integration].[open_order_opordrpt] s where not exists (select * from [dbo].[BRS_FSC_Rollup] where s.[cps_code] = [TerritoryCd])



-- fix st & item

insert into BRS_Customer
(shipto)
select distinct [shipto] from [Integration].[open_order_prorepr] s where not exists (select * from BRS_Customer where s.shipto = shipto)

EXECUTE [ds].[jde_transaction_extract_proc] @bDebug=0
EXECUTE [ds].[jde_transaction_update_legacy_proc]  @bDebug=0

select 60 * 7

*/