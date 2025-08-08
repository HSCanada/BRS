
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW nes.order_install_date_tag
AS

/******************************************************************************
**	File: 
**	Name: nes.order_tag_date_actual
**	Desc: EQ tag order from D1 (based on nes.order_install_date_actual view)
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
	s.id_key

	,wo.[ets_num]						AS equipment_order
	,'TAG'								AS source_cd
	,s.tag_date							AS data_capture_date

	,s.work_order_num					AS work_order_num

	,ISNULL(comm.WSDOCO_salesorder_number, 0)	AS salesorder_num
	,ISNULL(comm.WSSHAN_shipto,0)		AS shipto
	,ISNULL(comm.ess_code, '.')			AS ess_code
	,s.tag_date 						AS tag_date
	,ISNULL(comm.FiscalMonth,0)			AS install_fiscalmo
	,s.total_extended_value				AS tag_sales_amt

	,s.d1_branch
	,s.item	
	,s.tag_number
	,s.item_description
	,s.d1_user
	,comm.ID
	,CAST(comm.WSDGL__gl_date as date) install_date




FROM
	-- tag is source
	[Integration].[nes_transaction_tag_only] s

	-- link source to workorder
	LEFT JOIN [nes].[order] wo
	ON wo.work_order_num = s.work_order_num

	-- link workorder to order
	LEFT JOIN nes.order_ets ord
	ON ord.ets_num = wo.[ets_num]

	-- linke order to comm header

	LEFT JOIN [comm].[transaction_F555115] AS comm 
	ON ord.[eq_forecast_act_comm_key] = comm.id and
	-- EQ only
	comm.ess_code <> '' AND
	-- speed up?
--	header.FiscalMonth >= 202401 AND
	(1=1)

/*
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
*/

WHERE
	(s.total_extended_value > 0.01) AND
--	[FiscalMonth] >=202401
	(1=1)

/*
GROUP BY 
header.[WSORD__equipment_order]
,header.[WSDOCO_salesorder_number]

*/

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

-- select    top 100 * FROM nes.order_tag_date_actual

 select    * FROM nes.order_install_date_tag where equipment_order is null


