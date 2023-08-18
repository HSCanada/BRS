-- free goods mix and match, tmc, 17 Nov 22
BEGIN TRANSACTION
GO
ALTER TABLE fg.chargeback ADD
	fg_supplier char(6) NULL,
	fg_external char(10) NULL,
	fg_note varchar(50) NULL
GO
ALTER TABLE fg.chargeback ADD CONSTRAINT
	FK_chargeback_BRS_ItemSupplier1 FOREIGN KEY
	(
	fg_supplier
	) REFERENCES dbo.BRS_ItemSupplier
	(
	Supplier
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.chargeback SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
CREATE UNIQUE NONCLUSTERED INDEX fg_chargeback_idx_u_01 ON fg.chargeback(fg_supplier)  where fg_supplier is not null WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA 
GO
ALTER TABLE fg.chargeback SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE fg.deal ADD
	fg_get_item_default char(10) NOT NULL CONSTRAINT DF_deal_fg_get_item_default DEFAULT ''
GO
ALTER TABLE fg.deal ADD CONSTRAINT
	FK_deal_BRS_Item FOREIGN KEY
	(
	fg_get_item_default
	) REFERENCES dbo.BRS_Item
	(
	Item
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.deal SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- CB

-- ** Fix date fields **

-- DROP TABLE STAGE_JDE_F5830
SELECT 
	top 1000

	"VA$CN2" AS contract_number,
	"VAKCOO" AS order_company,
	"VA$EON" AS manufacturers_external_contract_number,
	"VADESC" AS description,
	"VA$FD" AS start_date,
	"VA$TD" AS end_date,
	"VAEFTB" AS start_effective_date,
	"VA$DCA" AS date_contract_activated,
	"VAODDJ" AS original_due_date,
	"VADGCG" AS change_date,
	"VACNDJ" AS cancel_date,
	"VAEXDJ" AS expired_date,
	"VASRP6" AS category_code_6,
	"VA$MA1" AS alternate_manufacturer_1,
	"VA$MA2" AS alternate_manufacturer_2,
	"VA$MA3" AS alternate_manufacturer_3,
	"VA$MA4" AS alternate_manufacturer_4,
	"VA$MA5" AS alternate_manufacturer_5,
	"VA$MA6" AS alternate_manufacturer_6,
	"VAUSA1" AS address_number_1_user,
	"VAGCNT" AS contract_number_gpo,
	"VACRTU" AS created_by_user,
	"VACRDJ" AS creation_date,
	"VAUPMB" AS updated_by,
	"VA$SLM" AS sales_approval,
	"VA$VAP" AS vendor_approval,
	"VA$OTY" AS transaction_type,
	"VA$PCF" AS chargeback_cycle,
	"VA$AFC" AS admin_fee_cycle,
	"VA$OTP" AS chargeback_output_type,
	"VA$CST" AS status_chargebacks,
	"VA$FGY" AS multi_purpose_flag,
	"VA$CRN" AS number_contract_cross_reference,
	"VA$IAS" AS status_include_all_sales,
	"VA$FMT" AS edi_document_format,
	"VA$HIN" AS hindea_required,
	"VA$CPT" AS chargeback_payment_type,
	"VA$SCG" AS service_charge_percent_admin_fee,
	"VA$PC1" AS chargeback_percent_factors_1,
	"VA$FC1" AS chargeback_dollar_factors_1,
	"VA$RET" AS retro,
	"VA$RPV" AS retro_processed_values,
	"VA$RD" AS reset_chargeback_data,
	"VA$RC" AS recurring_chargeback,
	"VA$CL" AS chargeback_calc_type,
	"VA$TOC" AS type_of_cost,
	"VA$CAL" AS contract_accumulation_level,
	"VA$BIS" AS bid_incoming_sequence_number,
	"VA$CLV" AS contract_level,
	"VALINN" AS line_number,
	"VABA" AS beginning_gl_account_number,
	"VARP07" AS line_of_business,
	"VARP10" AS category_code_10,
	"VA$FG1" AS flag_1,
	"VA$CMT" AS comment,
	"VACONC" AS compressed_contract_name,
	"VAPH2" AS phone_number,
	"VAEML" AS email_address,
	"VAURAT" AS user_reserved_amount,
	"VAURCD" AS user_reserved_code,
	"VAURDT" AS user_reserved_date,
	"VAURAB" AS user_reserved_number,
	"VAURRF" AS user_reserved_reference,
	"VA$RV1" AS user_reserved_field,
	"VA$RV2" AS user_reserved_field_2,
	"VA$RV3" AS user_reserved_field_3,
	"VA$RV4" AS user_reserved_field_4,
	"VA$RV5" AS user_reserved_field_5,
	"VAURC1" AS user_reserved_code_2,
	"VAURC2" AS user_reserved_code_3,
	"VAUSD1" AS user_date_1,
	"VAUSD2" AS user_date_2,
	"VAUSD3" AS user_date_3,
	"VAUDC1" AS user_defined_code__1,
	"VAUDC2" AS user_defined_code__2,
	"VAUDC3" AS user_defined_code__3,
	"VA$AM1" AS user_amount_future_1,
	"VA$AM2" AS user_amount_future_2,
	"VA$AM3" AS user_amount_future_3,
	"VAUSER" AS user_id,
	"VAJOBN" AS work_station_id,
	"VAPID" AS program_id,
	"VAUPMJ" AS date_updated,
	"VATDAY" AS time_of_day 

-- INTO STAGE_JDE_F5830b

FROM 
    OPENQUERY (ESYS_PROD, '
	SELECT
		VA$CN2,
		VAKCOO,
		VA$EON,
		VADESC,
		CASE WHEN VA$FD IS NOT NULL THEN DATE(DIGITS(DEC(VA$FD+ 1900000,7,0))) ELSE NULL END AS VA$FD,
--		CAST(VA$FD AS CHAR(10)) AS VA$FD,

		CASE WHEN VA$TD IS NOT NULL THEN DATE(DIGITS(DEC(VA$TD+ 1900000,7,0))) ELSE NULL END AS VA$TD,
--		CAST(VA$TD AS CHAR(10)) AS VA$TD,

		CASE WHEN VAEFTB IS NOT NULL THEN DATE(DIGITS(DEC(VAEFTB+ 1900000,7,0))) ELSE NULL END AS VAEFTB,
--		CAST(VAEFTB AS CHAR(10)) AS VAEFTB,

		CASE WHEN VA$DCA IS NOT NULL THEN DATE(DIGITS(DEC(VA$DCA+ 1900000,7,0))) ELSE NULL END AS VA$DCA,
--		CAST(VA$DCA AS CHAR(10)) AS VA$DCA,

--		CASE WHEN VAODDJ IS NOT NULL THEN DATE(DIGITS(DEC(VAODDJ+ 1900000,7,0))) ELSE NULL END AS VAODDJ,
		CAST(VAODDJ AS CHAR(10)) AS VAODDJ,

--		CASE WHEN VADGCG IS NOT NULL THEN DATE(DIGITS(DEC(VADGCG+ 1900000,7,0))) ELSE NULL END AS VADGCG,
		CAST(VADGCG AS CHAR(10)) AS VADGCG,

--		CASE WHEN VACNDJ IS NOT NULL THEN DATE(DIGITS(DEC(VACNDJ+ 1900000,7,0))) ELSE NULL END AS VACNDJ,
		CAST(VACNDJ AS CHAR(10)) AS VACNDJ,

--		CASE WHEN VAEXDJ IS NOT NULL THEN DATE(DIGITS(DEC(VAEXDJ+ 1900000,7,0))) ELSE NULL END AS VAEXDJ,
		CAST(VAEXDJ AS CHAR(10)) AS VAEXDJ,

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
--		CASE WHEN VACRDJ IS NOT NULL THEN DATE(DIGITS(DEC(VACRDJ+ 1900000,7,0))) ELSE NULL END AS VACRDJ,
		CAST(VACRDJ AS CHAR(10)) AS VACRDJ,

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
--		CASE WHEN VAURDT IS NOT NULL THEN DATE(DIGITS(DEC(VAURDT+ 1900000,7,0))) ELSE NULL END AS VAURDT,
		CAST(VAURDT AS CHAR(10)) AS VAURDT,

		VAURAB,
		VAURRF,
		VA$RV1,
		VA$RV2,
		VA$RV3,
		VA$RV4,
		VA$RV5,
		VAURC1,
		VAURC2,
--		CASE WHEN VAUSD1 IS NOT NULL THEN DATE(DIGITS(DEC(VAUSD1+ 1900000,7,0))) ELSE NULL END AS VAUSD1,
		CAST(VAUSD1 AS CHAR(10)) AS VAUSD1,

--		CASE WHEN VAUSD2 IS NOT NULL THEN DATE(DIGITS(DEC(VAUSD2+ 1900000,7,0))) ELSE NULL END AS VAUSD2,
		CAST(VAUSD2 AS CHAR(10)) AS VAUSD2,

--		CASE WHEN VAUSD3 IS NOT NULL THEN DATE(DIGITS(DEC(VAUSD3+ 1900000,7,0))) ELSE NULL END AS VAUSD3,
		CAST(VAUSD3 AS CHAR(10)) AS VAUSD3,

		VAUDC1,
		VAUDC2,
		VAUDC3,
		CAST((VA$AM1)/100.0 AS DEC(15,2)) AS VA$AM1,
		CAST((VA$AM2)/100.0 AS DEC(15,2)) AS VA$AM2,
		CAST((VA$AM3)/100.0 AS DEC(15,2)) AS VA$AM3,
		VAUSER,
		VAJOBN,
		VAPID,
--		CASE WHEN VAUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(VAUPMJ+ 1900000,7,0))) ELSE NULL END AS VAUPMJ,
		CAST(VAUPMJ AS CHAR(10)) AS VAUPMJ,

		VATDAY

	FROM
		HSIPDTA71.F5830
')

		ARCPDTA71.F5830

--

--------------------------------------------------------------------------------
-- DROP TABLE Integration.ARCPDTA71_F5830MB_<instert_friendly_name_here>
--------------------------------------------------------------------------------

SELECT 

    Top 5 
	*

--    "MA$CN2" AS MA$CN2_contract_number, "MAKCOO" AS MAKCOO_order_company, "MA$CAL" AS MA$CAL_contract_accumulation_level, "MA$EON" AS MA$EON_vendors_contract, "MADESC" AS MADESC_contract_description, "MA$FD" AS MA$FD__start_date, "MA$TD" AS MA$TD__end_date, "MASRP6" AS MASRP6_category_code_6, "MA$GPO" AS MA$GPO_contract_type, "MA$CRN" AS MA$CRN_gpo_tier, "MADOCU" AS MADOCU_gpo_paperwork, "MAGCNT" AS MAGCNT_gpo_contract_number, "MA$VAP" AS MA$VAP_product_group, "MA$CMT" AS MA$CMT_gpo_requirements, "MACONC" AS MACONC_contact_name, "MAPH2" AS MAPH2__contact_phone_number, "MAEML1" AS MAEML1_contact_email, "MAEML2" AS MAEML2_supplier_finance_email, "MAYN" AS MAYN___send_manual_cb_excel, "MAEML" AS MAEML__override_email_for_send_manual_cb_excel, "MA$SEQ" AS MA$SEQ_contract_priority, "MAUDC1" AS MAUDC1_marketing_adj_off_"y"on"_", "MAUDC2" AS MAUDC2_freight_factor_off_"y"on"_", "MA$HIN" AS MA$HIN_customer_reference, "MA$RV4" AS MA$RV4_use_contr_cost_for_cb"y", "MA$CON" AS MA$CON_replaces_contract, "MACDC" AS MACDC__replaced_by_contract, "MAURAT" AS MAURAT_user_reserved_amount, "MAURCD" AS MAURCD_user_reserved_code, "MAURDT" AS MAURDT_user_reserved_date, "MAURAB" AS MAURAB_user_reserved_number, "MAURRF" AS MAURRF_user_reserved_reference, "MA$RV1" AS MA$RV1_user_reserved_field, "MA$RV2" AS MA$RV2_user_reserved_field, "MA$RV3" AS MA$RV3_user_reserved_field, "MA$RV5" AS MA$RV5_user_reserved_field, "MAURC1" AS MAURC1_cl_shipto_s, "MAURC2" AS MAURC2_user_reserved_code, "MAUSD1" AS MAUSD1_user_date_1, "MAUSD2" AS MAUSD2_user_date_2, "MAUSD3" AS MAUSD3_user_date_3, "MAUDC3" AS MAUDC3_user_defined_code__3, "MA$AM1" AS MA$AM1_user_amount_future_1, "MA$AM2" AS MA$AM2_user_amount_future_2, "MA$AM3" AS MA$AM3_user_amount_future_3, "MAUSER" AS MAUSER_user_id, "MAJOBN" AS MAJOBN_work_station_id, "MAPID" AS MAPID__program_id, "MAUPMJ" AS MAUPMJ_date_updated, "MATDAY" AS MATDAY_time_of_day 

-- INTO Integration.ARCPDTA71_F5830MB_<instert_friendly_name_here>

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		MA$CN2, MAKCOO, MA$CAL, MA$EON, MADESC, CASE WHEN MA$FD IS NOT NULL THEN DATE(DIGITS(DEC(MA$FD+ 1900000,7,0))) ELSE NULL END AS MA$FD, CASE WHEN MA$TD IS NOT NULL THEN DATE(DIGITS(DEC(MA$TD+ 1900000,7,0))) ELSE NULL END AS MA$TD, MASRP6, MA$GPO, MA$CRN, MADOCU, MAGCNT, MA$VAP, MA$CMT, MACONC, MAPH2, MAEML1, MAEML2, MAYN, MAEML, MA$SEQ, MAUDC1, MAUDC2, MA$HIN, MA$RV4, MA$CON, MACDC, CAST((MAURAT)/100.0 AS DEC(15,2)) AS MAURAT, MAURCD, CASE WHEN MAURDT IS NOT NULL THEN DATE(DIGITS(DEC(MAURDT+ 1900000,7,0))) ELSE NULL END AS MAURDT, MAURAB, MAURRF, MA$RV1, MA$RV2, MA$RV3, MA$RV5, MAURC1, MAURC2, CASE WHEN MAUSD1 IS NOT NULL THEN DATE(DIGITS(DEC(MAUSD1+ 1900000,7,0))) ELSE NULL END AS MAUSD1, CASE WHEN MAUSD2 IS NOT NULL THEN DATE(DIGITS(DEC(MAUSD2+ 1900000,7,0))) ELSE NULL END AS MAUSD2, CASE WHEN MAUSD3 IS NOT NULL THEN DATE(DIGITS(DEC(MAUSD3+ 1900000,7,0))) ELSE NULL END AS MAUSD3, MAUDC3, CAST((MA$AM1)/100.0 AS DEC(15,2)) AS MA$AM1, CAST((MA$AM2)/100.0 AS DEC(15,2)) AS MA$AM2, CAST((MA$AM3)/100.0 AS DEC(15,2)) AS MA$AM3, MAUSER, MAJOBN, MAPID, CASE WHEN MAUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(MAUPMJ+ 1900000,7,0))) ELSE NULL END AS MAUPMJ, MATDAY

	FROM
		ARCPDTA71.F5830MB
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------

