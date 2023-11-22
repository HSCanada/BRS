-- DS patch process, tmc 17 Nov 23


-- JDE pull from Kurt
--

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


-- LEFT([WO$SPM_secondary_promotion_code],2)

-- ExtChargebackAmt = (WO$CBA_chargeback_amount * [ShippedQty])
-- line tyupe

-- truncate TABLE Integration.F55520_daily_sales_order_header_detail_workfile

INSERT INTO Integration.F55520_daily_sales_order_header_detail_workfile
(
WODOCO_salesorder_number
,WODCTO_order_type
,WOKCOO_order_number_document_company
,WOLNID_line_number
,WODMCT_contract_number
,WOSHAN_shipto
,WOTRDJ_order_date
,WODGL__gl_date
,WOLITM_item_number
,WOLNTY_line_type
,WOUORG_quantity
,WO$CBA_chargeback_amount
,WO$LDC_landed_cost
,WO$FCS_file_cost
,WOSRP6_manufacturer
,WO$SPM_secondary_promotion_code
,WOORBY_ordered_by
,WOTKBY_order_taken_by 
)

SELECT 
--    Top 100

    "WODOCO" AS WODOCO_salesorder_number
	, "WODCTO" AS WODCTO_order_type
	, "WOKCOO" AS WOKCOO_order_number_document_company
	, "WOLNID" AS WOLNID_line_number
	, "WODMCT" AS WODMCT_contract_number
	, "WOSHAN" AS WOSHAN_shipto
	, "WOTRDJ" AS WOTRDJ_order_date
	, "WODGL" AS WODGL__gl_date
	, "WOLITM" AS WOLITM_item_number
	, "WOLNTY" AS WOLNTY_line_type
	, "WOUORG" AS WOUORG_quantity
	, "WO$CBA" AS WO$CBA_chargeback_amount
	, "WO$LDC" AS WO$LDC_landed_cost
	, "WO$FCS" AS WO$FCS_file_cost
	, "WOSRP6" AS WOSRP6_manufacturer
	, "WO$SPM" AS WO$SPM_secondary_promotion_code
	, "WOORBY" AS WOORBY_ordered_by
	, "WOTKBY" AS WOTKBY_order_taken_by 

-- INTO Integration.F55520_daily_sales_order_header_detail_workfile

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		WODOCO
		,WODCTO
		,WOKCOO
		,CAST((WOLNID)/1000.0 AS DEC(15,3)) AS WOLNID
		,WODMCT
		,WOSHAN
		,CASE WHEN WOTRDJ IS NOT NULL THEN DATE(DIGITS(DEC(WOTRDJ+ 1900000,7,0))) ELSE NULL END AS WOTRDJ
		,CASE WHEN WODGL IS NOT NULL THEN DATE(DIGITS(DEC(WODGL+ 1900000,7,0))) ELSE NULL END AS WODGL
		,WOLITM
		,WOLNTY
		,WOUORG
		,CAST((WO$CBA)/100.0 AS DEC(15,2)) AS WO$CBA
		,CAST((WO$LDC)/100.0 AS DEC(15,2)) AS WO$LDC
		,CAST((WO$FCS)/100.0 AS DEC(15,2)) AS WO$FCS
		,WOSRP6
		,WO$SPM
		,WOORBY
		,WOTKBY

	FROM
		ARCPDTA71.F55520
    WHERE
--        DATE(DIGITS(DEC(WODGL+ 1900000,7,0))) = ''2023-11-13''
--      WODGL >= 123275
--		PROD 1 Nov 23 ***
--      WODGL >= 123303

--		PROD 1 Oct 23
      WODGL >= 123274
	  

--		PROD 6 Nov 23
--      WODGL >= 123314

		-- QA xxx
--        WODGL = 123234
	
--    ORDER BY
--        <insert custom code here>
')
GO

-- 283140 rows @ 2m
/*
-- join flat to DS
UPDATE
	Integration.F55520_daily_sales_order_header_detail_workfile
SET
	ID_source_ref = BRS_Transaction.ID
FROM
	Integration.F55520_daily_sales_order_header_detail_workfile 
	INNER JOIN BRS_Transaction 
	ON Integration.F55520_daily_sales_order_header_detail_workfile.WODOCO_salesorder_number = BRS_Transaction.SalesOrderNumberKEY AND 
		Integration.F55520_daily_sales_order_header_detail_workfile.WODCTO_order_type = BRS_Transaction.DocType AND 
		ROUND(Integration.F55520_daily_sales_order_header_detail_workfile.WOLNID_line_number * 1000, 0) = BRS_Transaction.LineNumber
	WHERE (BRS_Transaction.DocType <> 'AA')
GO

*/


