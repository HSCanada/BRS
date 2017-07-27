
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[Salesperson]
AS

/******************************************************************************
**	File: 
**	Name: Salesperson
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
**	Date: 14 Jun 17
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

SELECT        
	s.FscKey
	,sroll.FSCName		AS FieldSales
	,b.BranchName		AS Branch

FROM
	BRS_FSC_Rollup AS s 

	INNER JOIN BRS_Branch AS b 
	ON s.Branch = b.Branch

	INNER JOIN BRS_FSC_Rollup sroll
	ON s.FSCRollup = sroll.TerritoryCd
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


SELECT top 10 * FROM Dimension.Salesperson order by 1