--

-- ** Fix bad date **
-- DROP TABLE STAGE_JDE_F5831

SELECT 
	top 10

    "VB$CN2" AS contract_number,
	"VBKCOO" AS order_company,
	"VB$EON" AS manufacturers_external_contract_number,
	"VBSRP6" AS category_code_6,
	"VBLITM" AS item_number,
	"VBCITM" AS customersupplier_item_number,
	"VBSRP1" AS sales_catalog_section,
	"VBSRP2" AS sub_section,
	"VBSRP3" AS sales_category_code_3,
	"VBSRP4" AS sales_category_code_4,
	"VBLINN" AS line_number,
	"VB$FD" AS start_date,
	"VB$TD" AS end_date,
	"VB$CCC" AS cost_contract_cost_chargebacks,
	"VB$FC1" AS chargeback_dollar_factors_1,
	"VB$PC1" AS chargeback_percent_factors_1,
	"VB$MNC" AS manual_cost_chargebacks,
	"VB$IS" AS contract_item_status,
	"VBCRTU" AS created_by_user,
	"VBCRDJ" AS creation_date,
	"VBDGCG" AS change_date,
	"VBUPMB" AS updated_by,
	"VB$CRN" AS number_contract_cross_reference,
	"VBAC10" AS category_code_10,
	"VBSIC" AS industry_classification,
	"VBURAT" AS user_reserved_amount,
	"VBURCD" AS user_reserved_code,
	"VBURDT" AS user_reserved_date,
	"VBURAB" AS user_reserved_number,
	"VBURRF" AS user_reserved_reference,
	"VB$RV1" AS user_reserved_field_1,
	"VB$RV2" AS user_reserved_field_2,
	"VB$RV3" AS user_reserved_field_3,
	"VB$RV4" AS user_reserved_field_4,
	"VB$RV5" AS user_reserved_field_5,
	"VBURC1" AS user_reserved_code_1,
	"VBURC2" AS user_reserved_code_2,
	"VBUSD1" AS user_date_1,
	"VBUSD2" AS user_date_2,
	"VBUSD3" AS user_date_3,
	"VBUDC1" AS user_defined_code_1,
	"VBUDC2" AS user_defined_code_2,
	"VBUDC3" AS user_defined_code_3,
	"VB$AM1" AS user_amount_future_1,
	"VB$AM2" AS user_amount_future_2,
	"VB$AM3" AS user_amount_future_3,
	"VBUSER" AS user_id,
	"VBJOBN" AS work_station_id,
	"VBPID" AS program_id,
	"VBUPMJ" AS date_updated,
	"VBTDAY" AS time_of_day 

