--------------------------------------------------------------------------------
-- STAGE TRUNCATE TABLE etl.F40314_preference_price_adjustment_schedule
--------------------------------------------------------------------------------

SELECT 

--    Top 5 
    "PJAN8" AS PJAN8__billto,
	"PJCS14" AS PJCS14_customer_group_price_adjustment_sched,
	"PJITM" AS PJITM__item_number_short,
	"PJIT14" AS PJIT14_item_group_price_adjustment_schedule,

--	"PJEFTJ" AS PJEFTJ_effective_date,
	DATEADD(day, CAST(RIGHT("PJEFTJ",3) AS int)-1, CONVERT(datetime,LEFT("PJEFTJ",2) + '0101', 112)) AS PJEFTJ_effective_date,

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
    OPENQUERY (ESYS_PROD, '

	SELECT
		PJAN8,
		PJCS14,
		PJITM,
		PJIT14,

		PJEFTJ,
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
		ARCPDTA71.F40314
    WHERE
 		PJEFTJ <= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) AND 		
		PJEXDJ >= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) AND	
		(1=1)
--    ORDER BY
--        PJEFTJ
')


/*
	1. run org, not crash 
	2. rest QA package 
	3. run prod on server

	hardcode filter
	rerun
	find offending field
	fix & test
	Plan B - carve our offending section 

*/

--------------------------------------------------------------------------------
-- STAGE TRUNCATE TABLE etl.F40314_preference_price_adjustment_schedule
--------------------------------------------------------------------------------



SELECT DATEADD(day, CAST(RIGHT('95076',3) AS int)-1, CONVERT(datetime,LEFT('95076',2) + '0101', 112))

SELECT DATEADD(day, CAST(RIGHT('95076',3) AS int)-1, CONVERT(datetime,LEFT('95076',2) + '0101', 112))