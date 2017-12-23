
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[BRS_DS_GLBU_Rollup]
AS

/******************************************************************************
**	File: 
**	Name: BRS_DS_GLBU_Rollup
**	Desc:  
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
--	20 Feb 17	tmc		Added extra level of SM rollup for SM P&L 
*******************************************************************************/

SELECT     
	GLBU_Class, 
	GLBU_ClassNm, 
	GLBU_ClassDS_L1, 
	GLBU_ClassSM_L2, 
	GLBU_ClassSM_L1, 
	GLBU_ClassUS_L1, 
	CorpParticipationFactor, 
	ReportingClass,
	GLBU_ClassSM_L3

FROM         

	BRS_BusinessUnitClass AS buc

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT * FROM BRS_DS_GLBU_Rollup
