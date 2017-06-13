
--------------------------------------------------------------------------------
-- DROP TABLE STAGE_JDE_ARCPCOM93_F0005_user_defined_codes
--------------------------------------------------------------------------------

-- 0.5 m

SELECT 

--    Top 5 
    "DRSY" AS DRSY___product_code,
	"DRRT" AS DRRT___user_defined_codes,
	"DRKY" AS DRKY___user_defined_code,
	"DRDL01" AS DRDL01_description,
	"DRDL02" AS DRDL02_description_02,
	"DRSPHD" AS DRSPHD_special_handling_code,
	"DRUDCO" AS DRUDCO_active_flag_yn,
	"DRHRDC" AS DRHRDC_hard_coded_yn,
	"DRUSER" AS DRUSER_user_id,
	"DRPID" AS DRPID__program_id,
	"DRUPMJ" AS DRUPMJ_date_updated,
	"DRJOBN" AS DRJOBN_work_station_id,
	"DRUPMT" AS DRUPMT_time_last_updated 

INTO 
	STAGE_JDE_ARCPCOM93_F0005_user_defined_codes

FROM 
    OPENQUERY (ESYS_QA, '

	SELECT
		DRSY,
		DRRT,
		DRKY,
		DRDL01,
		DRDL02,
		DRSPHD,
		DRUDCO,
		DRHRDC,
		DRUSER,
		DRPID,
		CASE WHEN DRUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(DRUPMJ+ 1900000,7,0))) ELSE NULL END AS DRUPMJ,
		DRJOBN,
		DRUPMT

	FROM
		ARCPCOM93.F0005
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')



--------------------------------------------------------------------------------
-- DROP TABLE STAGE_JDE_ARCPDTA93_F4072_price_adjustment_detail
--------------------------------------------------------------------------------

-- 12 min

SELECT 

--    Top 5 
    "ADAST" AS ADAST__adjustment_name,
	"ADITM" AS ADITM__item_number_short,
	"ADLITM" AS ADLITM_item_number,
	"ADAITM" AS ADAITM__3rd_item_number,
	"ADAN8" AS ADAN8__billto,
	"ADICID" AS ADICID_itemcustomer_key_id,
	"ADSDGR" AS ADSDGR_order_detail_group,
	"ADSDV1" AS ADSDV1_sales_detail_value_01,
	"ADSDV2" AS ADSDV2_sales_detail_value_02,
	"ADSDV3" AS ADSDV3_sales_detail_value_03,
	"ADCRCD" AS ADCRCD_currency_code,
	"ADUOM" AS ADUOM__um,
	"ADMNQ" AS ADMNQ__quantity_from,
	"ADEFTJ" AS ADEFTJ_effective_date,
	"ADEXDJ" AS ADEXDJ_expired_date,
	"ADBSCD" AS ADBSCD_basis,
	"ADLEDG" AS ADLEDG_cost_method,
	"ADFRMN" AS ADFRMN_formula_name,
	"ADFCNM" AS ADFCNM_function_name,
	"ADFVTR" AS ADFVTR_factor_value,
	"ADFGY" AS ADFGY__free_goods_yn,
	"ADATID" AS ADATID_price_adjustment_key_id,
	"ADURCD" AS ADURCD_user_reserved_code,
	"ADURDT" AS ADURDT_user_reserved_date_JDT,
	"ADURAT" AS ADURAT_user_reserved_amount,
	"ADURAB" AS ADURAB_user_reserved_number,
	"ADURRF" AS ADURRF_user_reserved_reference,
	"ADASTN" AS ADASTN_adjustment_for_net_price,
	"ADUSER" AS ADUSER_user_id,
	"ADPID" AS ADPID__program_id,
	"ADJOBN" AS ADJOBN_work_station_id,
	"ADUPMJ" AS ADUPMJ_date_updated_JDT,
	"ADTDAY" AS ADTDAY_time_of_day,
	"ADUPAJ" AS ADUPAJ_date_added_JDT,
	"ADTENT" AS ADTENT_time_entered 

INTO 
	STAGE_JDE_ARCPDTA93_F4072_price_adjustment_detail