-- INTO STAGE_JDE_F5831

FROM 
    OPENQUERY (ESYS_PROD, '

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
		CASE WHEN VB$FD IS NOT NULL THEN DATE(DIGITS(DEC(VB$FD+ 1900000,7,0))) ELSE NULL END AS VB$FD,
		CASE WHEN VB$TD IS NOT NULL THEN DATE(DIGITS(DEC(VB$TD+ 1900000,7,0))) ELSE NULL END AS VB$TD,
		CAST((VB$CCC)/100.0 AS DEC(15,2)) AS VB$CCC,
		CAST((VB$FC1)/100.0 AS DEC(15,2)) AS VB$FC1,
		CAST((VB$PC1)/100.0 AS DEC(15,2)) AS VB$PC1,
		CAST((VB$MNC)/100.0 AS DEC(15,2)) AS VB$MNC,
		VB$IS,
		VBCRTU,
		CASE WHEN VBCRDJ IS NOT NULL THEN DATE(DIGITS(DEC(VBCRDJ+ 1900000,7,0))) ELSE NULL END AS VBCRDJ,
		CASE WHEN VBDGCG IS NOT NULL THEN DATE(DIGITS(DEC(VBDGCG+ 1900000,7,0))) ELSE NULL END AS VBDGCG,
		VBUPMB,
		VB$CRN,
		VBAC10,
		VBSIC,
		CAST((VBURAT)/100.0 AS DEC(15,2)) AS VBURAT,
		VBURCD,
		CASE WHEN VBURDT IS NOT NULL THEN DATE(DIGITS(DEC(VBURDT+ 1900000,7,0))) ELSE NULL END AS VBURDT,
		VBURAB,
		VBURRF,
		VB$RV1,
		VB$RV2,
		VB$RV3,
		VB$RV4,
		VB$RV5,
		VBURC1,
		VBURC2,
		CASE WHEN VBUSD1 IS NOT NULL THEN DATE(DIGITS(DEC(VBUSD1+ 1900000,7,0))) ELSE NULL END AS VBUSD1,
		CASE WHEN VBUSD2 IS NOT NULL THEN DATE(DIGITS(DEC(VBUSD2+ 1900000,7,0))) ELSE NULL END AS VBUSD2,
		CASE WHEN VBUSD3 IS NOT NULL THEN DATE(DIGITS(DEC(VBUSD3+ 1900000,7,0))) ELSE NULL END AS VBUSD3,
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
	order by VBUPMJ desc
')


--

--

-- DROP TABLE STAGE_JDE_F5832

SELECT 
	top 10

	"VE$CN2" AS contract_number,
	"VE$EON" AS manufacturers_external_contract_number,
	"VEKCOO" AS order_company,
	"VE$CAL" AS contract_accumulation_level,
	"VE$SNB" AS sequence_number,
	"VEASN" AS adjustment_schedule,
	"VE$CGP" AS customer_group_id,
	"VEAC10" AS category_code_10,
	"VEAC02" AS account_representative,
	"VESIC" AS industry_classification,
	"VELINN" AS line_number,
	"VECRTU" AS created_by_user,
	"VECRDJ" AS creation_date,
	"VERCDS" AS record_status,
	"VEUPMB" AS updated_by,
	"VEDGCG" AS change_date,
	"VEURAT" AS user_reserved_amount,
	"VEURCD" AS user_reserved_code,
	"VEURDT" AS user_reserved_date,
	"VEURAB" AS user_reserved_number,
	"VEURRF" AS user_reserved_reference,
	"VE$RV1" AS user_reserved_field,
	"VE$RV2" AS user_reserved_field,
	"VE$RV3" AS user_reserved_field,
	"VE$RV4" AS user_reserved_field,
	"VE$RV5" AS user_reserved_field,
	"VEURC1" AS user_reserved_code,
	"VEURC2" AS user_reserved_code,
	"VEUSD1" AS user_date_1,
	"VEUSD2" AS user_date_2,
	"VEUSD3" AS user_date_3,
	"VEUDC1" AS user_defined_code__1,
	"VEUDC2" AS user_defined_code__2,
	"VEUDC3" AS user_defined_code__3,
	"VE$AM1" AS user_amount_future_1,
	"VE$AM2" AS user_amount_future_2,
	"VE$AM3" AS user_amount_future_3,
	"VEUSER" AS user_id,
	"VEPID" AS program_id,
	"VEJOBN" AS work_station_id,
	"VEUPMJ" AS date_updated,
	"VETDAY" AS time_of_day 

-- INTO STAGE_JDE_F5832

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		VE$CN2,
		VE$EON,
		VEKCOO,
		VE$CAL,
		CAST((VE$SNB)/100.0 AS DEC(15,2)) AS VE$SNB,
		VEASN,
		VE$CGP,
		VEAC10,
		VEAC02,
		VESIC,
		CAST((VELINN)/1000.0 AS DEC(15,3)) AS VELINN,
		VECRTU,
		CASE WHEN VECRDJ IS NOT NULL THEN DATE(DIGITS(DEC(VECRDJ+ 1900000,7,0))) ELSE NULL END AS VECRDJ,
		VERCDS,
		VEUPMB,
		CASE WHEN VEDGCG IS NOT NULL THEN DATE(DIGITS(DEC(VEDGCG+ 1900000,7,0))) ELSE NULL END AS VEDGCG,
		CAST((VEURAT)/100.0 AS DEC(15,2)) AS VEURAT,
		VEURCD,
		CASE WHEN VEURDT IS NOT NULL THEN DATE(DIGITS(DEC(VEURDT+ 1900000,7,0))) ELSE NULL END AS VEURDT,
		VEURAB,
		VEURRF,
		VE$RV1,
		VE$RV2,
		VE$RV3,
		VE$RV4,
		VE$RV5,
		VEURC1,
		VEURC2,
		CASE WHEN VEUSD1 IS NOT NULL THEN DATE(DIGITS(DEC(VEUSD1+ 1900000,7,0))) ELSE NULL END AS VEUSD1,
		CASE WHEN VEUSD2 IS NOT NULL THEN DATE(DIGITS(DEC(VEUSD2+ 1900000,7,0))) ELSE NULL END AS VEUSD2,
		CASE WHEN VEUSD3 IS NOT NULL THEN DATE(DIGITS(DEC(VEUSD3+ 1900000,7,0))) ELSE NULL END AS VEUSD3,
		VEUDC1,
		VEUDC2,
		VEUDC3,
		CAST((VE$AM1)/100.0 AS DEC(15,2)) AS VE$AM1,
		CAST((VE$AM2)/100.0 AS DEC(15,2)) AS VE$AM2,
		CAST((VE$AM3)/100.0 AS DEC(15,2)) AS VE$AM3,
		VEUSER,
		VEPID,
		VEJOBN,
		CASE WHEN VEUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(VEUPMJ+ 1900000,7,0))) ELSE NULL END AS VEUPMJ,
		VETDAY


	FROM
		ARCPDTA71.F5832
