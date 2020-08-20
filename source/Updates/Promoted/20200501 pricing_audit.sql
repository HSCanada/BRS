-- setup proce audit table, tmc, 17 Aug 20
--

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_SalesDay ADD
	SalesDay date NULL
GO
ALTER TABLE dbo.BRS_SalesDay SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

UPDATE dbo.BRS_SalesDay
set SalesDay = SalesDate

ALTER TABLE dbo.BRS_SalesDay
ALTER COLUMN SalesDay date NOT NULL;

BEGIN TRANSACTION
GO
CREATE UNIQUE NONCLUSTERED INDEX BRS_SalesDay_u_idx02 ON dbo.BRS_SalesDay
	(
	SalesDay
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE dbo.BRS_SalesDay SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- drop TABLE [Integration].[F5527_price_adjustment_history_Staging]
CREATE TABLE [Integration].[F5527_price_adjustment_history_Staging](
	[QPCO___company] [char](5) NOT NULL,
	[QPAC08_market_segment] [char](3) NOT NULL,
	[QPITM__item_number_short] [numeric](8, 0) NOT NULL,
	[QPUOM4_pricing_uom] [char](2) NOT NULL,
	[QPOVPR_override_price] [numeric](15, 2) NOT NULL,
	[QP$RSC_reason_code] [char](2) NOT NULL,
	[QP$CTR_competitor] [char](10) NOT NULL,

	[QP$AID_authorized_id] [char](10) NOT NULL,
	[QPUSER_user_id] [char](10) NOT NULL,
	[QPPID__program_id] [char](10) NOT NULL,
	[QPUPMJ_date_updated] [date] NULL,
	[QPTDAY_time_of_day] [numeric](6, 0) NOT NULL,
	[QPJOBN_work_station_id] [char](10) NOT NULL,

	[QP$TO__total_number_of_orders] [numeric](15, 0) NOT NULL,

	[ID] [int] IDENTITY(1,1) NOT NULL
) ON [USERDATA]
GO

-- drop TABLE [pricing].[price_adjustment_history_F5527]
CREATE TABLE [pricing].[price_adjustment_history_F5527](
	[QPUPMJ_date_updated] [date] NOT NULL,
	[Item] [char](10) NOT NULL,
	[QPOVPR_override_price] [money] NOT NULL,
	[QP$RSC_reason_code] [char](2) NOT NULL,
	[QP$CTR_competitor] [char](10) NOT NULL,
	[QP$AID_authorized_id] [char](10) NOT NULL,
	[QPUSER_user_id] [char](10) NOT NULL,
	[QPTDAY_time_of_day] [numeric](6, 0) NOT NULL,
	[QPAC08_market_segment] [char](3) NOT NULL,
	[QPUOM4_pricing_uom] [char](2) NOT NULL,
	[QP$TO__total_number_of_orders] [int] NOT NULL,

	[ID] [int] IDENTITY(1,1) NOT NULL,

	[QPCO___company] [char](5) NOT NULL,
	[QPITM__item_number_short] [numeric](8, 0) NOT NULL,
	[QPPID__program_id] [char](10) NOT NULL,
	[QPJOBN_work_station_id] [char](10) NOT NULL

) ON [USERDATA]
GO

BEGIN TRANSACTION
GO
ALTER TABLE Pricing.price_adjustment_history_F5527 ADD CONSTRAINT
	FK_price_adjustment_history_F5527_entered_by FOREIGN KEY
	(
	QPUSER_user_id
	) REFERENCES Pricing.entered_by
	(
	entered_by_code
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE Pricing.price_adjustment_history_F5527 ADD CONSTRAINT
	FK_price_adjustment_history_F5527_entered_by1 FOREIGN KEY
	(
	QP$AID_authorized_id
	) REFERENCES Pricing.entered_by
	(
	entered_by_code
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE Pricing.price_adjustment_history_F5527 ADD CONSTRAINT
	FK_price_adjustment_history_F5527_BRS_SalesDay FOREIGN KEY
	(
	QPUPMJ_date_updated
	) REFERENCES dbo.BRS_SalesDay
	(
	SalesDay
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE Pricing.price_adjustment_history_F5527 ADD CONSTRAINT
	FK_price_adjustment_history_F5527_BRS_Item FOREIGN KEY
	(
	Item
	) REFERENCES dbo.BRS_Item
	(
	Item
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE Pricing.price_adjustment_history_F5527 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
CREATE UNIQUE NONCLUSTERED INDEX price_adjustment_history_F5527_u_idx_01 ON Pricing.price_adjustment_history_F5527
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
CREATE CLUSTERED INDEX price_adjustment_history_F5527_c_idx_02 ON Pricing.price_adjustment_history_F5527
	(
	QPUPMJ_date_updated,
	QPTDAY_time_of_day,
	Item
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE Pricing.price_adjustment_history_F5527 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--------------------------------------------------------------------------------
-- DROP TABLE Integration.F5527_price_adjustment_history_Staging
--------------------------------------------------------------------------------
SELECT 
	Top 500 
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
--		(QPUPMJ >= CONCAT(CONCAT(1,SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3))-20) AND 
		(QPUPMJ between 120000 AND 120365) AND
		(1=1)
--    ORDER BY
--        QPITM, QPUPMJ
')


