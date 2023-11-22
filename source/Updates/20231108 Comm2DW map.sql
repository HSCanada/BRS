
-- comm2DW map, tmc, 8 Nov 23

------------------------------------------>> Load starts here

truncate table [Integration].[F555115_commission_sales_extract_Staging]
GO

select count(*) from [Integration].[F555115_commission_sales_extract_Staging]
-- rows = 51738

-- clean up the non-ess codes (comm has extra compare with DW)
select distinct WSTKBY_order_taken_by
from 
[Integration].[F555115_commission_sales_extract_Staging]
where
left(WSTKBY_order_taken_by,3) not in ('CCS', 'DTS', 'ESS', 'PMT')

update [Integration].[F555115_commission_sales_extract_Staging]
set WSTKBY_order_taken_by = ''
where
left(WSTKBY_order_taken_by,3) not in ('CCS', 'DTS', 'ESS', 'PMT')
GO

-- DST

-- this maps commission STAGE to Datawarehouse STAGE so we can load if DW offline

-- truncate table STAGE_BRS_TransactionDW

select count(*) from STAGE_BRS_TransactionDW

insert into STAGE_BRS_TransactionDW
-- SELECT 
(
JDEORNO
,ORDOTYCD
,LNNO
,CMID
,PDDT
,ADNOID
,ITLONO
,ENBYNA
,ORTKBYID
,ORSCCD
,RF1TT
,PRMDCD
,SPCDID
,LNTY
,HSDCDID
,MJPRCLID
,CBCONTRNO
,GLBUNO
,ORFISHDT
,IVNO
,WJXBFS1
,WJXBFS2
,WJXBFS3
,WJXBFS4
,WJXBFS5
,WJXBFS6
,PCADLINO
,BTADNO
,ESSCD
,CCSCD
,ESTCD
,TSSCD
,CAGREPCD
,EQORDNO
,EQORDTYCD

-- manual add for NULL
,WJXBFS7
,WJXBFS8

,PMID
,OPMID
,OORNO
,OORTY
,OORLINO

)
-- FROM STAGE_BRS_TransactionDW

-- SRC
select 
-- top 10
WSDOCO_salesorder_number
,WSDCTO_order_type
,WSLNID_line_number
,Format(WSDGL__gl_date, 'yyyyMM') calmo
,WSDGL__gl_date
,WSSHAN_shipto
,LEFT(WSLITM_item_number,10) item
,WSENTB_entered_by
,WSTKBY_order_taken_by
,WS$OSC_order_source_code
,WSVR01_reference
,LEFT(WS$PMC_promotion_code_price_method,1) price_method
,WSASN__adjustment_schedule
,WSLNTY_line_type
,WSAC10_division_code
,WSSRP1_major_product_class
,'' cb_contract
,'' glbu
,WSTRDJ_order_date
,0 inv_num
,WSUORG_quantity
,0 gpamt
,0 gpfc
,ROUND((
				(t.WSAEXP_extended_price - t.WS$ODS_order_discount_amount) 
				- (t.WS$UNC_sales_order_cost_markup * t.WSSOQS_quantity_shipped)
			),2)	AS [gp_cc_amt]
,0 ext_cb
,ROUND((t.WSAEXP_extended_price - t.WS$ODS_order_discount_amount),2)
				AS [transaction_amt]
,'' price_adj_line
,0 so_billto
,LEFT(WSTKBY_order_taken_by,5) ess_code
,'' ccs_code
,0 est_code
,'' tss_code
,LEFT(WSCAG__cagess_code,5) pmts_code
,LEFT(WSORD__equipment_order,6) eq_order
,WSORDT_order_type eq_type

-- manual add for NULL
,0
,0

,0
,0
,0
,0
,0

from [Integration].[F555115_commission_sales_extract_Staging] t
GO


-- review stage
select top 10 * from STAGE_BRS_TransactionDW  order by PDDT desc
GO

--
select distinct [ITLONO] FROM STAGE_BRS_TransactionDW s
where not exists (select * from dbo.BRS_Item d where s.[ITLONO] = d.Item)
--

select max(id) from BRS_TransactionDW
-- LAST ID = 46841101

-- test for RI fails
Exec BRS_BE_Transaction_DW_load_proc @bClearStage=0, @bDebug=1
-- 268 698 rows in 56s

--  load prod from patched comm stage (reload Oct >  once back)
Exec BRS_BE_Transaction_DW_load_proc @bClearStage=0, @bDebug=0


-- review prod
select * from BRS_TransactionDW
where ID >46841101
GO


-- 380 test


-- JDE pull from Kurt

--------------------------------------------------------------------------------
-- DROP TABLE Integration.F55520_daily_sales_order_header_detail_workfile
--------------------------------------------------------------------------------

-- truncate table Integration.F55520_daily_sales_order_header_detail_workfile

select count(*) from Integration.F55520_daily_sales_order_header_detail_workfile

