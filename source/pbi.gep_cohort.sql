
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW Dimension.gep_cohort
AS

/******************************************************************************
**	File: 
**	Name: pbi.item_cobra_xref_review
**	Desc: how cobra xref in vertical view
**		
**
**              
**	Return values:  
**
**	Called by:   Access as a sub-query
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**
**	Auth: tmc
**	Date: 21 Mar 25
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
--	19 Sep 25	tmc		open list to show all items for review / update
*******************************************************************************/



SELECT 
	[GEP_Cohort_Code]
	,[GEP_Cohort]
	,[GEP_StartDate]
	,[Comment]
	,[GEP_StartDate_LY]
	,DATEDIFF(week,[GEP_StartDate], [SalesDateLastWeekly]) GEP_Cohort_Weeks_To_Date
	,SalesDateLastWeekly
FROM [pbi].[gep_cohort], [dbo].[BRS_Config]


GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


 select  top 100 * from Dimension.gep_cohort
-- select  count (*) from pbi.item_cobra_xref_review 

-- select  top 100 * from pbi.item_cobra_xref_review where item_subst = '9007437' order by 4,1

-- select  count(*) from pbi.item_cobra_xref_review


