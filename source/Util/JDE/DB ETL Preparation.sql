/*

USE [DEV_BRSales]
GO
CREATE SCHEMA [etl] AUTHORIZATION [maint_role]
GO

*/

-- ETL01 F4072_price_adjustment_detail


--------------------------------------------------------------------------------
-- STAGE DROP TABLE etl.F4072_price_adjustment_detail
--------------------------------------------------------------------------------

SELECT 

    Top 50
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

-- INTO etl.F4072_price_adjustment_detail

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

-- SELECT ADAST__adjustment_name AS adjustment_name, ADITM__item_number_short AS item_number_short, ADLITM_item_number AS item_number, ADAITM__3rd_item_number AS _3rd_item_number, ADAN8__billto AS billto, ADICID_itemcustomer_key_id AS itemcustomer_key_id, ADSDGR_order_detail_group AS order_detail_group, ADSDV1_sales_detail_value_01 AS sales_detail_value_01, ADSDV2_sales_detail_value_02 AS sales_detail_value_02, ADSDV3_sales_detail_value_03 AS sales_detail_value_03, ADCRCD_currency_code AS currency_code, ADUOM__um AS um, ADMNQ__quantity_from AS quantity_from, ADEFTJ_effective_date AS effective_date, ADEXDJ_expired_date AS expired_date, ADBSCD_basis AS basis, ADLEDG_cost_method AS cost_method, ADFRMN_formula_name AS formula_name, ADFCNM_function_name AS function_name, ADFVTR_factor_value AS factor_value, ADFGY__free_goods_yn AS free_goods_yn, ADATID_price_adjustment_key_id AS price_adjustment_key_id, ADURCD_user_reserved_code AS user_reserved_code, ADURDT_user_reserved_date_JDT AS user_reserved_date, ADURAT_user_reserved_amount AS user_reserved_amount, ADURAB_user_reserved_number AS user_reserved_number, ADURRF_user_reserved_reference AS user_reserved_reference, ADASTN_adjustment_for_net_price AS adjustment_for_net_price, ADUSER_user_id AS user_id, ADPID__program_id AS program_id, ADJOBN_work_station_id AS work_station_id, ADUPMJ_date_updated_JDT AS date_updated, ADTDAY_time_of_day AS time_of_day, ADUPAJ_date_added_JDT AS date_added, ADTENT_time_entered AS time_entered FROM etl.F4072_price_adjustment_detail


--------------------------------------------------------------------------------
-- PROD DROP TABLE etl.F4072_price_adjustment_detail
--------------------------------------------------------------------------------

SELECT 

    Top 5 
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
	"ADFVTR" AS ADFVTR_factor_value,
	"ADFGY" AS ADFGY__free_goods_yn,
	"ADATID" AS ADATID_price_adjustment_key_id,
	"ADURCD" AS ADURCD_user_reserved_code,
	"ADURDT" AS ADURDT_user_reserved_date,
	"ADURAT" AS ADURAT_user_reserved_amount,
	"ADURAB" AS ADURAB_user_reserved_number,
	"ADURRF" AS ADURRF_user_reserved_reference,
	"ADUSER" AS ADUSER_user_id,
	"ADPID" AS ADPID__program_id,
	"ADJOBN" AS ADJOBN_work_station_id,
	"ADUPMJ" AS ADUPMJ_date_updated,
	"ADTDAY" AS ADTDAY_time_of_day 

-- INTO etl.F4072_price_adjustment_detail

FROM 
    OPENQUERY (ESYS_PROD, '

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
		CASE WHEN ADEFTJ IS NOT NULL THEN DATE(DIGITS(DEC(ADEFTJ+ 1900000,7,0))) ELSE NULL END AS ADEFTJ,
		CASE WHEN ADEXDJ IS NOT NULL THEN DATE(DIGITS(DEC(ADEXDJ+ 1900000,7,0))) ELSE NULL END AS ADEXDJ,
		ADBSCD,
		ADLEDG,
		ADFRMN,
		CAST((ADFVTR)/10000.0 AS DEC(15,4)) AS ADFVTR,
		ADFGY,
		ADATID,
		ADURCD,
		CASE WHEN ADURDT IS NOT NULL THEN DATE(DIGITS(DEC(ADURDT+ 1900000,7,0))) ELSE NULL END AS ADURDT,
		CAST((ADURAT)/100.0 AS DEC(15,2)) AS ADURAT,
		ADURAB,
		ADURRF,
		ADUSER,
		ADPID,
		ADJOBN,
		CASE WHEN ADUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(ADUPMJ+ 1900000,7,0))) ELSE NULL END AS ADUPMJ,
		ADTDAY

			FROM
				ARCPDTA71.F4072
			WHERE
				ADEFTJ <= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) AND 		
				ADEXDJ >= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3))  		
		--    ORDER BY
		--        <insert custom code here>
		')

--------------------------------------------------------------------------------

-- SELECT ADAST__adjustment_name AS adjustment_name, ADITM__item_number_short AS item_number_short, ADLITM_item_number AS item_number, ADAITM__3rd_item_number AS _3rd_item_number, ADAN8__billto AS billto, ADICID_itemcustomer_key_id AS itemcustomer_key_id, ADSDGR_order_detail_group AS order_detail_group, ADSDV1_sales_detail_value_01 AS sales_detail_value_01, ADSDV2_sales_detail_value_02 AS sales_detail_value_02, ADSDV3_sales_detail_value_03 AS sales_detail_value_03, ADCRCD_currency_code AS currency_code, ADUOM__um AS um, ADMNQ__quantity_from AS quantity_from, ADEFTJ_effective_date AS effective_date, ADEXDJ_expired_date AS expired_date, ADBSCD_basis AS basis, ADLEDG_cost_method AS cost_method, ADFRMN_formula_name AS formula_name, ADFVTR_factor_value AS factor_value, ADFGY__free_goods_yn AS free_goods_yn, ADATID_price_adjustment_key_id AS price_adjustment_key_id, ADURCD_user_reserved_code AS user_reserved_code, ADURDT_user_reserved_date AS user_reserved_date, ADURAT_user_reserved_amount AS user_reserved_amount, ADURAB_user_reserved_number AS user_reserved_number, ADURRF_user_reserved_reference AS user_reserved_reference, ADUSER_user_id AS user_id, ADPID__program_id AS program_id, ADJOBN_work_station_id AS work_station_id, ADUPMJ_date_updated AS date_updated, ADTDAY_time_of_day AS time_of_day FROM <...>


-- ETL02 


--------------------------------------------------------------------------------
-- STAGE TRUNCATE TABLE etl.F40314_preference_price_adjustment_schedule
--------------------------------------------------------------------------------

SELECT 

    Top 5 
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

--INTO etl.F40314_preference_price_adjustment_schedule

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

--------------------------------------------------------------------------------

-- SELECT PJAN8__billto AS billto, PJCS14_customer_group_price_adjustment_sched AS customer_group_price_adjustment_sched, PJITM__item_number_short AS item_number_short, PJIT14_item_group_price_adjustment_schedule AS item_group_price_adjustment_schedule, PJEFTJ_effective_date AS effective_date, PJEXDJ_expired_date AS expired_date, PJMNQ__quantity_from AS quantity_from, PJMXQ__quantity_thru AS quantity_thru, PJUOM__um AS um, PJTXID_text_id_number AS text_id_number, PJSTPR_preference_status AS preference_status, PJOSEQ_sequence_number AS sequence_number, PJMCU__business_unit AS business_unit, PJASN__adjustment_schedule AS adjustment_schedule, PJURCD_user_reserved_code AS user_reserved_code, PJURDT_user_reserved_date AS user_reserved_date, PJURAT_user_reserved_amount AS user_reserved_amount, PJURAB_user_reserved_number AS user_reserved_number, PJURRF_user_reserved_reference AS user_reserved_reference, PJUSER_user_id AS user_id, PJPID__program_id AS program_id, PJJOBN_work_station_id AS work_station_id, PJUPMJ_date_updated AS date_updated, PJTDAY_time_of_day AS time_of_day FROM <...>




--------------------------------------------------------------------------------
-- PROD DROP TABLE STAGE_JDE_ARCPDTA71_F40314_<instert_friendly_name_here>
--------------------------------------------------------------------------------

SELECT 

    Top 5 
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
	"PJURDT" AS PJURDT_user_reserved_date,
	"PJURAT" AS PJURAT_user_reserved_amount,
	"PJURAB" AS PJURAB_user_reserved_number,
	"PJURRF" AS PJURRF_user_reserved_reference,
	"PJUSER" AS PJUSER_user_id,
	"PJPID" AS PJPID__program_id,
	"PJJOBN" AS PJJOBN_work_station_id,
	"PJUPMJ" AS PJUPMJ_date_updated,
	"PJTDAY" AS PJTDAY_time_of_day 

-- INTO etl.ARCPDTA71_F40314_<instert_friendly_name_here>

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		PJAN8,
		PJCS14,
		PJITM,
		PJIT14,
		CASE WHEN PJEFTJ IS NOT NULL THEN DATE(DIGITS(DEC(PJEFTJ+ 1900000,7,0))) ELSE NULL END AS PJEFTJ,
		CASE WHEN PJEXDJ IS NOT NULL THEN DATE(DIGITS(DEC(PJEXDJ+ 1900000,7,0))) ELSE NULL END AS PJEXDJ,
		PJMNQ,
		PJMXQ,
		PJUOM,
		PJTXID,
		PJSTPR,
		PJOSEQ,
		PJMCU,
		PJASN,
		PJURCD,
		CASE WHEN PJURDT IS NOT NULL THEN DATE(DIGITS(DEC(PJURDT+ 1900000,7,0))) ELSE NULL END AS PJURDT,
		CAST((PJURAT)/100.0 AS DEC(15,2)) AS PJURAT,
		PJURAB,
		PJURRF,
		PJUSER,
		PJPID,
		PJJOBN,
		CASE WHEN PJUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(PJUPMJ+ 1900000,7,0))) ELSE NULL END AS PJUPMJ,
		PJTDAY

	FROM
		ARCPDTA71.F40314
    WHERE
 		PJEFTJ <= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) AND 		
		PJEXDJ >= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3))  		
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------

-- SELECT PJAN8__billto AS billto, PJCS14_customer_group_price_adjustment_sched AS customer_group_price_adjustment_sched, PJITM__item_number_short AS item_number_short, PJIT14_item_group_price_adjustment_schedule AS item_group_price_adjustment_schedule, PJEFTJ_effective_date AS effective_date, PJEXDJ_expired_date AS expired_date, PJMNQ__quantity_from AS quantity_from, PJMXQ__quantity_thru AS quantity_thru, PJUOM__um AS um, PJTXID_text_id_number AS text_id_number, PJSTPR_preference_status AS preference_status, PJOSEQ_sequence_number AS sequence_number, PJMCU__business_unit AS business_unit, PJASN__adjustment_schedule AS adjustment_schedule, PJURCD_user_reserved_code AS user_reserved_code, PJURDT_user_reserved_date AS user_reserved_date, PJURAT_user_reserved_amount AS user_reserved_amount, PJURAB_user_reserved_number AS user_reserved_number, PJURRF_user_reserved_reference AS user_reserved_reference, PJUSER_user_id AS user_id, PJPID__program_id AS program_id, PJJOBN_work_station_id AS work_station_id, PJUPMJ_date_updated AS date_updated, PJTDAY_time_of_day AS time_of_day FROM <...>


-- ETL03



--------------------------------------------------------------------------------
-- DROP TABLE etl.F4073_free_goods_master_file
--------------------------------------------------------------------------------

SELECT 

    Top 5 
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
	"FGUPMJ" AS FGUPMJ_date_updated_JDT,
	"FGTDAY" AS FGTDAY_time_of_day 

INTO etl.F4073_free_goods_master_file