SELECT 
--    Top 10
    "WODOCO" AS WODOCO_salesorder_number
	, "WODCTO" AS WODCTO_order_type
	, "WOKCOO" AS WOKCOO_order_number_document_company
	, "WOLNID" AS WOLNID_line_number
	, "WOSFXO" AS WOSFXO_order_suffix
	, "WOMCU" AS WOMCU__business_unit
	, "WOCO" AS WOCO___company
	, "WOOKCO" AS WOOKCO_original_order_document_company
	, "WOOORN" AS WOOORN_original_order_number
	, "WOOCTO" AS WOOCTO_original_order_type
	, "WOOGNO" AS WOOGNO_original_line_number
	, "WORKCO" AS WORKCO_related_order_key_company
	, "WORORN" AS WORORN_related_posowo_number
	, "WORCTO" AS WORCTO_related_posowo_order_type
	, "WORLLN" AS WORLLN_related_poso_line_number
	, "WODMCT" AS WODMCT_contract_number
	, "WODMCS" AS WODMCS_contract_supplement
	, "WOBALU" AS WOBALU_contract_balances_updated_yn
	, "WOAN8" AS WOAN8__billto
	, "WOSHAN" AS WOSHAN_shipto
	, "WOPA8" AS WOPA8__parent_number

	, "WODRQJ" AS WODRQJ_requested
	, "WOTRDJ" AS WOTRDJ_order_date
	, "WOPDDJ" AS WOPDDJ_promised
	, "WOADDJ" AS WOADDJ_actual_ship
	, "WOIVD" AS WOIVD__invoice_date
	, "WOCNDJ" AS WOCNDJ_cancel_date
	, "WODGL" AS WODGL__gl_date
	, "WORSDJ" AS WORSDJ_promised_delivery
	, "WOPEFJ" AS WOPEFJ_price_effective
	, "WOPPDJ" AS WOPPDJ_future_use_1
	, "WOPSDJ" AS WOPSDJ_future_use_2

	, "WOVR01" AS WOVR01_reference
	, "WOVR02" AS WOVR02_reference_2
	, "WOITM" AS WOITM__item_number_short
	, "WOLITM" AS WOLITM_item_number
	, "WOAITM" AS WOAITM__3rd_item_number
	, "WOLOTN" AS WOLOTN_lot
	, "WOEXDP" AS WOEXDP_days_before_expiration
	, "WODSC1" AS WODSC1_description
	, "WODSC2" AS WODSC2_description_2
	, "WOLNTY" AS WOLNTY_line_type
	, "WONXTR" AS WONXTR_status_code_next
	, "WOLTTR" AS WOLTTR_status_code_last
	, "WOEMCU" AS WOEMCU_header_business_unit
	, "WORLIT" AS WORLIT_related_item_number_kit
	, "WOKTLN" AS WOKTLN_kit_master_line_number
	, "WOCPNT" AS WOCPNT_component_line_number
	, "WORKIT" AS WORKIT_related_kit_component
	, "WOKTP" AS WOKTP__number_of_component_per_parent
	, "WOSRP1" AS WOSRP1_major_product_class
	, "WOSRP2" AS WOSRP2_sub_major_product_class
	, "WOSRP3" AS WOSRP3_minor_product_class
	, "WOSRP4" AS WOSRP4_sub_minor_product_class
	, "WOSRP5" AS WOSRP5_hazardous_class
	, "WOPRP1" AS WOPRP1_commodity_class
	, "WOPRP2" AS WOPRP2_commodity_sub_class
	, "WOPRP3" AS WOPRP3_supplier_rebate_code
	, "WOPRP4" AS WOPRP4_tax_classification
	, "WOPRP5" AS WOPRP5_landed_cost_rule
	, "WOUOM" AS WOUOM__um
	, "WOUORG" AS WOUORG_quantity
	, "WOSOQS" AS WOSOQS_quantity_shipped
	, "WOSOBK" AS WOSOBK_quantity_backordered
	, "WOSOCN" AS WOSOCN_quantity_canceled
	, "WOSONE" AS WOSONE_future_quantity_committed
	, "WOUOPN" AS WOUOPN_quantity_open
	, "WOQTYT" AS WOQTYT_quantity_shipped_to_date
	, "WOQRLV" AS WOQRLV_quantity_relieved
	, "WOCOMM" AS WOCOMM_committed_hs
	, "WOOTQY" AS WOOTQY_other_quantity_12
	, "WOUPRC" AS WOUPRC_unit_price
	, "WOAEXP" AS WOAEXP_extended_price
	, "WOAOPN" AS WOAOPN_amount_open
	, "WOPROV" AS WOPROV_price_override_code
	, "WOTPC" AS WOTPC__temporary_price_yn
	, "WOAPUM" AS WOAPUM_entered_unit_of_measure_for_unit_price
	, "WOLPRC" AS WOLPRC_unit_list_price
	, "WOUNCS" AS WOUNCS_unit_cost
	, "WOECST" AS WOECST_extended_cost
	, "WOCSTO" AS WOCSTO_cost_override_code
	, "WOTCST" AS WOTCST_transfer_cost
	, "WOINMG" AS WOINMG_print_message
	, "WOPTC" AS WOPTC__payment_terms
	, "WORYIN" AS WORYIN_payment_instrument
	, "WODTBS" AS WODTBS_based_on_date
	, "WOTRDC" AS WOTRDC_trade_discount
	, "WOFUN2" AS WOFUN2_trade_discount_old
	, "WOASN" AS WOASN__adjustment_schedule
	, "WOPRGR" AS WOPRGR_item_price_group
	, "WOCLVL" AS WOCLVL_pricing_category_level
	, "WODSPR" AS WODSPR_discount_factor
	, "WODSFT" AS WODSFT_discount_factor_type_amt_orpct
	, "WOFAPP" AS WOFAPP_discount_application_type
	, "WOCADC" AS WOCADC_cash_discount_pct
	, "WOKCO" AS WOKCO__document_company
	, "WODOC" AS WODOC__document_number
	, "WODCT" AS WODCT__document_type
	, "WOODOC" AS WOODOC_original_document_no
	, "WOODCT" AS WOODCT_original_document_type
	, "WOOKC" AS WOOKC__original_document_company
	, "WOPSN" AS WOPSN__pick_slip_number
	, "WODELN" AS WODELN_delivery_number
	, "WOPRMO" AS WOPRMO_promotion_number
	, "WOTAX1" AS WOTAX1_sales_taxable
	, "WOTXA1" AS WOTXA1_tax_ratearea
	, "WOEXR1" AS WOEXR1_tax_expl_code
	, "WOPRIO" AS WOPRIO_priority_processing_code
	, "WORESL" AS WORESL_printed_code
	, "WOBACK" AS WOBACK_backorders_allowed_yn
	, "WOSBAL" AS WOSBAL_substitutes_allowed_yn
	, "WOAPTS" AS WOAPTS_partial_shipments_allowed_yn
	, "WOLOB" AS WOLOB__line_of_business
	, "WOEUSE" AS WOEUSE_end_use
	, "WODTYS" AS WODTYS_duty_status
	, "WOCDCD" AS WOCDCD_commodity_code
	, "WONTR" AS WONTR__nature_of_transaction
	, "WOVEND" AS WOVEND_primary_last_supplier_number
	, "WOANBY" AS WOANBY_buyer_number
	, "WOCARS" AS WOCARS_carrier_number
	, "WOMOT" AS WOMOT__mode_of_trn
	, "WOCOT" AS WOCOT__conditions_of_transport
	, "WOROUT" AS WOROUT_ship_method
	, "WOSTOP" AS WOSTOP_stop_code
	, "WOZON" AS WOZON__zone_number
	, "WOCNID" AS WOCNID_container_id
	, "WOFRTH" AS WOFRTH_freight_handling_code
	, "WOAFT" AS WOAFT__apply_freight_yn
	, "WOFRTC" AS WOFRTC_freight_calculated_yn
	, "WOFRAT" AS WOFRAT_rate_code_freightmisc
	, "WORATT" AS WORATT_rate_type_freightmisc
	, "WOSHCM" AS WOSHCM_shipping_commodity_class
	, "WOSHCN" AS WOSHCN_shipping_conditions_code
	, "WOSERN" AS WOSERN_lot_serial_number
	, "WOUOM1" AS WOUOM1_unit_of_measure
	, "WOPQOR" AS WOPQOR_quantity_ordered
	, "WOUOM2" AS WOUOM2_secondary_uom
	, "WOUOM4" AS WOUOM4_pricing_uom
	, "WOITWT" AS WOITWT_unit_weight
	, "WOWTUM" AS WOWTUM_weight_unit_of_measure
	, "WOITVL" AS WOITVL_unit_volume
	, "WOVLUM" AS WOVLUM_volume_unit_of_measure
	, "WORPRC" AS WORPRC_basket_reprice_group
	, "WOORPR" AS WOORPR_order_reprice_group
	, "WOORP" AS WOORP__order_repriced_indicator
	, "WOCMGP" AS WOCMGP_inventory_costing_method
	, "WOCMGL" AS WOCMGL_commitment_method
	, "WOGLC" AS WOGLC__gl_offset
	, "WOFY" AS WOFY___fiscal_year
	, "WOSTTS" AS WOSTTS_line_status
	, "WOSO01" AS WOSO01_inter_branch_sales
	, "WOSO04" AS WOSO04_sales_order_status_04
	, "WOSO05" AS WOSO05_substitute_item_indicator
	, "WOSO06" AS WOSO06_preference_commitment_indicator
	, "WOSO07" AS WOSO07_ship_date_overridden
	, "WOSO08" AS WOSO08_price_adjustment_line_indicator
	, "WOSO09" AS WOSO09_sales_order_status_09
	, "WOSO10" AS WOSO10_preference_product_allocation
	, "WOSO11" AS WOSO11_sales_order_status_11
	, "WOSO12" AS WOSO12_sales_order_status_12
	, "WOSO13" AS WOSO13_sales_order_status_13
	, "WOSO14" AS WOSO14_sales_order_status_14
	, "WOSO15" AS WOSO15_sales_order_status_15
	, "WOSLSM" AS WOSLSM_salesperson_code_01
	, "WOSLCM" AS WOSLCM_salesperson_commission_1
	, "WOSLM2" AS WOSLM2_salesperson_code_02
	, "WOSLC2" AS WOSLC2_salesperson_commission_2
	, "WOACOM" AS WOACOM_apply_commission_yn
	, "WOCMCG" AS WOCMCG_commission_category
	, "WORCD" AS WORCD__reason_code
	, "WOANI" AS WOANI__account_number
	, "WOAID" AS WOAID__account_id
	, "WOOMCU" AS WOOMCU_project_cost_center
	, "WOOBJ" AS WOOBJ__object_account
	, "WOSUB" AS WOSUB__subsidiary
	, "WOLT" AS WOLT___ledger_type
	, "WOSBL" AS WOSBL__subledger
	, "WOSBLT" AS WOSBLT_subledger_type
	, "WOLCOD" AS WOLCOD_loc_tax_code
	, "WOUPC1" AS WOUPC1_price_code_1
	, "WOUPC2" AS WOUPC2_price_code_2
	, "WOUPC3" AS WOUPC3_price_code_3
	, "WOCRMD" AS WOCRMD_send_method
	, "WOCRCD" AS WOCRCD_currency_code
	, "WOCRR" AS WOCRR__exchange_rate
	, "WOFPRC" AS WOFPRC_foreign_list_price
	, "WOFUP" AS WOFUP__foreign_unit_price
	, "WOFEA" AS WOFEA__foreign_extended_price
	, "WOFUC" AS WOFUC__foreign_unit_cost
	, "WOFEC" AS WOFEC__foreign_extended_cost
	, "WOURCD" AS WOURCD_user_reserved_code
	, "WOURDT" AS WOURDT_user_reserved_date
	, "WOURAT" AS WOURAT_user_reserved_amount
	, "WOURAB" AS WOURAB_user_reserved_number
	, "WOURRF" AS WOURRF_user_reserved_reference
	, "WOTORG" AS WOTORG_transaction_originator
	, "WO$TRT" AS WO$TRT_tax_rate
	, "WOSTAM" AS WOSTAM_tax
	, "WO$EFA" AS WO$EFA_estimated_freight_amount
	, "WO$AHC" AS WO$AHC_apply_hazardous_charges
	, "WO$AC2" AS WO$AC2_address_code_future_2
	, "WO$ODN" AS WO$ODN_other_document_number
	, "WO$ODT" AS WO$ODT_other_document_type
	, "WOCACT" AS WOCACT_creditbank_account_number
	, "WO$CCT" AS WO$CCT_credit_card_type
	, "WOCEXP" AS WOCEXP_expired_date_creditbank_acct
	, "WO$CBA" AS WO$CBA_chargeback_amount
	, "WO$NTC" AS WO$NTC_net_cost_chargebacks
	, "WO$LDC" AS WO$LDC_landed_cost
	, "WO$FCS" AS WO$FCS_file_cost
	, "WO$AGC" AS WO$AGC_average_cost
	, "WOENTB" AS WOENTB_entered_by
	, "WO$SPS" AS WO$SPS_sequence_number_ship
	, "WO$PRM" AS WO$PRM_promotion_code
	, "WO$UNC" AS WO$UNC_sales_order_cost_markup
	, "WOXRT" AS WOXRT__cross_reference_type_code
	, "WOCITM" AS WOCITM_customersupplier_item_number
	, "WO$AID" AS WO$AID_authorized_id
	, "WOOVPR" AS WOOVPR_override_price
	, "WO$OCR" AS WO$OCR_original_computer_resale
	, "WO$PMC" AS WO$PMC_promotion_code_price_method
	, "WO$LDP" AS WO$LDP_line_discount_pct
	, "WO$PPM" AS WO$PPM_price_promotion_code
	, "WO$VPM" AS WO$VPM_volume_promotion_code
	, "WO$US2" AS WO$US2_status_pricing_added_line
	, "WO$MSG" AS WO$MSG_message_code
	, "WOPRP6" AS WOPRP6_item_dimension_group
	, "WOPRP7" AS WOPRP7_warehouse_process_grp_1
	, "WOPRP8" AS WOPRP8_warehouse_process_grp_2
	, "WOPRP9" AS WOPRP9_warehouse_process_grp_3
	, "WOPRP0" AS WOPRP0_commodity_code
	, "WOSRP6" AS WOSRP6_manufacturer
	, "WOSRP7" AS WOSRP7_drug_class
	, "WOSRP8" AS WOSRP8_manuf_dspsearch
	, "WOSRP9" AS WOSRP9_category_code_9
	, "WOSRP0" AS WOSRP0_category_code_10
	, "WO$XRN" AS WO$XRN_cross_reference_number
	, "WO$AC1" AS WO$AC1_special_handling_code
	, "WO$OSC" AS WO$OSC_order_source_code
	, "WO$FA" AS WO$FA__total_amount_freight
	, "WO$ASC" AS WO$ASC_apply_small_order_charges
	, "WO$DEA" AS WO$DEA_dea_number
	, "WO$DEX" AS WO$DEX_dea_expiration_date
	, "WOSIC" AS WOSIC__speciality
	, "WO$PLN" AS WO$PLN_prof_lic
	, "WO$LEX" AS WO$LEX_license_expiration_date
	, "WO$DPC" AS WO$DPC_document_print_code
	, "WO$DC" AS WO$DC__primary_warehouse_override
	, "WO$DCO" AS WO$DCO_order_consolidation_warehouse
	, "WO$ACS" AS WO$ACS_accept_cross_shipments
	, "WO$A02" AS WO$A02_freight_charge_level
	, "WO$A03" AS WO$A03_carrier_override_code
	, "WO$SPM" AS WO$SPM_secondary_promotion_code
	, "WO$ODP" AS WO$ODP_order_discount_pct
	, "WO$IDT" AS WO$IDT_invoice_discount_amount_taken
	, "WO$DTD" AS WO$DTD_discount_taken_to_date
	, "WO$SDA" AS WO$SDA_sales_plan_discount_amount
	, "WO$SDP" AS WO$SDP_sales_plan_discount_pct
	, "WO$PDI" AS WO$PDI_promotion_dollar_incentive
	, "WO$CVA" AS WO$CVA_convention_discount_amount
	, "WOAC01" AS WOAC01_customer_profession
	, "WOAC02" AS WOAC02_customer_sub_profession
	, "WOAC03" AS WOAC03_type_of_paying_customer
	, "WOAC04" AS WOAC04_practice_type
	, "WOAC05" AS WOAC05_category_code_address_05
	, "WOAC06" AS WOAC06_category_code_address_06
	, "WOAC07" AS WOAC07_category_code_address_07
	, "WOAC08" AS WOAC08_market_segment
	, "WOAC09" AS WOAC09_reserved_hsi_interface_reporting_req
	, "WOAC10" AS WOAC10_category_code_10
	, "WOAC11" AS WOAC11_return_rate_of_customer
	, "WOAC12" AS WOAC12_regency_frequency_monetery
	, "WOAC13" AS WOAC13_foreign_domestic_code
	, "WOAC14" AS WOAC14_foreign_country_code
	, "WOAC15" AS WOAC15_category_code_15
	, "WOAC16" AS WOAC16_category_code_16
	, "WOAC17" AS WOAC17_category_code_17
	, "WOAC18" AS WOAC18_category_code_18
	, "WOAC19" AS WOAC19_category_code_19
	, "WOAC20" AS WOAC20_category_code_20
	, "WOAC21" AS WOAC21_category_code_21
	, "WOAC22" AS WOAC22_category_code_22
	, "WOAC23" AS WOAC23_category_code_23
	, "WOAC24" AS WOAC24_category_code_24
	, "WOAC25" AS WOAC25_category_code_25
	, "WOAC26" AS WOAC26_category_code_26
	, "WOAC27" AS WOAC27_area
	, "WOAC28" AS WOAC28_category_code_28
	, "WOAC29" AS WOAC29_category_code_29
	, "WOAC30" AS WOAC30_category_code_30
	, "WOPRGP" AS WOPRGP_pricing_group
	, "WOTXCT" AS WOTXCT_certificate
	, "WOFUF2" AS WOFUF2_post_quantities
	, "WOOTOT" AS WOOTOT_order_gross_amount
	, "WOTOTC" AS WOTOTC_total_cost
	, "WOSBLI" AS WOSBLI_subledger_inactive_code
	, "WOFAP" AS WOFAP__foreign_open_amount
	, "WOFCST" AS WOFCST_foreign_total_cost
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
	,WOSFXO
	,WOMCU
	,WOCO
	,WOOKCO
	,WOOORN
	,WOOCTO
	,CAST((WOOGNO)/1000.0 AS DEC(15,3)) AS WOOGNO
	,WORKCO
	,WORORN
	,WORCTO
	,CAST((WORLLN)/1000.0 AS DEC(15,3)) AS WORLLN
	,WODMCT
	,WODMCS
	,WOBALU
	,WOAN8
	,WOSHAN
	,WOPA8

	,WODRQJ
