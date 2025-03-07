
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW nes.order_install_date_estimate
AS

/******************************************************************************
**	File: 
**	Name: nes.order_open_equipment_pipeline
**	Desc: open order and sales for ESS, CCS
**		
**
**              
**	Return values:  
**
**	Called by:   Access as a sub-query
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**
**	Auth: tmc
**	Date: 28 Feb 25
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
*******************************************************************************/



SELECT 
	header.ets_num				AS equipment_order
	,'EST'						AS source_cd
	,MIN(header.SalesDate)		AS data_capture_date
	,MIN(header.work_order_num)	AS work_order_num
	,0							AS salesorder_num
	,MIN(header.shipto)			AS shipto
	,MIN(header.ess_code)		AS ess_code
	,CAST( MIN(header.install_date) AS date) AS install_date
	,MIN(day_.[FiscalMonth])	AS install_fiscalmo
	,SUM(detail.net_sales_amount) AS install_sales_amt
FROM
	nes.order_ets AS main 
	
	INNER JOIN nes.open_order_opordrpt AS header 
	ON main.eq_forecast_est_astea_key = header.fact_id 
	
	INNER JOIN nes.open_order_opordrpt AS detail 
	ON header.SalesDate = detail.SalesDate AND 
	header.ets_num = detail.ets_num AND 
	header.line_number = detail.line_number

	LEFT JOIN [dbo].[BRS_SalesDay] day_
	on header.install_date = day_.SalesDate



GROUP BY header.ets_num



GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/*
	t.FactKey, 
	t.FiscalMonth, 
	t.FSC_SalespersonKey, 
	t.ESS_SalespersonKey, 
	t.ShipTo, 
	t.ItemKey, 
	t.DateKey, 
	t.SourceKey, 
	'' AS OrderSource,
	i.comm_group_cd,
	f.Branch,
	sm.master_salesperson_cd,
	sm.comm_plan_id,

	t.Quantity, 
	t.SalesAmt,
	t.[GPAmt]
*/

-- SELECT top 10 * FROM nes.order_open_equipment_pipeline
-- SELECT * FROM nes.order_open_equipment_pipeline where Branch = 'TORNT'
-- SELECT count(*) FROM nes.order_open_equipment_pipeline where Branch = 'TORNT'
-- ORG 9256
-- NEW 15456

-- select  top 10 * from nes.order_install_date_estimate  -- where ess_code = '' equipment_order= 'X63139'

-- select  * from nes.order_install_date_estimate  where install_fiscalmo >= 202401
