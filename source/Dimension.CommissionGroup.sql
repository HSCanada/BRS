﻿
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[CommissionGroup]
AS

/******************************************************************************
**	File: 
**	Name: CommisionGroup
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
**	Date: 08 Dec 17
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	08 May 19	tmc		added scorecard rollup
**  04 Jul 19	tmc		added 3 rollups for FSC, ESS, CSS
**	02 Jun 20	tmc		remove legacy fields. not needed
**  19 Apr 21	tmc		add rollup for analysis: Merch, HSB, EQ
*******************************************************************************/

SELECT 
	[comm_group_key]								AS CommGroupKey
	,[comm_group_cd]	+ ' | ' + [comm_group_desc]	AS CommGroup
	,[comm_group_cd]								AS CommGroupCode
	,comm_group_scorecard_cd
	,SalesCategory									AS CommGroupRollup
FROM 
	[comm].[group]
WHERE
    [active_ind]=1


GO


-- SELECT * FROM [Dimension].[CommissionGroup]
-- SELECT Count(*) FROM [Dimension].[CommissionGroup]