--	,CASE WHEN WODRQJ IS NOT NULL THEN DATE(DIGITS(DEC(WODRQJ+ 1900000,7,0))) ELSE NULL END AS WODRQJ

--	,WOTRDJ
	,CASE WHEN WOTRDJ IS NOT NULL THEN DATE(DIGITS(DEC(WOTRDJ+ 1900000,7,0))) ELSE NULL END AS WOTRDJ

	,WOPDDJ
--	,CASE WHEN WOPDDJ IS NOT NULL THEN DATE(DIGITS(DEC(WOPDDJ+ 1900000,7,0))) ELSE NULL END AS WOPDDJ

	,WOADDJ
--	,CASE WHEN WOADDJ IS NOT NULL THEN DATE(DIGITS(DEC(WOADDJ+ 1900000,7,0))) ELSE NULL END AS WOADDJ

	,WOIVD
--	,CASE WHEN WOIVD IS NOT NULL THEN DATE(DIGITS(DEC(WOIVD+ 1900000,7,0))) ELSE NULL END AS WOIVD

	,WOCNDJ
--	,CASE WHEN WOCNDJ IS NOT NULL THEN DATE(DIGITS(DEC(WOCNDJ+ 1900000,7,0))) ELSE NULL END AS WOCNDJ


	,CASE WHEN WODGL IS NOT NULL THEN DATE(DIGITS(DEC(WODGL+ 1900000,7,0))) ELSE NULL END AS WODGL

	,WORSDJ
