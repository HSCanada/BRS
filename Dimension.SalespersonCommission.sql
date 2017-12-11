
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
	[employee_num]				AS EmployeeNumber
	,[master_salesperson_cd]	AS CommMasterCode
	,[salesperson_nm]			AS SalespersonName
	,[comm_plan_id]				AS CommPlanCode
	,CAST([territory_start_dt] AS Date)	AS TerritoryStart
	,[salesperson_key_id]		AS SalespersonID
	,[salesperson_master_key]	AS SalespersonKey
  FROM [comm].[salesperson_master]
GO

      

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


--  SELECT * FROM Dimension.SalespersonCommission