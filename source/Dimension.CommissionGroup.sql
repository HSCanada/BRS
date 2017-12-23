
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
**    
*******************************************************************************/

SELECT 
	[comm_group_key]								AS CommGroupKey
	,[comm_group_cd]	+ ' | ' + [comm_group_desc]	AS CommGroup
	,[comm_group_cd]								AS CommGroupCode
FROM 
	[comm].[group]
WHERE
    [active_ind]=1


GO


-- SELECT top 10 * FROM [Dimension].[CommissionGroup]
-- SELECT Count(*) FROM [Dimension].[CommissionGroup]