--	,CASE WHEN WORSDJ IS NOT NULL THEN DATE(DIGITS(DEC(WORSDJ+ 1900000,7,0))) ELSE NULL END AS WORSDJ

	,WOPEFJ
--	,CASE WHEN WOPEFJ IS NOT NULL THEN DATE(DIGITS(DEC(WOPEFJ+ 1900000,7,0))) ELSE NULL END AS WOPEFJ

	,WOPPDJ
--	,CASE WHEN WOPPDJ IS NOT NULL THEN DATE(DIGITS(DEC(WOPPDJ+ 1900000,7,0))) ELSE NULL END AS WOPPDJ

	,WOPSDJ
--	,CASE WHEN WOPSDJ IS NOT NULL THEN DATE(DIGITS(DEC(WOPSDJ+ 1900000,7,0))) ELSE NULL END AS WOPSDJ

	,WOVR01
	,WOVR02
	,WOITM
	,WOLITM
	,WOAITM
	,WOLOTN
	,WOEXDP
	,WODSC1
	,WODSC2
	,WOLNTY
	,WONXTR
	,WOLTTR
	,WOEMCU
	,WORLIT
	,CAST((WOKTLN)/1000.0 AS DEC(15,3)) AS WOKTLN
	,CAST((WOCPNT)/10.0 AS DEC(15,1)) AS WOCPNT
	,WORKIT
	,WOKTP
	,WOSRP1
	,WOSRP2
	,WOSRP3
	,WOSRP4
	,WOSRP5
	,WOPRP1
	,WOPRP2
	,WOPRP3
	,WOPRP4
	,WOPRP5
	,WOUOM
	,WOUORG
	,WOSOQS
	,WOSOBK
	,WOSOCN
	,WOSONE
	,WOUOPN
	,WOQTYT
	,WOQRLV
	,WOCOMM
	,WOOTQY
	,CAST((WOUPRC)/10000.0 AS DEC(15,4)) AS WOUPRC
	,CAST((WOAEXP)/100.0 AS DEC(15,2)) AS WOAEXP
	,CAST((WOAOPN)/100.0 AS DEC(15,2)) AS WOAOPN
	,WOPROV
	,WOTPC
	,WOAPUM
	,CAST((WOLPRC)/10000.0 AS DEC(15,4)) AS WOLPRC
	,CAST((WOUNCS)/10000.0 AS DEC(15,4)) AS WOUNCS
	,CAST((WOECST)/100.0 AS DEC(15,2)) AS WOECST
	,WOCSTO
	,CAST((WOTCST)/10000.0 AS DEC(15,4)) AS WOTCST
	,WOINMG
	,WOPTC
	,WORYIN
	,WODTBS
	,CAST((WOTRDC)/1000.0 AS DEC(15,3)) AS WOTRDC
	,CAST((WOFUN2)/10000.0 AS DEC(15,4)) AS WOFUN2
	,WOASN
	,WOPRGR
	,WOCLVL
	,CAST((WODSPR)/10000.0 AS DEC(15,4)) AS WODSPR
	,WODSFT
	,WOFAPP
	,CAST((WOCADC)/1000.0 AS DEC(15,3)) AS WOCADC
	,WOKCO
	,WODOC
	,WODCT
	,WOODOC
	,WOODCT
	,WOOKC
	,WOPSN
	,WODELN
	,WOPRMO
	,WOTAX1
	,WOTXA1
	,WOEXR1
	,WOPRIO
	,WORESL
	,WOBACK
	,WOSBAL
	,WOAPTS
	,WOLOB
	,WOEUSE
	,WODTYS
	,WOCDCD
	,WONTR
	,WOVEND
	,WOANBY
	,WOCARS
	,WOMOT
	,WOCOT
	,WOROUT
	,WOSTOP
	,WOZON
	,WOCNID
	,WOFRTH
	,WOAFT
	,WOFRTC
	,WOFRAT
	,WORATT
	,WOSHCM
	,WOSHCN
	,WOSERN
	,WOUOM1
	,WOPQOR
	,WOUOM2
	,WOUOM4
	,CAST((WOITWT)/10000.0 AS DEC(15,4)) AS WOITWT
	,WOWTUM
	,CAST((WOITVL)/10000.0 AS DEC(15,4)) AS WOITVL
	,WOVLUM
	,WORPRC
	,WOORPR
	,WOORP
	,WOCMGP
	,WOCMGL
	,WOGLC
	,WOFY
	,WOSTTS
	,WOSO01
	,WOSO04
	,WOSO05
	,WOSO06
	,WOSO07
	,WOSO08
	,WOSO09
	,WOSO10
	,WOSO11
	,WOSO12
	,WOSO13
	,WOSO14
	,WOSO15
	,WOSLSM
	,CAST((WOSLCM)/1000.0 AS DEC(15,3)) AS WOSLCM
	,WOSLM2
	,CAST((WOSLC2)/1000.0 AS DEC(15,3)) AS WOSLC2
	,WOACOM
	,WOCMCG
	,WORCD
	,WOANI
	,WOAID
	,WOOMCU
	,WOOBJ
	,WOSUB
	,WOLT
	,WOSBL
	,WOSBLT
	,WOLCOD
	,WOUPC1
	,WOUPC2
	,WOUPC3
	,WOCRMD
	,WOCRCD
	,WOCRR
	,CAST((WOFPRC)/10000.0 AS DEC(15,4)) AS WOFPRC
	,CAST((WOFUP)/10000.0 AS DEC(15,4)) AS WOFUP
	,CAST((WOFEA)/100.0 AS DEC(15,2)) AS WOFEA
	,CAST((WOFUC)/10000.0 AS DEC(15,4)) AS WOFUC
	,CAST((WOFEC)/100.0 AS DEC(15,2)) AS WOFEC
	,WOURCD

	,WOURDT
