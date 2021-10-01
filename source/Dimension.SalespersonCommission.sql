
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW Dimension.SalespersonCommission
AS

/******************************************************************************
**	File: 
**	Name: Dimension.SalespersonCommission
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
**	Date: 10 Dec 17
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	02 Jul 20		tmc	added master code to name for easier excel mapping, post
**	03 Feb 21		tmc	fixed salesperson name to remove code for legal reasons
**  19 Jul 21		tmc	add salesforce adoption and opportunity for playbook
**    
*******************************************************************************/


SELECT 
	[salesperson_master_key]	AS SalespersonKey
	,[employee_num]				AS EmployeeNumber
	,[master_salesperson_cd]	AS CommMasterCode
	,RTRIM([salesperson_nm]) 	AS SalespersonName
--	,[salesperson_nm] 			AS SalespersonName
	,[comm_plan_id]				AS CommPlanCode
	,CAST([territory_start_dt] AS Date)	AS TerritoryStart
	,[salesperson_key_id]		AS SalespersonID
	,ISNULL(BranchCount,0)		AS BranchCount
	,[CostCenter]
	,b.Branch					AS BranchCode
	,b.BranchName
	,b.ZoneName
	,tracker_ind

	-- tmc	add salesforce adoption and opportunity for playbook, 19 Jul 21
	,sf_adpt_login_score 
	,sf_adpt_created_opps_score 
	,sf_adpt_activity_score 
	,sf_adpt_pastdue_opps_score 
	,sf_adpt_closed_opps_score 

	,sf_opps_equipment_technology_cnt
	,sf_opps_cadcam_digitial_imaging_cnt
	,sf_opps_merchandise_cnt
	,sf_opps_other_cnt

	,sf_opps_equipment_technology_amt
	,sf_opps_cadcam_digitial_imaging_amt
	,sf_opps_merchandise_amt
	,sf_opps_other_amt


  FROM 
	[comm].[salesperson_master] s

	INNER JOIN [dbo].[BRS_FSC_Rollup] f
	ON s.master_salesperson_cd = f.TerritoryCd

	INNER JOIN [dbo].[BRS_Branch] b
	ON f.Branch = b.Branch

	LEFT JOIN (
		SELECT        
		comm_salesperson_key_id
		,COUNT(distinct  Branch) AS BranchCount
		FROM
			BRS_FSC_Rollup
		GROUP BY 
			comm_salesperson_key_id
	) AS tc
	ON s.[salesperson_key_id] = tc.comm_salesperson_key_id

GO
      

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- SELECT  top 10 * FROM Dimension.SalespersonCommission where branchcode = 'NWFLD'

-- SELECT  * FROM Dimension.SalespersonCommission where SalespersonName like '%laura%'
