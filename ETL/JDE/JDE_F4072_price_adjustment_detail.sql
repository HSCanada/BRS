
/*
SELECT * from OPENQUERY (ESYS_QA, '	
	SELECT
*	FROM
		QSYS2.SYStables
	WHERE
		TABLE_NAME in( ''F4072'')
 ')
 */

-- drop  table STAGE_JDE_F4072_price_adjustment_detail

SELECT 
--    Top 500
	"ADAST"	AS adjustment_name
	, "ADITM" AS item_number_short
	, "ADLITM" AS item_number
	, "ADAN8" AS billto
	, "ADSDGR" AS order_detail_group
	, "ADSDV1" AS sales_detail_value_01
	, "ADSDV2" AS sales_detail_value_02
	, "ADSDV3" AS sales_detail_value_03
	, "ADCRCD" AS currency_code
	, "ADUOM" AS um
	, "ADMNQ" AS quantity_from
	, "ADEFTJ" AS effective_date
	, "ADEXDJ" AS expired_date
	, "ADBSCD" AS basis
	, "ADLEDG" AS cost_method
	, "ADFRMN" AS formula_name
	, "ADFVTR" AS factor_value
	, "ADFGY" AS free_goods_yn
	, "ADATID" AS price_adjustment_key_id
	, "ADURCD" AS user_reserved_code
	, "ADURDT" AS user_reserved_date
	, "ADURAT" AS user_reserved_amount
	, "ADURAB" AS user_reserved_number
	, "ADURRF" AS user_reserved_reference
	, "ADUSER" AS user_id
	, "ADPID" AS program_id
	, "ADJOBN" AS work_station_id
	, "ADUPMJ" AS date_updated
	, "ADTDAY" AS time_of_day 

INTO STAGE_JDE_F4072_price_adjustment_detail
    
FROM 
    OPENQUERY (ESYS_PROD, '

SELECT
	ADAST
	, ADITM
	, ADLITM
	, ADAN8
	, ADSDGR
	, ADSDV1
	, ADSDV2
	, ADSDV3
	, ADCRCD
	, ADUOM
	, ADMNQ
	, DATE(DIGITS(DEC( NULLIF(ADEFTJ, 0001-01-01) + 1900000,7,0))) AS ADEFTJ
	, DATE(DIGITS(DEC( NULLIF(ADEXDJ, 0001-01-01) + 1900000,7,0))) AS ADEXDJ
	, ADBSCD
	, ADLEDG
	, ADFRMN, CAST((ADFVTR)/10000.0 AS DEC(15,4)) AS ADFVTR
	, ADFGY
	, ADATID
	, ADURCD
	, DATE(DIGITS(DEC( NULLIF(ADURDT, 0001-01-01) + 1900000,7,0))) AS ADURDT
	, CAST((ADURAT)/100.0 AS DEC(15,2)) AS ADURAT
	, ADURAB
	, ADURRF
	, ADUSER
	, ADPID
	, ADJOBN
	, DATE(DIGITS(DEC( NULLIF(ADUPMJ, 0001-01-01) + 1900000,7,0))) AS ADUPMJ
	, ADTDAY
        
FROM
	ARCPDTA71.F4072
WHERE
--	ADAST = ''PRLINFG'' AND 
	ADAST <> ''CORPRICE'' AND 	
--	ADLITM <> '' '' AND	
	ADEFTJ <= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT_DATE)),3,2)), SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT_DATE))),8,3)) AND 		
	ADEXDJ >= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT_DATE)),3,2)), SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT_DATE))),8,3))
/*
ORDER BY
	ADLITM
	, ADMNQ
	, CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT_DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT_DATE))),8,3)) DESC
*/
')


/*

SELECT 
*
    
FROM 
    OPENQUERY (ESYS_PROD, '

SELECT
	ADAST, count (*) 
        
FROM
	ARCPDTA71.F4072
WHERE
	ADEFTJ <= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT_DATE)),3,2)), SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT_DATE))),8,3)) AND 		
	ADEXDJ >= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT_DATE)),3,2)), SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT_DATE))),8,3))
GROUP BY
	ADAST
ORDER BY 2 DESC
')

*/