--	,CASE WHEN WOURDT IS NOT NULL THEN DATE(DIGITS(DEC(WOURDT+ 1900000,7,0))) ELSE NULL END AS WOURDT

	,CAST((WOURAT)/100.0 AS DEC(15,2)) AS WOURAT
	,WOURAB
	,WOURRF
	,WOTORG
	,WO$TRT
	,CAST((WOSTAM)/100.0 AS DEC(15,2)) AS WOSTAM
	,CAST((WO$EFA)/100.0 AS DEC(15,2)) AS WO$EFA
	,WO$AHC
	,WO$AC2
	,WO$ODN
	,WO$ODT
	,WOCACT
	,WO$CCT

	,WOCEXP
--	,CASE WHEN WOCEXP IS NOT NULL THEN DATE(DIGITS(DEC(WOCEXP+ 1900000,7,0))) ELSE NULL END AS WOCEXP

	,CAST((WO$CBA)/100.0 AS DEC(15,2)) AS WO$CBA
	,CAST((WO$NTC)/100.0 AS DEC(15,2)) AS WO$NTC
	,CAST((WO$LDC)/100.0 AS DEC(15,2)) AS WO$LDC
	,CAST((WO$FCS)/100.0 AS DEC(15,2)) AS WO$FCS
	,CAST((WO$AGC)/100.0 AS DEC(15,2)) AS WO$AGC
	,WOENTB
	,WO$SPS
	,WO$PRM
	,CAST((WO$UNC)/10000.0 AS DEC(15,4)) AS WO$UNC
	,WOXRT
	,WOCITM
	,WO$AID
	,CAST((WOOVPR)/100.0 AS DEC(15,2)) AS WOOVPR
	,CAST((WO$OCR)/10000.0 AS DEC(15,4)) AS WO$OCR
	,WO$PMC
	,CAST((WO$LDP)/1000.0 AS DEC(15,3)) AS WO$LDP
	,WO$PPM
	,WO$VPM
	,WO$US2
	,WO$MSG
	,WOPRP6
	,WOPRP7
	,WOPRP8
	,WOPRP9
	,WOPRP0
	,WOSRP6
	,WOSRP7
	,WOSRP8
	,WOSRP9
	,WOSRP0
	,WO$XRN
	,WO$AC1
	,WO$OSC
	,CAST((WO$FA)/100.0 AS DEC(15,2)) AS WO$FA
	,WO$ASC
	,WO$DEA

	,WO$DEX
