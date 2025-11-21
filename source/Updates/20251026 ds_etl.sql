-- ds.etl, tmc, 26 Oct 25




--------------------------------------------------------------------------------
-- DROP TABLE Integration.QFMATRIXZ_transaction
--------------------------------------------------------------------------------

SELECT 

    Top 5 
    "SHDOCO" AS SHDOCO_salesorder_number, "SHDCTO" AS SHDCTO_order_type, "SDLNID" AS SDLNID_line_number, "SDAN8" AS SDAN8__billto, "SDSHAN" AS SDSHAN_shipto, "SDLITM" AS SDLITM_item_number, "SDDOC" AS SDDOC__document_number, "SDDCT" AS SDDCT__document_type, "QCAC10" AS QCAC10_division_code, "QCAC08" AS QCAC08_market_segment, "QCAC04" AS QCAC04_practice_type, "QC$OSC" AS QC$OSC_order_source_code, "SDLNTY" AS SDLNTY_line_type, "SDSRP1" AS SDSRP1_major_product_class, "SDGLC" AS SDGLC__gl_offset, "SHMCU" AS SHMCU__business_unit, "SHMCU01" AS SHMCU01_description, "SDMCU" AS SDMCU__business_unit, "SDMCU01" AS SDMCU01_description, "SDEMCU" AS SDEMCU_header_business_unit, "SDEMCU01" AS SDEMCU01_description, "GLANI" AS GLANI__account_number, "GMDL01" AS GMDL01_description, "GLAA" AS GLAA___amount 

-- INTO Integration.QFMATRIXZ_transaction

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		SHDOCO, SHDCTO, CAST((SDLNID)/1000.0 AS DEC(15,3)) AS SDLNID, SDAN8, SDSHAN, SDLITM, SDDOC, SDDCT, QCAC10, QCAC08, QCAC04, QC$OSC, SDLNTY, SDSRP1, SDGLC, SHMCU, SHMCU01, SDMCU, SDMCU01, SDEMCU, SDEMCU01, GLANI, GMDL01, CAST((GLAA)/100.0 AS DEC(15,2)) AS GLAA

	FROM
		HSIUSRFLE.QFMATRIXZ
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- DROP TABLE [Integration].F0911_account_ledger_Staging
--------------------------------------------------------------------------------

