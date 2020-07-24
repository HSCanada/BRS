
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW nes.open_order_deposit_R560960_week_over_week
AS

/******************************************************************************
**	File: 
**	Name: nes.open_order_deposit_R560960_week_over_week
**	Desc: pull current open order with deposit AND matching last year values
**		
**
**              
**	Return values:  
**
**	Called by:   SSAS
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**
**	Auth: tmc
**	Date: 23 Jul 20
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
*******************************************************************************/

-- CY
SELECT 
	s.[TerritoryCd]
	,d.FiscalMonth
	,d.CalWeek
	,d.FiscalYear
	,t.Branch
	,UPPER(t.FSCName)  AS TerritoryName
	,s.[Past_Due_Deposit]
	,s.[Past_Due_Order]
	,s.[Current_Month_Deposit]
	,s.[Current_Month_Order]
	,s.[Month_Plus1_Deposit]
	,s.[Month_Plus1_Order]
	,s.[Month_Plus2_Deposit]
	,s.[Month_Plus2_Order]
	,s.[Month_Plus3_Deposit]
	,s.[Month_Plus3_Order]
	,s.[note]
	,s.[id]
	,s.[SalesDateLastWeekly]

FROM
	[nes].[open_order_deposit_R560960] s

	INNER JOIN [dbo].[BRS_SalesDay] d
	ON d.SalesDate = [SalesDateLastWeekly]

	INNER JOIN [dbo].[BRS_FSC_Rollup] t
	ON t.TerritoryCd = s.[TerritoryCd]
WHERE 
	CalWeek = 
	(
		SELECT d.CalWeek 
		FROM [dbo].[BRS_Config] s 
		INNER JOIN [dbo].[BRS_SalesDay] d 
		ON d.[SalesDate] = s.[SalesDateLastWeekly]
	) AND
	FiscalYear = 
	(
		SELECT FiscalYear 
		FROM [dbo].[BRS_Config] s 
		INNER JOIN [dbo].[BRS_SalesDay] d 
		ON d.[SalesDate] = s.[SalesDateLastWeekly]
	)

UNION ALL

-- PY
SELECT 
	s.[TerritoryCd]
	,d.FiscalMonth
	,d.CalWeek
	,d.FiscalYear
	,t.Branch
	,UPPER(t.FSCName)  AS TerritoryName
	,s.[Past_Due_Deposit]
	,s.[Past_Due_Order]
	,s.[Current_Month_Deposit]
	,s.[Current_Month_Order]
	,s.[Month_Plus1_Deposit]
	,s.[Month_Plus1_Order]
	,s.[Month_Plus2_Deposit]
	,s.[Month_Plus2_Order]
	,s.[Month_Plus3_Deposit]
	,s.[Month_Plus3_Order]
	,s.[note]
	,s.[id]
	,s.[SalesDateLastWeekly]

FROM
	[nes].[open_order_deposit_R560960] s

	INNER JOIN [dbo].[BRS_SalesDay] d
	ON d.SalesDate = [SalesDateLastWeekly]

	INNER JOIN [dbo].[BRS_FSC_Rollup] t
	ON t.TerritoryCd = s.[TerritoryCd]
WHERE 
	CalWeek = 
	(
		SELECT d.CalWeek 
		FROM [dbo].[BRS_Config] s 
		INNER JOIN [dbo].[BRS_SalesDay] d 
		ON d.[SalesDate] = s.[SalesDateLastWeekly]
	) AND
	-- CY minus 1
	FiscalYear = 
	(
		SELECT FiscalYear - 1
		FROM [dbo].[BRS_Config] s 
		INNER JOIN [dbo].[BRS_SalesDay] d 
		ON d.[SalesDate] = s.[SalesDateLastWeekly]
	)

GO


-- SELECT * from nes.open_order_deposit_R560960_week_over_week

-- last week day -> this curr week AND same week PY

/*
SELECT d.CalWeek, FiscalYear
FROM [dbo].[BRS_Config] s
	INNER JOIN [dbo].[BRS_SalesDay] d
	ON d.[SalesDate] = s.[SalesDateLastWeekly]
*/




