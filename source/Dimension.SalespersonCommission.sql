
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
**    
*******************************************************************************/


SELECT 
	[salesperson_master_key]	AS SalespersonKey
	,[employee_num]				AS EmployeeNumber
	,[master_salesperson_cd]	AS CommMasterCode
	,[salesperson_nm]			AS SalespersonName
	,[comm_plan_id]				AS CommPlanCode
	,CAST([territory_start_dt] AS Date)	AS TerritoryStart
	,[salesperson_key_id]		AS SalespersonID
	,BranchCount
	,[CostCenter]
	,b.Branch					AS BranchCode
	,b.BranchName
	,b.ZoneName
	,tracker_ind

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


--  SELECT  * FROM Dimension.SalespersonCommission order by 2