--	,CASE WHEN WO$DEX IS NOT NULL THEN DATE(DIGITS(DEC(WO$DEX+ 1900000,7,0))) ELSE NULL END AS WO$DEX

	,WOSIC
	,WO$PLN

	,WO$LEX
--	,CASE WHEN WO$LEX IS NOT NULL THEN DATE(DIGITS(DEC(WO$LEX+ 1900000,7,0))) ELSE NULL END AS WO$LEX

	,WO$DPC
	,WO$DC
	,WO$DCO
	,WO$ACS
	,WO$A02
	,WO$A03
	,WO$SPM
	,CAST((WO$ODP)/1000.0 AS DEC(15,3)) AS WO$ODP
	,CAST((WO$IDT)/100.0 AS DEC(15,2)) AS WO$IDT
	,CAST((WO$DTD)/100.0 AS DEC(15,2)) AS WO$DTD
	,CAST((WO$SDA)/100.0 AS DEC(15,2)) AS WO$SDA
	,CAST((WO$SDP)/1000.0 AS DEC(15,3)) AS WO$SDP
	,CAST((WO$PDI)/100.0 AS DEC(15,2)) AS WO$PDI
	,CAST((WO$CVA)/100.0 AS DEC(15,2)) AS WO$CVA
	,WOAC01
	,WOAC02
	,WOAC03
	,WOAC04
	,WOAC05
	,WOAC06
	,WOAC07
	,WOAC08
	,WOAC09
	,WOAC10
	,WOAC11
	,WOAC12
	,WOAC13
	,WOAC14
	,WOAC15
	,WOAC16
	,WOAC17
	,WOAC18
	,WOAC19
	,WOAC20
	,WOAC21
	,WOAC22
	,WOAC23
	,WOAC24
	,WOAC25
	,WOAC26
	,WOAC27
	,WOAC28
	,WOAC29
	,WOAC30
	,WOPRGP
	,WOTXCT
	,WOFUF2
	,CAST((WOOTOT)/100.0 AS DEC(15,2)) AS WOOTOT
	,CAST((WOTOTC)/100.0 AS DEC(15,2)) AS WOTOTC
	,WOSBLI
	,CAST((WOFAP)/100.0 AS DEC(15,2)) AS WOFAP
	,CAST((WOFCST)/100.0 AS DEC(15,2)) AS WOFCST
	,WOORBY
	,WOTKBY

	FROM
		ARCPDTA71.F55520
    WHERE