----------------------------------------------------------------------------------------
-- chargeback
----------------------------------------------------------------------------------------


select distinct WODGL__gl_date from Integration.F55520_daily_sales_order_header_detail_workfile

select count(*) from Integration.F55520_daily_sales_order_header_detail_workfile
GO

-- rows 113774

SELECT
	d.SalesOrderNumber
	,d.DocType
	,d.LineNumber
	,d.SalesDate
	,s.WODGL__gl_date
	,s.ID_source_ref
	,d.Shipto
	,d.Item
	,s.WOLNTY_line_type
	,s.WOSHAN_shipto
	,s.WOLITM_item_number
	,d.OrderSourceCode
	,d.salesDate AS date_dest
	,s.WOUORG_quantity
	,d.ExtChargebackAmt
	,s.WO$CBA_chargeback_amount * s.WOUORG_quantity AS ext_cb_new
	,s.WO$CBA_chargeback_amount

FROM
	BRS_Transaction AS d 

	INNER JOIN Integration.F55520_daily_sales_order_header_detail_workfile AS s  

	ON d.[SalesOrderNumberKEY] = [WODOCO_salesorder_number] AND
		d.[DocType] = [WODCTO_order_type] AND
		d.[LineNumber] =  ROUND([WOLNID_line_number] * 1000, 0)

WHERE
	(d.FiscalMonth >= 202310) AND 
--	(d.SalesDate >== '2023-11-01') and
--	([WODOCO_salesorder_number] is not null) and
	-- DW CB
	(d.ExtChargebackAmt is null ) AND 
--	(d.ExtChargebackAmt is not null ) AND 

	(s.WO$CBA_chargeback_amount <> 0) And
--	(ABS(isnull(d.ExtChargebackAmt,0) - s.WO$CBA_chargeback_amount * s.WOUORG_quantity) > 0.01)  AND
	(1=1)
GO

-- 11 390 rows to change DEV
-- 13 238 rows to change Prod

--

UPDATE
	BRS_Transaction
SET
	ExtChargebackAmt = WO$CBA_chargeback_amount * WOUORG_quantity
FROM
	BRS_Transaction 
	
	INNER JOIN Integration.F55520_daily_sales_order_header_detail_workfile AS s 
	ON BRS_Transaction.SalesOrderNumberKEY = s.WODOCO_salesorder_number AND 
		BRS_Transaction.DocType = s.WODCTO_order_type AND 
		BRS_Transaction.LineNumber = ROUND(s.WOLNID_line_number * 1000, 0)
WHERE
	(BRS_Transaction.FiscalMonth >= 202311) AND 
--	(BRS_Transaction.SalesDate = '2023-08-22') AND 
	(ABS(ISNULL(BRS_Transaction.ExtChargebackAmt, 0) - s.WO$CBA_chargeback_amount * s.WOUORG_quantity) > 0.01) AND 
	(1 = 1)

-- 11 390 DEV
-- 13 238 PROD



----------------------------------------------------------------------------------------
-- Promo
----------------------------------------------------------------------------------------


-- find missing promos

SELECT         distinct [WO$SPM_secondary_promotion_code]
FROM            Integration.F55520_daily_sales_order_header_detail_workfile w 
where not exists (select * from BRS_Promotion p where w.[WO$SPM_secondary_promotion_code] = p.PromotionCode)


INSERT INTO BRS_Promotion
(PromotionCode)
SELECT         distinct left([WO$SPM_secondary_promotion_code],2)
FROM            Integration.F55520_daily_sales_order_header_detail_workfile w 
where 
	not exists (select * from BRS_Promotion p where w.[WO$SPM_secondary_promotion_code] = p.PromotionCode) and
	([WO$SPM_secondary_promotion_code] not in ('', 'FLE', 'MET'))

SELECT
	d.SalesOrderNumber
	,d.DocType
	,d.LineNumber
	,d.Date
	,s.WODGL__gl_date
	,d.Shipto
	,d.Item
	,s.WOLNTY_line_type
	,s.WOSHAN_shipto
	,s.WOLITM_item_number
	,d.OrderSourceCode
	,d.Date AS date_dest
	,s.WOUORG_quantity
	,s.WO$FCS_file_cost
	,d.GPAtFileCostAmt

	,d.OrderPromotionCode
	,s.[WO$SPM_secondary_promotion_code]

