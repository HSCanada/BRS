
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
**	31 Jan 21	tmc		update field order to match adjustment    
**    
*******************************************************************************/

-- draw
SELECT
	[salesperson_master_key]*2-1									AS ID
	,s.[FiscalMonth]
	,'HR'															AS owner_code
	,(salesperson_master_key*2-1)+s.[FiscalMonth]*10000				AS [original_line_number]	

	,IIF(LEFT([comm_plan_id],3)='FSC', [master_salesperson_cd], '')	AS [fsc_code]
	,IIF(LEFT([comm_plan_id],3)='FSC', 'SALD30', '')				AS [fsc_comm_group_cd]
	,IIF(LEFT([comm_plan_id],3)='FSC', salesperson_key_id, '')		AS [fsc_salesperson_key_id]

	,IIF(LEFT([comm_plan_id],3) IN ('ESS','CCS'), [master_salesperson_cd], '')	AS [ess_code]
	,IIF(LEFT([comm_plan_id],3) IN ('ESS','CCS'), 'SALD30', '')					AS [ess_comm_group_cd]
	,IIF(LEFT([comm_plan_id],3) IN ('ESS','CCS'), salesperson_key_id, '')		AS [ess_salesperson_key_id]

	,0							AS [ShipTo]
	,'.'						AS customer_name
	,0							AS salesorder_num
	,'AA'						AS order_type
	,'.'						AS item_id
	,'Payroll - Draw'			AS details
	,m.EndDt					AS transaction_date
	,0.0						AS transaction_amt
	,0.0						AS gp_ext_amt 
	,0.0						AS file_cost_amt
	-- draw
	,[salary_draw_amt]			AS [fsc_comm_amt]
	-- inferred good:  only goods accounts selected via filter
	,0							AS [status_code]
	,'PAY'						AS [source_cd]
	,'ACT'						AS adj_type_code
	,'.'						AS [cust_comm_group_cd]
	,'.'						AS [item_comm_group_cd]
	,'GP'						AS gp_code
	,0.0						AS [ma_estimate_factor]
	,RTRIM([comm_plan_id])+' | '+[master_salesperson_cd]			AS [comm_note_txt]

	,IIF(LEFT([comm_plan_id],3)='ISR', [master_salesperson_cd], '') AS [isr_code]
	,IIF(LEFT([comm_plan_id],3)='ISR', 'SALD30', '')				AS [isr_comm_group_cd]
	,IIF(LEFT([comm_plan_id],3)='ISR', salesperson_key_id, '')		AS [isr_salesperson_key_id]

	,IIF(LEFT([comm_plan_id],3)='EPS', [master_salesperson_cd], '') AS [eps_code]
	,IIF(LEFT([comm_plan_id],3)='EPS', 'SALD30', '')				AS [eps_comm_group_cd]
	,IIF(LEFT([comm_plan_id],3)='EPS', salesperson_key_id, '')		AS [eps_salesperson_key_id]

	,IIF(LEFT([comm_plan_id],3)='EST', [master_salesperson_cd], '') AS [est_code]
	,IIF(LEFT([comm_plan_id],3)='EST', 'SALD30', '')				AS [est_comm_group_cd]
	,IIF(LEFT([comm_plan_id],3)='EST', salesperson_key_id, '')		AS [est_salesperson_key_id]

	,IIF(LEFT([comm_plan_id],3)='CPS', [master_salesperson_cd], '') AS [cps_code]
	,IIF(LEFT([comm_plan_id],3)='CPS', 'SALD30', '')				AS [cps_comm_group_cd]
	,IIF(LEFT([comm_plan_id],3)='CPS', salesperson_key_id, '')		AS [cps_salesperson_key_id]

 FROM 
	[comm].[salesperson_master] s

	INNER JOIN [dbo].[BRS_FiscalMonth] m
	ON m.FiscalMonth = s.FiscalMonth

 WHERE 
	s.FiscalMonth = (SELECT [PriorFiscalMonth] FROM [dbo].[BRS_Config])