')

--


SELECT top 10 * from OPENQUERY (ESYS_PROD, '	
	SELECT
		*
 	FROM
--		ARCPDTA71.W564101Z -- not same
--		HSIPDTA71.IV0031 -- works
		ARCPDTA71.IV0031 -- works
--		HSIPCORDTA.IV0031 -- old
--		ARCPCORDTA.IV0031 -- old

	WHERE 
	QILITM like ''BAY%''
--	QI$ACC = ''''
--	order by QICADT desc
	-- VA$CN2 = 1732065
')

--

select 
[WKDOCO_salesorder_number] 
,[WKDCTO_order_type]
,[line_id]
FROM 
[Integration].[F5554240_fg_redeem_Staging]

-- add new dummy orders

			INSERT INTO 
				BRS_TransactionDW_Ext (
					SalesOrderNumber, 
					DocType, 
					CustomerPOText1
				)
			SELECT     distinct 
				s.[WKDOCO_salesorder_number] AS SalesOrderNumber, 
				s.[WKDCTO_order_type] AS DocType,
				'FGDUMMY' as po
			FROM         
	[Integration].[F5554240_fg_redeem_Staging] s
			WHERE     NOT EXISTS
			(
				Select 
					* 
				From 
					BRS_TransactionDW_Ext s
				Where 
					[WKDOCO_salesorder_number] = s.SalesOrderNumber And
					[WKDCTO_order_type] = s.DocType 
			)

-- add new dummy lines
			INSERT INTO BRS_TransactionDW
			(
				SalesOrderNumber, 
				DocType, 
				LineNumber, 
				CalMonth, 
				Date, 
				Shipto, 
				Item, 

				EnteredBy, 
				OrderTakenBy, 
				OrderSourceCode, 
				CustomerPOText1, 
				PriceMethod, 
				VPA, 

				LineTypeOrder, 
				SalesDivision, 
				MajorProductClass, 

				ChargebackContractNumber, 
				GLBusinessUnit, 
				OrderFirstShipDate, 
				InvoiceNumber, 

				--  09 Dec 16	tmc		Update Metrics load logic
				ShippedQty, 
				GPAmt, 
				GPAtFileCostAmt, 
				GPAtCommCostAmt, 
				ExtChargebackAmt, 
				NetSalesAmt, 
				PromotionCode,
				OrderPromotionCode,

				-- Custom Logic Section BEGIN -----------------------------------------

				ExtPriceORG,                    
				ExtListPriceORG, 
               
				BackorderInd,                 
				FreeGoodsRedeemedInd,

				[OriginalSalesOrderNumber],		-- [OORN]		
				[OriginalOrderDocumentType],	-- [OORTY]		
				[OriginalOrderLineNumber],		-- [OORLINO]	

				FreeGoodsInvoicedInd,   
				FreeGoodsEstInd,  
              
				ExtListPrice,
				ExtPrice,

				ExtDiscAmt,                     


				-- Custom Logic Section END -------------------------------------------

				[PricingAdjustmentLine],		-- [PCADLINO]	
				[SalesOrderBilltoNumber],		-- [BTADNO]	
				[EssCode],						-- [ESSCD]		
				[CcsCode],						-- [CCSCD]		
				[EstCode],						-- [ESTCD]		
				[TssCode],						-- [TSSCD]		
				[CagCode],						-- [CAGREPCD]	
				[EquipmentOrderNumber],			-- [EQORDNO]	
				[EquipmentOrderType]			-- [EQORDTYCD]	

				)
				SELECT     

				s.[WKDOCO_salesorder_number] AS SalesOrderNumber, 
				s.[WKDCTO_order_type] AS DocType, 
				ROUND(s.[line_id] * 1000,0) AS LineNumber, 

				202306 AS CalMonth, 
				CONVERT(DATE,s.WKDATE_order_date_text) AS Date, 
				s.[WKSHAN_shipto] AS Shipto, 
				s.[WKLITM_item_number] AS Item, 

				'' AS EnteredBy, 
				'' AS OrderTakenBy, 
				'' AS OrderSourceCode, 
				LEFT(s.[WKDSC1_description],25) AS CustomerPOText1, 
				'' AS PriceMethod, 
				'' AS VPA, 

				'' AS LineTypeOrder, 
				s.[WKAC10_division_code] AS SalesDivision, 
				'' AS MajorProductClass, 

				--  16 Jan 17   tmc     Fixed Chargeback Number load so * maps to 0
				CASE WHEN s.[WK$ODN_free_goods_contract_number] = '*' THEN 0 ELSE ISNULL(s.[WK$ODN_free_goods_contract_number],0) END AS ChargebackContractNumber, 
		--		ISNULL(s.CBCONTRNO,0) AS ChargebackContractNumber, 
				'' AS GLBusinessUnit, 
				'1980-01-10' AS OrderFirstShipDate, 
				-- ISNULL(s.ORFISHDT, '1 Jan 1980') AS OrderFirstShipDate, 
				'' AS InvoiceNumber, 

				--  09 Dec 16	tmc		Update Metrics load logic
				s.[WKUORG_quantity] AS ShippedQty, 

				0 AS GPAmt, 
				0 AS GPAtFileCostAmt, 
				0 AS GPAtCommCostAmt, 
				0 AS ExtChargebackAmt, 
				0 AS NetSalesAmt,
				'' AS PromotionCode, 
				'' AS OrderPromotionCode,

				-- Custom Logic Section BEGIN 

				-- store ORG, ~ORG will be modified to follow
				0                                       AS ExtPriceORG,         
				0                                       AS ExtListPriceORG,     

				0                                              AS BackorderInd,		
				0                                               AS FreeGoodsRedeemedInd,

				-- Copy SO where Original SO missing to make Credit rebill matching easy
				0                                             AS OriginalSalesOrderNumber,		 

				'' 	                                            AS OriginalOrderDocumentType,	 

				0 	                                            AS OriginalOrderLineNumber,	

				0                                             AS FreeGoodsInvoicedInd,
		--      CASE WHEN ShippedQty <> 0 AND NetSalesAmt = 0 AND ABS(GPAtFileCostAmt) > 0.02 * ShippedQty THEN 1 ELSE 0 END AS FreeGoodsInvoicedInd

				-- Free goods estimate model can be improved, 27 Jan 17
				0                                              AS FreeGoodsEstInd,

				-- Correct Ext List on price adjusmtent as the DW field incorrect
				0                                             AS ExtListPrice,

				/*
		SET              
			ExtListPrice    = CASE WHEN LineTypeOrder IN ('CP', 'CL', 'CE')     THEN CASE WHEN LineTypeOrder = 'CE' THEN NetSalesAmt ELSE 0 END ELSE ExtListPriceORG END	
			, ExtPrice        = CASE WHEN OrderSourceCode IN ('A', 'L', 'K')    THEN NetSalesAmt ELSE ExtPriceORG END
		*/

				-- Correct Ext Price for non Advanced price as the DW field incorrect
				0                                           AS ExtPrice,

				-- Calc Total Discount based on correct fields.  Ugly Dup code needed?
				-- SUM(t.ExtListPrice  + t.ExtPrice -2*NetSalesAmt) AS ExtDiscTotal,

							- 
				0                       AS ExtDiscAmt,


				-- Custom Logic Section END 
	 
				''	AS	PricingAdjustmentLine,		 
				0		AS	SalesOrderBilltoNumber,		 
				''		AS	EssCode,						 
				''		AS	CcsCode,						 
				''		AS	EstCode,						 
				''		AS	TssCode,						 
				''	AS	CagCode,						 
				''	AS	EquipmentOrderNumber,			 
				''	AS	EquipmentOrderType			 
FROM
[Integration].[F5554240_fg_redeem_Staging] s


			WHERE     NOT EXISTS
			(
				Select 
					* 
				From 
					BRS_TransactionDW s2
				Where 
					[WKDOCO_salesorder_number] = s2.SalesOrderNumber And
					[WKDCTO_order_type] = s2.DocType And
					ROUND(s.[line_id] * 1000,0) = s2.LineNumber
			)

-- add CB contract

INSERT INTO [fg].[chargeback]
(
[cb_contract_num]
,[cb_contract_cd]
,[note_txt]
)
select distinct [WK$ODN_free_goods_contract_number], 'FGCBA', 'TC CB auto'  FROM
[Integration].[F5554240_fg_redeem_Staging] s
where [WK$ODN_free_goods_contract_number] is not null

-- hack to added test promo for RI
insert into
[dbo].[BRS_Promotion]
(
[PromotionCode]
)
select distinct [WKTHGD_thru_grade] FROM
[Integration].[F5554240_fg_redeem_Staging] s
where [WK$ODN_free_goods_contract_number] is not null and [WKTHGD_thru_grade] = 'LN'

--

-- Add FGCBA to exempt

INSERT INTO fg.exempt_code
                         (fg_exempt_cd, fg_exempt_desc, source_cd, active_ind, sequence_num, note_txt, show_ind)
SELECT        'FGCBA' AS fg_exempt_cd, 'CB Autoadd' AS fg_exempt_desc, source_cd, active_ind, sequence_num, 'noManClaim' AS note_txt, show_ind
FROM            fg.exempt_code AS exempt_code_1
WHERE        (fg_exempt_cd = 'fgauto')
