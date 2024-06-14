
--------------------------------------------------------------------------------
-- DROP TABLE Integration.F56CUSA2_CUSINF2A
--------------------------------------------------------------------------------

SELECT 

--  Top 1000
    "A5AN8" AS A5AN8__billto
,"ABALPH" AS ABALPH_alpha_name
,"ABAC01" AS ABAC01_category_code_01
,"ABAC04" AS ABAC04_geographic_region
,"ABAC10" AS ABAC10_category_code_10
,"ABCM" AS ABCM___credit_message
,"A5ACL" AS A5ACL__credit_limit
,"A5CLMG" AS A5CLMG_collection_manager
,"A5CMGR" AS A5CMGR_credit_manager
,"A5AVD" AS A5AVD__average_days_late
,"A5URAB" AS A5URAB_user_reserved_number
,"A5TSTA" AS A5TSTA_temporary_credit_message
,"A5AFC" AS A5AFC__apply_finance_charges_yn

,"A5DLC" AS A5DLC__date_of_last_credit_review

,"A5CYCN" AS A5CYCN_statement_cycle
,"MAPA8" AS MAPA8__parent_number
,"MAOSTP" AS MAOSTP_structure_type
,"A5BADT" AS A5BADT_billing_address_type
,"ALADDS" AS ALADDS_state
,"ALADDZ" AS ALADDZ_postal_code
,"ABATPR" AS ABATPR_user_code
,"ABAN82" AS ABAN82__2nd_address_number
,"ABEFTB" AS ABEFTB_start_effective_date
,"A5DLP" AS A5DLP__date_last_paid
,"QC$FLG" AS QC$FLG_reason_code
,"QB$A04" AS QB$A04_address_flag_future_4
,"A5RYIN" AS A5RYIN_payment_instrument
,"A5TRAR" AS A5TRAR_payment_terms_ar
,"WPAR1" AS WPAR1__prefix
,"WPPH1" AS WPPH1__phone_number
,"ALADD1" AS ALADD1_address_line_1
,"ALADD2" AS ALADD2_address_line_2
,"ALADD3" AS ALADD3_address_line_3
,"ALADD4" AS ALADD4_address_line_4
,"ALCTY1" AS ALCTY1_city
,"A5EXR1" AS A5EXR1_tax_expl_code
,"ABTAX" AS ABTAX__tax_id
,"ABTX2" AS ABTX2__addl_ind_tax_id
,"ABTXCT" AS ABTXCT_certificate
,"ALCTR" AS ALCTR__country
,"ABAC03" AS ABAC03_category_code_03
,"QB$RPC" AS QB$RPC_representative_preference_code 

 INTO Integration.F56CUSA2_CUSINF2A

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		A5AN8
,ABALPH
,ABAC01
,ABAC04
,ABAC10
,ABCM
,A5ACL
,A5CLMG
,A5CMGR
,A5AVD
,A5URAB
,A5TSTA
,A5AFC

--,A5DLC
--,CASE WHEN A5DLC IS NOT NULL THEN DATE(DIGITS(DEC(A5DLC+ 1900000,7,0))) ELSE NULL END AS A5DLC
,CASE WHEN A5DLC > 0 THEN DATE(DIGITS(DEC(A5DLC+ 1900000,7,0))) ELSE NULL END AS A5DLC

,A5CYCN
,MAPA8
,MAOSTP
,A5BADT
,ALADDS
,ALADDZ
,ABATPR
,ABAN82

--,ABEFTB 
--,CASE WHEN ABEFTB IS NOT NULL THEN DATE(DIGITS(DEC(ABEFTB+ 1900000,7,0))) ELSE NULL END AS ABEFTB
,CASE WHEN ABEFTB > 0 THEN DATE(DIGITS(DEC(ABEFTB+ 1900000,7,0))) ELSE NULL END AS ABEFTB

--,A5DLP
--,CASE WHEN A5DLP IS NOT NULL THEN DATE(DIGITS(DEC(A5DLP+ 1900000,7,0))) ELSE NULL END AS A5DLP
,CASE WHEN A5DLP > 0 THEN DATE(DIGITS(DEC(A5DLP+ 1900000,7,0))) ELSE NULL END AS A5DLP

,QC$FLG
,QB$A04
,A5RYIN
,A5TRAR
,WPAR1
,WPPH1
,ALADD1
,ALADD2
,ALADD3
,ALADD4
,ALCTY1
,A5EXR1
,ABTAX
,ABTX2
,ABTXCT
,ALCTR
,ABAC03
,QB$RPC

	FROM
		ARCUSRFLE.F56CUSA2
--    WHERE
--        A5AN8 = 1677735
    ORDER BY
        1
')

--------------------------------------------------------------------------------


-- err at rows 142 492