FROM
	BRS_TransactionDW AS d 

	INNER JOIN Integration.F55520_daily_sales_order_header_detail_workfile AS s  

	ON d.SalesOrderNumber = s.[WODOCO_salesorder_number] AND
		d.[DocType] = s.[WODCTO_order_type] AND
		d.[LineNumber] =  ROUND(s.[WOLNID_line_number] * 1000, 0)

WHERE
	(d.CalMonth >= 202310) AND 
--	(s.[WODOCO_salesorder_number] is null) and
--	(d.SalesDate >== '2023-11-01') and
--	([WODOCO_salesorder_number] is not null) and
	-- DW CB
	(d.OrderPromotionCode='') AND
	(d.OrderPromotionCode<>[WO$SPM_secondary_promotion_code]) AND
	(1=1)
GO


UPDATE
	BRS_TransactionDW
SET
	OrderPromotionCode = LEFT([WO$SPM_secondary_promotion_code],2)
FROM
	BRS_TransactionDW 
	
	INNER JOIN Integration.F55520_daily_sales_order_header_detail_workfile AS s 
	
	ON BRS_TransactionDW.SalesOrderNumber = s.WODOCO_salesorder_number AND 
	BRS_TransactionDW.DocType = s.WODCTO_order_type AND 
	BRS_TransactionDW.LineNumber = ROUND(s.WOLNID_line_number * 1000, 0) AND 
	BRS_TransactionDW.OrderPromotionCode <> s.WO$SPM_secondary_promotion_code
WHERE
	(BRS_TransactionDW.CalMonth >= 202310) AND 
	(BRS_TransactionDW.OrderPromotionCode = '') AND 
	([WO$SPM_secondary_promotion_code] not in ('', 'FLE', 'MET')) AND
	(1 = 1)
GO

----------------------------------------------------------------------------------------
-- Filecost
----------------------------------------------------------------------------------------

SELECT
	d.SalesOrderNumber
	,d.DocType
	,d.LineNumber
	,d.Date
	,s.WODGL__gl_date
	,d.Shipto
	,d.Item
	,s.WOLNTY_line_type
	,s.WOSHAN_shipto
	,s.WOLITM_item_number
	,d.OrderSourceCode
	,d.Date AS date_dest
	,d.NetSalesAmt
	,d.ShippedQty
	,s.WOUORG_quantity
	,(d.NetSalesAmt - (s.WO$FCS_file_cost * d.ShippedQty)) as gpfc_new
	,d.GPAtFileCostAmt
FROM
	BRS_TransactionDW AS d 

	INNER JOIN Integration.F55520_daily_sales_order_header_detail_workfile AS s  

	ON d.SalesOrderNumber = s.[WODOCO_salesorder_number] AND
		d.[DocType] = s.[WODCTO_order_type] AND
		d.[LineNumber] =  ROUND(s.[WOLNID_line_number] * 1000, 0)
WHERE
	(d.CalMonth >= 202310) AND 
	-- DW CB
	(GPAtFileCostAmt <> 0) and
	(abs((d.NetSalesAmt - (s.WO$FCS_file_cost * d.ShippedQty)) - d.GPAtFileCostAmt) >0.01) and
	(1=1)
GO


UPDATE
	BRS_TransactionDW
SET
	GPAtFileCostAmt = BRS_TransactionDW.NetSalesAmt - s.WO$FCS_file_cost * ShippedQty
FROM
	BRS_TransactionDW 

	INNER JOIN Integration.F55520_daily_sales_order_header_detail_workfile AS s 
ON BRS_TransactionDW.SalesOrderNumber = s.WODOCO_salesorder_number AND 
	BRS_TransactionDW.DocType = s.WODCTO_order_type AND 
	BRS_TransactionDW.LineNumber = ROUND(s.WOLNID_line_number * 1000, 0)
WHERE
	(BRS_TransactionDW.CalMonth >= 202310) AND 
	(BRS_TransactionDW.GPAtFileCostAmt = 0) AND 
	(ABS(BRS_TransactionDW.NetSalesAmt - s.WO$FCS_file_cost * ShippedQty - BRS_TransactionDW.GPAtFileCostAmt) > 0.01) AND 
	(1 = 1)
GO

-- File Cost (Matt), Customer VPA (Kelly)
