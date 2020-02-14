
SELECT 

--    Top 50

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
	"ADCRCD" AS msrp_currency,
	"ADUOM" AS ADUOM__um,
	"ADMNQ" AS ADMNQ__quantity_from,
	"ADEFTJ" AS ADEFTJ_effective_date,
	"ADEXDJ" AS ADEXDJ_expired_date,
	"ADBSCD" AS ADBSCD_basis,
	"ADLEDG" AS ADLEDG_cost_method,
	"ADFRMN" AS ADFRMN_formula_name,
	"ADFCNM" AS ADFCNM_function_name,
	"ADFVTR" AS msrp_price,
	"ADFGY" AS ADFGY__free_goods_yn,
	"ADATID" AS ADATID_price_adjustment_key_id,
	"ADURCD" AS ADURCD_user_reserved_code,
	"ADURDT" AS ADURDT_user_reserved_date_JDT,
	"ADURAT" AS ADURAT_user_reserved_amount,
	"ADURAB" AS ADURAB_user_reserved_number,
	"ADURRF" AS Item,
	"ADASTN" AS ADASTN_adjustment_for_net_price,
	"ADUSER" AS ADUSER_user_id,
	"ADPID" AS ADPID__program_id,
	"ADJOBN" AS ADJOBN_work_station_id,
	"ADUPMJ" AS DateUpdated,
	"ADTDAY" AS ADTDAY_time_of_day,
	"ADUPAJ" AS ADUPAJ_date_added_JDT,
	"ADTENT" AS ADTENT_time_entered,
"dt"

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
		DATE(DIGITS(DEC(ADEFTJ+ 1900000,7,0))) AS ADEFTJ,
		DATE(DIGITS(DEC(ADEXDJ+ 1900000,7,0))) AS ADEXDJ,
		ADBSCD,
		ADLEDG,
		ADFRMN,
		'' '' AS ADFCNM,
		CAST((ADFVTR)/10000.0 AS DEC(15,4)) AS ADFVTR,
		ADFGY,
		ADATID,
		ADURCD,
		ADURDT AS ADURDT,
		CAST((ADURAT)/10000.0 AS DEC(15,2)) AS ADURAT,
		ADURAB,
		ADURRF,
		'' '' AS ADASTN,
		ADUSER,
		ADPID,
		ADJOBN,
		ADUPMJ AS ADUPMJ,
		ADTDAY,
		0 AS ADUPAJ,
		0 AS ADTENT,
CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3))  		as dt

			FROM
				ARCPDTA71.F4072
		    WHERE
				ADEFTJ between 11800 AND 118365 AND 		
				ADEXDJ >=  11800 AND
				ADAST = ''MSRPPRC''
		--    ORDER BY
		--        <insert custom code here>
		')


