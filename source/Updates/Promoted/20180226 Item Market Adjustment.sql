-- add Market adjustment, tmc, 26 Jan 18

--------------------------------------------------------------------------------
---- DROP TABLE Integration.F5698_item_market_adjustment_Staging
--------------------------------------------------------------------------------

SELECT 

--    Top 5 
    "QT$RTP" AS QT$RTP_record_type,
	"QTITM" AS QTITM__item_number_short,
	"QTLITM" AS QTLITM_item_number,
	"QT$AJP" AS QT$AJP_adjustment_percent,
	"QT$AJD" AS QT$AJD_adjustment_dollar,
	"QT$USG" AS QT$USG_adjustment_usage,
	"QTEFFF" AS QTEFFF_effective_from_date,
	"QTEXDE" AS QTEXDE_expiration_date,
	"QT$FLD" AS QT$FLD_data_field_name,
	"QTAC10" AS QTAC10_division_code,
	"QT$SEQ" AS QT$SEQ_sequence_id,
	"QTSIC" AS QTSIC__speciality,
	"QTAC01" AS QTAC01_customer_profession,
	"QTAC02" AS QTAC02_customer_sub_profession,
	"QTAC03" AS QTAC03_type_of_paying_customer,
	"QTAC04" AS QTAC04_practice_type,
	"QTAC05" AS QTAC05_ap_check_routing_code,
	"QTAC06" AS QTAC06_category_code_address_06,
	"QT$FT1" AS QT$FT1_future_use_1,
	"QT$FT2" AS QT$FT2_future_use_2,
	"QT$FT3" AS QT$FT3_future_use_3,
	"QT$FT4" AS QT$FT4_future_use_4,
	"QT$FT5" AS QT$FT5_future_use_5,
	"QT$FT6" AS QT$FT6_future_use_6,
	"QT$FT7" AS QT$FT7_future_use_7,
	"QT$FT8" AS QT$FT8_future_use_8,
	"QT$FT9" AS QT$FT9_future_use_9,
	"QT$FT0" AS QT$FT0_future_use_0,
	"QTCRTU" AS QTCRTU_created_by_user,
	"QTPGM" AS QTPGM__program_name,
	"QTCRDJ" AS QTCRDJ_creation_date,
	"QTCRTM" AS QTCRTM_creation_time,
	"QTUSER" AS QTUSER_user_id,
	"QTPID" AS QTPID__program_id,
	"QTJOBN" AS QTJOBN_work_station_id,
	"QTUPMJ" AS QTUPMJ_date_updated,
	"QTTDAY" AS QTTDAY_time_of_day 

INTO Integration.F5698_item_market_adjustment_Staging

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		QT$RTP,
		QTITM,
		QTLITM,
		CAST((QT$AJP)/10000.0 AS DEC(15,4)) AS QT$AJP,
		QT$AJD,
		QT$USG,
		CASE WHEN QTEFFF IS NOT NULL THEN DATE(DIGITS(DEC(QTEFFF+ 1900000,7,0))) ELSE NULL END AS QTEFFF,
		CASE WHEN QTEXDE IS NOT NULL THEN DATE(DIGITS(DEC(QTEXDE+ 1900000,7,0))) ELSE NULL END AS QTEXDE,
		QT$FLD,
		QTAC10,
		QT$SEQ,
		QTSIC,
		QTAC01,
		QTAC02,
		QTAC03,
		QTAC04,
		QTAC05,
		QTAC06,
		QT$FT1,
		QT$FT2,
		QT$FT3,
		QT$FT4,
		QT$FT5,
		QT$FT6,
		QT$FT7,
		QT$FT8,
		QT$FT9,
		QT$FT0,
		QTCRTU,
		QTPGM,
		CASE WHEN QTCRDJ IS NOT NULL THEN DATE(DIGITS(DEC(QTCRDJ+ 1900000,7,0))) ELSE NULL END AS QTCRDJ,
		QTCRTM,
		QTUSER,
		QTPID,
		QTJOBN,
		CASE WHEN QTUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(QTUPMJ+ 1900000,7,0))) ELSE NULL END AS QTUPMJ,
		QTTDAY

	FROM
		ARCPDTA71.F5698
    WHERE
		QTEFFF <= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) AND 		
		QTEXDE >= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3))  		
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------

-- add pk

Alter Table Integration.F5698_item_market_adjustment_Staging
Add ID Int Identity(1, 1)
Go

CREATE UNIQUE NONCLUSTERED INDEX F5698_item_market_adjustment_Staging_u_idx ON Integration.F5698_item_market_adjustment_Staging
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
GO



/*
-- dup test1

SELECT        QTITM__item_number_short, COUNT(*) AS count
FROM            Integration.F5698_item_market_adjustment_Staging
where QTAC10_division_code = 'ALL'
GROUP BY QTITM__item_number_short
having count(*) > 1
order by 2 desc

select * from Integration.F5698_item_market_adjustment_Staging where QTITM__item_number_short = 1319506 AND QTAC10_division_code = 'ALL'

SELECT        QTITM__item_number_short, COUNT(*) AS Expr1
FROM            Integration.F5698_item_market_adjustment_Staging
GROUP BY 
	QTITM__item_number_short,
	QTAC10_division_code,
	[QTEFFF_effective_from_date]
having count(*) > 1
order by 2 desc

select * from Integration.F5698_item_market_adjustment_Staging where QTITM__item_number_short = 1406841
*/