FROM 
    OPENQUERY (ESYS_PROD, '

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
		FGUPMJ AS FGUPMJ,
		FGTDAY

	FROM
		ARCPDTA71.F4073
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------

-- SELECT FGAST__adjustment_name AS adjustment_name, FGATID_price_adjustment_key_id AS price_adjustment_key_id, FGITMR_related_short_item_number AS related_short_item_number, FGLITM_item_number AS item_number, FGAITM__3rd_item_number AS _3rd_item_number, FGUORG_quantity AS quantity, FGUOM__um AS um, FGRPRI_related_price AS related_price, FGUNCS_unit_cost AS unit_cost, FGGLC__gl_offset AS gl_offset, FGLNTY_line_type AS line_type, FGFQTY_quantity_per AS quantity_per, FGFGTY_free_good_type AS free_good_type, FGFP01_free_good_process_code_01 AS free_good_process_code_01, FGFP02_free_good_process_code_02 AS free_good_process_code_02, FGFP03_free_good_process_code_03 AS free_good_process_code_03, FGUSER_user_id AS user_id, FGPID__program_id AS program_id, FGJOBN_work_station_id AS work_station_id, FGUPMJ_date_updated AS date_updated, FGTDAY_time_of_day AS time_of_day FROM <...>


-- ETL04

--------------------------------------------------------------------------------

-- SELECT GSAN8__billto AS billto, GSCS08_customer_group_grade_and_potency AS customer_group_grade_and_potency, GSITM__item_number_short AS item_number_short, GSIT08_item_group_grade_and_potency AS item_group_grade_and_potency, GSEFTJ_effective_date AS effective_date, GSEXDJ_expired_date AS expired_date, GSMNQ__quantity_from AS quantity_from, GSMXQ__quantity_thru AS quantity_thru, GSUOM__um AS um, GSTXID_text_id_number AS text_id_number, GSSTPR_preference_status AS preference_status, GSOSEQ_sequence_number AS sequence_number, GSFRGD_from_grade AS from_grade, GSTHGD_thru_grade AS thru_grade, GSFRMP_from_potency AS from_potency, GSTHRP_thru_potency AS thru_potency, GSEXDP_days_before_expiration AS days_before_expiration, GSURCD_user_reserved_code AS user_reserved_code, GSURDT_user_reserved_date AS user_reserved_date, GSURAT_user_reserved_amount AS user_reserved_amount, GSURAB_user_reserved_number AS user_reserved_number, GSURRF_user_reserved_reference AS user_reserved_reference, GSUSER_user_id AS user_id, GSPID__program_id AS program_id, GSJOBN_work_station_id AS work_station_id, GSUPMJ_date_updated AS date_updated, GSTDAY_time_of_day AS time_of_day FROM <...>


--------------------------------------------------------------------------------
-- DROP TABLE etl.F40308_preference_profile_grade_and_potency
--------------------------------------------------------------------------------

SELECT 
    Top 5 
    "GSAN8" AS GSAN8__billto,
	"GSCS08" AS GSCS08_customer_group_grade_and_potency,
	"GSITM" AS GSITM__item_number_short,
	"GSIT08" AS GSIT08_item_group_grade_and_potency,
	"GSEFTJ" AS GSEFTJ_effective_date_JDT,
	"GSEXDJ" AS GSEXDJ_expired_date,
	"GSMNQ" AS GSMNQ__quantity_from,
	"GSMXQ" AS GSMXQ__quantity_thru,
	"GSUOM" AS GSUOM__um,
	"GSTXID" AS GSTXID_text_id_number,
	"GSSTPR" AS GSSTPR_preference_status,
	"GSOSEQ" AS GSOSEQ_sequence_number,
	"GSFRGD" AS GSFRGD_from_grade,
	"GSTHGD" AS GSTHGD_thru_grade,
	"GSFRMP" AS GSFRMP_from_potency,
	"GSTHRP" AS GSTHRP_thru_potency,
	"GSEXDP" AS GSEXDP_days_before_expiration,
	"GSURCD" AS GSURCD_user_reserved_code,
	"GSURDT" AS GSURDT_user_reserved_date_JDT,
	"GSURAT" AS GSURAT_user_reserved_amount,
	"GSURAB" AS GSURAB_user_reserved_number,
	"GSURRF" AS GSURRF_user_reserved_reference,
	"GSUSER" AS GSUSER_user_id,
	"GSPID" AS GSPID__program_id,
	"GSJOBN" AS GSJOBN_work_station_id,
	"GSUPMJ" AS GSUPMJ_date_updated_JDT,
	"GSTDAY" AS GSTDAY_time_of_day 

-- INTO etl.F40308_preference_profile_grade_and_potency

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		GSAN8,
		GSCS08,
		GSITM,
		GSIT08,
		GSEFTJ AS GSEFTJ,
		DATE(DIGITS(DEC(GSEXDJ+ 1900000,7,0))) AS GSEXDJ,
		GSMNQ,
		GSMXQ,
		GSUOM,
		GSTXID,
		GSSTPR,
		0 AS GSOSEQ,
		GSFRGD,
		GSTHGD,
		CAST((GSFRMP)/1000.0 AS DEC(15,3)) AS GSFRMP,
		CAST((GSTHRP)/1000.0 AS DEC(15,3)) AS GSTHRP,
		GSEXDP,
		GSURCD,
		GSURDT AS GSURDT,
		CAST((GSURAT)/100.0 AS DEC(15,2)) AS GSURAT,
		GSURAB,
		GSURRF,
		GSUSER,
		GSPID,
		GSJOBN,
		GSUPMJ AS GSUPMJ,
		GSTDAY

	FROM
		ARCPDTA71.F40308
    WHERE
		GSEFTJ <= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) AND 		
		GSEXDJ >= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) 
    ORDER BY
        GSEFTJ
')



-- ETL05



--------------------------------------------------------------------------------
-- DROP TABLE etl.F4094_item_customer_keyid_master_file
--------------------------------------------------------------------------------

SELECT 

    Top 5 
    "KIPRGR" AS KIPRGR_item_price_group,
	"KIIGP1" AS KIIGP1_item_group_category_code_01,
	"KIIGP2" AS KIIGP2_item_group_category_code_02,
	"KIIGP3" AS KIIGP3_item_group_category_code_03,
	"KIIGP4" AS KIIGP4_item_group_category_code_04,
	"KICPGP" AS KICPGP_customer_price_group,
	"KICGP1" AS KICGP1_customer_group_category_code_01,
	"KICGP2" AS KICGP2_customer_group_category_code_02,
	"KICGP3" AS KICGP3_customer_group_category_code_03,
	"KICGP4" AS KICGP4_customer_group_category_code_04,
	"KIICID" AS KIICID_itemcustomer_key_id 

-- INTO etl.F4094_item_customer_keyid_master_file

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		KIPRGR,
		KIIGP1,
		KIIGP2,
		KIIGP3,
		KIIGP4,
		KICPGP,
		KICGP1,
		KICGP2,
		KICGP3,
		KICGP4,
		KIICID

	FROM
		ARCPDTA71.F4094
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------

-- SELECT KIPRGR_item_price_group AS item_price_group, KIIGP1_item_group_category_code_01 AS item_group_category_code_01, KIIGP2_item_group_category_code_02 AS item_group_category_code_02, KIIGP3_item_group_category_code_03 AS item_group_category_code_03, KIIGP4_item_group_category_code_04 AS item_group_category_code_04, KICPGP_customer_price_group AS customer_price_group, KICGP1_customer_group_category_code_01 AS customer_group_category_code_01, KICGP2_customer_group_category_code_02 AS customer_group_category_code_02, KICGP3_customer_group_category_code_03 AS customer_group_category_code_03, KICGP4_customer_group_category_code_04 AS customer_group_category_code_04, KIICID_itemcustomer_key_id AS itemcustomer_key_id FROM <...>



-- ETL06


--------------------------------------------------------------------------------
-- DROP TABLE etl.F4101_item_master
--------------------------------------------------------------------------------

SELECT 

--    Top 5 
    "IMITM" AS IMITM__item_number_short,
	"IMLITM" AS IMLITM_item_number,
	"IMAITM" AS IMAITM__3rd_item_number,
	"IMDSC1" AS IMDSC1_description,
	"IMDSC2" AS IMDSC2_description_2,
	"IMSRTX" AS IMSRTX_search_text,
	"IMALN" AS IMALN__search_text_compressed,
	"IMSRP1" AS IMSRP1_sales_catalog_section,
	"IMSRP2" AS IMSRP2_sub_section,
	"IMSRP3" AS IMSRP3_sales_category_code_3,
	"IMSRP4" AS IMSRP4_sales_category_code_4,
	"IMSRP5" AS IMSRP5_sales_category_code_5,
	"IMSRP6" AS IMSRP6_category_code_6,
	"IMSRP7" AS IMSRP7_category_code_7,
	"IMSRP8" AS IMSRP8_category_code_8,
	"IMSRP9" AS IMSRP9_category_code_9,
	"IMSRP0" AS IMSRP0_category_code_10,
	"IMPRP1" AS IMPRP1_commodity_class,
	"IMPRP2" AS IMPRP2_commodity_sub_class,
	"IMPRP3" AS IMPRP3_supplier_rebate_code,
	"IMPRP4" AS IMPRP4_master_planning_family,
	"IMPRP5" AS IMPRP5_landed_cost_rule,
	"IMPRP6" AS IMPRP6_item_dimension_group,
	"IMPRP7" AS IMPRP7_warehouse_process_grp_1,
	"IMPRP8" AS IMPRP8_warehouse_process_grp_2,
	"IMPRP9" AS IMPRP9_warehouse_process_grp_3,
	"IMPRP0" AS IMPRP0_item_pool_code,
	"IMCDCD" AS IMCDCD_commodity_code,
	"IMPDGR" AS IMPDGR_product_group,
	"IMDSGP" AS IMDSGP_dispatch_group,
	"IMPRGR" AS IMPRGR_item_price_group,
	"IMRPRC" AS IMRPRC_basket_reprice_group,
	"IMORPR" AS IMORPR_order_reprice_group,
	"IMBUYR" AS IMBUYR_buyer_number,
	"IMDRAW" AS IMDRAW_drawing_number,
	"IMRVNO" AS IMRVNO_last_revision_no,
	"IMDSZE" AS IMDSZE_drawing_size,
	"IMVCUD" AS IMVCUD_volume_cubic_dimensions,
	"IMCARS" AS IMCARS_carrier_number,
	"IMCARP" AS IMCARP_preferred_carrier_purchasing,
	"IMSHCN" AS IMSHCN_shipping_conditions_code,
	"IMSHCM" AS IMSHCM_shipping_commodity_class,
	"IMUOM1" AS IMUOM1_unit_of_measure,
	"IMUOM2" AS IMUOM2_secondary_uom,
	"IMUOM3" AS IMUOM3_purchasing_uom,
	"IMUOM4" AS IMUOM4_pricing_uom,
	"IMUOM6" AS IMUOM6_shipping_uom,
	"IMUOM8" AS IMUOM8_production_uom,
	"IMUOM9" AS IMUOM9_component_uom,
	"IMUWUM" AS IMUWUM_unit_of_measure_weight,
	"IMUVM1" AS IMUVM1_unit_of_measure_volume,
	"IMSUTM" AS IMSUTM_stocking_um,
	"IMUMVW" AS IMUMVW_psauvolume_or_weight,
	"IMCYCL" AS IMCYCL_cycle_count_category,
	"IMGLPT" AS IMGLPT_gl_category,
	"IMPLEV" AS IMPLEV_sales_price_level,
	"IMPPLV" AS IMPPLV_purchase_price_level,
	"IMCLEV" AS IMCLEV_inventory_cost_level,
	"IMPRPO" AS IMPRPO_gradepotency_pricing,
	"IMCKAV" AS IMCKAV_check_availability_yn,
	"IMBPFG" AS IMBPFG_bulkpacked_flag,
	"IMSRCE" AS IMSRCE_layer_code_source,
	"IMOT1Y" AS IMOT1Y_potency_control,
	"IMOT2Y" AS IMOT2Y_grade_control,
	"IMSTDP" AS IMSTDP_standard_potency,
	"IMFRMP" AS IMFRMP_from_potency,
	"IMTHRP" AS IMTHRP_thru_potency,
	"IMSTDG" AS IMSTDG_standard_grade,
	"IMFRGD" AS IMFRGD_from_grade,
	"IMTHGD" AS IMTHGD_thru_grade,
	"IMCOTY" AS IMCOTY_component_type,
	"IMSTKT" AS IMSTKT_stocking_type,
	"IMLNTY" AS IMLNTY_line_type,
	"IMCONT" AS IMCONT_contract_item,
	"IMBACK" AS IMBACK_backorders_allowed_yn,
	"IMIFLA" AS IMIFLA_item_flash_message,
	"IMTFLA" AS IMTFLA_std_uom_conversion,
	"IMINMG" AS IMINMG_print_message,
	"IMABCS" AS IMABCS_abc_code_1_sales,
	"IMABCM" AS IMABCM_abc_code_2_margin,
	"IMABCI" AS IMABCI_abc_code_3_investment,
	"IMOVR" AS IMOVR__abc_code_override_indicator,
	"IMWARR" AS IMWARR_warranty_item_group,
	"IMCMCG" AS IMCMCG_commission_category,
	"IMSRNR" AS IMSRNR_serial_no_required,
	"IMPMTH" AS IMPMTH_kit_pricing_method,
	"IMFIFO" AS IMFIFO_fifo_processing,
	"IMLOTS" AS IMLOTS_lot_status_code,
	"IMSLD" AS IMSLD__shelf_life_days,
	"IMANPL" AS IMANPL_planner_number,
	"IMMPST" AS IMMPST_planning_code,
	"IMPCTM" AS IMPCTM_percent_margin,
	"IMMMPC" AS IMMMPC_margin_maintenance_pct,
	"IMPTSC" AS IMPTSC_material_status,
	"IMSNS" AS IMSNS__round_to_whole_number,
	"IMLTLV" AS IMLTLV_leadtime_level,
	"IMLTMF" AS IMLTMF_leadtime_manufacturing,
	"IMLTCM" AS IMLTCM_leadtime_cumulative,
	"IMOPC" AS IMOPC__order_policy_code,
	"IMOPV" AS IMOPV__value_order_policy,
	"IMACQ" AS IMACQ__accounting_cost_quantity,
	"IMMLQ" AS IMMLQ__mfg_leadtime_quantity,
	"IMLTPU" AS IMLTPU_leadtime_per_unit,
	"IMMPSP" AS IMMPSP_planning_fence_rule,
	"IMMRPP" AS IMMRPP_fixedvariable_leadtime,
	"IMITC" AS IMITC__issue_type_code,
	"IMORDW" AS IMORDW_order_with_yn,
	"IMMTF1" AS IMMTF1_planning_fence,
	"IMMTF2" AS IMMTF2_freeze_fence,
	"IMMTF3" AS IMMTF3_message_display_fence,
	"IMMTF4" AS IMMTF4_time_fence,
	"IMMTF5" AS IMMTF5_shipment_leadtime_offset,
	"IMMTF6" AS IMMTF6_supply_time_fence,
	"IMEXPD" AS IMEXPD_expedite_damper_days,
	"IMDEFD" AS IMDEFD_defer_damper_days,
	"IMSFLT" AS IMSFLT_safety_leadtime,
	"IMMAKE" AS IMMAKE_makebuy_code,
	"IMCOBY" AS IMCOBY_cobyproductintermediate,
	"IMLLX" AS IMLLX__low_level_code,
	"IMCMGL" AS IMCMGL_commitment_method,
	"IMCOMH" AS IMCOMH_specific_commitment_days,
	"IMCSNN" AS IMCSNN_configured_string_id_next_number,
	"IMURCD" AS IMURCD_user_reserved_code,
	"IMURDT" AS IMURDT_user_reserved_date,
	"IMURAT" AS IMURAT_user_reserved_amount,
	"IMURAB" AS IMURAB_user_reserved_number,
	"IMURRF" AS IMURRF_user_reserved_reference,
	"IMAVRT" AS IMAVRT_replenishment_hours,
	"IMUPCN" AS IMUPCN_upc_number,
	"IMSCC0" AS IMSCC0_aggregate_scc_code_pi0,
	"IMUMUP" AS IMUMUP_unit_of_measure_upc,
	"IMUMDF" AS IMUMDF_unit_of_measure_aggregate_upc,
	"IMUMS0" AS IMUMS0_unit_of_measure_sccpi0,
	"IMUMS1" AS IMUMS1_unit_of_measure_sccpi1,
	"IMUMS2" AS IMUMS2_unit_of_measure_sccpi2,
	"IMUMS3" AS IMUMS3_unit_of_measure_sccpi3,
	"IMUMS4" AS IMUMS4_unit_of_measure_sccpi4,
	"IMUMS5" AS IMUMS5_unit_of_measure_sccpi5,
	"IMUMS6" AS IMUMS6_unit_of_measure_sccpi6,
	"IMUMS7" AS IMUMS7_unit_of_measure_sccpi7,
	"IMUMS8" AS IMUMS8_unit_of_measure_sccpi8,
	"IMPILT" AS IMPILT_purchasing_internal_lead_time,
	"IMWTRQ" AS IMWTRQ_item_weight_required_yn,
	"IMPOC" AS IMPOC__i,
	"IMEXPI" AS IMEXPI_explode_item_10,
	"IMCONI" AS IMCONI_constraint_item_10,
	"IMORSP" AS IMORSP_allow_order_split_10,
	"IMCNSD" AS IMCNSD_consolidation_days,
	"IMCMDM" AS IMCMDM_commitment_date_method,
	"IMLECM" AS IMLECM_exp_date_calc_method,
	"IMBBDD" AS IMBBDD_best_before_default_days,
	"IMSBDD" AS IMSBDD_sell_by_default_days,
	"IMLEDD" AS IMLEDD_mfg_lot_effective_days,
	"IMPEFD" AS IMPEFD_purchasing_lot_effective_days,
	"IMU1DD" AS IMU1DD_user_lot_date_1_default_days,
	"IMU2DD" AS IMU2DD_user_lot_date_2_default_days,
	"IMU3DD" AS IMU3DD_user_lot_date_3_default_days,
	"IMU4DD" AS IMU4DD_user_lot_date_4_default_days,
	"IMU5DD" AS IMU5DD_user_lot_date_5_default_days,
	"IMTORG" AS IMTORG_transaction_originator,
	"IMUSER" AS IMUSER_user_id,
	"IMPID" AS IMPID__program_id,
	"IMJOBN" AS IMJOBN_work_station_id,
	"IMUPMJ" AS IMUPMJ_date_updated,
	"IMTDAY" AS IMTDAY_time_of_day 