FROM 
    OPENQUERY (ESYS_QA, '

	SELECT
		ADAST,
		ADITM,
		ADLITM,
		ADAITM,
		ADAN8,
		ADICID,
		ADSDGR,
		ADSDV1,
		ADSDV2,
		ADSDV3,
		ADCRCD,
		ADUOM,
		ADMNQ,
		DATE(DIGITS(DEC(ADEFTJ+ 1900000,7,0))) AS ADEFTJ,
		DATE(DIGITS(DEC(ADEXDJ+ 1900000,7,0))) AS ADEXDJ,
		ADBSCD,
		ADLEDG,
		ADFRMN,
		ADFCNM,
		CAST((ADFVTR)/10000.0 AS DEC(15,4)) AS ADFVTR,
		ADFGY,
		ADATID,
		ADURCD,
		ADURDT AS ADURDT,
		CAST((ADURAT)/100.0 AS DEC(15,2)) AS ADURAT,
		ADURAB,
		ADURRF,
		ADASTN,
		ADUSER,
		ADPID,
		ADJOBN,
		ADUPMJ AS ADUPMJ,
		ADTDAY,
		ADUPAJ AS ADUPAJ,
		ADTENT

	FROM
		ARCPDTA93.F4072
    WHERE
		ADEFTJ <= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) AND 		
		ADEXDJ >= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3))  		
--    ORDER BY
--        <insert custom code here>
')





--------------------------------------------------------------------------------
-- DROP TABLE STAGE_JDE_ARCPDTA93_F4073_free_goods_master_file
--------------------------------------------------------------------------------

-- 0 min
SELECT 

--    Top 5 
    "FGAST" AS FGAST__adjustment_name,
	"FGATID" AS FGATID_price_adjustment_key_id,
	"FGITMR" AS FGITMR_related_short_item_number,
	"FGLITM" AS FGLITM_item_number,
	"FGAITM" AS FGAITM__3rd_item_number,
	"FGUORG" AS FGUORG_quantity,
	"FGUOM" AS FGUOM__um,
	"FGRPRI" AS FGRPRI_related_price,
	"FGUNCS" AS FGUNCS_unit_cost,
	"FGGLC" AS FGGLC__gl_offset,
	"FGLNTY" AS FGLNTY_line_type,
	"FGFQTY" AS FGFQTY_quantity_per,
	"FGFGTY" AS FGFGTY_free_good_type,
	"FGFP01" AS FGFP01_free_good_process_code_01,
	"FGFP02" AS FGFP02_free_good_process_code_02,
	"FGFP03" AS FGFP03_free_good_process_code_03,
	"FGUSER" AS FGUSER_user_id,
	"FGPID" AS FGPID__program_id,
	"FGJOBN" AS FGJOBN_work_station_id,
	"FGUPMJ" AS FGUPMJ_date_updated,
	"FGTDAY" AS FGTDAY_time_of_day 

INTO 
	STAGE_JDE_ARCPDTA93_F4073_free_goods_master_file

FROM 
    OPENQUERY (ESYS_QA, '

	SELECT
		FGAST,
		FGATID,
		FGITMR,
		FGLITM,
		FGAITM,
		FGUORG,
		FGUOM,
		CAST((FGRPRI)/10000.0 AS DEC(15,4)) AS FGRPRI,
		CAST((FGUNCS)/10000.0 AS DEC(15,4)) AS FGUNCS,
		FGGLC,
		FGLNTY,
		CAST((FGFQTY)/100.0 AS DEC(15,2)) AS FGFQTY,
		FGFGTY,
		FGFP01,
		FGFP02,
		FGFP03,
		FGUSER,
		FGPID,
		FGJOBN,
		CASE WHEN FGUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(FGUPMJ+ 1900000,7,0))) ELSE NULL END AS FGUPMJ,
		FGTDAY

	FROM
		ARCPDTA93.F4073
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')




--------------------------------------------------------------------------------
-- DROP TABLE STAGE_JDE_ARCPDTA93_F554072_price_adjustment_detail_extension
--------------------------------------------------------------------------------

-- 0 min

SELECT 

