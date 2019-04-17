
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
*******************************************************************************/

SELECT DISTINCT
	g.bx_shipto,
	g.bx_group_id								AS GROUP_ID,
	e.bx_user_id								AS USER_ID


FROM
	nes.bx_task_template AS t 

	CROSS JOIN nes.bx_group_load g

	INNER JOIN nes.bx_role_branch br
	ON g.bx_branch_code = br.Branch AND
--		t.role_key = br.role_key AND
--		br.unique_id = 1 AND
		(1=1)

	INNER JOIN dbo.BRS_Employee AS e
	ON br.SamAccountName = e.SamAccountName


WHERE
	(t.bx_task_id > 0) AND
	(g.bx_invite_ind < 1) AND
	(br.bx_active_ind = 1) AND
	(e.bx_user_id > 1) AND
--	(g.bx_group_id > 0) AND
	(1=1)


GO


SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

--

SELECT  * FROM nes.bx_group_permission_load  order by GROUP_ID

