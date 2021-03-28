
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW nes.order_open_equipment_pipeline
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
**	Date: 25 Mar 21
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
** updated to add GP, tmc, 27 Jan 20
** updated to add py and date logic, hack, 6 Feb 20
** maint 26 Mar 20
** automated 7 Apr 20
*******************************************************************************/


-- Sales CY & PY
SELECT
--	TOP (10) 

	t.FactKey, 
	t.FiscalMonth, 
	t.FSC_SalespersonKey, 
	t.ESS_SalespersonKey, 
	t.ShipTo, 
	t.ItemKey, 
	t.DateKey, 
	t.SourceKey, 

	i.comm_group_cd,
	f.Branch,
	sm.master_salesperson_cd,
	sm.comm_plan_id,

	t.Quantity, 
	t.SalesAmt,
	t.[GPAmt]

FROM
	Fact.Commission AS t 
	
	INNER JOIN BRS_Customer AS c 
	ON t.ShipTo = c.ShipTo 
	
	INNER JOIN BRS_Item AS i 
	ON t.ItemKey = i.ItemKey 
	
	INNER JOIN BRS_FSC_Rollup AS f 
	ON c.TerritoryCd = f.TerritoryCd

	INNER JOIN [comm].[salesperson_master] AS sm
	ON t.ESS_SalespersonKey = sm.salesperson_master_key
	
	INNER JOIN BRS_FiscalMonth AS m 
	ON t.FiscalMonth = m.FiscalMonth

WHERE
	(
		(sm.master_salesperson_cd like 'CCS%') AND
		(i.comm_group_cd IN ('DIGCIM', 'DIGIMP', 'DIGLAB', 'DIGCCS'))
	) OR
	(
		(sm.master_salesperson_cd like 'ESS%') AND
		(i.comm_group_cd IN ('ITMCPU', 'ITMFO1', 'ITMFO2', 'ITMFO3', 'ITMISC')) 
	) AND
	-- test
	-- Branch = 'TORNT' AND
	-- 17 516 @ 11s
	(1=1)

UNION ALL

-- Open CY & PY
SELECT
--	top 10

	t.[FactKey],
	t.[FiscalMonthInstall] as FiscalMonth,

	fsc_comm.salesperson_master_key AS FSC_SalespersonKey,
	ess_comm.salesperson_master_key AS ESS_SalespersonKey,

	t.[ShipTo],
	i.[ItemKey],

	t.[InstallDate],

	1 AS [OrderSource],

	i.comm_group_cd,
	f.Branch,
	ess_comm.master_salesperson_cd,
	ess_comm.comm_plan_id,

	t.[Quantity],
	t.[SalesAmt],
	t.[GPAmt]
FROM
	[nes].[pipeline]  AS t

	INNER JOIN BRS_Customer AS c 
	ON t.ShipTo = c.ShipTo 

	INNER JOIN BRS_Item AS i 
	ON t.Item = i.Item
	
	INNER JOIN BRS_FSC_Rollup AS f 
	ON c.TerritoryCd = f.TerritoryCd

	INNER JOIN [comm].[salesperson_master] AS fsc_comm
	ON t.FSC_SalespersonKeyID = fsc_comm.salesperson_key_id

	INNER JOIN [comm].[salesperson_master] AS ess_comm
	ON t.ESS_SalespersonKeyID = ess_comm.salesperson_key_id

WHERE
	(
		(ess_comm.master_salesperson_cd like 'CCS%') AND
		(i.comm_group_cd IN ('DIGCIM', 'DIGIMP', 'DIGLAB', 'DIGCCS'))
	) OR
	(
		(ess_comm.master_salesperson_cd like 'ESS%') AND
		(i.comm_group_cd IN ('ITMCPU', 'ITMFO1', 'ITMFO2', 'ITMFO3', 'ITMISC'))
	) AND
	-- test
	-- Branch = 'TORNT' AND
	-- 2 225 @ 0s
	(1=1)
	
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT top 10 * FROM nes.order_open_equipment_pipeline
-- SELECT * FROM nes.order_open_equipment_pipeline where Branch = 'TORNT'




