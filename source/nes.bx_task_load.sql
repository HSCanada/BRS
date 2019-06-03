
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW nes.bx_task_load
AS

/******************************************************************************
**	File: 
**	Name: nes.bx_group_load
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
**	Date: 31 Mar 19
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
*******************************************************************************/

SELECT
	g.bx_group_id								AS GROUP_ID,
	t.bx_task_id								AS bx_task_id_org,

	t.load_seq									AS bx_task_id_org_seq,
	b.language_cd,

	CASE 
		WHEN b.language_cd = 'FR' 
		THEN t.bx_title_fr 
		ELSE t.bx_title 
	END											AS TITLE,


	CASE 
		WHEN b.language_cd = 'FR' 
		THEN t.bx_description_fr 
		ELSE t.bx_description 
	END											AS [DESCRIPTION],


	CASE 
		WHEN b.language_cd = 'FR' 
		THEN t.bx_checklist_fr 
		ELSE t.bx_checklist 
	END											AS bx_checklist,

	CASE 
		WHEN milestone_ind = 1 
		THEN 2 
		ELSE 1 
	END											AS [PRIORITY],
	RTRIM(r.role_cd)							AS TAGS,
	DATEADD(WEEKDAY, t.offset_start_date, 
		g.bx_install_date)						AS START_DATE_PLAN,
	DATEADD(WEEKDAY, t.offset_end_date, 
		g.bx_install_date)						AS END_DATE_PLAN,
	e.bx_user_id								AS RESPONSIBLE_ID,
	t.effort_hours								AS bx_task_hours,

	t.bx_parent_task_id							AS bx_task_id_parent_org,
	t.bx_previous_task_id						AS bx_task_id_depends_on_org,
	g.bx_newreno_qty,
	g.bx_xray_qty


FROM
	nes.bx_task_template AS t 

	INNER JOIN nes.bx_role AS r
	ON t.role_key = r.role_key

	CROSS JOIN nes.bx_group_load g

	INNER JOIN dbo.BRS_Branch b
	ON g.bx_branch_code = b.Branch

	INNER JOIN nes.bx_role_branch br
	ON g.bx_branch_code = br.Branch AND
		t.role_key = br.role_key AND
		br.unique_id = 1

	INNER JOIN dbo.BRS_Employee AS e
	ON br.SamAccountName = e.SamAccountName




WHERE
	(t.bx_task_id > 0) AND
	(g.bx_invite_ind < 1) AND
--	(g.bx_group_id > 0) AND
	(1=1)


GO


SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

--

SELECT  * FROM nes.bx_task_load  order by GROUP_ID, bx_task_id_org_seq

