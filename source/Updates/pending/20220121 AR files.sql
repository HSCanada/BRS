
-- AR file,tmc,21 Jan 22

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
	top 100
	[LFAN8__billto]
      ,[LFDI___invoice_date_jul]
	,DATEADD (day,[LFDI___invoice_date_jul]%1000-1,
				DATEADD(year,[LFDI___invoice_date_jul]/1000,0 ) ) AS ADUPMJ_date_updated
--		,DATEADD(DAY, [LFDI___invoice_date_jul] - 2415021, '1900-01-01')
--		,CAST([LFDI___invoice_date_jul] - 2415021 as datetime)

      ,[LFDD___net_due_date_jul]
      ,[LFAAP__open_amount]
  FROM [Integration].[F564201_accounts_receivable_detail_Staging]


--------------------------------------------------------------------------------
-- DROP TABLE Integration.F564201_accounts_receivable_detail_Staging
--------------------------------------------------------------------------------

SELECT 

--    Top 5 
"LFAN8" AS LFAN8__billto
,"LFALPH" AS LFALPH_alpha_name
,"LFCO" AS LFCO___company
,"LFDCT" AS LFDCT__document_type
,"LFDOC" AS LFDOC__document_number
,"LFSFX" AS LFSFX__pay_item
,"LFDI" AS LFDI___invoice_date_jul
,"LFDD" AS LFDD___net_due_date_jul
,"LFAG" AS LFAG___gross_amount
,"LFAAP" AS LFAAP__open_amount
,"LFAG1" AS LFAG1__aging_amount_1
,"LFAG2" AS LFAG2__aging_amount_2
,"LFAG3" AS LFAG3__aging_amount_3
,"LFAG4" AS LFAG4__aging_amount_4
,"LFAG5" AS LFAG5__aging_amount_5
,"LFAG6" AS LFAG6__aging_amount_6
,"LF$DRA" AS LF$DRA_draft_amount
,"LFMCU" AS LFMCU__business_unit
,"LFPA8" AS LFPA8__parent_number
,"LFCM" AS LFCM___credit_message
,"LFMCU2" AS LFMCU2_business_unit_2
,"LFAC08" AS LFAC08_category_code_08
,"LFAC04" AS LFAC04_geographic_region
,"LFAC10" AS LFAC10_category_code_10
,"LFCMGR" AS LFCMGR_credit_manager
,"LFVINV" AS LFVINV_invoice_number
,"LFSDOC" AS LFSDOC_sales_document_number
,"LFSDCT" AS LFSDCT_sales_document_type
,"LFAC03" AS LFAC03_category_code_03
,"LFADDS" AS LFADDS_state
,"LFADDZ" AS LFADDZ_postal_code
,"LFCLMG" AS LFCLMG_collection_manager
,"LFVR01" AS LFVR01_reference
,"LFTORG" AS LFTORG_transaction_originator
,"LFACL" AS LFACL__credit_limit
,"LFAFC" AS LFAFC__apply_finance_charges_yn
,"LFCYCN" AS LFCYCN_statement_cycle
,"LFDCTM" AS LFDCTM_paymentitem_document_type
,"LFDAOJ" AS LFDAOJ_date_account_opened_jul
,"LFPTC" AS LFPTC__payment_terms
,"LFTRAR" AS LFTRAR_payment_terms_ar
,"LFCTR" AS LFCTR__country
,"LFDGJ" AS LFDGJ__gl_date_jul
,"LFBADT" AS LFBADT_billing_address_type
,"LFSTMT" AS LFSTMT_print_statement_yn
,"LFTRDJ" AS LFTRDJ_order_date_jul
,"LFDNLT" AS LFDNLT_delinquency_notice_yn
,"LF$RPC" AS LF$RPC_credit_spread_flag
,"LF$A04" AS LF$A04_credit_card_auto_pay
,"LF$PRO" AS LF$PRO_preferred_credit_card
,"LFADD1" AS LFADD1_address_line_1
,"LFADD2" AS LFADD2_address_line_2
,"LFADD3" AS LFADD3_address_line_3
,"LFADD4" AS LFADD4_address_line_4
,"LFCTY1" AS LFCTY1_city
,"LFCOUN" AS LFCOUN_county
,"LFPH1" AS LFPH1__phone_number
,"LFAVD" AS LFAVD__average_days_late
,"LFASTY" AS LFASTY_invoiced_this_year
,"LFSPYE" AS LFSPYE_invoiced_prior_year
,"LFTSTA" AS LFTSTA_temporary_credit_message
,"LFDLC" AS LFDLC__date_of_last_credit_review_jul
,"LFEXR1" AS LFEXR1_tax_expl_code
,"LFTAX" AS LFTAX__tax_id
,"LFHDAR" AS LFHDAR_hold_invoices
,"LFSTTO" AS LFSTTO_send_statement_to
,"LFSITO" AS LFSITO_send_invoice_to
,"LFEXHD" AS LFEXHD_exempt_from_credit_hold
,"LF$ACT" AS LF$ACT_active_inactive_flag
,"LFAR1" AS LFAR1__prefix
,"LF$AD1" AS LF$AD1_address_1 

