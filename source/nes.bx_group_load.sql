
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW nes.bx_group_load
AS

/******************************************************************************
**	File: 
**	Name: nes.bx_group_load
**	Desc: Bitrix new orders to load
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
**	Date: 6 Feb 18
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
*******************************************************************************/

SELECT        
	s.shipto									AS bx_shipto
	,MIN(ess.bx_user_id)						AS bx_user_id_ess
	,MIN(fsc.bx_user_id)						AS bx_user_id_fsc
	,MIN(br.[bx_user_id])						AS bx_user_id_branch

	,MIN(c.PracticeName) + ' - '
	+CAST(s.[shipto] as varchar(7)) +' - TBD'	AS NAME

	,RTRIM(MIN([AddressLine3])) 
	+' | ' + RTRIM(MIN([AddressLine4]))	
	+' | ' + MIN([City])			
	+' | ' + MIN([Province])		
	+' | ' + MIN([PhoneNo])
	+' | ' + LOWER(RTRIM(MIN(ess.FSCName)))	
	+' | ' + LOWER(RTRIM(MIN(fsc.FSCName)))			AS DESCRIPTION

	,'Y'										AS VISIBLE	
	,'N'										AS OPENED
	,LOWER(MIN(br.BranchName))					AS KEYWORDS
	,'K'										AS INITIATE_PERMS
	,'Y'										AS PROJECT 
	,MIN(sales_date)							AS PROJECT_DATE_START 
	,CAST('2040-12-31' AS date)					AS PROJECT_DATE_FINISH 


FROM
nes.order_open_equipment_current AS s 

INNER JOIN BRS_Customer AS c 
ON s.shipto = c.ShipTo 

INNER JOIN BRS_FSC_Rollup AS fsc 
ON s.fsc_code = fsc.TerritoryCd 

INNER JOIN BRS_FSC_Rollup AS ess 
ON s.ess_code = ess.TerritoryCd 

INNER JOIN BRS_Branch br
ON fsc.Branch = br.Branch 

INNER JOIN nes.order_status 
ON s.order_status_code = nes.order_status.order_status_code 


WHERE
	(br.bx_active_ind = 1) AND 
	(order_status.bx_active_ind = 1)  AND
	(c.bx_group_id IS NULL)

GROUP BY 
	s.shipto
HAVING 
	SUM(s.net_sales_amount) >= (SELECT [bx_order_thresh] FROM [dbo].[BRS_Config])


GO


SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

--
SELECT TOP 10 * FROM nes.bx_group_load

/*
NAME - group name (required field),
DESCRIPTION - group description,
VISIBLE - Y/N flag, defines group visibility in the group list,
OPENED - Y/N flag defines if the group is open to be joined,

KEYWORDS - keywords,
INITIATE_PERMS - specifies, if the user has access permission to invite users into the group (required field): SONET_ROLES_OWNER - group owner only, SONET_ROLES_MODERATOR - group owner and moderators, SONET_ROLES_USER - all group members,

CLOSED - Y/N flag - defines if the group is archived,
SPAM_PERMS - defines who has the access permission to send messages to group (required field): SONET_ROLES_OWNER - group owner only, SONET_ROLES_MODERATOR - group owner and moderators, SONET_ROLES_USER - all group members, SONET_ROLES_ALL - all users.

PROJECT Y/N. Defines if the group is classified as project or not. It is not a project by default. (Starting from version 18.0.0)
PROJECT_DATE_FINISH Defines project finish date. (Available from version 18.0.0)
PROJECT_DATE_START Defines the project start. (Available from version 18.0.0)
*/