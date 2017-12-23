
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[STAGE_BRS_Transaction_T1]
AS

/******************************************************************************
**	File: 
**	Name: STAGE_BRS_Transaction_T1
**	Desc: STAGE_BRS_Transaction - Transform 1
**
**              
**	Return values:  @@Error
**
**	Called by:   
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**
**	Auth: tmc
**	Date: 16 Feb 16
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

SELECT     
	t.SHDOCO, 
	t.SHDCTO, 
	t.SDLNID, 
	o.GLOBJ_Type, 
	o.GLAcctNumberObj, 
	SUM(CASE WHEN GLOBJ_TYPE = 'S' THEN - GLAA ELSE GLAA END) AS SUM_GLAA, 
	MIN(t.ID) AS MIN_ID
FROM         

	dbo.STAGE_BRS_Transaction AS t 

	INNER JOIN dbo.BRS_Object AS o 
	ON SUBSTRING(t.GLANI, 14, 10) = o.GLAcctNumberObj

GROUP BY 
	t.SHDOCO, 
	t.SHDCTO, 
	t.SDLNID, 
	o.GLOBJ_Type, 
	o.GLAcctNumberObj

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT * FROM STAGE_BRS_Transaction_T1