--        DATE(DIGITS(DEC(WODGL+ 1900000,7,0))) = ''2023-11-13''

--      WODGL >= 123275

--		PROD 6 Nov 23
--      WODGL >= 123314

		-- QA xxx
        WODGL = 123274
	
--    ORDER BY
--        <insert custom code here>
')

-- 1day 21 231 @ 47

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

-- join to DS
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
GO

--
-- join to DW
UPDATE
Integration.F55520_daily_sales_order_header_detail_workfile
SET
ID_source_dw_ref = ID
FROM
Integration.F55520_daily_sales_order_header_detail_workfile 

INNER JOIN BRS_TransactionDW s
ON Integration.F55520_daily_sales_order_header_detail_workfile.WODOCO_salesorder_number = s.SalesOrderNumber AND 
	Integration.F55520_daily_sales_order_header_detail_workfile.WODCTO_order_type = s.DocType AND 
	ROUND(Integration.F55520_daily_sales_order_header_detail_workfile.WOLNID_line_number * 1000, 0) = s.LineNumber
GO


-- test

SELECT top 10        BRS_TransactionDW.SalesOrderNumber, BRS_TransactionDW.DocType, BRS_TransactionDW.LineNumber, BRS_TransactionDW.Date, 
                         Integration.F55520_daily_sales_order_header_detail_workfile.ID_source_dw_ref, BRS_TransactionDW.Shipto, BRS_TransactionDW.Item, Integration.F55520_daily_sales_order_header_detail_workfile.WOSHAN_shipto, 
                         Integration.F55520_daily_sales_order_header_detail_workfile.WOLITM_item_number, BRS_TransactionDW.OrderPromotionCode, BRS_TransactionDW.PromotionCode
,OrderSourceCode
,[WO$PMC_promotion_code_price_method] 
,[WO$PRM_promotion_code]
,[WO$PPM_price_promotion_code]
,[WO$VPM_volume_promotion_code]
,[WO$SPM_secondary_promotion_code]

FROM            Integration.F55520_daily_sales_order_header_detail_workfile RIGHT OUTER JOIN
                         BRS_TransactionDW ON Integration.F55520_daily_sales_order_header_detail_workfile.ID_source_dw_ref = BRS_TransactionDW.ID
WHERE        (BRS_TransactionDW.CalMonth >= 202308) and

OrderPromotionCode <> '' and
OrderPromotionCode  = [WO$SPM_secondary_promotion_code]
order by [date] desc
GO


-- find promos
SELECT         distinct [WO$SPM_secondary_promotion_code]
FROM            Integration.F55520_daily_sales_order_header_detail_workfile 


-- update

UPDATE
	BRS_TransactionDW
