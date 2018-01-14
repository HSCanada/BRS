
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].Branch
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
**	Date: 3 Oct 17
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	13 Jan 18	tmc		show active branch only
**    
*******************************************************************************/

SELECT        
	BranchKey, 
	Branch AS BranchCode, 
	BranchName,
	[ZoneName]
FROM            
	BRS_Branch    
WHERE
	[StatusCd] = 1


GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- SELECT * FROM Dimension.Branch
