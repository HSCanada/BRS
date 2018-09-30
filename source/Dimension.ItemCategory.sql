
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[ItemCategory]
AS

/******************************************************************************
**	File: 
**	Name: xxx
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
**	Date: 28 Sep 18
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

    
SELECT  
	[CategoryRollupKey]			
	,[category_rollup_desc]			AS ItemCategory
	,[CategoryRollup]				AS ItemCategoryCode
	,CategorySharePercent
	,top15_ind
	,[CategoryClass_Rollup]			AS CategoryClass


FROM 
	[dbo].[BRS_ItemCategoryRollup]
WHERE
	active_ind = 1

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- SELECT top 10 * FROM Dimension.[ItemCategory]


