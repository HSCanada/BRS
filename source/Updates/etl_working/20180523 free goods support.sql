--------------------------------------------------------------------------------
-- DROP TABLE Integration.F5503_canned_message_file_parameters_Staging
--------------------------------------------------------------------------------

SELECT 
    Top 5
    "Q3KCOO" AS Q3KCOO_order_number_document_company,
	"Q3DCTO" AS Q3DCTO_order_type,
	"Q3DOCO" AS Q3DOCO_salesorder_number,
	"Q3LNID" AS Q3LNID_line_number,
	"Q3$APC" AS Q3$APC_application_code,
	"Q3$PMQ" AS Q3$PMQ_program_parameter,
	"Q3LNGP" AS Q3LNGP_language,
	"Q3INMG" AS Q3INMG_print_message,
	"Q3$SNB" AS Q3$SNB_sequence_number,
	"QCTRDJ" AS QCTRDJ_order_date,
	HASHBYTES('SHA1', "Q3$PMQ") AS chksum

--INTO Integration.F5503_canned_message_file_parameters_Staging

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
		CAST((Q3$SNB)/100.0 AS DEC(15,2)) AS Q3$SNB,

		DATE(DIGITS(DEC(QCTRDJ+ 1900000,7,0))) AS QCTRDJ
--		CASE WHEN QCTRDJ IS NOT NULL THEN DATE(DIGITS(DEC(QCTRDJ+ 1900000,7,0))) ELSE NULL END AS QCTRDJ

	FROM
		ARCPDTA71.F5503 n, ARCPDTA71.F5501 h
    WHERE
		Q3KCOO = QCKCOO AND
		Q3DCTO = QCDCTO AND
		Q3DOCO = QCDOCO AND

		Q3KCOO = ''02000'' AND
--		DATE(DIGITS(DEC(QCTRDJ+ 1900000,7,0))) = 20180521
		1=1

--    ORDER BY
--        QCTRDJ desc
')

--------------------------------------------------------------------------------
SELECT        
	Q3DOCO_salesorder_number, 
	Q3LNID_line_number, 
	Q3$SNB_sequence_number,
	count(*)
FROM            Integration.F5503_canned_message_file_parameters_Staging
GROUP BY 
Q3DOCO_salesorder_number, 
Q3LNID_line_number, 
Q3$SNB_sequence_number
HAVING        (COUNT(*) > 1)
ORDER BY 4 DESC

-- truncate table Integration.F5503_canned_message_file_parameters_Staging