INTO Integration.F564201_accounts_receivable_detail_Staging

FROM 
    OPENQUERY (ESYS_PROD
,'

	SELECT
LFAN8
,LFALPH
,LFCO
,LFDCT
,LFDOC
,LFSFX

,LFDI
--,CASE WHEN LFDI IS NOT NULL THEN DATE(DIGITS(DEC(LFDI+ 1900000,7,0))) ELSE NULL END AS LFDI

,LFDD
--,CASE WHEN LFDD IS NOT NULL THEN DATE(DIGITS(DEC(LFDD+ 1900000,7,0))) ELSE NULL END AS LFDD

,CAST((LFAG)/100.0 AS DEC(15,2)) AS LFAG
,CAST((LFAAP)/100.0 AS DEC(15,2)) AS LFAAP
,CAST((LFAG1)/100.0 AS DEC(15,2)) AS LFAG1
,CAST((LFAG2)/100.0 AS DEC(15,2)) AS LFAG2
,CAST((LFAG3)/100.0 AS DEC(15,2)) AS LFAG3
,CAST((LFAG4)/100.0 AS DEC(15,2)) AS LFAG4
,CAST((LFAG5)/100.0 AS DEC(15,2)) AS LFAG5
,CAST((LFAG6)/100.0 AS DEC(15,2)) AS LFAG6
,CAST((LF$DRA)/100.0 AS DEC(15,2)) AS LF$DRA
,LFMCU
,LFPA8
,LFCM
,LFMCU2
,LFAC08
,LFAC04
,LFAC10
,LFCMGR
,LFVINV
,LFSDOC
,LFSDCT
,LFAC03
,LFADDS
,LFADDZ
,LFCLMG
,LFVR01
,LFTORG
,LFACL
,LFAFC
,LFCYCN
,LFDCTM

,LFDAOJ
--,CASE WHEN LFDAOJ IS NOT NULL THEN DATE(DIGITS(DEC(LFDAOJ+ 1900000,7,0))) ELSE NULL END AS LFDAOJ

,LFPTC
,LFTRAR
,LFCTR

,LFDGJ
--,CASE WHEN LFDGJ IS NOT NULL THEN DATE(DIGITS(DEC(LFDGJ+ 1900000,7,0))) ELSE NULL END AS LFDGJ

,LFBADT
,LFSTMT

,LFTRDJ
--,CASE WHEN LFTRDJ IS NOT NULL THEN DATE(DIGITS(DEC(LFTRDJ+ 1900000,7,0))) ELSE NULL END AS LFTRDJ

,LFDNLT
,LF$RPC
,LF$A04
,LF$PRO
,LFADD1
,LFADD2
,LFADD3
,LFADD4
,LFCTY1
,LFCOUN
,LFPH1
,LFAVD
,CAST((LFASTY)/100.0 AS DEC(15,2)) AS LFASTY
,CAST((LFSPYE)/100.0 AS DEC(15,2)) AS LFSPYE
,LFTSTA

,LFDLC
--,CASE WHEN LFDLC IS NOT NULL THEN DATE(DIGITS(DEC(LFDLC+ 1900000,7,0))) ELSE NULL END AS LFDLC

,LFEXR1
,LFTAX
,LFHDAR
,LFSTTO
,LFSITO
,LFEXHD
,LF$ACT
,LFAR1
,LF$AD1

	FROM
		ARCPDTA71.F564201
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------
-- rows 77 209


--


--------------------------------------------------------------------------------
-- DROP TABLE Integration.F564201A_ar_monthly_aging_detail_Staging
--------------------------------------------------------------------------------

SELECT 

--    Top 5 
    "LFAN8" AS LFAN8__billto
,"LFALPH" AS LFALPH_alpha_name
,"LFCO" AS LFCO___company
,"LFDCT" AS LFDCT__document_type
,"LFDOC" AS LFDOC__document_number
,"LFSFX" AS LFSFX__pay_item
,"LFDI" AS LFDI___invoice_date_jul
,"LFDD" AS LFDD___net_due_date_jul
,"LFAG" AS LFAG___gross_amount
,"LFAAP" AS LFAAP__open_amount
,"LFAG1" AS LFAG1__aging_amount_1
,"LFAG2" AS LFAG2__aging_amount_2
,"LFAG3" AS LFAG3__aging_amount_3
,"LFAG4" AS LFAG4__aging_amount_4
,"LFAG5" AS LFAG5__aging_amount_5
,"LFAG6" AS LFAG6__aging_amount_6
,"LF$DRA" AS LF$DRA_draft_amount
,"LFMCU" AS LFMCU__business_unit
,"LFPA8" AS LFPA8__parent_number
,"LFCM" AS LFCM___credit_message
,"LFMCU2" AS LFMCU2_business_unit_2
,"LFAC08" AS LFAC08_category_code_08
,"LFAC04" AS LFAC04_geographic_region
,"LFAC10" AS LFAC10_category_code_10
,"LFCMGR" AS LFCMGR_credit_manager
,"LFFLAG" AS LFFLAG_journaling_flag
,"LFTKBY" AS LFTKBY_order_taken_by
,"LFDSC1" AS LFDSC1_description
,"LFZONR" AS LFZONR_replenishment_zone
,"LFRESU" AS LFRESU_result_field
,"LFCESL" AS LFCESL_annual_salary
,"LFTECD" AS LFTECD_taxing_entity_code
,"LFSSST" AS LFSSST_state
,"LF$GTY" AS LF$GTY_group_type
,"LFENTB" AS LFENTB_entered_by
,"LFDSC2" AS LFDSC2_description_2
,"LFZON" AS LFZON__zone_number
,"LF$RVA" AS LF$RVA_reversal_authorization
,"LFCCDF" AS LFCCDF_cost_center_dflt_fld
,"LFTAEC" AS LFTAEC_taxing_entity_code
,"LFUSER" AS LFUSER_user_id
,"LFDSC3" AS LFDSC3_description_line_3
,"LFAR1" AS LFAR1__prefix
,"LFPH1" AS LFPH1__phone_number
,"LFAC03" AS LFAC03_category_code_03
,"LFSDOC" AS LFSDOC_sales_document_number
,"LFSDCT" AS LFSDCT_sales_document_type
,"LFVINV" AS LFVINV_invoice_number
,"LF$TER" AS LF$TER_territory_code
,"LF$TSS" AS LF$TSS_tss_rep
,"LF$TSN" AS LF$TSN_tss_name
,"LF$D4D" AS LF$D4D_ccs_rep
,"LF$D4N" AS LF$D4N_ccs_name
,"LF$US1" AS LF$US1_user_reserved_reference
,"LF$US2" AS LF$US2_user_reserved_reference
,"LF$US3" AS LF$US3_user_reserved_reference
,"LF$US4" AS LF$US4_user_reserved_reference
,"LF$US5" AS LF$US5_user_reserved_reference 

INTO Integration.F564201A_ar_monthly_aging_detail_Staging

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
LFAN8
,LFALPH
,LFCO
,LFDCT
,LFDOC
,LFSFX

,LFDI
--,CASE WHEN LFDI IS NOT NULL THEN DATE(DIGITS(DEC(LFDI+ 1900000,7,0))) ELSE NULL END AS LFDI

,LFDD
--,CASE WHEN LFDD IS NOT NULL THEN DATE(DIGITS(DEC(LFDD+ 1900000,7,0))) ELSE NULL END AS LFDD

,CAST((LFAG)/100.0 AS DEC(15,2)) AS LFAG
,CAST((LFAAP)/100.0 AS DEC(15,2)) AS LFAAP
,CAST((LFAG1)/100.0 AS DEC(15,2)) AS LFAG1
,CAST((LFAG2)/100.0 AS DEC(15,2)) AS LFAG2
,CAST((LFAG3)/100.0 AS DEC(15,2)) AS LFAG3
,CAST((LFAG4)/100.0 AS DEC(15,2)) AS LFAG4
,CAST((LFAG5)/100.0 AS DEC(15,2)) AS LFAG5
,CAST((LFAG6)/100.0 AS DEC(15,2)) AS LFAG6
,CAST((LF$DRA)/100.0 AS DEC(15,2)) AS LF$DRA
,LFMCU
,LFPA8
,LFCM
,LFMCU2
,LFAC08
,LFAC04
,LFAC10
,LFCMGR
,LFFLAG
,LFTKBY
,LFDSC1
,LFZONR
,LFRESU
,LFCESL
,LFTECD
,LFSSST
,LF$GTY
,LFENTB
,LFDSC2
,LFZON
,LF$RVA
,LFCCDF
,LFTAEC
,LFUSER
,LFDSC3
,LFAR1
,LFPH1
,LFAC03
,LFSDOC
,LFSDCT
,LFVINV
,LF$TER
,LF$TSS
,LF$TSN
,LF$D4D
,LF$D4N
,LF$US1
,LF$US2
,LF$US3
,LF$US4
,LF$US5

	FROM
		ARCPDTA71.F564201A
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------
