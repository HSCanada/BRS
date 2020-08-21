-- AR ETL setup
-- 23 Jan 18, tmc

--------------------------------------------------------------------------------
-- DROP TABLE Integration.F564201_accounts_receivable_detail_Staging
--------------------------------------------------------------------------------

SELECT 

	Top 5000 
	"LFAN8" AS LFAN8__billto,
	"LFALPH" AS LFALPH_alpha_name,
	"LFCO" AS LFCO___company,
	"LFDCT" AS LFDCT__document_type,
	"LFDOC" AS LFDOC__document_number,
	"LFSFX" AS LFSFX__pay_item,
	"LFDI" AS LFDI___invoice_date,
	"LFDD" AS LFDD___net_due_date,
	"LFAG" AS LFAG___gross_amount,
	"LFAAP" AS LFAAP__open_amount,
	"LFAG1" AS LFAG1__aging_amount_1,
	"LFAG2" AS LFAG2__aging_amount_2,
	"LFAG3" AS LFAG3__aging_amount_3,
	"LFAG4" AS LFAG4__aging_amount_4,
	"LFAG5" AS LFAG5__aging_amount_5,
	"LFAG6" AS LFAG6__aging_amount_6,
	"LF$DRA" AS LF$DRA_draft_amount,
	"LFMCU" AS LFMCU__business_unit,
	"LFPA8" AS LFPA8__parent_number,
	"LFCM" AS LFCM___credit_message,
	"LFMCU2" AS LFMCU2_business_unit_2,
	"LFAC08" AS LFAC08_market_segment,
	"LFAC04" AS LFAC04_practice_type,
	"LFAC10" AS LFAC10_division_code,
	"LFCMGR" AS LFCMGR_credit_representative,
	"LFVINV" AS LFVINV_ship_to_,
	"LFSDOC" AS LFSDOC_sales_document_number,
	"LFSDCT" AS LFSDCT_sales_document_type,
	"LFAC03" AS LFAC03_type_of_paying_customer,
	"LFADDS" AS LFADDS_state,
	"LFADDZ" AS LFADDZ_postal_code,
	"LFCLMG" AS LFCLMG_collection_representative,
	"LFVR01" AS LFVR01_reference,
	"LFTORG" AS LFTORG_transaction_originator,
	"LFACL" AS LFACL__credit_limit,
	"LFAFC" AS LFAFC__apply_late_charges_yn,
	"LFCYCN" AS LFCYCN_statement_cycle,
	"LFDCTM" AS LFDCTM_paymentitem_document_type,
	"LFDAOJ" AS LFDAOJ_date_account_opened,
	"LFPTC" AS LFPTC__payment_terms,
	"LFTRAR" AS LFTRAR_payment_terms_ar,
	"LFCTR" AS LFCTR__country,
	"LFDGJ" AS LFDGJ__gl_date,
	"LFBADT" AS LFBADT_billing_address_type,
	"LFSTMT" AS LFSTMT_print_statement_yn,
	"LFTRDJ" AS LFTRDJ_order_date,
	"LFDNLT" AS LFDNLT_delinquency_notice_yn,
	"LF$RPC" AS LF$RPC_credit_spread_flag,
	"LF$A04" AS LF$A04_credit_card_auto_pay,
	"LF$PRO" AS LF$PRO_preferred_credit_card,
	"LFADD1" AS LFADD1_business_name,
	"LFADD2" AS LFADD2_care_of_attn,
	"LFADD3" AS LFADD3_address_line_3,
	"LFADD4" AS LFADD4_address_line_4,
	"LFCTY1" AS LFCTY1_city,
	"LFCOUN" AS LFCOUN_county,
	"LFPH1" AS LFPH1__phone_number,
	"LFAVD" AS LFAVD__average_days_late,
	"LFASTY" AS LFASTY_invoiced_this_year,
	"LFSPYE" AS LFSPYE_invoiced_prior_year,
	"LFTSTA" AS LFTSTA_temporary_credit_message,
	"LFDLC" AS LFDLC__date_of_last_credit_review,
	"LFEXR1" AS LFEXR1_tax_expl_code,
	"LFTAX" AS LFTAX__tax_id,
	"LFHDAR" AS LFHDAR_hold_invoices,
	"LFSTTO" AS LFSTTO_send_statement_to,
	"LFSITO" AS LFSITO_send_invoice_to,
	"LFEXHD" AS LFEXHD_exempt_from_credit_hold,
	"LF$ACT" AS LF$ACT_active_inactive_flag,
	"LFAR1" AS LFAR1__prefix,
	"LF$AD1" AS LF$AD1_address_1 

