
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW nes.order_open_equipment_current_py
AS

/******************************************************************************
**	File: 
**	Name: nes.order_open_equipment_current_py
**	Desc:  *** this is Terrible.  Fix hardcode logic, 9 Mar 20 ***
**		
**
**              
**	Return values:  
**
**	Called by:   Excel power query
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**
**	Auth: tmc
**	Date: 6 Feb 20
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
*******************************************************************************/

SELECT

	[ets_num]
	,[line_number]

	,RTRIM(t.[d1_branch])				AS branch_eq
	,RTRIM(t.[order_status])			AS order_status_code

	,RTRIM(t.[order_status])			AS order_status
	,t.[work_order_num]					AS workorder

	,CAST(t.[work_order_date] as date)	AS workorder_date
	,CAST(t.[install_date]	as date)	AS install_date
	,CAST(t.[received_date]	as date)	AS received_date
	
	,t.[shipto]
	,[item]
	,t.item_status

	,[cps_code]
	,[ess_code]
	,[dts_code]
	,[fsc_code]

	,[order_qty]
	,[received_qty]
	,[net_sales_amount]


	,t.[fact_id]
	
	,CAST(t.[SalesDate] as date)	AS sales_date

	,[extended_cost_amount]

FROM 
	open_order_opordrpt t



WHERE
	[SalesDate] = '03/22/2019'
--	[SalesDate] = (SELECT MAX([SalesDate]) FROM nes.open_order_opordrpt) 
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT TOP 10 * FROM nes.order_open_equipment_current_py

-- SELECT count(*) FROM nes.order_open_equipment_current



