-- new Terrtiory and Item Weight add

--------------------------------------------------------------------------------
-- DROP TABLE Integration.F5554_territory_name_Staging
--------------------------------------------------------------------------------


SELECT 
    Top 5 
    "GECO" AS GECO___company,
	"GE$GTY" AS GE$GTY_group_type,
	"GE$VNO" AS GE$VNO_number_version,
	"GE$LID" AS GE$LID_level_id,
	"GE$L01" AS GE$L01_level_code_01,
	"GEDSC1" AS GEDSC1_description,
	"GETKBY" AS GETKBY_order_taken_by,
	"GEUSER" AS GEUSER_user_id,
	"GEPID" AS GEPID__program_id,
	"GEJOBN" AS GEJOBN_work_station_id,
	"GEUPMJ" AS GEUPMJ_date_updated,
	"GEUPMT" AS GEUPMT_time_last_updated 

INTO Integration.F5554_territory_name_Staging

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		GECO,
		GE$GTY,
		GE$VNO,
		GE$LID,
		GE$L01,
		GEDSC1,
		GETKBY,
		GEUSER,
		GEPID,
		GEJOBN,
		CASE WHEN GEUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(GEUPMJ+ 1900000,7,0))) ELSE NULL END AS GEUPMJ,
		GEUPMT

	FROM
		ARCPDTA71.F5554
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

GO

/*
SELECT        GE$L01_level_code_01, COUNT(*) AS Expr1
FROM            Integration.F5554_territory_name_Staging
GROUP BY GE$L01_level_code_01
*/