SELECT 
    Top 5 
    "GLKCO" AS GLKCO__document_company,
	"GLDCT" AS GLDCT__document_type,
	"GLDOC" AS GLDOC__document_number,
	"GLDGJ" AS GLDGJ__gl_date,
	"GLJELN" AS GLJELN_journal_entry_line_number,
	"GLEXTL" AS GLEXTL_line_extension_code,
	"GLPOST" AS GLPOST_gl_posted_code,
	"GLICU" AS GLICU__batch_number,
	"GLICUT" AS GLICUT_batch_type,
	"GLDICJ" AS GLDICJ_batch_date,
	"GLDSYJ" AS GLDSYJ_batch_system_date,
	"GLTICU" AS GLTICU_batch_time,
	"GLCO" AS GLCO___company,
	"GLANI" AS GLANI__account_number,
	"GLAM" AS GLAM___account_mode,
	"GLAID" AS GLAID__account_id,
	"GLMCU" AS GLMCU__business_unit,
	"GLOBJ" AS GLOBJ__object_account,
	"GLSUB" AS GLSUB__subsidiary,
	"GLSBL" AS GLSBL__subledger,
	"GLSBLT" AS GLSBLT_subledger_type,
	"GLLT" AS GLLT___ledger_type,
	"GLPN" AS GLPN___gl_period_number,
	"GLCTRY" AS GLCTRY_century,
	"GLFY" AS GLFY___fiscal_year,
	"GLFQ" AS GLFQ___fiscal_quarter_obsolete,
	"GLCRCD" AS GLCRCD_currency_code,
	"GLCRR" AS GLCRR__exchange_rate,
	"GLHCRR" AS GLHCRR_historical_exchange_rate,
	"GLHDGJ" AS GLHDGJ_historical_date,
	"GLAA" AS GLAA___amount,
	"GLU" AS GLU____units,
	"GLUM" AS GLUM___unit_of_measure,
	"GLGLC" AS GLGLC__gl_offset,
	"GLRE" AS GLRE___reverse_or_void_rv,
	"GLEXA" AS GLEXA__explanation_name_alpha,
	"GLEXR" AS GLEXR__explanation_remark,
	"GLR1" AS GLR1___reference_1_je_voucher_invoice_etc,
	"GLR2" AS GLR2___reference_2_address_number,
	"GLR3" AS GLR3___reference_3_account_reconciliation,
	"GLSFX" AS GLSFX__pay_item,
	"GLODOC" AS GLODOC_original_document_no,
	"GLODCT" AS GLODCT_original_document_type,
	"GLOSFX" AS GLOSFX_original_pay_item,
	"GLPKCO" AS GLPKCO_purchase_order_document_company,
	"GLOKCO" AS GLOKCO_original_order_document_company,
	"GLPDCT" AS GLPDCT_purchase_order_document_type,
	"GLAN8" AS GLAN8__billto,
	"GLCN" AS GLCN___payment_number,
	"GLDKJ" AS GLDKJ__check_date,
	"GLDKC" AS GLDKC__check_cleared_date,
	"GLASID" AS GLASID_serial_number,
	"GLBRE" AS GLBRE__batch_rear_end_posted_code,
	"GLRCND" AS GLRCND_reconciled,
	"GLSUMM" AS GLSUMM_summarized_code,
	"GLPRGE" AS GLPRGE_purge_code,
	"GLTNN" AS GLTNN__flag_for_1099,
	"GLALT1" AS GLALT1_alternate_gl_posting_code_1,
	"GLALT2" AS GLALT2_alternate_gl_posting_code_2,
	"GLALT3" AS GLALT3_alternate_gl_posting_code_3,
	"GLALT4" AS GLALT4_alternate_gl_posting_code_4,
	"GLALT5" AS GLALT5_multi_currency_journal_entry,
	"GLALT6" AS GLALT6_cash_basis_accounting_post_code,
	"GLALT7" AS GLALT7_commitment_relief_flag,
	"GLALT8" AS GLALT8_billing_control,
	"GLALT9" AS GLALT9_currency_update,
	"GLALT0" AS GLALT0_labor_costing_flag,
	"GLALTT" AS GLALTT_crossenvironment_status,
	"GLALTU" AS GLALTU_intercompany_invoicevoucher_creation,
	"GLALTV" AS GLALTV_stocked_inventory_commitment,
	"GLALTW" AS GLALTW_voucher_logging_status_code,
	"GLALTX" AS GLALTX_consumption_tax_cross_reference,
	"GLALTZ" AS GLALTZ_gl_posting_code_alternate_z,
	"GLDLNA" AS GLDLNA_delete_not_allowed,
	"GLCFF1" AS GLCFF1_application_flag,
	"GLCFF2" AS GLCFF2_future_use,
	"GLASM" AS GLASM__lease_cost_ledger_posted_code,
	"GLBC" AS GLBC___bill_code,
	"GLVINV" AS GLVINV_ship_to_,
	"GLIVD" AS GLIVD__invoice_date,
	"GLWR01" AS GLWR01_phase,
	"GLPO" AS GLPO___ship_to_,
	"GLPSFX" AS GLPSFX_purchase_order_suffix,
	"GLDCTO" AS GLDCTO_order_type,
	"GLLNID" AS GLLNID_line_number,
	"GLWY" AS GLWY___fiscal_year_weekly,
	"GLWN" AS GLWN___fiscal_period_weekly,
	"GLFNLP" AS GLFNLP_closed_item,
	"GLOPSQ" AS GLOPSQ_operations_sequence_number,
	"GLJBCD" AS GLJBCD_job_type,
	"GLJBST" AS GLJBST_job_step,
	"GLHMCU" AS GLHMCU_home_business_unit,
	"GLDOI" AS GLDOI__doi_sub,
	"GLALID" AS GLALID_outsider_leasewell_id,
	"GLALTY" AS GLALTY_id_type,
	"GLDSVJ" AS GLDSVJ_servicetax_date,
	"GLTORG" AS GLTORG_transaction_originator,
	"GLREG#" AS GLREG#_registration_number,
	"GLPYID" AS GLPYID_payment_id_internal,
	"GLRNID" AS GLRNID_batch_run_id_internal,
	"GLBCRC" AS GLBCRC_base_currency,
	"GLHCO" AS GLHCO__company_originating,
	"GLDRFJ" AS GLDRFJ_gl_reference_date,
	"GLDCFL" AS GLDCFL_dual_currency_rate_override,
	"GLLRFL" AS GLLRFL_localization_flag,
	"GLABR1" AS GLABR1_enh_subledger_code_1,
	"GLABT1" AS GLABT1_enh_subledger_type_1,
	"GLABR2" AS GLABR2_enh_subledger_code_2,
	"GLABT2" AS GLABT2_enh_subledger_type_2,
	"GLABR3" AS GLABR3_enh_subledger_code_3,
	"GLABT3" AS GLABT3_enh_subledger_type_3,
	"GLABR4" AS GLABR4_enh_subledger_code_4,
	"GLABT4" AS GLABT4_enh_subledger_type_4,
	"GLCRRM" AS GLCRRM_mode_f,
	"GLPM01" AS GLPM01_posting_code_1_managerial_accounting,
	"GLPM02" AS GLPM02_intercompany_flag_localization,
	"GLPM03" AS GLPM03_posting_code_3_managerial_accounting,
	"GLPM04" AS GLPM04_posting_code_4_managerial_accounting,
	"GLPM05" AS GLPM05_posting_code_5_managerial_accounting,
	"GLPM06" AS GLPM06_posting_code_6_managerial_accounting,
	"GLPM07" AS GLPM07_posting_code_7_managerial_accounting,
	"GLPM08" AS GLPM08_posting_code_8_managerial_accounting,
	"GLPM09" AS GLPM09_posting_code_9_managerial_accounting,
	"GLPM10" AS GLPM10_revenue_account_flag_reason_code,
	"GLITM" AS GLITM__item_number_short,
	"GLUSER" AS GLUSER_user_id,
	"GLPID" AS GLPID__program_id,
	"GLJOBN" AS GLJOBN_work_station_id,
	"GLUPMJ" AS GLUPMJ_date_updated,
	"GLUPMT" AS GLUPMT_time_last_updated,
	"GLUPAJ" AS GLUPAJ_date_added,
	"GLPGEN" AS GLPGEN_post_generation_number,
	"GLTENT" AS GLTENT_time_entered 