--    Top 5 
    "QXAST" AS QXAST__adjustment_name,
	"QXATID" AS QXATID_price_adjustment_key_id,
	"QX$PLT" AS QX$PLT_promotional_limit,
	"QX$SPE" AS QX$SPE_special_processing_code,
	"QX$APM" AS QX$APM_additional_promotion_code,
	"QX$PMU" AS QX$PMU_premium_point_multiplier,
	"QXURCD" AS QXURCD_user_reserved_code,
	"QXURDT" AS QXURDT_user_reserved_date_JDT,
	"QXURAT" AS QXURAT_user_reserved_amount,
	"QXURAB" AS QXURAB_user_reserved_number,
	"QXURRF" AS QXURRF_user_reserved_reference,
	"QXUSER" AS QXUSER_user_id,
	"QXPID" AS QXPID__program_id,
	"QXJOBN" AS QXJOBN_work_station_id,
	"QXUPMJ" AS QXUPMJ_date_updated,
	"QXTDAY" AS QXTDAY_time_of_day 

INTO 
	STAGE_JDE_ARCPDTA93_F554072_price_adjustment_detail_extension

FROM 
    OPENQUERY (ESYS_QA, '

	SELECT
		QXAST,
		QXATID,
		QX$PLT,
		QX$SPE,
		QX$APM,
		CAST((QX$PMU)/100.0 AS DEC(15,2)) AS QX$PMU,
		QXURCD,
		QXURDT AS QXURDT,
		CAST((QXURAT)/100.0 AS DEC(15,2)) AS QXURAT,
		QXURAB,
		QXURRF,
		QXUSER,
		QXPID,
		QXJOBN,
		CASE WHEN QXUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(QXUPMJ+ 1900000,7,0))) ELSE NULL END AS QXUPMJ,
		QXTDAY

	FROM
		ARCPDTA93.F554072
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')



--------------------------------------------------------------------------------
-- DROP TABLE STAGE_JDE_ARCPDTA93_F40314_preference_price_adjustment_schedule
--------------------------------------------------------------------------------

-- 0 min

SELECT 

--    Top 5 
    "PJAN8" AS PJAN8__billto,
	"PJCS14" AS PJCS14_customer_group_price_adjustment_sched,
	"PJITM" AS PJITM__item_number_short,
	"PJIT14" AS PJIT14_item_group_price_adjustment_schedule,
	"PJEFTJ" AS PJEFTJ_effective_date,
	"PJEXDJ" AS PJEXDJ_expired_date,
	"PJMNQ" AS PJMNQ__quantity_from,
	"PJMXQ" AS PJMXQ__quantity_thru,
	"PJUOM" AS PJUOM__um,
	"PJTXID" AS PJTXID_text_id_number,
	"PJSTPR" AS PJSTPR_preference_status,
	"PJOSEQ" AS PJOSEQ_sequence_number,
	"PJMCU" AS PJMCU__business_unit,
	"PJASN" AS PJASN__adjustment_schedule,
	"PJURCD" AS PJURCD_user_reserved_code,
	"PJURDT" AS PJURDT_user_reserved_date_JDT,
	"PJURAT" AS PJURAT_user_reserved_amount,
	"PJURAB" AS PJURAB_user_reserved_number,
	"PJURRF" AS PJURRF_user_reserved_reference,
	"PJUSER" AS PJUSER_user_id,
	"PJPID" AS PJPID__program_id,
	"PJJOBN" AS PJJOBN_work_station_id,
	"PJUPMJ" AS PJUPMJ_date_updated,
	"PJTDAY" AS PJTDAY_time_of_day 

INTO 
	STAGE_JDE_ARCPDTA93_F40314_preference_price_adjustment_schedule

FROM 
    OPENQUERY (ESYS_QA, '

	SELECT
		PJAN8,
		PJCS14,
		PJITM,
		PJIT14,
		DATE(DIGITS(DEC(PJEFTJ+ 1900000,7,0))) AS PJEFTJ,
		DATE(DIGITS(DEC(PJEXDJ+ 1900000,7,0))) AS PJEXDJ,
		PJMNQ,
		PJMXQ,
		PJUOM,
		PJTXID,
		PJSTPR,
		PJOSEQ,
		PJMCU,
		PJASN,
		PJURCD,
		PJURDT AS PJURDT,
		CAST((PJURAT)/100.0 AS DEC(15,2)) AS PJURAT,
		PJURAB,
		PJURRF,
		PJUSER,
		PJPID,
		PJJOBN,
		CASE WHEN PJUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(PJUPMJ+ 1900000,7,0))) ELSE NULL END AS PJUPMJ,
		PJTDAY

	FROM
		ARCPDTA93.F40314
    WHERE
		PJEFTJ <= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) AND 		
		PJEXDJ >= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3))  		
--    ORDER BY
--        <insert custom code here>
')
