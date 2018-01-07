-- update ETL & Table for F0005 stage 
--------------------------------------------------------------------------------
-- DROP TABLE etl.F0005_user_defined_codes
--------------------------------------------------------------------------------

SELECT 

   -- Top 5 
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
--		DRUPMJ  AS DRUPMJ,
		CASE WHEN DRUPMJ >0 THEN DATE(DIGITS(DEC(DRUPMJ+ 1900000,7,0))) ELSE NULL END AS DRUPMJ,
		DRJOBN,
		DRUPMT

	FROM
		ARCPCOM71.F0005
    WHERE
		DRSY like ''%01%'' 
--		DRRT like ''%W2%'' AND
--		DRKY like ''%JR%'' 
--    ORDER BY
--        DRUPMJ
')



ALTER TABLE Integration.F0005_user_defined_codes_Staging
	DROP CONSTRAINT PK_F0005_user_defined_codes
GO

ALTER TABLE Integration.F0005_user_defined_codes_Staging
	ADD ID integer identity(1,1) 
GO



SELECT        DRSY___product_code, DRRT___user_defined_codes, DRKY___user_defined_code, COUNT(*) AS Expr1
FROM            Integration.F0005_user_defined_codes_Staging
GROUP BY DRSY___product_code, DRRT___user_defined_codes, DRKY___user_defined_code
HAVING        (COUNT(*) > 1)