SET
	OrderPromotionCode = LEFT([WO$SPM_secondary_promotion_code],2)
FROM
Integration.F55520_daily_sales_order_header_detail_workfile 

INNER JOIN BRS_TransactionDW 
ON Integration.F55520_daily_sales_order_header_detail_workfile.ID_source_dw_ref = BRS_TransactionDW.ID

WHERE
(BRS_TransactionDW.CalMonth >= 202310) AND 
(BRS_TransactionDW.OrderPromotionCode = '') and 
([WO$SPM_secondary_promotion_code] not in ('', 'FLE', 'MET'))
GO


-- CB test

SELECT
--top 100
BRS_TransactionDW.SalesOrderNumber
,BRS_TransactionDW.DocType
,BRS_TransactionDW.LineNumber
,BRS_TransactionDW.Date
,Integration.F55520_daily_sales_order_header_detail_workfile.ID_source_dw_ref
,BRS_TransactionDW.Shipto
,BRS_TransactionDW.Item
,Integration.F55520_daily_sales_order_header_detail_workfile.WOSHAN_shipto
,Integration.F55520_daily_sales_order_header_detail_workfile.WOLITM_item_number
,OrderSourceCode
,[Date]
,ShippedQty
,WOSOQS_quantity_shipped
,WOUORG_quantity
,[ExtChargebackAmt]
,WO$CBA_chargeback_amount * [ShippedQty] ext_cb_new

,WO$CBA_chargeback_amount


FROM            Integration.F55520_daily_sales_order_header_detail_workfile INNER JOIN
                         BRS_TransactionDW ON Integration.F55520_daily_sales_order_header_detail_workfile.ID_source_dw_ref = BRS_TransactionDW.ID
WHERE
(BRS_TransactionDW.CalMonth >= 202310) AND
--ShippedQty<>WOUORG_quantity and
 [ExtChargebackAmt] <> 0 and
 abs([ExtChargebackAmt]-(WO$CBA_chargeback_amount * [ShippedQty]))>0.01 and

(1=1)
GO


-- cb update
SELECT
--top 100
BRS_TransactionDW.SalesOrderNumber
,BRS_TransactionDW.DocType
,BRS_TransactionDW.LineNumber
,BRS_TransactionDW.Date
,Integration.F55520_daily_sales_order_header_detail_workfile.ID_source_dw_ref
,BRS_TransactionDW.Shipto
,BRS_TransactionDW.Item
,Integration.F55520_daily_sales_order_header_detail_workfile.WOSHAN_shipto
,Integration.F55520_daily_sales_order_header_detail_workfile.WOLITM_item_number
,OrderSourceCode
,[Date]
,ShippedQty
,WOSOQS_quantity_shipped
,WOUORG_quantity
,[ExtChargebackAmt]
,WO$CBA_chargeback_amount * [ShippedQty] ext_cb_new

,WO$CBA_chargeback_amount


FROM            Integration.F55520_daily_sales_order_header_detail_workfile INNER JOIN
                         BRS_TransactionDW ON Integration.F55520_daily_sales_order_header_detail_workfile.ID_source_dw_ref = BRS_TransactionDW.ID
WHERE
(BRS_TransactionDW.CalMonth >= 202310) AND
--ShippedQty<>WOUORG_quantity and
-- [ExtChargebackAmt] <> 0 and
WO$CBA_chargeback_amount <>0 and
 abs([ExtChargebackAmt]-(WO$CBA_chargeback_amount * [ShippedQty]))>0.01 and

(1=1)
GO

-- update DW from stage
UPDATE       BRS_TransactionDW
SET                ExtChargebackAmt = (WO$CBA_chargeback_amount * [ShippedQty])
FROM            Integration.F55520_daily_sales_order_header_detail_workfile INNER JOIN
                         BRS_TransactionDW ON Integration.F55520_daily_sales_order_header_detail_workfile.ID_source_dw_ref = BRS_TransactionDW.ID
WHERE        (BRS_TransactionDW.CalMonth >= 202310) AND (ABS(BRS_TransactionDW.ExtChargebackAmt - Integration.F55520_daily_sales_order_header_detail_workfile.WO$CBA_chargeback_amount * BRS_TransactionDW.ShippedQty) 
                         > 0.01)

GO

-- update DS from DW

SELECT
--top 100
BRS_TransactionDW.SalesOrderNumber
,BRS_TransactionDW.DocType
,BRS_TransactionDW.LineNumber
,BRS_TransactionDW.Date
,Integration.F55520_daily_sales_order_header_detail_workfile.ID_source_dw_ref
,BRS_TransactionDW.Shipto
,BRS_TransactionDW.Item
,Integration.F55520_daily_sales_order_header_detail_workfile.WOSHAN_shipto
,Integration.F55520_daily_sales_order_header_detail_workfile.WOLITM_item_number
,OrderSourceCode
,[Date]
,ShippedQty
,WOSOQS_quantity_shipped
,WOUORG_quantity
,[ExtChargebackAmt]
,WO$CBA_chargeback_amount * [ShippedQty] ext_cb_new

,WO$CBA_chargeback_amount


FROM 
[dbo].[BRS_Transaction] t INNER JOIN
                         BRS_TransactionDW ON t.ID_source_ref = BRS_TransactionDW.ID
WHERE
(BRS_TransactionDW.CalMonth >= 202310) AND
--ShippedQty<>WOUORG_quantity and
-- [ExtChargebackAmt] <> 0 and
WO$CBA_chargeback_amount <>0 and
 abs([ExtChargebackAmt]-(WO$CBA_chargeback_amount * [ShippedQty]))>0.01 and

(1=1)
GO
