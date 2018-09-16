
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
**    
*******************************************************************************/


SELECT 
	[TerritoryCd]				AS FSC_SalespersonCode
	,[FSCName]					AS SalespersonName
	,[FscKey]					AS FSC_SalespersonCodeKey
	,[FSCRollup]
	,b.Branch					AS BranchCode
	,b.BranchName
	,b.ZoneName

FROM 
	[dbo].[BRS_FSC_Rollup] s


	INNER JOIN [dbo].[BRS_Branch] b
	ON s.Branch = b.Branch

WHERE
	group_type = 'AAFS' OR
	[TerritoryCd] = ''

	
GO
      

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


--  SELECT  top 10 * FROM Dimension.SalespersonCodeCommission 
--  SELECT  * FROM Dimension.SalespersonCodeCommission 
--  SELECT  DISTINCT [group_type], FSCStatusCode FROM Dimension.SalespersonCodeCommission  ORDER BY 1