-- INTO etl.F4101_item_master

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		IMITM,
		IMLITM,
		IMAITM,
		IMDSC1,
		IMDSC2,
		IMSRTX,
		IMALN,
		IMSRP1,
		IMSRP2,
		IMSRP3,
		IMSRP4,
		IMSRP5,
		IMSRP6,
		IMSRP7,
		IMSRP8,
		IMSRP9,
		IMSRP0,
		IMPRP1,
		IMPRP2,
		IMPRP3,
		IMPRP4,
		IMPRP5,
		IMPRP6,
		IMPRP7,
		IMPRP8,
		IMPRP9,
		IMPRP0,
		IMCDCD,
		IMPDGR,
		IMDSGP,
		IMPRGR,
		IMRPRC,
		IMORPR,
		IMBUYR,
		IMDRAW,
		IMRVNO,
		IMDSZE,
		CAST((IMVCUD)/10000.0 AS DEC(15,4)) AS IMVCUD,
		IMCARS,
		IMCARP,
		IMSHCN,
		IMSHCM,
		IMUOM1,
		IMUOM2,
		IMUOM3,
		IMUOM4,
		IMUOM6,
		IMUOM8,
		IMUOM9,
		IMUWUM,
		IMUVM1,
		IMSUTM,
		IMUMVW,
		IMCYCL,
		IMGLPT,
		IMPLEV,
		IMPPLV,
		IMCLEV,
		IMPRPO,
		IMCKAV,
		IMBPFG,
		IMSRCE,
		IMOT1Y,
		IMOT2Y,
		CAST((IMSTDP)/1000.0 AS DEC(15,3)) AS IMSTDP,
		CAST((IMFRMP)/1000.0 AS DEC(15,3)) AS IMFRMP,
		CAST((IMTHRP)/1000.0 AS DEC(15,3)) AS IMTHRP,
		IMSTDG,
		IMFRGD,
		IMTHGD,
		IMCOTY,
		IMSTKT,
		IMLNTY,
		IMCONT,
		IMBACK,
		IMIFLA,
		IMTFLA,
		IMINMG,
		IMABCS,
		IMABCM,
		IMABCI,
		IMOVR,
		IMWARR,
		IMCMCG,
		IMSRNR,
		IMPMTH,
		IMFIFO,
		IMLOTS,
		IMSLD,
		IMANPL,
		IMMPST,
		CAST((IMPCTM)/1000.0 AS DEC(15,3)) AS IMPCTM,
		CAST((IMMMPC)/1000.0 AS DEC(15,3)) AS IMMMPC,
		IMPTSC,
		IMSNS,
		IMLTLV,
		IMLTMF,
		IMLTCM,
		IMOPC,
		IMOPV,
		IMACQ,
		IMMLQ,
		CAST((IMLTPU)/100.0 AS DEC(15,2)) AS IMLTPU,
		IMMPSP,
		IMMRPP,
		IMITC,
		IMORDW,
		IMMTF1,
		IMMTF2,
		IMMTF3,
		IMMTF4,
		IMMTF5,
		0 AS IMMTF6,
		IMEXPD,
		IMDEFD,
		IMSFLT,
		IMMAKE,
		IMCOBY,
		IMLLX,
		IMCMGL,
		IMCOMH,
		IMCSNN,
		IMURCD,
		CASE WHEN IMURDT IS NOT NULL THEN DATE(DIGITS(DEC(IMURDT+ 1900000,7,0))) ELSE NULL END AS IMURDT,
		CAST((IMURAT)/100.0 AS DEC(15,2)) AS IMURAT,
		IMURAB,
		IMURRF,
		CAST((0)/100.0 AS DEC(15,2)) AS IMAVRT,
		'' '' AS IMUPCN,
		'' '' AS IMSCC0,
		'' '' AS IMUMUP,
		'' '' AS IMUMDF,
		'' '' AS IMUMS0,
		'' '' AS IMUMS1,
		'' '' AS IMUMS2,
		'' '' AS IMUMS3,
		'' '' AS IMUMS4,
		'' '' AS IMUMS5,
		'' '' AS IMUMS6,
		'' '' AS IMUMS7,
		'' '' AS IMUMS8,
		'' '' AS IMPILT,
		'' '' AS IMWTRQ,
		'' '' AS IMPOC,
		'' '' AS IMEXPI,
		'' '' AS IMCONI,
		'' '' AS IMORSP,
		'' '' AS IMCNSD,
		'' '' AS IMCMDM,
		'' '' AS IMLECM,
		0 AS IMBBDD,
		0 AS IMSBDD,
		0 AS IMLEDD,
		0 AS IMPEFD,
		0 AS IMU1DD,
		0 AS IMU2DD,
		0 AS IMU3DD,
		0 AS IMU4DD,
		0 AS IMU5DD,
		'' '' AS IMTORG,
		IMUSER,
		IMPID,
		IMJOBN,
		CASE WHEN IMUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(IMUPMJ+ 1900000,7,0))) ELSE NULL END AS IMUPMJ,
		IMTDAY

	FROM
		ARCPDTA71.F4101
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------