UNION ALL

-- balance
SELECT
	[salesperson_master_key]*2										AS ID
	,s.[FiscalMonth]
	,'HR'															AS owner_code
	,(salesperson_master_key*2)+s.[FiscalMonth]*10000				AS [original_line_number]	

	,IIF(LEFT([comm_plan_id],3)='FSC', [master_salesperson_cd], '')	AS [fsc_code]
	,IIF(LEFT([comm_plan_id],3)='FSC', 'STMPBA', '')				AS [fsc_comm_group_cd]
	,IIF(LEFT([comm_plan_id],3)='FSC', salesperson_key_id, '')		AS [fsc_salesperson_key_id]

	,IIF(LEFT([comm_plan_id],3) IN ('ESS','CCS'), [master_salesperson_cd], '')	AS [ess_code]
	,IIF(LEFT([comm_plan_id],3) IN ('ESS','CCS'), 'STMPBA', '')					AS [ess_comm_group_cd]
	,IIF(LEFT([comm_plan_id],3) IN ('ESS','CCS'), salesperson_key_id, '')		AS [ess_salesperson_key_id]

	,0							AS [ShipTo]
	,'.'						AS customer_name
	,0							AS salesorder_num
	,'AA'						AS order_type
	,'.'						AS item_id
	,'Payroll - Balance'		AS details
	,m.EndDt					AS transaction_date
	,0.0						AS transaction_amt
	,0.0						AS gp_ext_amt 
	,0.0						AS file_cost_amt
	-- balance
	,[deficit_amt]				AS [fsc_comm_amt]
	-- inferred good:  only goods accounts selected via filter
	,0							AS [status_code]
	,'PAY'						AS [source_cd]
	,'ACT'						AS adj_type_code
	,'.'						AS [cust_comm_group_cd]
	,'.'						AS [item_comm_group_cd]
	,'GP'						AS gp_code
	,0.0						AS [ma_estimate_factor]
	,RTRIM([comm_plan_id])+' | '+[master_salesperson_cd]			AS [comm_note_txt]

	,IIF(LEFT([comm_plan_id],3)='ISR', [master_salesperson_cd], '') AS [isr_code]
	,IIF(LEFT([comm_plan_id],3)='ISR', 'STMPBA', '')				AS [isr_comm_group_cd]
	,IIF(LEFT([comm_plan_id],3)='ISR', salesperson_key_id, '')		AS [isr_salesperson_key_id]

	,IIF(LEFT([comm_plan_id],3)='EPS', [master_salesperson_cd], '') AS [eps_code]
	,IIF(LEFT([comm_plan_id],3)='EPS', 'STMPBA', '')				AS [eps_comm_group_cd]
	,IIF(LEFT([comm_plan_id],3)='EPS', salesperson_key_id, '')		AS [eps_salesperson_key_id]

	,IIF(LEFT([comm_plan_id],3)='EST', [master_salesperson_cd], '') AS [est_code]
	,IIF(LEFT([comm_plan_id],3)='EST', 'STMPBA', '')				AS [est_comm_group_cd]
	,IIF(LEFT([comm_plan_id],3)='EST', salesperson_key_id, '')		AS [est_salesperson_key_id]

	,IIF(LEFT([comm_plan_id],3)='CPS', [master_salesperson_cd], '') AS [cps_code]
	,IIF(LEFT([comm_plan_id],3)='CPS', 'STMPBA', '')				AS [cps_comm_group_cd]
	,IIF(LEFT([comm_plan_id],3)='CPS', salesperson_key_id, '')		AS [cps_salesperson_key_id]

 FROM 
	[comm].[salesperson_master] s

	INNER JOIN [dbo].[BRS_FiscalMonth] m
	ON m.FiscalMonth = s.FiscalMonth

 WHERE 
	s.FiscalMonth = (SELECT [PriorFiscalMonth] FROM [dbo].[BRS_Config])

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




