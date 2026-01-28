
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[CommissionGroupTier]
AS

/******************************************************************************
**	File: 
**	Name: CommisionGroupTier
**	Desc: used for FSC Comm 2026 
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
**	Date: 23 Jan 26
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
*******************************************************************************/

SELECT
	calc_key
	, disp_comm_group_cd
	, CASE WHEN comm_gm_threshold_cd = '' THEN 'T00' ELSE comm_gm_threshold_cd END as comm_tier_cd 
	, ISNULL(comm_gm_threshold_descr,'na') rate_level_display

FROM
	comm.plan_group_rate
WHERE
	(comm_plan_id in ('FSCGP02', 'FSCGP02_Q', 'FSCGP03', 'FSCGP03_Q', 'FSCGP00')) AND
	(active_ind = 1) AND 
	(source_cd <> 'PAY') AND
	(1=1)

UNION ALL
Select 0, '.', 'Txx', ''
GO



GO


-- SELECT * FROM [Dimension].[CommissionGroupTier] order by 1
-- SELECT Count(*) FROM [Dimension].[CommissionGroupTier]