-- SELECT IMITM__item_number_short AS item_number_short, IMLITM_item_number AS item_number, IMAITM__3rd_item_number AS _3rd_item_number, IMDSC1_description AS description, IMDSC2_description_2 AS description_2, IMSRTX_search_text AS search_text, IMALN__search_text_compressed AS search_text_compressed, IMSRP1_sales_catalog_section AS sales_catalog_section, IMSRP2_sub_section AS sub_section, IMSRP3_sales_category_code_3 AS sales_category_code_3, IMSRP4_sales_category_code_4 AS sales_category_code_4, IMSRP5_sales_category_code_5 AS sales_category_code_5, IMSRP6_category_code_6 AS category_code_6, IMSRP7_category_code_7 AS category_code_7, IMSRP8_category_code_8 AS category_code_8, IMSRP9_category_code_9 AS category_code_9, IMSRP0_category_code_10 AS category_code_10, IMPRP1_commodity_class AS commodity_class, IMPRP2_commodity_sub_class AS commodity_sub_class, IMPRP3_supplier_rebate_code AS supplier_rebate_code, IMPRP4_master_planning_family AS master_planning_family, IMPRP5_landed_cost_rule AS landed_cost_rule, IMPRP6_item_dimension_group AS item_dimension_group, IMPRP7_warehouse_process_grp_1 AS warehouse_process_grp_1, IMPRP8_warehouse_process_grp_2 AS warehouse_process_grp_2, IMPRP9_warehouse_process_grp_3 AS warehouse_process_grp_3, IMPRP0_item_pool_code AS item_pool_code, IMCDCD_commodity_code AS commodity_code, IMPDGR_product_group AS product_group, IMDSGP_dispatch_group AS dispatch_group, IMPRGR_item_price_group AS item_price_group, IMRPRC_basket_reprice_group AS basket_reprice_group, IMORPR_order_reprice_group AS order_reprice_group, IMBUYR_buyer_number AS buyer_number, IMDRAW_drawing_number AS drawing_number, IMRVNO_last_revision_no AS last_revision_no, IMDSZE_drawing_size AS drawing_size, IMVCUD_volume_cubic_dimensions AS volume_cubic_dimensions, IMCARS_carrier_number AS carrier_number, IMCARP_preferred_carrier_purchasing AS preferred_carrier_purchasing, IMSHCN_shipping_conditions_code AS shipping_conditions_code, IMSHCM_shipping_commodity_class AS shipping_commodity_class, IMUOM1_unit_of_measure AS unit_of_measure, IMUOM2_secondary_uom AS secondary_uom, IMUOM3_purchasing_uom AS purchasing_uom, IMUOM4_pricing_uom AS pricing_uom, IMUOM6_shipping_uom AS shipping_uom, IMUOM8_production_uom AS production_uom, IMUOM9_component_uom AS component_uom, IMUWUM_unit_of_measure_weight AS unit_of_measure_weight, IMUVM1_unit_of_measure_volume AS unit_of_measure_volume, IMSUTM_stocking_um AS stocking_um, IMUMVW_psauvolume_or_weight AS psauvolume_or_weight, IMCYCL_cycle_count_category AS cycle_count_category, IMGLPT_gl_category AS gl_category, IMPLEV_sales_price_level AS sales_price_level, IMPPLV_purchase_price_level AS purchase_price_level, IMCLEV_inventory_cost_level AS inventory_cost_level, IMPRPO_gradepotency_pricing AS gradepotency_pricing, IMCKAV_check_availability_yn AS check_availability_yn, IMBPFG_bulkpacked_flag AS bulkpacked_flag, IMSRCE_layer_code_source AS layer_code_source, IMOT1Y_potency_control AS potency_control, IMOT2Y_grade_control AS grade_control, IMSTDP_standard_potency AS standard_potency, IMFRMP_from_potency AS from_potency, IMTHRP_thru_potency AS thru_potency, IMSTDG_standard_grade AS standard_grade, IMFRGD_from_grade AS from_grade, IMTHGD_thru_grade AS thru_grade, IMCOTY_component_type AS component_type, IMSTKT_stocking_type AS stocking_type, IMLNTY_line_type AS line_type, IMCONT_contract_item AS contract_item, IMBACK_backorders_allowed_yn AS backorders_allowed_yn, IMIFLA_item_flash_message AS item_flash_message, IMTFLA_std_uom_conversion AS std_uom_conversion, IMINMG_print_message AS print_message, IMABCS_abc_code_1_sales AS abc_code_1_sales, IMABCM_abc_code_2_margin AS abc_code_2_margin, IMABCI_abc_code_3_investment AS abc_code_3_investment, IMOVR__abc_code_override_indicator AS abc_code_override_indicator, IMWARR_warranty_item_group AS warranty_item_group, IMCMCG_commission_category AS commission_category, IMSRNR_serial_no_required AS serial_no_required, IMPMTH_kit_pricing_method AS kit_pricing_method, IMFIFO_fifo_processing AS fifo_processing, IMLOTS_lot_status_code AS lot_status_code, IMSLD__shelf_life_days AS shelf_life_days, IMANPL_planner_number AS planner_number, IMMPST_planning_code AS planning_code, IMPCTM_percent_margin AS percent_margin, IMMMPC_margin_maintenance_pct AS margin_maintenance_pct, IMPTSC_material_status AS material_status, IMSNS__round_to_whole_number AS round_to_whole_number, IMLTLV_leadtime_level AS leadtime_level, IMLTMF_leadtime_manufacturing AS leadtime_manufacturing, IMLTCM_leadtime_cumulative AS leadtime_cumulative, IMOPC__order_policy_code AS order_policy_code, IMOPV__value_order_policy AS value_order_policy, IMACQ__accounting_cost_quantity AS accounting_cost_quantity, IMMLQ__mfg_leadtime_quantity AS mfg_leadtime_quantity, IMLTPU_leadtime_per_unit AS leadtime_per_unit, IMMPSP_planning_fence_rule AS planning_fence_rule, IMMRPP_fixedvariable_leadtime AS fixedvariable_leadtime, IMITC__issue_type_code AS issue_type_code, IMORDW_order_with_yn AS order_with_yn, IMMTF1_planning_fence AS planning_fence, IMMTF2_freeze_fence AS freeze_fence, IMMTF3_message_display_fence AS message_display_fence, IMMTF4_time_fence AS time_fence, IMMTF5_shipment_leadtime_offset AS shipment_leadtime_offset, IMMTF6_supply_time_fence AS supply_time_fence, IMEXPD_expedite_damper_days AS expedite_damper_days, IMDEFD_defer_damper_days AS defer_damper_days, IMSFLT_safety_leadtime AS safety_leadtime, IMMAKE_makebuy_code AS makebuy_code, IMCOBY_cobyproductintermediate AS cobyproductintermediate, IMLLX__low_level_code AS low_level_code, IMCMGL_commitment_method AS commitment_method, IMCOMH_specific_commitment_days AS specific_commitment_days, IMCSNN_configured_string_id_next_number AS configured_string_id_next_number, IMURCD_user_reserved_code AS user_reserved_code, IMURDT_user_reserved_date AS user_reserved_date, IMURAT_user_reserved_amount AS user_reserved_amount, IMURAB_user_reserved_number AS user_reserved_number, IMURRF_user_reserved_reference AS user_reserved_reference, IMAVRT_replenishment_hours AS replenishment_hours, IMUPCN_upc_number AS upc_number, IMSCC0_aggregate_scc_code_pi0 AS aggregate_scc_code_pi0, IMUMUP_unit_of_measure_upc AS unit_of_measure_upc, IMUMDF_unit_of_measure_aggregate_upc AS unit_of_measure_aggregate_upc, IMUMS0_unit_of_measure_sccpi0 AS unit_of_measure_sccpi0, IMUMS1_unit_of_measure_sccpi1 AS unit_of_measure_sccpi1, IMUMS2_unit_of_measure_sccpi2 AS unit_of_measure_sccpi2, IMUMS3_unit_of_measure_sccpi3 AS unit_of_measure_sccpi3, IMUMS4_unit_of_measure_sccpi4 AS unit_of_measure_sccpi4, IMUMS5_unit_of_measure_sccpi5 AS unit_of_measure_sccpi5, IMUMS6_unit_of_measure_sccpi6 AS unit_of_measure_sccpi6, IMUMS7_unit_of_measure_sccpi7 AS unit_of_measure_sccpi7, IMUMS8_unit_of_measure_sccpi8 AS unit_of_measure_sccpi8, IMPILT_purchasing_internal_lead_time AS purchasing_internal_lead_time, IMWTRQ_item_weight_required_yn AS item_weight_required_yn, IMPOC__i AS i, IMEXPI_explode_item_10 AS explode_item_10, IMCONI_constraint_item_10 AS constraint_item_10, IMORSP_allow_order_split_10 AS allow_order_split_10, IMCNSD_consolidation_days AS consolidation_days, IMCMDM_commitment_date_method AS commitment_date_method, IMLECM_exp_date_calc_method AS exp_date_calc_method, IMBBDD_best_before_default_days AS best_before_default_days, IMSBDD_sell_by_default_days AS sell_by_default_days, IMLEDD_mfg_lot_effective_days AS mfg_lot_effective_days, IMPEFD_purchasing_lot_effective_days AS purchasing_lot_effective_days, IMU1DD_user_lot_date_1_default_days AS user_lot_date_1_default_days, IMU2DD_user_lot_date_2_default_days AS user_lot_date_2_default_days, IMU3DD_user_lot_date_3_default_days AS user_lot_date_3_default_days, IMU4DD_user_lot_date_4_default_days AS user_lot_date_4_default_days, IMU5DD_user_lot_date_5_default_days AS user_lot_date_5_default_days, IMTORG_transaction_originator AS transaction_originator, IMUSER_user_id AS user_id, IMPID__program_id AS program_id, IMJOBN_work_station_id AS work_station_id, IMUPMJ_date_updated AS date_updated, IMTDAY_time_of_day AS time_of_day FROM <...>

-- ETL07

--------------------------------------------------------------------------------
-- DROP TABLE etl.F41061_supplier_catalog_price_file
--------------------------------------------------------------------------------

SELECT 

    Top 5 
    "CBMCU" AS CBMCU__business_unit,
	"CBAN8" AS CBAN8__billto,
	"CBITM" AS CBITM__item_number_short,
	"CBLITM" AS CBLITM_item_number,
	"CBAITM" AS CBAITM__3rd_item_number,
	"CBCATN" AS CBCATN_catalog,
	"CBDMCT" AS CBDMCT_agreement_nbr,
	"CBDMCS" AS CBDMCS_agreement_supplement,
	"CBKCOO" AS CBKCOO_order_company,
	"CBDOCO" AS CBDOCO_salesorder_number,
	"CBDCTO" AS CBDCTO_order_type,
	"CBLNID" AS CBLNID_line_number,
	"CBCRCD" AS CBCRCD_currency_code,
	"CBUOM" AS CBUOM__um,
	"CBPRRC" AS CBPRRC_unit_cost,
	"CBUORG" AS CBUORG_quantity,
	"CBEFTJ" AS CBEFTJ_effective_date,
	"CBEXDJ" AS CBEXDJ_expired_date,
	"CBUSER" AS CBUSER_user_id,
	"CBPID" AS CBPID__program_id,
	"CBJOBN" AS CBJOBN_work_station_id,
	"CBUPMJ" AS CBUPMJ_date_updated,
	"CBTDAY" AS CBTDAY_time_of_day 

-- INTO etl.F41061_supplier_catalog_price_file

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		CBMCU,
		CBAN8,
		CBITM,
		CBLITM,
		CBAITM,
		CBCATN,
		CBDMCT,
		CBDMCS,
		CBKCOO,
		CBDOCO,
		CBDCTO,
		CAST((CBLNID)/1000.0 AS DEC(15,3)) AS CBLNID,
		CBCRCD,
		CBUOM,
		CAST((CBPRRC)/10000.0 AS DEC(15,4)) AS CBPRRC,
		CBUORG,
		DATE(DIGITS(DEC(CBEFTJ+ 1900000,7,0))) AS CBEFTJ,
		DATE(DIGITS(DEC(CBEXDJ+ 1900000,7,0))) AS CBEXDJ,
		CBUSER,
		CBPID,
		CBJOBN,
		CASE WHEN CBUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(CBUPMJ+ 1900000,7,0))) ELSE NULL END AS CBUPMJ,
		CBTDAY

	FROM
		ARCPDTA71.F41061
    WHERE
		CBEFTJ <= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) AND 		
		CBEXDJ >= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3))  		
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------

-- SELECT CBMCU__business_unit AS business_unit, CBAN8__billto AS billto, CBITM__item_number_short AS item_number_short, CBLITM_item_number AS item_number, CBAITM__3rd_item_number AS _3rd_item_number, CBCATN_catalog AS catalog, CBDMCT_agreement_nbr AS agreement_nbr, CBDMCS_agreement_supplement AS agreement_supplement, CBKCOO_order_company AS order_company, CBDOCO_salesorder_number AS salesorder_number, CBDCTO_order_type AS order_type, CBLNID_line_number AS line_number, CBCRCD_currency_code AS currency_code, CBUOM__um AS um, CBPRRC_unit_cost AS unit_cost, CBUORG_quantity AS quantity, CBEFTJ_effective_date AS effective_date, CBEXDJ_expired_date AS expired_date, CBUSER_user_id AS user_id, CBPID__program_id AS program_id, CBJOBN_work_station_id AS work_station_id, CBUPMJ_date_updated AS date_updated, CBTDAY_time_of_day AS time_of_day FROM <...>


-- ETL08

--------------------------------------------------------------------------------
-- DROP TABLE etl.F5613_product_extension_file
--------------------------------------------------------------------------------

SELECT 

    Top 5 
    "QNITM" AS QNITM__item_number_short,
	"QNLITM" AS QNLITM_item_number,
	"QNAITM" AS QNAITM__3rd_item_number,
	"QN$FIN" AS QN$FIN_force_item_notes,
	"QN$FRT" AS QN$FRT_freightable_item,
	"QN$IVP" AS QN$IVP_inventory_percentage,
	"QN$CEM" AS QN$CEM_ce_mark,
	"QN$CER" AS QN$CER_ce_mark_required,
	"QN$RPK" AS QN$RPK_repack,
	"QN$SPC" AS QN$SPC_supplier_code,
	"QN$SZE" AS QN$SZE_size_packaged_units,
	"QN$STR" AS QN$STR_strength,
	"QN$MDC" AS QN$MDC_multiple_drug_classes,
	"QN$STU" AS QN$STU_status,
	"QN$DS" AS QN$DS__drop_ship,
	"QN$IFP" AS QN$IFP_inbound_frt_adj_pct,
	"QN$IFD" AS QN$IFD_inbound_frt_adj_amt,
	"QN$SOM" AS QN$SOM_sales_order_markup,
	"QNLTDT" AS QNLTDT_transit_days,
	"QNINMG" AS QNINMG_print_message,
	"QNUSER" AS QNUSER_user_id,
	"QNPID" AS QNPID__program_id,
	"QNJOBN" AS QNJOBN_work_station_id,
	"QNUPMJ" AS QNUPMJ_date_updated,
	"QNTDAY" AS QNTDAY_time_of_day 

-- INTO etl.F5613_product_extension_file

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		QNITM,
		QNLITM,
		QNAITM,
		QN$FIN,
		QN$FRT,
		CAST((QN$IVP)/1000.0 AS DEC(15,3)) AS QN$IVP,
		QN$CEM,
		QN$CER,
		QN$RPK,
		QN$SPC,
		QN$SZE,
		QN$STR,
		QN$MDC,
		QN$STU,
		QN$DS,
		QN$IFP,
		QN$IFD,
		CAST((QN$SOM)/10000.0 AS DEC(15,4)) AS QN$SOM,
		QNLTDT,
		QNINMG,
		QNUSER,
		QNPID,
		QNJOBN,
		CASE WHEN QNUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(QNUPMJ+ 1900000,7,0))) ELSE NULL END AS QNUPMJ,
		QNTDAY

	FROM
		ARCPDTA71.F5613
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------

