
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Fact].[commission_strat]
AS

/******************************************************************************
**	File: 
**	Name: Sale
**	Desc:  
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
**	Date: 7 Dec 17
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------

**    
*******************************************************************************/

SELECT        
	t.ID											AS FactKey
	,t.FiscalMonth									AS FiscalMonth	
	,fsc.salesperson_master_key						AS FSC_SalespersonKey
	,t.[ShipTo]										AS ShipTo
	,t.date_complete								AS DateKey
	,tc.[strat_key]									AS StratKey

FROM            
	[strat].[tracker] AS t 

	INNER JOIN [strat].[tracker_code] as tc
	ON t.[strat_code] = tc.[strat_code]	

	INNER JOIN [dbo].[BRS_Customer] c
	ON t.ShipTo = c.ShipTo

	INNER JOIN [dbo].[BRS_FSC_Rollup] as fsc_code
	ON c.[TerritoryCd] = fsc_code.[TerritoryCd]

	INNER JOIN [comm].[salesperson_master] fsc
	ON fsc_code.comm_salesperson_key_id = fsc.salesperson_key_id


WHERE        
	(EXISTS (SELECT * FROM [Dimension].[Period] dd WHERE t.FiscalMonth = dd.FiscalMonth)) AND

	-- test

	(1 = 1)

GO

-- SELECT top 10 * FROM Fact.Commission_strat

