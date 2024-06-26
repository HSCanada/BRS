
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW nes.order_open_equipment_current
AS

/******************************************************************************
**	File: 
**	Name: nes.order_open_equipment_current
**	Desc:  
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
**	Date: 6 Feb 18
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**  27 Jan 20	tmc		added GP & date param based on config
**	31 Mar 20	tmc		setup dynamic date filter
**	30 Mar 21	tmc		Fix to remove non-open orders
*******************************************************************************/

SELECT
	d.FiscalMonth
	,[ets_num]
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
	nes.open_order_opordrpt t

	CROSS JOIN [dbo].[BRS_Config] as config

	INNER JOIN [dbo].[BRS_SalesDay] d
	ON t.SalesDate = d.SalesDate

WHERE
	t.SalesDate = config.[SalesDateLastWeekly] AND
--	t.SalesDate = (SELECT max(SalesDate) FROM nes.open_order_opordrpt) AND

	t.item_status NOT in ('CANCELLED', 'CLOSED') AND
--	[SalesDate] = (SELECT [PY_SalesDateLastWeekly] FROM [dbo].[BRS_Config])
	(1=1)

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

--SELECT distinct [SalesDate] from nes.open_order_opordrpt order by 1

-- SELECT TOP 10 * FROM nes.order_open_equipment_current
-- SELECT * FROM nes.order_open_equipment_current
-- ORG 4577



