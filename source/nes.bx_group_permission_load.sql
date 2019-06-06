
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW nes.bx_group_permission_load
AS

/******************************************************************************
**	File: 
**	Name: nes.bx_group_permission_load
**	Desc: Bitrix new Task templates to load
**		
**
**              
**	Return values:  
**
**	Called by:   Excel power query
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**
**	Auth: tmc
**	Date: 14 Apr 19
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	05 Jun 19	tmc		extend logic to include sales and support users
*******************************************************************************/


-- role-based users
SELECT DISTINCT
	g.bx_shipto
	,g.bx_group_id								AS GROUP_ID
	,e.bx_user_id								AS USER_ID

	-- test
	--,br.SamAccountName
FROM
	nes.bx_task_template AS t 

	CROSS JOIN nes.bx_group_load g

	INNER JOIN nes.bx_role_branch br
	ON g.bx_branch_code = br.Branch

	INNER JOIN dbo.BRS_Employee AS e
	ON br.SamAccountName = e.SamAccountName

WHERE
	(t.bx_task_id > 0) AND
	(g.bx_invite_ind < 1) AND
	(br.bx_active_ind = 1) AND
	(e.bx_user_id > 1) AND
	(1=1)

UNION

-- FSC-based users per group
SELECT DISTINCT
	g.bx_shipto
	,g.bx_group_id								AS GROUP_ID
	,e.bx_user_id								AS USER_ID

	-- test
	--,e.SamAccountName
FROM
	nes.bx_group_load g

	INNER JOIN [dbo].[BRS_FSC_Rollup] terr
	ON g.bx_fsc_code = terr.TerritoryCd

	INNER JOIN dbo.BRS_Employee AS e
	ON terr.SamAccountName = e.SamAccountName

WHERE
	(g.bx_invite_ind < 1) AND
	(e.bx_user_id > 1) AND
	(1=1)

UNION

-- cps-based users per group
SELECT DISTINCT
	g.bx_shipto
	,g.bx_group_id								AS GROUP_ID
	,e.bx_user_id								AS USER_ID

	-- test
	--,e.SamAccountName
FROM
	nes.bx_group_load g

	INNER JOIN [dbo].[BRS_FSC_Rollup] terr
	ON g.bx_cps_code = terr.TerritoryCd

	INNER JOIN dbo.BRS_Employee AS e
	ON terr.SamAccountName = e.SamAccountName

WHERE
	(g.bx_invite_ind < 1) AND
	(e.bx_user_id > 1) AND
	(1=1)

UNION

-- ess-based users per group
SELECT DISTINCT
	g.bx_shipto
	,g.bx_group_id								AS GROUP_ID
	,e.bx_user_id								AS USER_ID

	-- test
	--,e.SamAccountName
FROM
	nes.bx_group_load g

	INNER JOIN [dbo].[BRS_FSC_Rollup] terr
	ON g.bx_ess_code = terr.TerritoryCd

	INNER JOIN dbo.BRS_Employee AS e
	ON terr.SamAccountName = e.SamAccountName

WHERE
	(g.bx_invite_ind < 1) AND
	(e.bx_user_id > 1) AND
	(1=1)

UNION

-- dts-based users per group
SELECT DISTINCT
	g.bx_shipto
	,g.bx_group_id								AS GROUP_ID
	,e.bx_user_id								AS USER_ID

	-- test
	--,e.SamAccountName
FROM
	nes.bx_group_load g

	INNER JOIN [dbo].[BRS_FSC_Rollup] terr
	ON g.bx_dts_code = terr.TerritoryCd

	INNER JOIN dbo.BRS_Employee AS e
	ON terr.SamAccountName = e.SamAccountName

WHERE
	(g.bx_invite_ind < 1) AND
	(e.bx_user_id > 1) AND
	(1=1)


GO


SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT  * FROM nes.bx_group_permission_load  where group_id = 783 order by GROUP_ID 


-- SELECT  * FROM nes.bx_group_permission_load  order by GROUP_ID 