-- INTO [Integration].F0911_account_ledger_Staging

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		GLKCO,
		GLDCT,
		GLDOC,
		DATE(DIGITS(DEC(GLDGJ+ 1900000,7,0))) AS GLDGJ,
		GLJELN,
		GLEXTL,
		GLPOST,
		GLICU,
		GLICUT,
		CASE WHEN GLDICJ IS NOT NULL THEN DATE(DIGITS(DEC(GLDICJ+ 1900000,7,0))) ELSE NULL END AS GLDICJ,
		CASE WHEN GLDSYJ IS NOT NULL THEN DATE(DIGITS(DEC(GLDSYJ+ 1900000,7,0))) ELSE NULL END AS GLDSYJ,
		GLTICU,
		GLCO,
		GLANI,
		GLAM,
		GLAID,
		GLMCU,
		GLOBJ,
		GLSUB,
		GLSBL,
		GLSBLT,
		GLLT,
		GLPN,
		GLCTRY,
		GLFY,
		GLFQ,
		GLCRCD,
		GLCRR,
		GLHCRR,
		CASE WHEN GLHDGJ IS NOT NULL THEN DATE(DIGITS(DEC(GLHDGJ+ 1900000,7,0))) ELSE NULL END AS GLHDGJ,
		CAST((GLAA)/100.0 AS DEC(15,2)) AS GLAA,
		CAST((GLU)/100.0 AS DEC(15,2)) AS GLU,
		GLUM,
		GLGLC,
		GLRE,
		GLEXA,
		GLEXR,
		GLR1,
		GLR2,
		GLR3,
		GLSFX,
		GLODOC,
		GLODCT,
		GLOSFX,
		GLPKCO,
		GLOKCO,
		GLPDCT,
		GLAN8,
		GLCN,
		CASE WHEN GLDKJ IS NOT NULL THEN DATE(DIGITS(DEC(GLDKJ+ 1900000,7,0))) ELSE NULL END AS GLDKJ,
		CASE WHEN GLDKC IS NOT NULL THEN DATE(DIGITS(DEC(GLDKC+ 1900000,7,0))) ELSE NULL END AS GLDKC,
		GLASID,
		GLBRE,
		GLRCND,
		GLSUMM,
		GLPRGE,
		GLTNN,
		GLALT1,
		GLALT2,
		GLALT3,
		GLALT4,
		GLALT5,
		GLALT6,
		GLALT7,
		GLALT8,
		GLALT9,
		GLALT0,
		GLALTT,
		GLALTU,
		GLALTV,
		GLALTW,
		GLALTX,
		GLALTZ,
		GLDLNA,
		GLCFF1,
		GLCFF2,
		GLASM,
		GLBC,
		GLVINV,
		CASE WHEN GLIVD IS NOT NULL THEN DATE(DIGITS(DEC(GLIVD+ 1900000,7,0))) ELSE NULL END AS GLIVD,
		GLWR01,
		GLPO,
		GLPSFX,
		GLDCTO,
		CAST((GLLNID)/1000.0 AS DEC(15,3)) AS GLLNID,
		GLWY,
		GLWN,
		GLFNLP,
		CAST((GLOPSQ)/100.0 AS DEC(15,2)) AS GLOPSQ,
		GLJBCD,
		GLJBST,
		GLHMCU,
		GLDOI,
		GLALID,
		GLALTY,
		CASE WHEN GLDSVJ IS NOT NULL THEN DATE(DIGITS(DEC(GLDSVJ+ 1900000,7,0))) ELSE NULL END AS GLDSVJ,
		GLTORG,
		GLREG#,
		GLPYID,
		GLRNID,
		GLBCRC,
		GLHCO,
		CASE WHEN GLDRFJ IS NOT NULL THEN DATE(DIGITS(DEC(GLDRFJ+ 1900000,7,0))) ELSE NULL END AS GLDRFJ,
		GLDCFL,
		GLLRFL,
		GLABR1,
		GLABT1,
		GLABR2,
		GLABT2,
		GLABR3,
		GLABT3,
		GLABR4,
		GLABT4,
		GLCRRM,
		GLPM01,
		GLPM02,
		GLPM03,
		GLPM04,
		GLPM05,
		GLPM06,
		GLPM07,
		GLPM08,
		GLPM09,
		GLPM10,
		GLITM,
		GLUSER,
		GLPID,
		GLJOBN,
		CASE WHEN GLUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(GLUPMJ+ 1900000,7,0))) ELSE NULL END AS GLUPMJ,
		GLUPMT,
		CASE WHEN GLUPAJ IS NOT NULL THEN DATE(DIGITS(DEC(GLUPAJ+ 1900000,7,0))) ELSE NULL END AS GLUPAJ,
		GLPGEN,
		GLTENT

	FROM
		ARCPDTA71.F0911
--    WHERE
--		GLDOC = 1483663
--        GLICU = 12736044
		
		
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------

ALTER TABLE Integration.F0911_account_ledger_Staging ADD CONSTRAINT
	F0911_account_ledger_Staging_pk PRIMARY KEY CLUSTERED 
	(
	GLDCT__document_type,
	GLDOC__document_number,
	GLKCO__document_company,
	GLDGJ__gl_date,
	GLJELN_journal_entry_line_number,
	GLLT___ledger_type,
	GLEXTL_line_extension_code
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO

