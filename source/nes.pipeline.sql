
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [nes].[pipeline]
AS

/******************************************************************************
**	File: 
**	Name: pipeline
**	Desc:  
**		
**
**              
**	Return values:  
**
**	Called by:   all
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**
**	Auth: tmc
**	Date: 31 Mar 20
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

-- Open CY
SELECT
	t.fact_id							AS FactKey,
	t.FiscalMonth						AS FiscalMonth,
	CASE 
		WHEN d.FiscalMonth < t.FiscalMonth 
		THEN t.FiscalMonth 
		ELSE d.FiscalMonth 
	END									AS FiscalMonthInstall,
	CASE 
		WHEN d.FiscalMonth < t.FiscalMonth 
		THEN 1
		ELSE 0
	END									AS PastDueInd,

	t.shipto							AS ShipTo,
	i.Item								AS Item,

	t.install_date						AS InstallDate,
	t.sales_date						AS SalesDate,

	'' 									AS OrderSource,
	t.workorder							AS Workorder,
	t.order_status						AS OrderStatus,
	ISNULL(f.[comm_salesperson_key_id],'')	AS FSC_SalespersonKeyID,
	ISNULL(e.[comm_salesperson_key_id],'')	AS ESS_SalespersonKeyID,
	t.cps_code,
	ISNULL(cps.[comm_salesperson_key_id],'') AS CPS_SalespersonKeyID,

	t.order_qty							AS Quantity,
	t.net_sales_amount					AS SalesAmt,
	t.net_sales_amount 
	- [extended_cost_amount]			AS [GPAmt]

FROM
	nes.order_open_equipment_current AS t 
	INNER JOIN BRS_Item AS i 
	ON t.item = i.Item 

	INNER JOIN BRS_Customer AS c 
	ON t.shipto = c.ShipTo 

	INNER JOIN BRS_SalesDay AS d 
	ON t.install_date = d.SalesDate 

	INNER JOIN BRS_FSC_Rollup AS f 
	ON c.TerritoryCd = f.TerritoryCd 

	INNER JOIN BRS_FSC_Rollup AS e 
	ON t.ess_code = e.TerritoryCd 

	INNER JOIN BRS_FSC_Rollup AS cps 
	ON t.cps_code = cps.TerritoryCd 
WHERE
	(1 = 1)

UNION ALL

-- Open PY
SELECT
	t.fact_id							AS FactKey,
	t.FiscalMonth						AS FiscalMonth,
	CASE 
		WHEN d.FiscalMonth < t.FiscalMonth 
		THEN t.FiscalMonth 
		ELSE d.FiscalMonth 
	END									AS FiscalMonthInstall,
	CASE 
		WHEN d.FiscalMonth < t.FiscalMonth 
		THEN 1
		ELSE 0
	END									AS PastDueInd,

	t.shipto							AS ShipTo,
	i.Item								AS Item,

	t.install_date						AS InstallDate,
	t.sales_date						AS SalesDate,

	'' 									AS OrderSource,
	t.workorder							AS Workorder,
	t.order_status						AS OrderStatus,
	ISNULL(f.[comm_salesperson_key_id],'')	AS FSC_SalespersonKeyID,
	ISNULL(e.[comm_salesperson_key_id],'')	AS ESS_SalespersonKeyID,
	t.cps_code,
	ISNULL(cps.[comm_salesperson_key_id],'') AS CPS_SalespersonKeyID,

	t.order_qty							AS Quantity,
	t.net_sales_amount					AS SalesAmt,
	t.net_sales_amount 
	- [extended_cost_amount]			AS [GPAmt]

FROM
	nes.order_open_equipment_current_py AS t 
	INNER JOIN BRS_Item AS i 
	ON t.item = i.Item 

	INNER JOIN BRS_Customer AS c 
	ON t.shipto = c.ShipTo 

	INNER JOIN BRS_SalesDay AS d 
	ON t.install_date = d.SalesDate 

	INNER JOIN BRS_FSC_Rollup AS f 
	ON c.TerritoryCd = f.TerritoryCd 

	INNER JOIN BRS_FSC_Rollup AS e 
	ON t.ess_code = e.TerritoryCd 

	INNER JOIN BRS_FSC_Rollup AS cps 
	ON t.cps_code = cps.TerritoryCd 
WHERE
	(1 = 1)

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- SELECT top 10 * FROM nes.pipeline
-- SELECT * FROM nes.pipeline
-- 4173