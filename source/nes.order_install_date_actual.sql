
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW nes.order_install_date_actual
AS

/******************************************************************************
**	File: 
**	Name: nes.order_install_date_actual
**	Desc: EQ orders billed in commission table
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
	header.[WSORD__equipment_order]		AS equipment_order
	,'ACT'								AS source_cd
	,MIN(header.WSTRDJ_order_date)		AS data_capture_date
	,MIN(header.WSVR02_reference_2)		AS work_order_num
	,header.[WSDOCO_salesorder_number]	AS salesorder_num
	,MIN(header.WSSHAN_shipto)			AS shipto
	,MIN(header.ess_code)				AS ess_code
	,CAST(MIN(header.[WSDGL__gl_date]) as date)	AS install_date
	,MIN(header.[FiscalMonth])			AS install_fiscalmo
	,SUM(detail.transaction_amt)		AS install_sales_amt
FROM
	nes.order_ets AS main 
	
	INNER JOIN [comm].[transaction_F555115] AS header 
	ON main.[eq_forecast_act_comm_key] = header.id and
	-- EQ only
	header.ess_code <> '' AND
	-- speed up?
--	header.FiscalMonth >= 202401 AND
	(1=1)

	
	INNER JOIN [comm].[transaction_F555115] AS detail 
	ON header.[FiscalMonth] = detail.[FiscalMonth] AND 
	header.[WSDOCO_salesorder_number] = detail.[WSDOCO_salesorder_number] AND 
	header.[WSDCTO_order_type] = detail.[WSDCTO_order_type] AND 
	-- speed up?
--	detail.FiscalMonth >= 202401 AND
	(1=1)
--	header.[WSLNID_line_number] = detail.[WSLNID_line_number]
WHERE
--	[FiscalMonth] >=202401
	(1=1)


GROUP BY 
header.[WSORD__equipment_order]
,header.[WSDOCO_salesorder_number]



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


-- select    * from nes.order_install_date_actual where act_install_fiscalmo >= 202401 and ess_code <> '' equipment_order= 'X63139'
-- select    * from nes.order_install_date_actual where equipment_order= 'X34310'

-- select    top 10 * from nes.order_install_date_actual where install_fiscalmo = 202406 

-- select    * from nes.order_install_date_actual where install_fiscalmo >= 202401



