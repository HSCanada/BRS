
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW Dimension.SalespersonCodeCommission
AS

/******************************************************************************
**	File: 
**	Name: Dimension.SalespersonCodeCommission
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
**	Date: 16 Sep 18
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	26 Nov 18	tmc		Link Salesperson code to SalespersonMaster
**    
*******************************************************************************/


SELECT 
	[TerritoryCd]				AS FSC_SalespersonCode
	,[FSCName]					AS SalespersonName
	,sm.EmployeeNumber
	,sm.CommPlanCode
	,CAST([AddedDt] AS Date)	AS TerritoryStart
	,[FscKey]					AS FSC_SalespersonCodeKey
	,[FSCRollup]
	,b.Branch					AS BranchCode
	,b.BranchName
	,b.ZoneName

FROM 
	[dbo].[BRS_FSC_Rollup] s


	INNER JOIN [dbo].[BRS_Branch] b
	ON s.Branch = b.Branch

	INNER JOIN Dimension.SalespersonCommission sm
	ON s.comm_salesperson_key_id = sm.salespersonid

WHERE
	-- cross branch
	(sm.BranchCount > 1) OR
	-- ensure unassigned is included
	([TerritoryCd] = '')

	
GO
      

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


--  SELECT   * FROM Dimension.SalespersonCodeCommission order by 1
--select count(*) from Dimension.SalespersonCodeCommission
--ORG 496
--  SELECT  * FROM Dimension.SalespersonCodeCommission 
--  SELECT  DISTINCT [group_type], FSCStatusCode FROM Dimension.SalespersonCodeCommission  ORDER BY 1