-- SELECT QNITM__item_number_short AS item_number_short, QNLITM_item_number AS item_number, QNAITM__3rd_item_number AS _3rd_item_number, QN$FIN_force_item_notes AS force_item_notes, QN$FRT_freightable_item AS freightable_item, QN$IVP_inventory_percentage AS inventory_percentage, QN$CEM_ce_mark AS ce_mark, QN$CER_ce_mark_required AS ce_mark_required, QN$RPK_repack AS repack, QN$SPC_supplier_code AS supplier_code, QN$SZE_size_packaged_units AS size_packaged_units, QN$STR_strength AS strength, QN$MDC_multiple_drug_classes AS multiple_drug_classes, QN$STU_status AS status, QN$DS__drop_ship AS drop_ship, QN$IFP_inbound_frt_adj_pct AS inbound_frt_adj_pct, QN$IFD_inbound_frt_adj_amt AS inbound_frt_adj_amt, QN$SOM_sales_order_markup AS sales_order_markup, QNLTDT_transit_days AS transit_days, QNINMG_print_message AS print_message, QNUSER_user_id AS user_id, QNPID__program_id AS program_id, QNJOBN_work_station_id AS work_station_id, QNUPMJ_date_updated AS date_updated, QNTDAY_time_of_day AS time_of_day FROM <...>




--------------------------------------------------------------------------------
-- DROP TABLE etl.F5656_wcs_unique_fields_file
--------------------------------------------------------------------------------

SELECT 

    Top 5 
    "QVITM" AS QVITM__item_number_short,
	"QVLITM" AS QVLITM_item_number,
	"QVAITM" AS QVAITM__3rd_item_number,
	"QV$AVC" AS QV$AVC_availability_code,
	"QV$RQT" AS QV$RQT_restricted_qty,
	"QV$CCD" AS QV$CCD_case_code,
	"QV$CCQ" AS QV$CCQ_case_qty,
	"QV$ITH" AS QV$ITH_item_height,
	"QV$ITW" AS QV$ITW_item_width,
	"QV$ITL" AS QV$ITL_item_length,
	"QV$IDC" AS QV$IDC_importdomestic,
	"QV$CLC" AS QV$CLC_classification_code,
	"QV$PRI" AS QV$PRI_pricing_info,
	"QV$MMC" AS QV$MMC_mix_match_code,
	"QV$VCD" AS QV$VCD_vendor_code,
	"QV$LCT" AS QV$LCT_location_type,
	"QV$PPL" AS QV$PPL_print_on_pickticket,
	"QV$BKD" AS QV$BKD_backorder_date_JDT,
	"QV$ABD" AS QV$ABD_abbr_descr,
	"QV$ASR" AS QV$ASR_abbreviated_strength,
	"QVUSER" AS QVUSER_user_id,
	"QVPID" AS QVPID__program_id,
	"QVJOBN" AS QVJOBN_work_station_id,
	"QVUPMJ" AS QVUPMJ_date_updated,
	"QVTDAY" AS QVTDAY_time_of_day 

-- INTO etl.F5656_wcs_unique_fields_file

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		QVITM,
		QVLITM,
		QVAITM,
		QV$AVC,
		QV$RQT,
		QV$CCD,
		QV$CCQ,
		CAST((QV$ITH)/10.0 AS DEC(15,1)) AS QV$ITH,
		CAST((QV$ITW)/10.0 AS DEC(15,1)) AS QV$ITW,
		CAST((QV$ITL)/10.0 AS DEC(15,1)) AS QV$ITL,
		QV$IDC,
		QV$CLC,
		QV$PRI,
		QV$MMC,
		QV$VCD,
		QV$LCT,
		QV$PPL,
		QV$BKD AS QV$BKD,
		QV$ABD,
		QV$ASR,
		QVUSER,
		QVPID,
		QVJOBN,
		CASE WHEN QVUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(QVUPMJ+ 1900000,7,0))) ELSE NULL END AS QVUPMJ,
		QVTDAY

	FROM
		ARCPDTA71.F5656
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------

-- SELECT QVITM__item_number_short AS item_number_short, QVLITM_item_number AS item_number, QVAITM__3rd_item_number AS _3rd_item_number, QV$AVC_availability_code AS availability_code, QV$RQT_restricted_qty AS restricted_qty, QV$CCD_case_code AS case_code, QV$CCQ_case_qty AS case_qty, QV$ITH_item_height AS item_height, QV$ITW_item_width AS item_width, QV$ITL_item_length AS item_length, QV$IDC_importdomestic AS importdomestic, QV$CLC_classification_code AS classification_code, QV$PRI_pricing_info AS pricing_info, QV$MMC_mix_match_code AS mix_match_code, QV$VCD_vendor_code AS vendor_code, QV$LCT_location_type AS location_type, QV$PPL_print_on_pickticket AS print_on_pickticket, QV$BKD_backorder_date AS backorder_date, QV$ABD_abbr_descr AS abbr_descr, QV$ASR_abbreviated_strength AS abbreviated_strength, QVUSER_user_id AS user_id, QVPID__program_id AS program_id, QVJOBN_work_station_id AS work_station_id, QVUPMJ_date_updated AS date_updated, QVTDAY_time_of_day AS time_of_day FROM <...>

-- ETL09

--------------------------------------------------------------------------------
-- DROP TABLE etl.F0101_address_book_master
--------------------------------------------------------------------------------

SELECT 

    Top 5 
    "ABAN8" AS ABAN8__billto,
	"ABALKY" AS ABALKY_long_address_number,
	"ABTAX" AS ABTAX__tax_id,
	"ABALPH" AS ABALPH_alpha_name,
	"ABDC" AS ABDC___description_compressed,
	"ABMCU" AS ABMCU__business_unit,
	"ABSIC" AS ABSIC__industry_classification,
	"ABLNGP" AS ABLNGP_language,
	"ABAT1" AS ABAT1__search_type,
	"ABCM" AS ABCM___credit_message,
	"ABTAXC" AS ABTAXC_personcorporation_code,
	"ABAT2" AS ABAT2__arap_netting_y,
	"ABAT3" AS ABAT3__address_type_3_yn,
	"ABAT4" AS ABAT4__address_type_4_yn,
	"ABAT5" AS ABAT5__address_type_5_yn,
	"ABATP" AS ABATP__payables_ynm,
	"ABATR" AS ABATR__receivables_yn,
	"ABATPR" AS ABATPR_status,
	"ABAB3" AS ABAB3__miscellaneous_code,
	"ABATE" AS ABATE__employee_yn,
	"ABSBLI" AS ABSBLI_subledger_inactive_code,
	"ABEFTB" AS ABEFTB_start_effective_date,
	"ABAN81" AS ABAN81__1st_address_number,
	"ABAN82" AS ABAN82__2nd_address_number,
	"ABAN83" AS ABAN83__3rd_address_number,
	"ABAN84" AS ABAN84__4th_address_number,
	"ABAN86" AS ABAN86__5th_address_number,
	"ABAN85" AS ABAN85_factorspecial_payee_hard_coded,
	"ABAC01" AS ABAC01_customer_profession,
	"ABAC02" AS ABAC02_account_representative,
	"ABAC03" AS ABAC03_category_code_03,
	"ABAC04" AS ABAC04_geographic_region,
	"ABAC05" AS ABAC05_category_code_05,
	"ABAC06" AS ABAC06_category_code_06,
	"ABAC07" AS ABAC07__1099_reporting,
	"ABAC08" AS ABAC08_category_code_08,
	"ABAC09" AS ABAC09_category_code_09,
	"ABAC10" AS ABAC10_category_code_10,
	"ABAC11" AS ABAC11_sales_region,
	"ABAC12" AS ABAC12_category_code_12,
	"ABAC13" AS ABAC13_line_of_business,
	"ABAC14" AS ABAC14_foreign_country_code,
	"ABAC15" AS ABAC15_category_code_15,
	"ABAC16" AS ABAC16_category_code_16,
	"ABAC17" AS ABAC17_category_code_17,
	"ABAC18" AS ABAC18_category_code_18,
	"ABAC19" AS ABAC19_category_code_19,
	"ABAC20" AS ABAC20_category_code_20,
	"ABAC21" AS ABAC21_category_code_21,
	"ABAC22" AS ABAC22_category_code_22,
	"ABAC23" AS ABAC23_category_code_23,
	"ABAC24" AS ABAC24_category_code_24,
	"ABAC25" AS ABAC25_category_code_25,
	"ABAC26" AS ABAC26_category_code_26,
	"ABAC27" AS ABAC27_category_code_27,
	"ABAC28" AS ABAC28_category_code_28,
	"ABAC29" AS ABAC29_category_code_29,
	"ABAC30" AS ABAC30_category_code_30,
	"ABGLBA" AS ABGLBA_gl_bank_account,
	"ABPTI" AS ABPTI__time_scheduled_in,
	"ABPDI" AS ABPDI__date_scheduled_in_JDT,
	"ABMSGA" AS ABMSGA_cleared_y,
	"ABRMK" AS ABRMK__remark,
	"ABTXCT" AS ABTXCT_certificate,
	"ABTX2" AS ABTX2__addl_ind_tax_id,
	"ABALP1" AS ABALP1_secondary_alpha_name,
	"ABURCD" AS ABURCD_user_reserved_code,
	"ABURDT" AS ABURDT_user_reserved_date_JDT,
	"ABURAT" AS ABURAT_user_reserved_amount,
	"ABURAB" AS ABURAB_user_reserved_number,
	"ABURRF" AS ABURRF_user_reserved_reference,
	"ABEMCD" AS ABEMCD_email_client_designator,
	"ABUSER" AS ABUSER_user_id,
	"ABPID" AS ABPID__program_id,
	"ABUPMJ" AS ABUPMJ_date_updated_JDT,
	"ABJOBN" AS ABJOBN_work_station_id,
	"ABUPMT" AS ABUPMT_time_last_updated,
	"ABTORG" AS ABTORG_transaction_originator,
	"ABCNCD" AS ABCNCD_consolidation_code,
	"ABPA8" AS ABPA8__parent_number,
	"ABXAB" AS ABXAB__inactive_code,
	"ABFMDL" AS ABFMDL_templatemodel_flag,
	"ABHLS" AS ABHLS__homeland_security_flag,
	"ABNACS" AS ABNACS_naics_code,
	"ABUR1A" AS ABUR1A_user_reserved_field,
	"ABURA1" AS ABURA1_user_reserved_field,
	"ABFC05" AS ABFC05_deletion_flag,
	"ABFC06" AS ABFC06_future_use,
	"ABFC07" AS ABFC07_future_use,
	"ABFC08" AS ABFC08_future_use,
	"ABFCD3" AS ABFCD3_future_use_JDT,
	"ABFCD4" AS ABFCD4_future_use_JDT 

-- INTO etl.F0101_address_book_master

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		ABAN8,
		ABALKY,
		ABTAX,
		ABALPH,
		ABDC,
		ABMCU,
		ABSIC,
		ABLNGP,
		ABAT1,
		ABCM,
		ABTAXC,
		ABAT2,
		ABAT3,
		ABAT4,
		ABAT5,
		ABATP,
		ABATR,
		ABATPR,
		ABAB3,
		ABATE,
		ABSBLI,
		ABEFTB AS ABEFTB,
		ABAN81,
		ABAN82,
		ABAN83,
		ABAN84,
		ABAN86,
		ABAN85,
		ABAC01,
		ABAC02,
		ABAC03,
		ABAC04,
		ABAC05,
		ABAC06,
		ABAC07,
		ABAC08,
		ABAC09,
		ABAC10,
		ABAC11,
		ABAC12,
		ABAC13,
		ABAC14,
		ABAC15,
		ABAC16,
		ABAC17,
		ABAC18,
		ABAC19,
		ABAC20,
		ABAC21,
		ABAC22,
		ABAC23,
		ABAC24,
		ABAC25,
		ABAC26,
		ABAC27,
		ABAC28,
		ABAC29,
		ABAC30,
		ABGLBA,
		ABPTI,
		ABPDI AS ABPDI,
		ABMSGA,
		ABRMK,
		ABTXCT,
		ABTX2,
		ABALP1,
		ABURCD,
		ABURDT  AS ABURDT,
		CAST((ABURAT)/100.0 AS DEC(15,2)) AS ABURAT,
		ABURAB,
		ABURRF,
		'' '' AS ABEMCD,
		ABUSER,
		ABPID,
		ABUPMJ AS ABUPMJ,
		ABJOBN,
		ABUPMT,
		'' '' AS ABTORG,
		'' '' AS ABCNCD,
		0 AS ABPA8,
		'' '' AS ABXAB,
		'' '' AS ABFMDL,
		'' '' AS ABHLS,
		'' '' AS ABNACS,
		'' '' AS ABUR1A,
		'' '' AS ABURA1,
		'' '' AS ABFC05,
		'' '' AS ABFC06,
		'' '' AS ABFC07,
		'' '' AS ABFC08,
		0 AS ABFCD3,
		0 AS ABFCD4

	FROM
		ARCPDTA71.F0101
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------