BEGIN TRANSACTION
GO
ALTER TABLE Integration.F5503_canned_message_file_parameters_Staging ADD CONSTRAINT
	F5503_canned_message_file_parameters_Staging_c_pk PRIMARY KEY CLUSTERED 
	(
	Q3DOCO_salesorder_number,
	Q3INMG_print_message,
	Q3$SNB_sequence_number
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE Integration.F5503_canned_message_file_parameters_Staging SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

ALTER TABLE Integration.F5503_canned_message_file_parameters_Staging 
ADD id int identity(1,1)

ALTER TABLE Integration.F5503_canned_message_file_parameters_Staging 
ADD chksum binary(32)

-- Q3$PMQ

-- ORG
SELECT *  FROM OPENQUERY (ESYS_PROD, '
	SELECT * FROM
		ARCPDTA71.F5503 n, ARCPDTA71.F5501 h
    WHERE
		Q3KCOO = QCKCOO AND
		Q3DCTO = QCDCTO AND
		Q3DOCO = QCDOCO AND
		Q3KCOO = ''02000'' AND
		Q3DOCO = 10665814 AND
		1=1
')

-- NEW
SELECT *  FROM OPENQUERY (ESYS_PROD, '
	SELECT * FROM
		ARCPDTA71.F5503 n
    WHERE
		Q3KCOO = ''02000'' AND
		Q3DOCO = 10665814 AND
		1=1
')

--------------------------------------------------------------------------------


SELECT *
FROM            Integration.F5503_canned_message_file_parameters_Staging
where [Q3DOCO_salesorder_number] = 11306187
ORDER BY 
Q3KCOO_order_number_document_company,
Q3DCTO_order_type,
Q3DOCO_salesorder_number,
Q3LNID_line_number,
Q3$SNB_sequence_number


GO

SELECT        COUNT(*) AS Expr1, Q3INMG_print_message, Q3DCTO_order_type
FROM            Integration.F5503_canned_message_file_parameters_Staging
GROUP BY Q3INMG_print_message, Q3DCTO_order_type
order by 1 desc




---


--------------------------------------------------------------------------------
-- DROP TABLE Integration.ARCPDTA71_F5501_<instert_friendly_name_here>
--------------------------------------------------------------------------------

SELECT 

    Top 5 
    "QCDOCO" AS QCDOCO_salesorder_number, "QCDCTO" AS QCDCTO_order_type, "QCKCOO" AS QCKCOO_order_number_document_company, "QC$XRN" AS QC$XRN_cross_reference_number, "QC$AC1" AS QC$AC1_address_code_future_1, "QC$OSC" AS QC$OSC_order_source_code, "QC$FA" AS QC$FA__total_amount_freight, "QC$ASC" AS QC$ASC_apply_small_order_charges, "QC$AHC" AS QC$AHC_apply_hazardous_charges, "QC$FMC" AS QC$FMC_form_222c, "QC$FM1" AS QC$FM1_form_222c_date_1, "QC$FM2" AS QC$FM2_form_222c_date_2, "QCNAME" AS QCNAME_name, "QCTRDJ" AS QCTRDJ_order_date, "QCCRTM" AS QCCRTM_creation_time, "QCENTB" AS QCENTB_entered_by, "QC$DEA" AS QC$DEA_dea_number, "QC$DEX" AS QC$DEX_dea_expiration_date, "QC$D01" AS QC$D01_dea_schedule_01, "QC$D02" AS QC$D02_dea_schedule_02, "QC$D03" AS QC$D03_dea_schedule_03, "QC$D04" AS QC$D04_dea_schedule_04, "QC$D05" AS QC$D05_dea_schedule_05, "QC$D06" AS QC$D06_dea_schedule_06, "QC$D07" AS QC$D07_dea_schedule_07, "QC$D08" AS QC$D08_dea_schedule_08, "QC$D09" AS QC$D09_dea_schedule_09, "QC$D10" AS QC$D10_dea_schedule_10, "QC$OR" AS QC$OR__total_amount_ordered, "QC$BK" AS QC$BK__total_amount_backordered, "QC$HL" AS QC$HL__total_amount_on_hold, "QC$PK" AS QC$PK__total_amount_on_pick_ticket, "QC$AS" AS QC$AS__total_amount_shipped, "QC$AB" AS QC$AB__total_amount_posted, "QC$CA" AS QC$CA__total_amount_canceled, "QC$MSC" AS QC$MSC_total_amount_miscellaneous, "QC$NTC" AS QC$NTC_net_cost_chargebacks, "QCSIC" AS QCSIC__speciality, "QC$BCW" AS QC$BCW_by_pass_call_back_wait_period, "QC$PFI" AS QC$PFI_proforma_invoice_request, "QC$PLN" AS QC$PLN_prof_lic, "QC$LEX" AS QC$LEX_license_expiration_date, "QC$DPC" AS QC$DPC_document_print_code, "QC$LWS" AS QC$LWS_status_code_low, "QC$HGS" AS QC$HGS_status_code_high, "QC$DC" AS QC$DC__distribution_center, "QC$DCO" AS QC$DCO_order_consolidation_warehouse, "QC$ACS" AS QC$ACS_accept_cross_shipments, "QC$A02" AS QC$A02_freight_charge_level, "QC$A03" AS QC$A03_carrier_override_code, "QC$OCU" AS QC$OCU_original_customer_number, "QC$OCS" AS QC$OCS_original_customer_sub_number, "QC$SPM" AS QC$SPM_secondary_promotion_code, "QC$PRM" AS QC$PRM_promotion_code, "QC$ODP" AS QC$ODP_order_discount_pct, "QC$IDT" AS QC$IDT_invoice_discount_amount_taken, "QC$DTD" AS QC$DTD_discount_taken_to_date, "QC$SDA" AS QC$SDA_sales_plan_discount_amount, "QC$SDP" AS QC$SDP_sales_plan_discount_pct, "QC$PDI" AS QC$PDI_promotion_dollar_incentive, "QCAC01" AS QCAC01_customer_profession, "QC$CVA" AS QC$CVA_convention_discount_amount, "QCAC02" AS QCAC02_customer_sub_profession, "QCAC03" AS QCAC03_type_of_paying_customer, "QCAC04" AS QCAC04_practice_type, "QCAC05" AS QCAC05_ap_check_routing_code, "QCAC06" AS QCAC06_category_code_address_06, "QCAC07" AS QCAC07_category_code_address_07, "QCAC08" AS QCAC08_market_segment, "QCAC09" AS QCAC09_equipment_software_code, "QCAC10" AS QCAC10_division_code, "QCAC11" AS QCAC11_freight_category, "QCAC12" AS QCAC12_regency_frequency_monetery, "QCAC13" AS QCAC13_foreign_domestic_code, "QCAC14" AS QCAC14_foreign_country_code, "QCAC15" AS QCAC15_customer_location_code, "QCAC24" AS QCAC24_category_code_24, "QCAC25" AS QCAC25_category_code_25, "QCAC26" AS QCAC26_unsolicited_faxes, "QCAC27" AS QCAC27_area, "QCAC28" AS QCAC28_integration_group, "QCAC29" AS QCAC29_category_code_29, "QCAC30" AS QCAC30_category_code_30, "QCAC16" AS QCAC16_paperwork_logo, "QCAC17" AS QCAC17_category_code_17, "QCAC18" AS QCAC18_category_code_18, "QCAC19" AS QCAC19_category_code_19, "QCAC20" AS QCAC20_category_code_20, "QCAC21" AS QCAC21_category_code_21, "QCAC22" AS QCAC22_category_code_22, "QCAC23" AS QCAC23_category_code_23, "QCUSER" AS QCUSER_user_id, "QCPID" AS QCPID__program_id, "QCJOBN" AS QCJOBN_work_station_id, "QCUPMJ" AS QCUPMJ_date_updated, "QCTDAY" AS QCTDAY_time_of_day 

-- INTO Integration.ARCPDTA71_F5501_<instert_friendly_name_here>

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		QCDOCO, QCDCTO, QCKCOO, QC$XRN, QC$AC1, QC$OSC, CAST((QC$FA)/100.0 AS DEC(15,2)) AS QC$FA, QC$ASC, QC$AHC, QC$FMC, CASE WHEN QC$FM1 IS NOT NULL THEN DATE(DIGITS(DEC(QC$FM1+ 1900000,7,0))) ELSE NULL END AS QC$FM1, CASE WHEN QC$FM2 IS NOT NULL THEN DATE(DIGITS(DEC(QC$FM2+ 1900000,7,0))) ELSE NULL END AS QC$FM2, QCNAME, CASE WHEN QCTRDJ IS NOT NULL THEN DATE(DIGITS(DEC(QCTRDJ+ 1900000,7,0))) ELSE NULL END AS QCTRDJ, QCCRTM, QCENTB, QC$DEA, CASE WHEN QC$DEX IS NOT NULL THEN DATE(DIGITS(DEC(QC$DEX+ 1900000,7,0))) ELSE NULL END AS QC$DEX, QC$D01, QC$D02, QC$D03, QC$D04, QC$D05, QC$D06, QC$D07, QC$D08, QC$D09, QC$D10, CAST((QC$OR)/100.0 AS DEC(15,2)) AS QC$OR, CAST((QC$BK)/100.0 AS DEC(15,2)) AS QC$BK, CAST((QC$HL)/100.0 AS DEC(15,2)) AS QC$HL, CAST((QC$PK)/100.0 AS DEC(15,2)) AS QC$PK, CAST((QC$AS)/100.0 AS DEC(15,2)) AS QC$AS, CAST((QC$AB)/100.0 AS DEC(15,2)) AS QC$AB, CAST((QC$CA)/100.0 AS DEC(15,2)) AS QC$CA, CAST((QC$MSC)/100.0 AS DEC(15,2)) AS QC$MSC, CAST((QC$NTC)/100.0 AS DEC(15,2)) AS QC$NTC, QCSIC, QC$BCW, QC$PFI, QC$PLN, CASE WHEN QC$LEX IS NOT NULL THEN DATE(DIGITS(DEC(QC$LEX+ 1900000,7,0))) ELSE NULL END AS QC$LEX, QC$DPC, QC$LWS, QC$HGS, QC$DC, QC$DCO, QC$ACS, QC$A02, QC$A03, QC$OCU, QC$OCS, QC$SPM, QC$PRM, CAST((QC$ODP)/1000.0 AS DEC(15,3)) AS QC$ODP, CAST((QC$IDT)/100.0 AS DEC(15,2)) AS QC$IDT, CAST((QC$DTD)/100.0 AS DEC(15,2)) AS QC$DTD, CAST((QC$SDA)/100.0 AS DEC(15,2)) AS QC$SDA, CAST((QC$SDP)/1000.0 AS DEC(15,3)) AS QC$SDP, CAST((QC$PDI)/100.0 AS DEC(15,2)) AS QC$PDI, QCAC01, CAST((QC$CVA)/100.0 AS DEC(15,2)) AS QC$CVA, QCAC02, QCAC03, QCAC04, QCAC05, QCAC06, QCAC07, QCAC08, QCAC09, QCAC10, QCAC11, QCAC12, QCAC13, QCAC14, QCAC15, QCAC24, QCAC25, QCAC26, QCAC27, QCAC28, QCAC29, QCAC30, QCAC16, QCAC17, QCAC18, QCAC19, QCAC20, QCAC21, QCAC22, QCAC23, QCUSER, QCPID, QCJOBN, CASE WHEN QCUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(QCUPMJ+ 1900000,7,0))) ELSE NULL END AS QCUPMJ, QCTDAY

	FROM
		ARCPDTA71.F5501
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------


---


--------------------------------------------------------------------------------
-- DROP TABLE Integration.ARCPDTA71_F4211_<instert_friendly_name_here>
--------------------------------------------------------------------------------

SELECT 

    Top 5 
    "SDKCOO" AS SDKCOO_order_number_document_company, "SDDOCO" AS SDDOCO_salesorder_number, "SDDCTO" AS SDDCTO_order_type, "SDLNID" AS SDLNID_line_number, "SDSFXO" AS SDSFXO_order_suffix, "SDSFX" AS SDSFX__pay_item, "SDMCU" AS SDMCU__business_unit, "SDCO" AS SDCO___company, "SDOKCO" AS SDOKCO_original_order_document_company, "SDOORN" AS SDOORN_original_order_number, "SDOCTO" AS SDOCTO_original_order_type, "SDOGNO" AS SDOGNO_original_line_number, "SDRKCO" AS SDRKCO_related_order_key_company, "SDRORN" AS SDRORN_related_order_number, "SDRCTO" AS SDRCTO_related_order_type, "SDRLLN" AS SDRLLN_related_poso_line_number, "SDDMCT" AS SDDMCT_contract_number, "SDDMCS" AS SDDMCS_contract_supplement, "SDBALU" AS SDBALU_contract_balances_updated_yn, "SDAN8" AS SDAN8__billto, "SDSHAN" AS SDSHAN_shipto, "SDMKFR" AS SDMKFR_markfor, "SDBTAN" AS SDBTAN_bill_to_number, "SDPA8" AS SDPA8__parent_number, "SDDRQJ" AS SDDRQJ_requested, "SDTRDJ" AS SDTRDJ_order_date, "SDPDDJ" AS SDPDDJ_scheduled_pick, "SDOPDJ" AS SDOPDJ_original_promised, "SDADDJ" AS SDADDJ_actual_ship, "SDIVD" AS SDIVD__invoice_date, "SDCNDJ" AS SDCNDJ_cancel_date, "SDDGL" AS SDDGL__gl_date, "SDRSDJ" AS SDRSDJ_promised_delivery, "SDPEFJ" AS SDPEFJ_price_effective, "SDPPDJ" AS SDPPDJ_future_use_1, "SDRQSJ" AS SDRQSJ_requested, "SDADLJ" AS SDADLJ_actual_delivery, "SDDRQT" AS SDDRQT_requested_delivery_time, "SDRSDT" AS SDRSDT_promised_delivery_time, "SDVR01" AS SDVR01_reference, "SDVR02" AS SDVR02_reference_2, "SDVR03" AS SDVR03_markfor_reference, "SDITM" AS SDITM__item_number_short, "SDLITM" AS SDLITM_item_number, "SDAITM" AS SDAITM__3rd_item_number, "SDMERL" AS SDMERL_item_revision_level, "SDLOCN" AS SDLOCN_location, "SDLOTN" AS SDLOTN_lot, "SDFRGD" AS SDFRGD_from_grade, "SDTHGD" AS SDTHGD_thru_grade, "SDACGD" AS SDACGD_actual_grade, "SDFRMP" AS SDFRMP_from_potency, "SDTHRP" AS SDTHRP_thru_potency, "SDAPOT" AS SDAPOT_actual_potency, "SDEXDP" AS SDEXDP_days_before_expiration, "SDDSC1" AS SDDSC1_description, "SDDSC2" AS SDDSC2_description_2, "SDLNTY" AS SDLNTY_line_type, "SDNXTR" AS SDNXTR_status_code_next, "SDLTTR" AS SDLTTR_status_code_last, "SDHOLD" AS SDHOLD_hold_orders_code, "SDEMCU" AS SDEMCU_header_business_unit, "SDHDBU" AS SDHDBU_header_business_unit, "SDDMBU" AS SDDMBU_demand_business_unit, "SDRLIT" AS SDRLIT_related_item_number_kit, "SDKTLN" AS SDKTLN_kit_master_line_number, "SDCPNT" AS SDCPNT_component_line_number, "SDRKIT" AS SDRKIT_related_kit_component, "SDKTP" AS SDKTP__number_of_component_per_parent, "SDCSID" AS SDCSID_configured_string_id, "SDSRP1" AS SDSRP1_major_product_class, "SDSRP2" AS SDSRP2_sub_major_product_class, "SDSRP3" AS SDSRP3_minor_product_class, "SDSRP4" AS SDSRP4_sub_minor_product_class, "SDSRP5" AS SDSRP5_hazardous_class, "SDPRP1" AS SDPRP1_commodity_class, "SDPRP2" AS SDPRP2_commodity_sub_class, "SDPRP3" AS SDPRP3_supplier_rebate_code, "SDPRP4" AS SDPRP4_tax_classification, "SDPRP5" AS SDPRP5_landed_cost_rule, "SDDMS1" AS SDDMS1_agreement_supplement, "SDDMT1" AS SDDMT1_borrow_agreement, "SDUOM" AS SDUOM__um, "SDUORG" AS SDUORG_quantity, "SDSOQS" AS SDSOQS_quantity_shipped, "SDSOBK" AS SDSOBK_quantity_backordered, "SDSOCN" AS SDSOCN_quantity_canceled, "SDSONE" AS SDSONE_future_quantity_committed, "SDUOPN" AS SDUOPN_quantity_open, "SDQTYT" AS SDQTYT_quantity_shipped_to_date, "SDQRLV" AS SDQRLV_quantity_relieved, "SDCOMM" AS SDCOMM_committed_hs, "SDOTQY" AS SDOTQY_other_quantity_12, "SDBCRC" AS SDBCRC_base_currency, "SDUPRC" AS SDUPRC_unit_price, "SDAEXP" AS SDAEXP_extended_price, "SDAOPN" AS SDAOPN_amount_open, "SDPROV" AS SDPROV_price_override_code, "SDTPC" AS SDTPC__temporary_price_yn, "SDAPUM" AS SDAPUM_entered_unit_of_measure_for_unit_price, "SDLPRC" AS SDLPRC_unit_list_price, "SDUNCS" AS SDUNCS_unit_cost, "SDECST" AS SDECST_extended_cost, "SDCSTO" AS SDCSTO_cost_override_code, "SDTCST" AS SDTCST_transfer_cost, "SDINMG" AS SDINMG_print_message, "SDPTC" AS SDPTC__payment_terms, "SDRYIN" AS SDRYIN_payment_instrument, "SDDTBS" AS SDDTBS_based_on_date, "SDTRDC" AS SDTRDC_trade_discount, "SDFUN2" AS SDFUN2_trade_discount_old, "SDASN" AS SDASN__adjustment_schedule, "SDOSEQ" AS SDOSEQ_sequence_number, "SDPRGR" AS SDPRGR_item_price_group, "SDCLVL" AS SDCLVL_pricing_category_level, "SDDSPR" AS SDDSPR_discount_factor, "SDDSFT" AS SDDSFT_discount_factor_type_amt_orpct, "SDFAPP" AS SDFAPP_discount_application_type, "SDCADC" AS SDCADC_cash_discount_pct, "SDKCO" AS SDKCO__document_company, "SDDOC" AS SDDOC__document_number, "SDDCT" AS SDDCT__document_type, "SDODOC" AS SDODOC_original_document_no, "SDODCT" AS SDODCT_original_document_type, "SDOKC" AS SDOKC__original_document_company, "SDPSN" AS SDPSN__pick_slip_number, "SDDELN" AS SDDELN_delivery_number, "SDPTSK" AS SDPTSK_task_number, "SDTAX1" AS SDTAX1_sales_taxable, "SDTXA1" AS SDTXA1_tax_ratearea, "SDEXR1" AS SDEXR1_tax_expl_code, "SDATXT" AS SDATXT_associated_text, "SDPRIO" AS SDPRIO_priority_processing_code, "SDRESL" AS SDRESL_printed_code, "SDBACK" AS SDBACK_backorders_allowed_yn, "SDSBAL" AS SDSBAL_substitutes_allowed_yn, "SDAPTS" AS SDAPTS_partial_shipments_allowed_yn, "SDLOB" AS SDLOB__line_of_business, "SDEUSE" AS SDEUSE_end_use, "SDDTYS" AS SDDTYS_duty_status, "SDNTR" AS SDNTR__nature_of_transaction, "SDVEND" AS SDVEND_primary_last_supplier_number, "SDANBY" AS SDANBY_buyer_number, "SDCARS" AS SDCARS_carrier_number, "SDMOT" AS SDMOT__mode_of_trn, "SDCOT" AS SDCOT__conditions_of_transport, "SDROUT" AS SDROUT_ship_method, "SDSTOP" AS SDSTOP_stop_code, "SDZON" AS SDZON__zone_number, "SDCNID" AS SDCNID_container_id, "SDFRTH" AS SDFRTH_freight_handling_code, "SDAFT" AS SDAFT__apply_freight_yn, "SDFUF1" AS SDFUF1_aia_document, "SDFRTC" AS SDFRTC_freight_calculated_yn, "SDFRAT" AS SDFRAT_rate_code_freightmisc, "SDRATT" AS SDRATT_rate_type_freightmisc, "SDSHCM" AS SDSHCM_shipping_commodity_class, "SDSHCN" AS SDSHCN_shipping_conditions_code, "SDSHPN" AS SDSHPN_shipment_number, "SDSERN" AS SDSERN_lot_serial_number, "SDLDNM" AS SDLDNM_load_number, "SDSHMT" AS SDSHMT_shipment_number_itls, "SDTKNR" AS SDTKNR_ticket_number, "SDTKTM" AS SDTKTM_ticket_time, "SDTKDA" AS SDTKDA_ticket_date, "SDUOM1" AS SDUOM1_unit_of_measure, "SDPQOR" AS SDPQOR_quantity_ordered, "SDUOM2" AS SDUOM2_secondary_uom, "SDSQOR" AS SDSQOR_secondary_quantity_ordered, "SDUOM4" AS SDUOM4_pricing_uom, "SDITWT" AS SDITWT_unit_weight, "SDWTUM" AS SDWTUM_weight_unit_of_measure, "SDITVL" AS SDITVL_unit_volume, "SDVLUM" AS SDVLUM_volume_unit_of_measure, "SDRPRC" AS SDRPRC_basket_reprice_group, "SDORPR" AS SDORPR_order_reprice_group, "SDORP" AS SDORP__order_repriced_indicator, "SDCMGP" AS SDCMGP_inventory_costing_method, "SDCMGL" AS SDCMGL_commitment_method, "SDGLC" AS SDGLC__gl_offset, "SDCTRY" AS SDCTRY_century, "SDFY" AS SDFY___fiscal_year, "SDSTTS" AS SDSTTS_line_status, "SDSO01" AS SDSO01_inter_branch_sales, "SDSO02" AS SDSO02_on_hand_updated, "SDSO03" AS SDSO03_configurator_print_flag, "SDSO04" AS SDSO04_sales_order_status_04, "SDSO05" AS SDSO05_substitute_item_indicator, "SDSO06" AS SDSO06_preference_commitment_indicator, "SDSO07" AS SDSO07_ship_date_overridden, "SDSO08" AS SDSO08_price_adjustment_line_indicator, "SDSO09" AS SDSO09_sales_order_status_09, "SDSO10" AS SDSO10_preference_product_allocation, "SDSO11" AS SDSO11_sales_order_status_11, "SDSO12" AS SDSO12_sales_order_status_12, "SDSO13" AS SDSO13_euro_conversion_status, "SDSO14" AS SDSO14_order_promising_flag, "SDSO15" AS SDSO15_sales_order_status_15, "SDSO16" AS SDSO16_shipment_confirmed, "SDSO17" AS SDSO17_split_line, "SDSO18" AS SDSO18_backorders_printed, "SDSO19" AS SDSO19_adjustment_level, "SDSO20" AS SDSO20_sales_order_status_20, "SDSLSM" AS SDSLSM_salesperson_code_01, "SDSLCM" AS SDSLCM_salesperson_commission_1, "SDSLM2" AS SDSLM2_salesperson_code_02, "SDSLC2" AS SDSLC2_salesperson_commission_2, "SDACOM" AS SDACOM_apply_commission_yn, "SDCMCG" AS SDCMCG_commission_category, "SDRCD" AS SDRCD__reason_code, "SDGRWT" AS SDGRWT_gross_weight, "SDGWUM" AS SDGWUM_gross_weight_unit_of_measure, "SDANI" AS SDANI__account_number, "SDAID" AS SDAID__account_id, "SDOMCU" AS SDOMCU_project_cost_center, "SDOBJ" AS SDOBJ__object_account, "SDSUB" AS SDSUB__subsidiary, "SDLT" AS SDLT___ledger_type, "SDSBL" AS SDSBL__subledger, "SDSBLT" AS SDSBLT_subledger_type, "SDLCOD" AS SDLCOD_loc_tax_code, "SDUPC1" AS SDUPC1_price_code_1, "SDUPC2" AS SDUPC2_price_code_2, "SDUPC3" AS SDUPC3_price_code_3, "SDSWMS" AS SDSWMS_warehouse_status_code, "SDUNCD" AS SDUNCD_freeze_code, "SDCRMD" AS SDCRMD_send_method, "SDCRCD" AS SDCRCD_currency_code, "SDCRR" AS SDCRR__exchange_rate, "SDFPRC" AS SDFPRC_foreign_list_price, "SDFUP" AS SDFUP__foreign_unit_price, "SDFEA" AS SDFEA__foreign_extended_price, "SDFUC" AS SDFUC__foreign_unit_cost, "SDFEC" AS SDFEC__foreign_extended_cost, "SDURCD" AS SDURCD_user_reserved_code, "SDURDT" AS SDURDT_user_reserved_date, "SDURAT" AS SDURAT_user_reserved_amount, "SDURAB" AS SDURAB_user_reserved_number, "SDURRF" AS SDURRF_user_reserved_reference, "SDSCPD" AS SDSCPD_scheduled_completed_date, "SDSCPT" AS SDSCPT_scheduled_completed_time_hhmmss, "SDSCPS" AS SDSCPS_scheduled_completed_shift, "SDEDCK" AS SDEDCK_check_expiration_date, "SDSBCK" AS SDSBCK_check_sell_by_date, "SDBBCK" AS SDBBCK_check_best_before_date, "SDCMDM" AS SDCMDM_commitment_date_method, "SDUSC1" AS SDUSC1_check_user_defined_date_flag_1, "SDUSC2" AS SDUSC2_check_user_defined_date_flag_2, "SDUSC3" AS SDUSC3_check_user_defined_date_flag_3, "SDUSC4" AS SDUSC4_check_user_defined_date_flag_4, "SDUSC5" AS SDUSC5_check_user_defined_date_flag_5, "SDBLNO" AS SDBLNO_bill_of_lading_number, "SDTMUP" AS SDTMUP_transfer_price_code, "SDS1DJ" AS SDS1DJ_sales_order_date_1, "SDS2DJ" AS SDS2DJ_sales_order_date_2, "SDWORN" AS SDWORN_warranty_order_number, "SDWCTO" AS SDWCTO_warranty_document_type, "SDWKCO" AS SDWKCO_warranty_document_company, "SDWGNO" AS SDWGNO_warranty_line_number, "SDWCEJ" AS SDWCEJ_warranty_expiration_date, "SDWFLG" AS SDWFLG_warranty_action_flag, "SDWODO" AS SDWODO_work_order_number, "SDWOCT" AS SDWOCT_order_type, "SDMMCU" AS SDMMCU_branch, "SDSOQO" AS SDSOQO_original_quantity, "SDBOLA" AS SDBOLA_bill_of_lading_number, "SDSO21" AS SDSO21_exchange_rate_date_flag, "SDSO22" AS SDSO22_future_line_printed, "SDSO23" AS SDSO23_sales_order_status_23, "SDSO24" AS SDSO24_sales_order_status_24, "SDSO25" AS SDSO25_sales_order_status_25, "SDSO26" AS SDSO26_sales_order_status_26, "SDSO27" AS SDSO27_sales_order_status_27, "SDSO28" AS SDSO28_sales_order_status_28, "SDSO29" AS SDSO29_sales_order_status_29, "SDSO30" AS SDSO30_sales_order_status_30, "SDABR1" AS SDABR1_enh_subledger_code_1, "SDABT1" AS SDABT1_enh_subledger_type_1, "SDABR2" AS SDABR2_enh_subledger_code_2, "SDABT2" AS SDABT2_enh_subledger_type_2, "SDABR3" AS SDABR3_enh_subledger_code_3, "SDABT3" AS SDABT3_enh_subledger_type_3, "SDABR4" AS SDABR4_enh_subledger_code_4, "SDABT4" AS SDABT4_enh_subledger_type_4, "SDTORG" AS SDTORG_transaction_originator, "SDUSER" AS SDUSER_user_id, "SDPID" AS SDPID__program_id, "SDJOBN" AS SDJOBN_work_station_id, "SDUPMJ" AS SDUPMJ_date_updated, "SDTDAY" AS SDTDAY_time_of_day, "SDUPAJ" AS SDUPAJ_date_added, "SDTENT" AS SDTENT_time_entered 

-- INTO Integration.ARCPDTA71_F4211_<instert_friendly_name_here>

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		SDKCOO, SDDOCO, SDDCTO, CAST((SDLNID)/1000.0 AS DEC(15,3)) AS SDLNID, SDSFXO, SDSFX, SDMCU, SDCO, SDOKCO, SDOORN, SDOCTO, CAST((SDOGNO)/1000.0 AS DEC(15,3)) AS SDOGNO, SDRKCO, SDRORN, SDRCTO, CAST((SDRLLN)/1000.0 AS DEC(15,3)) AS SDRLLN, SDDMCT, SDDMCS, SDBALU, SDAN8, SDSHAN, SDMKFR, SDBTAN, SDPA8, CASE WHEN SDDRQJ IS NOT NULL THEN DATE(DIGITS(DEC(SDDRQJ+ 1900000,7,0))) ELSE NULL END AS SDDRQJ, CASE WHEN SDTRDJ IS NOT NULL THEN DATE(DIGITS(DEC(SDTRDJ+ 1900000,7,0))) ELSE NULL END AS SDTRDJ, CASE WHEN SDPDDJ IS NOT NULL THEN DATE(DIGITS(DEC(SDPDDJ+ 1900000,7,0))) ELSE NULL END AS SDPDDJ, CASE WHEN SDOPDJ IS NOT NULL THEN DATE(DIGITS(DEC(SDOPDJ+ 1900000,7,0))) ELSE NULL END AS SDOPDJ, CASE WHEN SDADDJ IS NOT NULL THEN DATE(DIGITS(DEC(SDADDJ+ 1900000,7,0))) ELSE NULL END AS SDADDJ, CASE WHEN SDIVD IS NOT NULL THEN DATE(DIGITS(DEC(SDIVD+ 1900000,7,0))) ELSE NULL END AS SDIVD, CASE WHEN SDCNDJ IS NOT NULL THEN DATE(DIGITS(DEC(SDCNDJ+ 1900000,7,0))) ELSE NULL END AS SDCNDJ, CASE WHEN SDDGL IS NOT NULL THEN DATE(DIGITS(DEC(SDDGL+ 1900000,7,0))) ELSE NULL END AS SDDGL, CASE WHEN SDRSDJ IS NOT NULL THEN DATE(DIGITS(DEC(SDRSDJ+ 1900000,7,0))) ELSE NULL END AS SDRSDJ, CASE WHEN SDPEFJ IS NOT NULL THEN DATE(DIGITS(DEC(SDPEFJ+ 1900000,7,0))) ELSE NULL END AS SDPEFJ, CASE WHEN SDPPDJ IS NOT NULL THEN DATE(DIGITS(DEC(SDPPDJ+ 1900000,7,0))) ELSE NULL END AS SDPPDJ, CASE WHEN SDRQSJ IS NOT NULL THEN DATE(DIGITS(DEC(SDRQSJ+ 1900000,7,0))) ELSE NULL END AS SDRQSJ, CASE WHEN SDADLJ IS NOT NULL THEN DATE(DIGITS(DEC(SDADLJ+ 1900000,7,0))) ELSE NULL END AS SDADLJ, SDDRQT, SDRSDT, SDVR01, SDVR02, SDVR03, SDITM, SDLITM, SDAITM, SDMERL, SDLOCN, SDLOTN, SDFRGD, SDTHGD, SDACGD, CAST((SDFRMP)/1000.0 AS DEC(15,3)) AS SDFRMP, CAST((SDTHRP)/1000.0 AS DEC(15,3)) AS SDTHRP, CAST((SDAPOT)/1000.0 AS DEC(15,3)) AS SDAPOT, SDEXDP, SDDSC1, SDDSC2, SDLNTY, SDNXTR, SDLTTR, SDHOLD, SDEMCU, SDHDBU, SDDMBU, SDRLIT, CAST((SDKTLN)/1000.0 AS DEC(15,3)) AS SDKTLN, CAST((SDCPNT)/10.0 AS DEC(15,1)) AS SDCPNT, SDRKIT, SDKTP, SDCSID, SDSRP1, SDSRP2, SDSRP3, SDSRP4, SDSRP5, SDPRP1, SDPRP2, SDPRP3, SDPRP4, SDPRP5, SDDMS1, SDDMT1, SDUOM, SDUORG, SDSOQS, SDSOBK, SDSOCN, SDSONE, SDUOPN, SDQTYT, SDQRLV, SDCOMM, SDOTQY, SDBCRC, CAST((SDUPRC)/10000.0 AS DEC(15,4)) AS SDUPRC, CAST((SDAEXP)/100.0 AS DEC(15,2)) AS SDAEXP, CAST((SDAOPN)/100.0 AS DEC(15,2)) AS SDAOPN, SDPROV, SDTPC, SDAPUM, CAST((SDLPRC)/10000.0 AS DEC(15,4)) AS SDLPRC, CAST((SDUNCS)/10000.0 AS DEC(15,4)) AS SDUNCS, CAST((SDECST)/100.0 AS DEC(15,2)) AS SDECST, SDCSTO, CAST((SDTCST)/10000.0 AS DEC(15,4)) AS SDTCST, SDINMG, SDPTC, SDRYIN, SDDTBS, CAST((SDTRDC)/1000.0 AS DEC(15,3)) AS SDTRDC, CAST((SDFUN2)/10000.0 AS DEC(15,4)) AS SDFUN2, SDASN, SDOSEQ, SDPRGR, SDCLVL, CAST((SDDSPR)/10000.0 AS DEC(15,4)) AS SDDSPR, SDDSFT, SDFAPP, CAST((SDCADC)/1000.0 AS DEC(15,3)) AS SDCADC, SDKCO, SDDOC, SDDCT, SDODOC, SDODCT, SDOKC, SDPSN, SDDELN, SDPTSK, SDTAX1, SDTXA1, SDEXR1, SDATXT, SDPRIO, SDRESL, SDBACK, SDSBAL, SDAPTS, SDLOB, SDEUSE, SDDTYS, SDNTR, SDVEND, SDANBY, SDCARS, SDMOT, SDCOT, SDROUT, SDSTOP, SDZON, SDCNID, SDFRTH, SDAFT, SDFUF1, SDFRTC, SDFRAT, SDRATT, SDSHCM, SDSHCN, SDSHPN, SDSERN, SDLDNM, SDSHMT, SDTKNR, SDTKTM, CASE WHEN SDTKDA IS NOT NULL THEN DATE(DIGITS(DEC(SDTKDA+ 1900000,7,0))) ELSE NULL END AS SDTKDA, SDUOM1, SDPQOR, SDUOM2, SDSQOR, SDUOM4, CAST((SDITWT)/10000.0 AS DEC(15,4)) AS SDITWT, SDWTUM, CAST((SDITVL)/10000.0 AS DEC(15,4)) AS SDITVL, SDVLUM, SDRPRC, SDORPR, SDORP, SDCMGP, SDCMGL, SDGLC, SDCTRY, SDFY, SDSTTS, SDSO01, SDSO02, SDSO03, SDSO04, SDSO05, SDSO06, SDSO07, SDSO08, SDSO09, SDSO10, SDSO11, SDSO12, SDSO13, SDSO14, SDSO15, SDSO16, SDSO17, SDSO18, SDSO19, SDSO20, SDSLSM, CAST((SDSLCM)/1000.0 AS DEC(15,3)) AS SDSLCM, SDSLM2, CAST((SDSLC2)/1000.0 AS DEC(15,3)) AS SDSLC2, SDACOM, SDCMCG, SDRCD, CAST((SDGRWT)/10000.0 AS DEC(15,4)) AS SDGRWT, SDGWUM, SDANI, SDAID, SDOMCU, SDOBJ, SDSUB, SDLT, SDSBL, SDSBLT, SDLCOD, SDUPC1, SDUPC2, SDUPC3, SDSWMS, SDUNCD, SDCRMD, SDCRCD, SDCRR, CAST((SDFPRC)/10000.0 AS DEC(15,4)) AS SDFPRC, CAST((SDFUP)/10000.0 AS DEC(15,4)) AS SDFUP, CAST((SDFEA)/100.0 AS DEC(15,2)) AS SDFEA, CAST((SDFUC)/10000.0 AS DEC(15,4)) AS SDFUC, CAST((SDFEC)/100.0 AS DEC(15,2)) AS SDFEC, SDURCD, CASE WHEN SDURDT IS NOT NULL THEN DATE(DIGITS(DEC(SDURDT+ 1900000,7,0))) ELSE NULL END AS SDURDT, CAST((SDURAT)/100.0 AS DEC(15,2)) AS SDURAT, SDURAB, SDURRF, CASE WHEN SDSCPD IS NOT NULL THEN DATE(DIGITS(DEC(SDSCPD+ 1900000,7,0))) ELSE NULL END AS SDSCPD, SDSCPT, SDSCPS, SDEDCK, SDSBCK, SDBBCK, SDCMDM, SDUSC1, SDUSC2, SDUSC3, SDUSC4, SDUSC5, SDBLNO, SDTMUP, CASE WHEN SDS1DJ IS NOT NULL THEN DATE(DIGITS(DEC(SDS1DJ+ 1900000,7,0))) ELSE NULL END AS SDS1DJ, CASE WHEN SDS2DJ IS NOT NULL THEN DATE(DIGITS(DEC(SDS2DJ+ 1900000,7,0))) ELSE NULL END AS SDS2DJ, SDWORN, SDWCTO, SDWKCO, SDWGNO, SDWCEJ, SDWFLG, SDWODO, SDWOCT, SDMMCU, SDSOQO, SDBOLA, SDSO21, SDSO22, SDSO23, SDSO24, SDSO25, SDSO26, SDSO27, SDSO28, SDSO29, SDSO30, SDABR1, SDABT1, SDABR2, SDABT2, SDABR3, SDABT3, SDABR4, SDABT4, SDTORG, SDUSER, SDPID, SDJOBN, CASE WHEN SDUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(SDUPMJ+ 1900000,7,0))) ELSE NULL END AS SDUPMJ, SDTDAY, CASE WHEN SDUPAJ IS NOT NULL THEN DATE(DIGITS(DEC(SDUPAJ+ 1900000,7,0))) ELSE NULL END AS SDUPAJ, SDTENT

	FROM
		ARCPDTA71.F4211
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------

SELECT        
--	distinct (Q3$PMQ_program_parameter) 
	distinct(HASHBYTES('SHA2_256', Q3$PMQ_program_parameter)) AS chksum

FROM            Integration.F5503_canned_message_file_parameters_Staging

-- 10s, 725323
-- 6s,  739916
-- 8s, 739916

	HASHBYTES('SHA1', "Q3$PMQ") AS chksum

