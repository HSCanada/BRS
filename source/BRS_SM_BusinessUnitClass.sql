
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[BRS_SM_BusinessUnitClass]
--CREATE VIEW [dbo].[BRS_SM_BusinessUnitClass]
AS

/******************************************************************************
**	File: 
**	Name: BRS_SM_BusinessUnitClass
**	Desc:  
**
**              
**	Return values: 
**
**	Called by:   
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**
**	Auth: tmc
**	Date: 22 Mar 16
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

SELECT     
	GLBU_Class, 
	GLBU_ClassNm, 
	ReportingClass, 
	CASE WHEN GLBU_ClassSM_L3 = '' THEN 'OTHER' ELSE GLBU_ClassSM_L3 END SM_SalesClass
FROM         
	BRS_BusinessUnitClass

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT * FROM [BRS_SM_BusinessUnitClass]