-- SELECT ABAN8__billto AS billto, ABALKY_long_address_number AS long_address_number, ABTAX__tax_id AS tax_id, ABALPH_alpha_name AS alpha_name, ABDC___description_compressed AS description_compressed, ABMCU__business_unit AS business_unit, ABSIC__industry_classification AS industry_classification, ABLNGP_language AS language, ABAT1__search_type AS search_type, ABCM___credit_message AS credit_message, ABTAXC_personcorporation_code AS personcorporation_code, ABAT2__arap_netting_y AS arap_netting_y, ABAT3__address_type_3_yn AS address_type_3_yn, ABAT4__address_type_4_yn AS address_type_4_yn, ABAT5__address_type_5_yn AS address_type_5_yn, ABATP__payables_ynm AS payables_ynm, ABATR__receivables_yn AS receivables_yn, ABATPR_status AS status, ABAB3__miscellaneous_code AS miscellaneous_code, ABATE__employee_yn AS employee_yn, ABSBLI_subledger_inactive_code AS subledger_inactive_code, ABEFTB_start_effective_date AS start_effective_date, ABAN81__1st_address_number AS _1st_address_number, ABAN82__2nd_address_number AS _2nd_address_number, ABAN83__3rd_address_number AS _3rd_address_number, ABAN84__4th_address_number AS _4th_address_number, ABAN86__5th_address_number AS _5th_address_number, ABAN85_factorspecial_payee_hard_coded AS factorspecial_payee_hard_coded, ABAC01_customer_profession AS customer_profession, ABAC02_account_representative AS account_representative, ABAC03_category_code_03 AS category_code_03, ABAC04_geographic_region AS geographic_region, ABAC05_category_code_05 AS category_code_05, ABAC06_category_code_06 AS category_code_06, ABAC07__1099_reporting AS _1099_reporting, ABAC08_category_code_08 AS category_code_08, ABAC09_category_code_09 AS category_code_09, ABAC10_category_code_10 AS category_code_10, ABAC11_sales_region AS sales_region, ABAC12_category_code_12 AS category_code_12, ABAC13_line_of_business AS line_of_business, ABAC14_foreign_country_code AS foreign_country_code, ABAC15_category_code_15 AS category_code_15, ABAC16_category_code_16 AS category_code_16, ABAC17_category_code_17 AS category_code_17, ABAC18_category_code_18 AS category_code_18, ABAC19_category_code_19 AS category_code_19, ABAC20_category_code_20 AS category_code_20, ABAC21_category_code_21 AS category_code_21, ABAC22_category_code_22 AS category_code_22, ABAC23_category_code_23 AS category_code_23, ABAC24_category_code_24 AS category_code_24, ABAC25_category_code_25 AS category_code_25, ABAC26_category_code_26 AS category_code_26, ABAC27_category_code_27 AS category_code_27, ABAC28_category_code_28 AS category_code_28, ABAC29_category_code_29 AS category_code_29, ABAC30_category_code_30 AS category_code_30, ABGLBA_gl_bank_account AS gl_bank_account, ABPTI__time_scheduled_in AS time_scheduled_in, ABPDI__date_scheduled_in AS date_scheduled_in, ABMSGA_cleared_y AS cleared_y, ABRMK__remark AS remark, ABTXCT_certificate AS certificate, ABTX2__addl_ind_tax_id AS addl_ind_tax_id, ABALP1_secondary_alpha_name AS secondary_alpha_name, ABURCD_user_reserved_code AS user_reserved_code, ABURDT_user_reserved_date AS user_reserved_date, ABURAT_user_reserved_amount AS user_reserved_amount, ABURAB_user_reserved_number AS user_reserved_number, ABURRF_user_reserved_reference AS user_reserved_reference, ABEMCD_email_client_designator AS email_client_designator, ABUSER_user_id AS user_id, ABPID__program_id AS program_id, ABUPMJ_date_updated AS date_updated, ABJOBN_work_station_id AS work_station_id, ABUPMT_time_last_updated AS time_last_updated, ABTORG_transaction_originator AS transaction_originator, ABCNCD_consolidation_code AS consolidation_code, ABPA8__parent_number AS parent_number, ABXAB__inactive_code AS inactive_code, ABFMDL_templatemodel_flag AS templatemodel_flag, ABHLS__homeland_security_flag AS homeland_security_flag, ABNACS_naics_code AS naics_code, ABUR1A_user_reserved_field AS user_reserved_field, ABURA1_user_reserved_field AS user_reserved_field, ABFC05_deletion_flag AS deletion_flag, ABFC06_future_use AS future_use, ABFC07_future_use AS future_use, ABFC08_future_use AS future_use, ABFCD3_future_use AS future_use, ABFCD4_future_use AS future_use FROM <...>


-- ETL09


--------------------------------------------------------------------------------
-- DROP TABLE STAGE_JDE_ARCPDTA93_F4070_<instert_friendly_name_here>
--------------------------------------------------------------------------------

SELECT 

    Top 5 
    "SNASN" AS SNASN__adjustment_schedule, "SNOSEQ" AS SNOSEQ_sequence_number, "SNAST" AS SNAST__adjustment_name, "SNURCD" AS SNURCD_user_reserved_code, "SNURDT" AS SNURDT_user_reserved_date, "SNURAT" AS SNURAT_user_reserved_amount, "SNURAB" AS SNURAB_user_reserved_number, "SNURRF" AS SNURRF_user_reserved_reference, "SNUSER" AS SNUSER_user_id, "SNPID" AS SNPID__program_id, "SNJOBN" AS SNJOBN_work_station_id, "SNUPMJ" AS SNUPMJ_date_updated, "SNTDAY" AS SNTDAY_time_of_day 

-- INTO etl.ARCPDTA93_F4070_<instert_friendly_name_here>

FROM 
    OPENQUERY (ESYS_QA, '

	SELECT
		SNASN, SNOSEQ, SNAST, SNURCD, CASE WHEN SNURDT IS NOT NULL THEN DATE(DIGITS(DEC(SNURDT+ 1900000,7,0))) ELSE NULL END AS SNURDT, CAST((SNURAT)/100.0 AS DEC(15,2)) AS SNURAT, SNURAB, SNURRF, SNUSER, SNPID, SNJOBN, CASE WHEN SNUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(SNUPMJ+ 1900000,7,0))) ELSE NULL END AS SNUPMJ, SNTDAY

	FROM
		ARCPDTA93.F4070
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------

-- SELECT SNASN__adjustment_schedule AS adjustment_schedule, SNOSEQ_sequence_number AS sequence_number, SNAST__adjustment_name AS adjustment_name, SNURCD_user_reserved_code AS user_reserved_code, SNURDT_user_reserved_date AS user_reserved_date, SNURAT_user_reserved_amount AS user_reserved_amount, SNURAB_user_reserved_number AS user_reserved_number, SNURRF_user_reserved_reference AS user_reserved_reference, SNUSER_user_id AS user_id, SNPID__program_id AS program_id, SNJOBN_work_station_id AS work_station_id, SNUPMJ_date_updated AS date_updated, SNTDAY_time_of_day AS time_of_day FROM <...>


-- ETL10


--------------------------------------------------------------------------------
-- DROP TABLE etl.F4071_price_adjustment_name
--------------------------------------------------------------------------------

SELECT 

    Top 5 
    "ATAST" AS ATAST__adjustment_name,
	"ATPRGR" AS ATPRGR_item_price_group,
	"ATCPGP" AS ATCPGP_customer_price_group,
	"ATSDGR" AS ATSDGR_order_detail_group,
	"ATPRFR" AS ATPRFR_preference_type,
	"ATLBT" AS ATLBT__level_break_type,
	"ATGLC" AS ATGLC__gl_offset,
	"ATSBIF" AS ATSBIF_subledger_in_gl,
	"ATACNT" AS ATACNT_adjustment_control_code,
	"ATLNTY" AS ATLNTY_line_type,
	"ATMDED" AS ATMDED_manual_addchange_yn,
	"ATABAS" AS ATABAS_override_price_yn,
	"ATOLVL" AS ATOLVL_adjustment_level,
	"ATTXB" AS ATTXB__taxable_yn,
	"ATPA01" AS ATPA01_rebate_beneficiary,
	"ATPA02" AS ATPA02_mandatory_adjustment,
	"ATPA03" AS ATPA03_exclude_from_payment_discount,
	"ATPA04" AS ATPA04_target_application,
	"ATPA05" AS ATPA05_include_in_margin_calc,
	"ATPA06" AS ATPA06_final_price,
	"ATPA07" AS ATPA07_processing_type_free_good,
	"ATPA08" AS ATPA08_price_adjustment_code_08,
	"ATPA09" AS ATPA09_price_adjustment_code_09,
	"ATPA10" AS ATPA10_price_adjustment_code_10,
	"ATEFCN" AS ATEFCN_excl_from_curr_net,
	"ATPTC" AS ATPTC__payment_terms,
	"ATURCD" AS ATURCD_user_reserved_code,
	"ATURDT" AS ATURDT_user_reserved_date_JDT,
	"ATURAT" AS ATURAT_user_reserved_amount,
	"ATURAB" AS ATURAB_user_reserved_number,
	"ATURRF" AS ATURRF_user_reserved_reference,
	"ATUSER" AS ATUSER_user_id,
	"ATPID" AS ATPID__program_id,
	"ATJOBN" AS ATJOBN_work_station_id,
	"ATUPMJ" AS ATUPMJ_date_updated,
	"ATTDAY" AS ATTDAY_time_of_day 

-- INTO etl.F4071_price_adjustment_name

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		ATAST,
		ATPRGR,
		ATCPGP,
		ATSDGR,
		ATPRFR,
		ATLBT,
		ATGLC,
		ATSBIF,
		ATACNT,
		ATLNTY,
		ATMDED,
		ATABAS,
		ATOLVL,
		ATTXB,
		ATPA01,
		ATPA02,
		ATPA03,
		ATPA04,
		ATPA05,
		'' '' AS ATPA06,
		'' '' AS ATPA07,
		'' '' AS ATPA08,
		'' '' AS ATPA09,
		'' '' AS ATPA10,
		'' '' AS ATEFCN,
		'' '' AS ATPTC,
		ATURCD,
		ATURDT AS ATURDT,
		CAST((ATURAT)/100.0 AS DEC(15,2)) AS ATURAT,
		ATURAB,
		ATURRF,
		ATUSER,
		ATPID,
		ATJOBN,
		CASE WHEN ATUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(ATUPMJ+ 1900000,7,0))) ELSE NULL END AS ATUPMJ,
		ATTDAY

	FROM
		ARCPDTA71.F4071
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------

-- SELECT ATAST__adjustment_name AS adjustment_name, ATPRGR_item_price_group AS item_price_group, ATCPGP_customer_price_group AS customer_price_group, ATSDGR_order_detail_group AS order_detail_group, ATPRFR_preference_type AS preference_type, ATLBT__level_break_type AS level_break_type, ATGLC__gl_offset AS gl_offset, ATSBIF_subledger_in_gl AS subledger_in_gl, ATACNT_adjustment_control_code AS adjustment_control_code, ATLNTY_line_type AS line_type, ATMDED_manual_addchange_yn AS manual_addchange_yn, ATABAS_override_price_yn AS override_price_yn, ATOLVL_adjustment_level AS adjustment_level, ATTXB__taxable_yn AS taxable_yn, ATPA01_rebate_beneficiary AS rebate_beneficiary, ATPA02_mandatory_adjustment AS mandatory_adjustment, ATPA03_exclude_from_payment_discount AS exclude_from_payment_discount, ATPA04_target_application AS target_application, ATPA05_include_in_margin_calc AS include_in_margin_calc, ATPA06_final_price AS final_price, ATPA07_processing_type_free_good AS processing_type_free_good, ATPA08_price_adjustment_code_08 AS price_adjustment_code_08, ATPA09_price_adjustment_code_09 AS price_adjustment_code_09, ATPA10_price_adjustment_code_10 AS price_adjustment_code_10, ATEFCN_excl_from_curr_net AS excl_from_curr_net, ATPTC__payment_terms AS payment_terms, ATURCD_user_reserved_code AS user_reserved_code, ATURDT_user_reserved_date AS user_reserved_date, ATURAT_user_reserved_amount AS user_reserved_amount, ATURAB_user_reserved_number AS user_reserved_number, ATURRF_user_reserved_reference AS user_reserved_reference, ATUSER_user_id AS user_id, ATPID__program_id AS program_id, ATJOBN_work_station_id AS work_station_id, ATUPMJ_date_updated AS date_updated, ATTDAY_time_of_day AS time_of_day FROM <...>



--------------------------------------------------------------------------------
-- DROP TABLE etl.F0005_user_defined_codes
--------------------------------------------------------------------------------

SELECT 

    Top 5 
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

-- INTO etl.F0005_user_defined_codes

