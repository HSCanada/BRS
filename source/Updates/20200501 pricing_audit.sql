
--

--------------------------------------------------------------------------------
-- DROP TABLE Integration.F5527_price_adjustment_history_Staging
--------------------------------------------------------------------------------

SELECT 
--    Top 500 
    "QPCO" AS QPCO___company,
	"QPAC08" AS QPAC08_market_segment,
	"QPITM" AS QPITM__item_number_short,
	"QPUOM4" AS QPUOM4_pricing_uom,
	"QPOVPR" AS QPOVPR_override_price,
	"QP$RSC" AS QP$RSC_reason_code,
	"QP$CTR" AS QP$CTR_competitor,
	"QP$TO" AS QP$TO__total_number_of_orders,
	"QP$AID" AS QP$AID_authorized_id,
	"QPUSER" AS QPUSER_user_id,
	"QPPID" AS QPPID__program_id,
	"QPUPMJ" AS QPUPMJ_date_updated,
	"QPTDAY" AS QPTDAY_time_of_day,
	"QPJOBN" AS QPJOBN_work_station_id 

-- INTO Integration.F5527_price_adjustment_history_Staging

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		QPCO,
		QPAC08,
		QPITM,
		QPUOM4,
		CAST((QPOVPR)/100.0 AS DEC(15,2)) AS QPOVPR,
		QP$RSC,
		QP$CTR,
		QP$TO,
		QP$AID,
		QPUSER,
		QPPID,
		CASE WHEN QPUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(QPUPMJ+ 1900000,7,0))) ELSE NULL END AS QPUPMJ,
		QPTDAY,
		QPJOBN

	FROM
		ARCPDTA71.F5527
    WHERE
		QPUPMJ between 120000 AND 120365
    ORDER BY
        QPITM, QPUPMJ
')

--------------------------------------------------------------------------------
/*
ALTER TABLE Integration.F5527_price_adjustment_history_Staging
ADD id int identity(1,1)
*/

---

