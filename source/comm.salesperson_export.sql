
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [comm].[salesperson_export]
AS

/******************************************************************************
**	File: 
**	Name: [comm].[salesperson_export]
**	Desc:  
**		
**
**              
**	Return values:  
**
**	Called by:   
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**
**	Auth: tmc
**	Date: 27 Dec 20
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

-- draw
SELECT
	[FiscalMonth]
	,'PAYROLL'					AS owner_code
	,0							AS [original_line_number]	
	,0							AS [ShipTo]
	,''							AS customer_name
	,0							AS salesorder_num
	,''							AS item_id
	,'Payroll - Draw'			AS details
	,0							AS transaction_amt
	,''							AS adj_type_code
	,''							AS gp_code
	,0							AS gp_ext_amt 

	,[comm_plan_id]
	,[master_salesperson_cd]

	,IIF(LEFT([comm_plan_id],3)='FSC', [master_salesperson_cd], '') AS [fsc_code]
	,IIF(LEFT([comm_plan_id],3)='FSC', [salary_draw_amt], 0)		AS [fsc_comm_amt]
	,IIF(LEFT([comm_plan_id],3)='FSC', 'SALD30', '')				AS [fsc_comm_group_cd]

	,IIF(LEFT([comm_plan_id],3)='ESS' OR 
		LEFT([comm_plan_id],3)='CCS', [master_salesperson_cd], '') AS [ess_code]
	,IIF(LEFT([comm_plan_id],3)='ESS' OR 
		LEFT([comm_plan_id],3)='CCS', [salary_draw_amt], 0)		AS [ess_comm_amt]
	,IIF(LEFT([comm_plan_id],3)='ESS' OR 
		LEFT([comm_plan_id],3)='CCS', 'SALD30', '')				AS [ess_comm_group_cd]

	,IIF(LEFT([comm_plan_id],3)='ISR', [master_salesperson_cd], '') AS [isr_code]
	,IIF(LEFT([comm_plan_id],3)='ISR', [salary_draw_amt], 0)		AS [isr_comm_amt]
	,IIF(LEFT([comm_plan_id],3)='ISR', 'SALD30', '')				AS [isr_comm_group_cd]

	,IIF(LEFT([comm_plan_id],3)='EPS', [master_salesperson_cd], '') AS [eps_code]
	,IIF(LEFT([comm_plan_id],3)='EPS', [salary_draw_amt], 0)		AS [eps_comm_amt]
	,IIF(LEFT([comm_plan_id],3)='EPS', 'SALD30', '')				AS [eps_comm_group_cd]

	,IIF(LEFT([comm_plan_id],3)='CPS', [master_salesperson_cd], '') AS [cps_code]
	,IIF(LEFT([comm_plan_id],3)='CPS', [salary_draw_amt], 0)		AS [cps_comm_amt]
	,IIF(LEFT([comm_plan_id],3)='CPS', 'SALD30', '')				AS [cps_comm_group_cd]

	,IIF(LEFT([comm_plan_id],3)='EST', [master_salesperson_cd], '') AS [est_code]
	,IIF(LEFT([comm_plan_id],3)='EST', [salary_draw_amt], 0)		AS [est_comm_amt]
	,IIF(LEFT([comm_plan_id],3)='EST', 'SALD30', '')				AS [est_comm_group_cd]

	,0							AS [status_code]
 FROM 
	[comm].[salesperson_master] 
 WHERE 
	FiscalMonth = (SELECT [PriorFiscalMonth] FROM [dbo].[BRS_Config])

UNION ALL

-- balance
SELECT
	[FiscalMonth]
	,'PAYROLL'					AS owner_code
	,0							AS [original_line_number]	
	,0							AS [ShipTo]
	,''							AS customer_name
	,0							AS salesorder_num
	,''							AS item_id
	,'Payroll - Balance'		AS details
	,0							AS transaction_amt
	,''							AS adj_type_code
	,''							AS gp_code
	,0							AS gp_ext_amt 

	,[comm_plan_id]
	,[master_salesperson_cd]

	,IIF(LEFT([comm_plan_id],3)='FSC', [master_salesperson_cd], '') AS [fsc_code]
	,IIF(LEFT([comm_plan_id],3)='FSC', [deficit_amt], 0)			AS [fsc_comm_amt]
	,IIF(LEFT([comm_plan_id],3)='FSC', 'STMPBA', '')				AS [fsc_comm_group_cd]

	,IIF(LEFT([comm_plan_id],3)='ESS' OR 
		LEFT([comm_plan_id],3)='CCS', [master_salesperson_cd], '')	AS [ess_code]
	,IIF(LEFT([comm_plan_id],3)='ESS' OR 
		LEFT([comm_plan_id],3)='CCS', [deficit_amt], 0)				AS [ess_comm_amt]
	,IIF(LEFT([comm_plan_id],3)='ESS' OR 
		LEFT([comm_plan_id],3)='CCS', 'STMPBA', '')					AS [ess_comm_group_cd]

	,IIF(LEFT([comm_plan_id],3)='ISR', [master_salesperson_cd], '') AS [isr_code]
	,IIF(LEFT([comm_plan_id],3)='ISR', [deficit_amt], 0)			AS [isr_comm_amt]
	,IIF(LEFT([comm_plan_id],3)='ISR', 'STMPBA', '')				AS [isr_comm_group_cd]

	,IIF(LEFT([comm_plan_id],3)='EPS', [master_salesperson_cd], '') AS [eps_code]
	,IIF(LEFT([comm_plan_id],3)='EPS', [deficit_amt], 0)			AS [eps_comm_amt]
	,IIF(LEFT([comm_plan_id],3)='EPS', 'STMPBA', '')				AS [eps_comm_group_cd]

	,IIF(LEFT([comm_plan_id],3)='CPS', [master_salesperson_cd], '') AS [cps_code]
	,IIF(LEFT([comm_plan_id],3)='CPS', [deficit_amt], 0)			AS [cps_comm_amt]
	,IIF(LEFT([comm_plan_id],3)='CPS', 'STMPBA', '')				AS [cps_comm_group_cd]

	,IIF(LEFT([comm_plan_id],3)='EST', [master_salesperson_cd], '') AS [est_code]
	,IIF(LEFT([comm_plan_id],3)='EST', [deficit_amt], 0)			AS [est_comm_amt]
	,IIF(LEFT([comm_plan_id],3)='EST', 'STMPBA', '')				AS [est_comm_group_cd]

	,0							AS [status_code]
 FROM 
	[comm].[salesperson_master] 
 WHERE 
	FiscalMonth = (SELECT [PriorFiscalMonth] FROM [dbo].[BRS_Config])


GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/*
print 'integrity checks (s/b 0):'
SELECT  * FROM [comm].[customer_rebate_export] where [teeth_share_rt] > 1.0 or [teeth_share_rt] < 0.0
*/

-- test details
--SELECT  top 10      * FROM comm.[salesperson_export]
--SELECT  * FROM comm.[salesperson_export] order by comm_plan_id
--SELECT  * FROM comm.[salesperson_export] order by master_salesperson_cd