FROM 
    OPENQUERY (ESYS_PROD, '

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
		ARCPCOM71.F0005
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------

-- SELECT DRSY___product_code AS product_code, DRRT___user_defined_codes AS user_defined_codes, DRKY___user_defined_code AS user_defined_code, DRDL01_description AS description, DRDL02_description_02 AS description_02, DRSPHD_special_handling_code AS special_handling_code, DRUDCO_active_flag_yn AS active_flag_yn, DRHRDC_hard_coded_yn AS hard_coded_yn, DRUSER_user_id AS user_id, DRPID__program_id AS program_id, DRUPMJ_date_updated AS date_updated, DRJOBN_work_station_id AS work_station_id, DRUPMT_time_last_updated AS time_last_updated FROM <...>



-- ETL


--------------------------------------------------------------------------------
-- DROP TABLE etl.F554072_price_adjustment_detail_extension
--------------------------------------------------------------------------------

SELECT 

--    Top 5 
    "QXAST" AS QXAST__adjustment_name,
	"QXATID" AS QXATID_price_adjustment_key_id,
	"QX$PLT" AS QX$PLT_promotional_limit,
	"QX$SPE" AS QX$SPE_special_processing_code,
	"QX$APM" AS QX$APM_additional_promotion_code,
	"QX$PMU" AS QX$PMU_premium_point_multiplier,
	"QXURCD" AS QXURCD_user_reserved_code,
	"QXURDT" AS QXURDT_user_reserved_date,
	"QXURAT" AS QXURAT_user_reserved_amount_JDT,
	"QXURAB" AS QXURAB_user_reserved_number,
	"QXURRF" AS QXURRF_user_reserved_reference,
	"QXUSER" AS QXUSER_user_id,
	"QXPID" AS QXPID__program_id,
	"QXJOBN" AS QXJOBN_work_station_id,
	"QXUPMJ" AS QXUPMJ_date_updated,
	"QXTDAY" AS QXTDAY_time_of_day 

-- INTO etl.F554072_price_adjustment_detail_extension

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
		QXUPMJ AS QXUPMJ,
		QXTDAY

	FROM
		ARCPDTA71.F554072
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------

-- SELECT QXAST__adjustment_name AS adjustment_name, QXATID_price_adjustment_key_id AS price_adjustment_key_id, QX$PLT_promotional_limit AS promotional_limit, QX$SPE_special_processing_code AS special_processing_code, QX$APM_additional_promotion_code AS additional_promotion_code, QX$PMU_premium_point_multiplier AS premium_point_multiplier, QXURCD_user_reserved_code AS user_reserved_code, QXURDT_user_reserved_date AS user_reserved_date, QXURAT_user_reserved_amount AS user_reserved_amount, QXURAB_user_reserved_number AS user_reserved_number, QXURRF_user_reserved_reference AS user_reserved_reference, QXUSER_user_id AS user_id, QXPID__program_id AS program_id, QXJOBN_work_station_id AS work_station_id, QXUPMJ_date_updated AS date_updated, QXTDAY_time_of_day AS time_of_day FROM <...>


-- ETL


--------------------------------------------------------------------------------
-- DROP TABLE etl.F4070_price_adjustment_schedule
--------------------------------------------------------------------------------

SELECT 

    Top 5 
    "SNASN" AS SNASN__adjustment_schedule,
	"SNOSEQ" AS SNOSEQ_sequence_number,
	"SNAST" AS SNAST__adjustment_name,
	"SNURCD" AS SNURCD_user_reserved_code,
	"SNURDT" AS SNURDT_user_reserved_date_JDT,
	"SNURAT" AS SNURAT_user_reserved_amount,
	"SNURAB" AS SNURAB_user_reserved_number,
	"SNURRF" AS SNURRF_user_reserved_reference,
	"SNUSER" AS SNUSER_user_id,
	"SNPID" AS SNPID__program_id,
	"SNJOBN" AS SNJOBN_work_station_id,
	"SNUPMJ" AS SNUPMJ_date_updated_JDT,
	"SNTDAY" AS SNTDAY_time_of_day 

-- INTO etl.F4070_price_adjustment_schedule

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		SNASN,
		SNOSEQ,
		SNAST,
		SNURCD,
		SNURDT AS SNURDT,
		CAST((SNURAT)/100.0 AS DEC(15,2)) AS SNURAT,
		SNURAB,
		SNURRF,
		SNUSER,
		SNPID,
		SNJOBN,
		SNUPMJ AS SNUPMJ,
		SNTDAY

	FROM
		ARCPDTA71.F4070
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------

-- SELECT SNASN__adjustment_schedule AS adjustment_schedule, SNOSEQ_sequence_number AS sequence_number, SNAST__adjustment_name AS adjustment_name, SNURCD_user_reserved_code AS user_reserved_code, SNURDT_user_reserved_date AS user_reserved_date, SNURAT_user_reserved_amount AS user_reserved_amount, SNURAB_user_reserved_number AS user_reserved_number, SNURRF_user_reserved_reference AS user_reserved_reference, SNUSER_user_id AS user_id, SNPID__program_id AS program_id, SNJOBN_work_station_id AS work_station_id, SNUPMJ_date_updated AS date_updated, SNTDAY_time_of_day AS time_of_day FROM <...>



-- ETL


--------------------------------------------------------------------------------
-- DROP TABLE etl.F554070_adjustment_schedule_extension
--------------------------------------------------------------------------------

SELECT 

--    Top 5 
    "QNASN" AS QNASN__adjustment_schedule,
	"QNAC10" AS QNAC10_category_code_10,
	"QN$PAF" AS QN$PAF_promotion_allowed_flag,
	"QN$AMS" AS QN$AMS_adjustment_schedule_status,
	"QNCRTU" AS QNCRTU_created_by_user,
	"QNEFTJ" AS QNEFTJ_effective_date,
	"QNEXDJ" AS QNEXDJ_expired_date,
	"QN$CBS" AS QN$CBS_chargeback_sync_flag,
	"QNURCD" AS QNURCD_user_reserved_code,
	"QNURDT" AS QNURDT_user_reserved_date_JDT,
	"QNURAT" AS QNURAT_user_reserved_amount,
	"QNURAB" AS QNURAB_user_reserved_number,
	"QNURRF" AS QNURRF_user_reserved_reference,
	"QNUSER" AS QNUSER_user_id,
	"QNPID" AS QNPID__program_id,
	"QNJOBN" AS QNJOBN_work_station_id,
	"QNUPMJ" AS QNUPMJ_date_updated,
	"QNTDAY" AS QNTDAY_time_of_day 

-- INTO etl.F554070_adjustment_schedule_extension

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		QNASN,
		QNAC10,
		QN$PAF,
		QN$AMS,
		QNCRTU,
		DATE(DIGITS(DEC(QNEFTJ+ 1900000,7,0))) AS QNEFTJ,
		DATE(DIGITS(DEC(QNEXDJ+ 1900000,7,0))) AS QNEXDJ,
		QN$CBS,
		QNURCD,
		QNURDT AS QNURDT,
		CAST((QNURAT)/100.0 AS DEC(15,2)) AS QNURAT,
		QNURAB,
		QNURRF,
		QNUSER,
		QNPID,
		QNJOBN,
		CASE WHEN QNUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(QNUPMJ+ 1900000,7,0))) ELSE NULL END AS QNUPMJ,
		QNTDAY

	FROM
		ARCPDTA71.F554070
    WHERE
		QNEFTJ <= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) AND 		
		QNEXDJ >= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3))  		
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------

-- SELECT QNASN__adjustment_schedule AS adjustment_schedule, QNAC10_category_code_10 AS category_code_10, QN$PAF_promotion_allowed_flag AS promotion_allowed_flag, QN$AMS_adjustment_schedule_status AS adjustment_schedule_status, QNCRTU_created_by_user AS created_by_user, QNEFTJ_effective_date AS effective_date, QNEXDJ_expired_date AS expired_date, QN$CBS_chargeback_sync_flag AS chargeback_sync_flag, QNURCD_user_reserved_code AS user_reserved_code, QNURDT_user_reserved_date AS user_reserved_date, QNURAT_user_reserved_amount AS user_reserved_amount, QNURAB_user_reserved_number AS user_reserved_number, QNURRF_user_reserved_reference AS user_reserved_reference, QNUSER_user_id AS user_id, QNPID__program_id AS program_id, QNJOBN_work_station_id AS work_station_id, QNUPMJ_date_updated AS date_updated, QNTDAY_time_of_day AS time_of_day FROM <...>




-- ETL Sales


--------------------------------------------------------------------------------
-- DROP TABLE etl.F0901_account_master
--------------------------------------------------------------------------------

SELECT 

    Top 5 
    "GMCO" AS GMCO___company,
	"GMAID" AS GMAID__account_id,
	"GMMCU" AS GMMCU__business_unit,
	"GMOBJ" AS GMOBJ__object_account,
	"GMSUB" AS GMSUB__subsidiary,
	"GMANS" AS GMANS__free_form_3rd_acct_no,
	"GMDL01" AS GMDL01_description,
	"GMLDA" AS GMLDA__account_level_of_detail,
	"GMBPC" AS GMBPC__budget_pattern_code,
	"GMPEC" AS GMPEC__posting_edit,
	"GMSTPC" AS GMSTPC_type_code,
	"GMFPEC" AS GMFPEC_fixed_asset_posting_edit_code,
	"GMBILL" AS GMBILL_billable_yn,
	"GMCRCD" AS GMCRCD_currency_code,
	"GMUM" AS GMUM___unit_of_measure,
	"GMR001" AS GMR001_bill_item_code,
	"GMR002" AS GMR002_category_code_002,
	"GMR003" AS GMR003_location,
	"GMR004" AS GMR004_floor,
	"GMR005" AS GMR005_category_code_005,
	"GMR006" AS GMR006_category_code_006,
	"GMR007" AS GMR007_category_code_007,
	"GMR008" AS GMR008_category_code_008,
	"GMR009" AS GMR009_category_code_009,
	"GMR010" AS GMR010_category_code_010,
	"GMR011" AS GMR011_category_code_011,
	"GMR012" AS GMR012_category_code_012,
	"GMR013" AS GMR013_category_code_013,
	"GMR014" AS GMR014_category_code_014,
	"GMR015" AS GMR015_category_code_015,
	"GMR016" AS GMR016_category_code_016,
	"GMR017" AS GMR017_category_code_017,
	"GMR018" AS GMR018_category_code_018,
	"GMR019" AS GMR019_category_code_019,
	"GMR020" AS GMR020_category_code_020,
	"GMR021" AS GMR021_category_code_021,
	"GMR022" AS GMR022_category_code_022,
	"GMR023" AS GMR023_category_code_023,
	"GMOBJA" AS GMOBJA_alternate_object_account,
	"GMSUBA" AS GMSUBA_alternate_subsidiary,
	"GMWCMP" AS GMWCMP_workers_comp,
	"GMCCT" AS GMCCT__method_of_computation,
	"GMERC" AS GMERC__equipment_rate_code,
	"GMHTC" AS GMHTC__header_type_code,
	"GMQLDA" AS GMQLDA_quantity_rollup_level,
	"GMCCC" AS GMCCC__cost_code_complete_yn,
	"GMFMOD" AS GMFMOD_model_accountconsolidations,
	"GMDTFR" AS GMDTFR_date_from,
	"GMDTTO" AS GMDTTO_date_thru,
	"GMCEDF" AS GMCEDF_current_effective_date_flag,
	"GMTOBJ" AS GMTOBJ_target_object_account,
	"GMTSUB" AS GMTSUB_target_subsidiary,
	"GMTXA1" AS GMTXA1_tax_ratearea,
	"GMEXR1" AS GMEXR1_tax_expl_code,
	"GMTXA2" AS GMTXA2_tax_area_2,
	"GMEXR2" AS GMEXR2_tax_expl_code_2,
	"GMTXGL" AS GMTXGL_gl_account_taxable_flag,
	"GMUSER" AS GMUSER_user_id,
	"GMPID" AS GMPID__program_id,
	"GMJOBN" AS GMJOBN_work_station_id,
	"GMUPMJ" AS GMUPMJ_date_updated,
	"GMUPMT" AS GMUPMT_time_last_updated 

-- INTO etl.F0901_account_master

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		GMCO,
		GMAID,
		GMMCU,
		GMOBJ,
		GMSUB,
		GMANS,
		GMDL01,
		GMLDA,
		GMBPC,
		GMPEC,
		'' '' AS GMSTPC,
		'' '' AS GMFPEC,
		GMBILL,
		GMCRCD,
		GMUM,
		GMR001,
		GMR002,
		GMR003,
		GMR004,
		GMR005,
		GMR006,
		GMR007,
		GMR008,
		GMR009,
		GMR010,
		GMR011,
		GMR012,
		GMR013,
		GMR014,
		GMR015,
		GMR016,
		GMR017,
		GMR018,
		GMR019,
		GMR020,
		GMR021,
		GMR022,
		GMR023,
		GMOBJA,
		GMSUBA,
		GMWCMP,
		GMCCT,
		GMERC,
		GMHTC,
		GMQLDA,
		GMCCC,
		GMFMOD,
		DATE(DIGITS(DEC(GMDTFR+ 1900000,7,0))) AS GMDTFR,
		DATE(DIGITS(DEC(GMDTTO+ 1900000,7,0))) AS GMDTTO,
		'' '' AS GMCEDF,
		'' '' AS GMTOBJ,
		'' '' AS GMTSUB,
		'' '' AS GMTXA1,
		'' '' AS GMEXR1,
		'' '' AS GMTXA2,
		'' '' AS GMEXR2,
		'' '' AS GMTXGL,
		GMUSER,
		GMPID,
		GMJOBN,
		CASE WHEN GMUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(GMUPMJ+ 1900000,7,0))) ELSE NULL END AS GMUPMJ,
		GMUPMT

		FROM
			ARCPDTA71.F0901
		WHERE
			GMDTFR <= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE)-300)),8,3)) AND 		
			GMDTTO >= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3))  		
		--    ORDER BY
		--        <insert custom code here>
		')

