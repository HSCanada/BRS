
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[CommissionGroupThresh]
AS

/******************************************************************************
**	File: 
**	Name: CommisionGroupThresh
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
**	Date: 18 Jun 24
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
*******************************************************************************/

SELECT
	calc_key
	, disp_comm_group_cd
--	, comm_gm_threshold_cd 
	, CASE WHEN comm_gm_threshold_cd = '' and comm_gm_threshold_descr is not null THEN 'T00' ELSE comm_gm_threshold_cd END as comm_gm_threshold_cd 
	, ISNULL(comm_gm_threshold_descr,'na') rate_level_display
--	, comm_gm_threshold_cd + ' ' + ISNULL(comm_gm_threshold_descr,'na') rate_level_display
FROM
	comm.plan_group_rate
WHERE
	(active_ind <> 0) AND 
	(comm_gm_threshold_ind <> 0) AND
--	(comm_plan_id = 'FSCMT02') AND 
	(source_cd <> 'PAY') AND
	(1=1)

UNION ALL

Select 0, '.', 'Txx', ''
GO


SELECT   calc_key, disp_comm_group_cd, comm_gm_threshold_cd, rate_level_display
FROM     Dimension.CommissionGroupThresh
ORDER BY calc_key