BEGIN TRANSACTION
GO
ALTER TABLE Integration.F5554_territory_name_Staging ADD CONSTRAINT
	F5554_territory_name_Staging_pk PRIMARY KEY NONCLUSTERED 
	(
	GECO___company,
	GE$GTY_group_type,
	GE$VNO_number_version,
	GE$LID_level_id,
	GE$L01_level_code_01
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE Integration.F5554_territory_name_Staging SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--

--------------------------------------------------------------------------------
-- DROP TABLE Integration.NPFIMS_item_wcs_Staging
--------------------------------------------------------------------------------

SELECT 
    Top 5
    "IMACDE" AS IMACDE_accounting_code,
	"IMACST" AS IMACST_average_unit_cost,
	"IMACHF" AS IMACHF_availability_change_flag,
	"IMAVLC" AS IMAVLC_availability_check,
	"IMADTE" AS IMADTE_availability_date_JDT,
	"IMRQTY" AS IMRQTY_reorder_quantity,
	"IMBODT" AS IMBODT_backorder_date,
	"IMCLSC" AS IMCLSC_class_code,
	"IMCQTC" AS IMCQTC_case_quantity_code,
	"IMCLQT" AS IMCLQT_closing_quantity,
	"IMDESC" AS IMDESC_description,
	"IMDKYA" AS IMDKYA_description_key_a,
	"IMDKYB" AS IMDKYB_description_key_b,
	"IMHEIG" AS IMHEIG_height,
	"IMCSET" AS IMCSET_cash_settlement_yn,
	"IMITEM" AS IMITEM_item_number,
	"IMRSET" AS IMRSET_rule_set_name,
	"IMITAX" AS IMITAX_item_tax_code,
	"IMKITC" AS IMKITC_kit_component_lines,
	"IMLENG" AS IMLENG_length,
	"IMNDC#" AS IMNDC#_ndc_codeprimary_supplier,
--	"IMPINF" AS IMPINF_percentage_budget_change,
	"IMPCL1" AS IMPCL1_prob_of_close_1,
	"IMWGTC" AS IMWGTC_item_shipping_method_code,
	"IMSIZE" AS IMSIZE_product_size,
	"IMSTRN" AS IMSTRN_transaction_code,
	"IMSCDE" AS IMSCDE_substitution_code,
	"IMVEND" AS IMVEND_primary_last_supplier_number,
	"IMVITM" AS IMVITM_primary_supplier_item_code,
	"IMWEIG" AS IMWEIG_weight,
	"IMWIDT" AS IMWIDT_width,
	"IMDTYP" AS IMDTYP_doi_entity_type,
	"IMLOCT" AS IMLOCT_location_type,
	"IMCLMJ" AS IMCLMJ_product_major_class,
	"IMCLSJ" AS IMCLSJ_product_submajor_class,
	"IMCLMC" AS IMCLMC_claim_code,
	"IMCLSM" AS IMCLSM_product_subminor_class,
	"IMBUYR" AS IMBUYR_buyer_number,
	"IMSUPL" AS IMSUPL_supplier_code,
	"IMRPKE" AS IMRPKE_needs_repackaging_yn,
	"IMTXCA" AS IMTXCA_tax_code_array_8_x,
	"IMUDEF" AS IMUDEF_undefined_filler_field,
	"IMPUCD" AS IMPUCD_archive_file_group_code,
	"IMENTD" AS IMENTD_date_entered_JDT,
	"IMFRTC" AS IMFRTC_freight_calculated_yn,
	"IMHAZC" AS IMHAZC_hazard_code,
	"IMADMC" AS IMADMC_admin_charge_code,
	"IMCSTP" AS IMCSTP_customer_group,
	"IMPKTP" AS IMPKTP_print_on_pick_ticket,
	"IMINVU" AS IMINVU_upd_inventoryservice_level,
	"IMSLEL" AS IMSLEL_count_as_sales_lnegross_prf,
	"IMJNKM" AS IMJNKM_junk_mail,
	"IMSTCK" AS IMSTCK_stocknonstock_code,
	"IMSLSC" AS IMSLSC_sales_plan_code,
	"IMPRCD" AS IMPRCD_method_code,
	"IMMSC1" AS IMMSC1_misc_flag_1,
	"IMMSC2" AS IMMSC2_misc_flag_2,
	"IMMSC3" AS IMMSC3_misc_flag_3,
	"IMWDSC" AS IMWDSC_warehouse_description,
	"IMPDSC" AS IMPDSC_primary_description,
	"IMDCLS" AS IMDCLS_date_regular_coverage_lost_JDT,
	"IMPRLF" AS IMPRLF_product_useful_life,
	"IMWCHC" AS IMWCHC_item_watch_code,
	"IMNHAZ" AS IMNHAZ_non_hazmat,
	"IMLCTL" AS IMLCTL_location_control_yn,
	"IMPSLF" AS IMPSLF_product_shelf_life,
	"IMJDSC" AS IMJDSC_jde_item_description,
	"IMLNTY" AS IMLNTY_line_type,
	"IMSNOR" AS IMSNOR_item_serial_required,
	"IMSTAS" AS IMSTAS_item_status,
	"IMSLBT" AS IMSLBT_item_eshipping_label_type,
	"IMNDC1" AS IMNDC1_ndc_10_digit_edited,
	"IMNDC2" AS IMNDC2_ndc_10_digit,
	"IMNDC3" AS IMNDC3_ndc_11_digit,
	"IMMLNK" AS IMMLNK_item_image_link,
	"IMELEN" AS IMELEN_item_ea_length,
	"IMEWID" AS IMEWID_item_ea_width,
	"IMEHEI" AS IMEHEI_item_ea_heigth,
	"IMGIN#" AS IMGIN#_get_in_,
	"IMEDES" AS IMEDES_item_extended_description,
	"IMIDES" AS IMIDES_invoice_description,
	"IMPSPD" AS IMPSPD_packing_slip_prt_desc,
	"IMJSTN" AS IMJSTN_jde_item_strength,
	"IMWTYP" AS IMWTYP_warranty_type,
	"IMSIDS" AS IMSIDS_supplier_item,
	"IMUS01" AS IMUS01_users_01,
	"IMUS02" AS IMUS02_users_02,
	"IMUS03" AS IMUS03_users_03,
	"IMUS04" AS IMUS04_users_04,
	"IMUS05" AS IMUS05_users_05,
	"IMUS06" AS IMUS06_users_06,
	"IMUS07" AS IMUS07_users_07,
	"IMUS08" AS IMUS08_users_08,
	"IMUS09" AS IMUS09_users_09,
	"IMUS10" AS IMUS10_users_10,
	"IMUS11" AS IMUS11_users_11,
	"IMUS12" AS IMUS12_users_12,
	"IMUS13" AS IMUS13_users_13,
	"IMUS14" AS IMUS14_users_14,
	"IMUS15" AS IMUS15_users_15 

INTO Integration.NPFIMS_item_wcs_Staging

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		IMACDE,
		CAST((IMACST)/10000.0 AS DEC(15,4)) AS IMACST,
		IMACHF,
		IMAVLC,
		IMADTE,
		IMRQTY,
		IMBODT,
		IMCLSC,
		IMCQTC,
		IMCLQT,
		IMDESC,
		IMDKYA,
		IMDKYB,
		IMHEIG,
		IMCSET,
		IMITEM,
		IMRSET,
		IMITAX,
		IMKITC,
		IMLENG,
		IMNDC#,
--		CAST((IMPINF)/10000.0 AS DEC(15,4)) AS IMPINF,
		IMPCL1,
		IMWGTC,
		IMSIZE,
		IMSTRN,
		IMSCDE,
		IMVEND,
		IMVITM,
		IMWEIG,
		IMWIDT,
		IMDTYP,
		IMLOCT,
		IMCLMJ,
		IMCLSJ,
		IMCLMC,
		IMCLSM,
		IMBUYR,
		IMSUPL,
		IMRPKE,
		IMTXCA,
		IMUDEF,
		IMPUCD,
		IMENTD,
--		CASE WHEN IMENTD > 0 THEN DATE(DIGITS(DEC(IMENTD+ 1900000,7,0))) ELSE NULL END AS IMENTD,
		IMFRTC,
		IMHAZC,
		IMADMC,
		IMCSTP,
		IMPKTP,
		IMINVU,
		IMSLEL,
		IMJNKM,
		IMSTCK,
		IMSLSC,
		IMPRCD,
		IMMSC1,
		IMMSC2,
		IMMSC3,
		IMWDSC,
		IMPDSC,
		IMDCLS  AS IMDCLS,
--		CASE WHEN IMDCLS > 0 THEN DATE(DIGITS(DEC(IMDCLS+ 1900000,7,0))) ELSE NULL END AS IMDCLS,
		IMPRLF,
		IMWCHC,
		IMNHAZ,
		IMLCTL,
		IMPSLF,
		IMJDSC,
		IMLNTY,
		IMSNOR,
		IMSTAS,
		IMSLBT,
		IMNDC1,
		IMNDC2,
		IMNDC3,
		IMMLNK,
		IMELEN,
		IMEWID,
		IMEHEI,
		IMGIN#,
		IMEDES,
		IMIDES,
		IMPSPD,
		IMJSTN,
		IMWTYP,
		IMSIDS,
		IMUS01,
		IMUS02,
		IMUS03,
		IMUS04,
		IMUS05,
		IMUS06,
		IMUS07,
		IMUS08,
		IMUS09,
		IMUS10,
		IMUS11,
		IMUS12,
		IMUS13,
		IMUS14,
		IMUS15

	FROM
		ARCPTEL.NPFIMS
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

BEGIN TRANSACTION
GO
ALTER TABLE Integration.NPFIMS_item_wcs_Staging ADD CONSTRAINT
	NPFIMS_item_wcs_Staging_c_pk PRIMARY KEY CLUSTERED 
	(
	IMITEM_item_number
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE Integration.NPFIMS_item_wcs_Staging SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


--------------------------------------------------------------------------------
/*

select IMITEM_item_number, count(*) from [Integration].[NPFIMS_item_wcs_Staging]
group by 
IMITEM_item_number
having count(*) > 1

*/