--------------------------------------------------------------------------------

-- SELECT GMCO___company AS company, GMAID__account_id AS account_id, GMMCU__business_unit AS business_unit, GMOBJ__object_account AS object_account, GMSUB__subsidiary AS subsidiary, GMANS__free_form_3rd_acct_no AS free_form_3rd_acct_no, GMDL01_description AS description, GMLDA__account_level_of_detail AS account_level_of_detail, GMBPC__budget_pattern_code AS budget_pattern_code, GMPEC__posting_edit AS posting_edit, GMSTPC_type_code AS type_code, GMFPEC_fixed_asset_posting_edit_code AS fixed_asset_posting_edit_code, GMBILL_billable_yn AS billable_yn, GMCRCD_currency_code AS currency_code, GMUM___unit_of_measure AS unit_of_measure, GMR001_bill_item_code AS bill_item_code, GMR002_category_code_002 AS category_code_002, GMR003_location AS location, GMR004_floor AS floor, GMR005_category_code_005 AS category_code_005, GMR006_category_code_006 AS category_code_006, GMR007_category_code_007 AS category_code_007, GMR008_category_code_008 AS category_code_008, GMR009_category_code_009 AS category_code_009, GMR010_category_code_010 AS category_code_010, GMR011_category_code_011 AS category_code_011, GMR012_category_code_012 AS category_code_012, GMR013_category_code_013 AS category_code_013, GMR014_category_code_014 AS category_code_014, GMR015_category_code_015 AS category_code_015, GMR016_category_code_016 AS category_code_016, GMR017_category_code_017 AS category_code_017, GMR018_category_code_018 AS category_code_018, GMR019_category_code_019 AS category_code_019, GMR020_category_code_020 AS category_code_020, GMR021_category_code_021 AS category_code_021, GMR022_category_code_022 AS category_code_022, GMR023_category_code_023 AS category_code_023, GMOBJA_alternate_object_account AS alternate_object_account, GMSUBA_alternate_subsidiary AS alternate_subsidiary, GMWCMP_workers_comp AS workers_comp, GMCCT__method_of_computation AS method_of_computation, GMERC__equipment_rate_code AS equipment_rate_code, GMHTC__header_type_code AS header_type_code, GMQLDA_quantity_rollup_level AS quantity_rollup_level, GMCCC__cost_code_complete_yn AS cost_code_complete_yn, GMFMOD_model_accountconsolidations AS model_accountconsolidations, GMDTFR_date_from AS date_from, GMDTTO_date_thru AS date_thru, GMCEDF_current_effective_date_flag AS current_effective_date_flag, GMTOBJ_target_object_account AS target_object_account, GMTSUB_target_subsidiary AS target_subsidiary, GMTXA1_tax_ratearea AS tax_ratearea, GMEXR1_tax_expl_code AS tax_expl_code, GMTXA2_tax_area_2 AS tax_area_2, GMEXR2_tax_expl_code_2 AS tax_expl_code_2, GMTXGL_gl_account_taxable_flag AS gl_account_taxable_flag, GMUSER_user_id AS user_id, GMPID__program_id AS program_id, GMJOBN_work_station_id AS work_station_id, GMUPMJ_date_updated AS date_updated, GMUPMT_time_last_updated AS time_last_updated FROM <...>




--------------------------------------------------------------------------------
-- DROP TABLE etl.F5511_order_detail_extension_file
--------------------------------------------------------------------------------

SELECT 

    Top 50
    "QBDOCO" AS QBDOCO_salesorder_number,
	"QBDCTO" AS QBDCTO_order_type,
	"QBKCOO" AS QBKCOO_order_company,
	"QBLNID" AS QBLNID_line_number,
	"QB$TRT" AS QB$TRT_tax_rate,
	"QBSTAM" AS QBSTAM_tax,
	"QB$EFA" AS QB$EFA_estimated_freight_amount,
	"QB$AHC" AS QB$AHC_apply_hazardous_charges,
	"QB$AC2" AS QB$AC2_arrival_fee_code,
	"QB$ODN" AS QB$ODN_other_document_number,
	"QB$ODT" AS QB$ODT_other_document_type,
	"QBCACT" AS QBCACT_creditbank_account_number,
	"QB$CCT" AS QB$CCT_credit_card_type,
	"QBCEXP" AS QBCEXP_expired_date_creditbank_acct_JDT,
	"QB$CBA" AS QB$CBA_chargeback_amount,
	"QB$NTC" AS QB$NTC_net_cost_chargebacks,
	"QB$LDC" AS QB$LDC_landed_cost,
	"QB$FCS" AS QB$FCS_file_cost,
	"QB$AGC" AS QB$AGC_average_cost,
	"QBENTB" AS QBENTB_entered_by,
	"QB$SPS" AS QB$SPS_sequence_number_ship,
	"QB$PRM" AS QB$PRM_promotion_code,
	"QB$UNC" AS QB$UNC_sales_order_cost_markup,
	"QBXRT" AS QBXRT__cross_reference_type_code,
	"QBCITM" AS QBCITM_customersupplier_item_number,
	"QB$AID" AS QB$AID_authorized_id,
	"QBOVPR" AS QBOVPR_override_price,
	"QB$ADC" AS QB$ADC_additional_warehouse,
	"QB$OCR" AS QB$OCR_original_computer_resale,
	"QB$PMC" AS QB$PMC_promotion_code_price_method,
	"QB$LDP" AS QB$LDP_line_discount_pct,
	"QB$PPM" AS QB$PPM_price_promotion_code,
	"QB$VPM" AS QB$VPM_volume_promotion_code,
	"QB$AAL" AS QB$AAL_automatically_added_line,
	"QB$US1" AS QB$US1_map_to_legacy_status,
	"QB$US2" AS QB$US2_user_defined_status_2,
	"QB$US3" AS QB$US3_user_defined_status_3,
	"QB$US4" AS QB$US4_user_defined_status_4,
	"QB$US5" AS QB$US5_user_defined_status_5,
	"QB$MSG" AS QB$MSG_message_code,
	"QBPRP6" AS QBPRP6_item_dimension_group,
	"QBPRP7" AS QBPRP7_warehouse_process_grp_1,
	"QBPRP8" AS QBPRP8_warehouse_process_grp_2,
	"QBPRP9" AS QBPRP9_warehouse_process_grp_3,
	"QBPRP0" AS QBPRP0_item_pool_code,
	"QBSRP6" AS QBSRP6_category_code_6,
	"QBSRP7" AS QBSRP7_category_code_7,
	"QBSRP8" AS QBSRP8_category_code_8,
	"QBSRP9" AS QBSRP9_category_code_9,
	"QBSRP0" AS QBSRP0_category_code_10,
	"QBUSER" AS QBUSER_user_id,
	"QBPID" AS QBPID__program_id,
	"QBJOBN" AS QBJOBN_work_station_id,
	"QBUPMJ" AS QBUPMJ_date_updated,
	"QBTDAY" AS QBTDAY_time_of_day 

-- INTO etl.F5511_order_detail_extension_file

FROM 
    OPENQUERY (ESYS_QA, '

	SELECT
		QBDOCO,
		QBDCTO,
		QBKCOO,
		CAST((QBLNID)/1000.0 AS DEC(15,3)) AS QBLNID,
		QB$TRT,
		CAST((QBSTAM)/100.0 AS DEC(15,2)) AS QBSTAM,
		CAST((QB$EFA)/100.0 AS DEC(15,2)) AS QB$EFA,
		QB$AHC,
		QB$AC2,
		QB$ODN,
		QB$ODT,
		QBCACT,
		QB$CCT,
		QBCEXP AS QBCEXP,
		CAST((QB$CBA)/100.0 AS DEC(15,2)) AS QB$CBA,
		CAST((QB$NTC)/100.0 AS DEC(15,2)) AS QB$NTC,
		CAST((QB$LDC)/100.0 AS DEC(15,2)) AS QB$LDC,
		CAST((QB$FCS)/100.0 AS DEC(15,2)) AS QB$FCS,
		CAST((QB$AGC)/100.0 AS DEC(15,2)) AS QB$AGC,
		QBENTB,
		QB$SPS,
		QB$PRM,
		CAST((QB$UNC)/10000.0 AS DEC(15,4)) AS QB$UNC,
		QBXRT,
		QBCITM,
		QB$AID,
		CAST((QBOVPR)/100.0 AS DEC(15,2)) AS QBOVPR,
		QB$ADC,
		CAST((QB$OCR)/10000.0 AS DEC(15,4)) AS QB$OCR,
		QB$PMC,
		CAST((QB$LDP)/1000.0 AS DEC(15,3)) AS QB$LDP,
		QB$PPM,
		QB$VPM,
		QB$AAL,
		QB$US1,
		QB$US2,
		QB$US3,
		QB$US4,
		QB$US5,
		QB$MSG,
		QBPRP6,
		QBPRP7,
		QBPRP8,
		QBPRP9,
		QBPRP0,
		QBSRP6,
		QBSRP7,
		QBSRP8,
		QBSRP9,
		QBSRP0,
		QBUSER,
		QBPID,
		QBJOBN,
		CASE WHEN QBUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(QBUPMJ+ 1900000,7,0))) ELSE NULL END AS QBUPMJ,
		QBTDAY

			FROM
				ARCPDTA93.F5511
		    WHERE
				QBUPMJ = CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) 
		    ORDER BY
		        QBDOCO DESC
		')

--------------------------------------------------------------------------------

-- SELECT QBDOCO_salesorder_number AS salesorder_number, QBDCTO_order_type AS order_type, QBKCOO_order_company AS order_company, QBLNID_line_number AS line_number, QB$TRT_tax_rate AS tax_rate, QBSTAM_tax AS tax, QB$EFA_estimated_freight_amount AS estimated_freight_amount, QB$AHC_apply_hazardous_charges AS apply_hazardous_charges, QB$AC2_arrival_fee_code AS arrival_fee_code, QB$ODN_other_document_number AS other_document_number, QB$ODT_other_document_type AS other_document_type, QBCACT_creditbank_account_number AS creditbank_account_number, QB$CCT_credit_card_type AS credit_card_type, QBCEXP_expired_date_creditbank_acct AS expired_date_creditbank_acct, QB$CBA_chargeback_amount AS chargeback_amount, QB$NTC_net_cost_chargebacks AS net_cost_chargebacks, QB$LDC_landed_cost AS landed_cost, QB$FCS_file_cost AS file_cost, QB$AGC_average_cost AS average_cost, QBENTB_entered_by AS entered_by, QB$SPS_sequence_number_ship AS sequence_number_ship, QB$PRM_promotion_code AS promotion_code, QB$UNC_sales_order_cost_markup AS sales_order_cost_markup, QBXRT__cross_reference_type_code AS cross_reference_type_code, QBCITM_customersupplier_item_number AS customersupplier_item_number, QB$AID_authorized_id AS authorized_id, QBOVPR_override_price AS override_price, QB$ADC_additional_warehouse AS additional_warehouse, QB$OCR_original_computer_resale AS original_computer_resale, QB$PMC_promotion_code_price_method AS promotion_code_price_method, QB$LDP_line_discount_pct AS line_discount_pct, QB$PPM_price_promotion_code AS price_promotion_code, QB$VPM_volume_promotion_code AS volume_promotion_code, QB$AAL_automatically_added_line AS automatically_added_line, QB$US1_map_to_legacy_status AS map_to_legacy_status, QB$US2_user_defined_status_2 AS user_defined_status_2, QB$US3_user_defined_status_3 AS user_defined_status_3, QB$US4_user_defined_status_4 AS user_defined_status_4, QB$US5_user_defined_status_5 AS user_defined_status_5, QB$MSG_message_code AS message_code, QBPRP6_item_dimension_group AS item_dimension_group, QBPRP7_warehouse_process_grp_1 AS warehouse_process_grp_1, QBPRP8_warehouse_process_grp_2 AS warehouse_process_grp_2, QBPRP9_warehouse_process_grp_3 AS warehouse_process_grp_3, QBPRP0_item_pool_code AS item_pool_code, QBSRP6_category_code_6 AS category_code_6, QBSRP7_category_code_7 AS category_code_7, QBSRP8_category_code_8 AS category_code_8, QBSRP9_category_code_9 AS category_code_9, QBSRP0_category_code_10 AS category_code_10, QBUSER_user_id AS user_id, QBPID__program_id AS program_id, QBJOBN_work_station_id AS work_station_id, QBUPMJ_date_updated AS date_updated, QBTDAY_time_of_day AS time_of_day FROM <...>


SELECT 
	*
FROM 
    OPENQUERY (ESYS_QA, '

	SELECT
		count (*) 

			FROM
				ARCPDTA93.F4211 
			WHERE
				(NOT EXISTS (SELECT * FROM ARCPDTA93.F5511 WHERE QBDOCO=SDDOCO AND QBDCTO=SDDCTO AND QBLNID=SDLNID ))

		')

--		ARCPDTA93.F5511 = 5227353

--		ARCPDTA93.F4211 = 5230183