INTO Integration.F564201_accounts_receivable_detail_Staging

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		LFAN8,
		LFALPH,
		LFCO,
		LFDCT,
		LFDOC,
		LFSFX,
		CASE WHEN LFDI IS NOT NULL THEN DATE(DIGITS(DEC(LFDI+ 1900000,7,0))) ELSE NULL END AS LFDI,
		CASE WHEN LFDD IS NOT NULL THEN DATE(DIGITS(DEC(LFDD+ 1900000,7,0))) ELSE NULL END AS LFDD,
		CAST((LFAG)/100.0 AS DEC(15,2)) AS LFAG,
		CAST((LFAAP)/100.0 AS DEC(15,2)) AS LFAAP,
		CAST((LFAG1)/100.0 AS DEC(15,2)) AS LFAG1,
		CAST((LFAG2)/100.0 AS DEC(15,2)) AS LFAG2,
		CAST((LFAG3)/100.0 AS DEC(15,2)) AS LFAG3,
		CAST((LFAG4)/100.0 AS DEC(15,2)) AS LFAG4,
		CAST((LFAG5)/100.0 AS DEC(15,2)) AS LFAG5,
		CAST((LFAG6)/100.0 AS DEC(15,2)) AS LFAG6,
		CAST((LF$DRA)/100.0 AS DEC(15,2)) AS LF$DRA,
		LFMCU,
		LFPA8,
		LFCM,
		LFMCU2,
		LFAC08,
		LFAC04,
		LFAC10,
		LFCMGR,
		LFVINV,
		LFSDOC,
		LFSDCT,
		LFAC03,
		LFADDS,
		LFADDZ,
		LFCLMG,
		LFVR01,
		LFTORG,
		LFACL,
		LFAFC,
		LFCYCN,
		LFDCTM,
		CASE WHEN LFDAOJ IS NOT NULL THEN DATE(DIGITS(DEC(LFDAOJ+ 1900000,7,0))) ELSE NULL END AS LFDAOJ,
		LFPTC,
		LFTRAR,
		LFCTR,
		CASE WHEN LFDGJ IS NOT NULL THEN DATE(DIGITS(DEC(LFDGJ+ 1900000,7,0))) ELSE NULL END AS LFDGJ,
		LFBADT,
		LFSTMT,
		CASE WHEN LFTRDJ IS NOT NULL THEN DATE(DIGITS(DEC(LFTRDJ+ 1900000,7,0))) ELSE NULL END AS LFTRDJ,
		LFDNLT,
		LF$RPC,
		LF$A04,
		LF$PRO,
		LFADD1,
		LFADD2,
		LFADD3,
		LFADD4,
		LFCTY1,
		LFCOUN,
		LFPH1,
		LFAVD,
		CAST((LFASTY)/100.0 AS DEC(15,2)) AS LFASTY,
		CAST((LFSPYE)/100.0 AS DEC(15,2)) AS LFSPYE,
		LFTSTA,
		CASE WHEN LFDLC IS NOT NULL THEN DATE(DIGITS(DEC(LFDLC+ 1900000,7,0))) ELSE NULL END AS LFDLC,
		LFEXR1,
		LFTAX,
		LFHDAR,
		LFSTTO,
		LFSITO,
		LFEXHD,
		LF$ACT,
		LFAR1,
		LF$AD1

	FROM
		ARCPDTA71.F564201
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------


SELECT        LFAN8__billto, LFCO___company, LFDCT__document_type, LFDOC__document_number, LFSFX__pay_item,  COUNT(*) AS Expr1
FROM            Integration.F564201_accounts_receivable_detail_Staging
GROUP BY LFAN8__billto, LFCO___company, LFDCT__document_type, LFDOC__document_number, LFSFX__pay_item
HAVING        (COUNT(*) > 1)


SELECT        *
FROM            Integration.F564201_accounts_receivable_detail_Staging
WHERE 
LFAN8__billto = 1530010 And
LFCO___company = 02000 And
LFDCT__document_type = 'RI' And
LFDOC__document_number = 13055572
