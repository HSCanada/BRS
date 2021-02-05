
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [comm].[customer_rebate_export]
AS

/******************************************************************************
**	File: 
**	Name: [comm].[customer_rebate_export]
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
*******************************************************************************/

-- rebate merch
SELECT
	[ID]*2-1					AS ID
	,s.[FiscalMonth]
	,'BR'						AS owner_code
	,([original_line_number]*2-1) AS [original_line_number]

	,[fsc_code]
	,'REBSND'					AS [fsc_comm_group_cd]
	,[fsc_salesperson_key_id]

	,'.'						AS [ess_code]
	,'.'						AS [ess_comm_group_cd]
	,'.'						AS [ess_salesperson_key_id]

	,[ShipTo]
	,[PracticeName]				AS customer_name
	,0							AS salesorder_num
	,'AA'						AS order_type
	,'.'						AS item_id
	,'Rebate - Merchandise'		AS details
	,m.EndDt					AS transaction_date
	,-1.0 * [rebate_amt] * (1-[teeth_share_rt]) as transaction_amt
	,-1.0 * [rebate_amt] * (1-[teeth_share_rt]) as gp_ext_amt 
	,0.0						AS file_cost_amt
	,0.0						AS fsc_comm_amt
	,[status_code]
	,'IMP'						AS [source_cd]
	,[SourceCode]				AS adj_type_code

	,[fsc_comm_group_cd]		AS [cust_comm_group_cd]
	,'.'						AS [item_comm_group_cd]

	,'GP'						AS gp_code
	,[teeth_share_rt]			AS [ma_estimate_factor]
	,[comm_note_txt]

	,[isr_code]
	,[isr_comm_group_cd]
	,[isr_salesperson_key_id]

 FROM 
	[comm].[customer_rebate] s

	INNER JOIN [dbo].[BRS_FiscalMonth] m
	ON m.FiscalMonth = s.FiscalMonth

 WHERE 
	s.FiscalMonth = (SELECT [PriorFiscalMonth] FROM [dbo].[BRS_Config]) 
	


UNION ALL

-- rebate teeth
SELECT
	[ID]*2						AS ID
	,s.[FiscalMonth]
	,'BR'						AS owner_code
	,([original_line_number]* 2) AS line_number

	,[fsc_code]
	,'REBTEE'					AS [fsc_comm_group_cd]
	,[fsc_salesperson_key_id]

	,'.'						AS [ess_code]
	,'.'						AS [ess_comm_group_cd]
	,'.'						AS [ess_salesperson_key_id]

	,[ShipTo]
	,[PracticeName]				AS customer_name
	,0							AS salesorder_num
	,'AA'						AS order_type
	,'.'						AS item_id
	,'Rebate - Teeth'			AS details
	,m.EndDt					AS transaction_date
	,-1.0 * [rebate_amt] * ([teeth_share_rt]) as transaction_amt
	,-1.0 * [rebate_amt] * ([teeth_share_rt]) as gp_ext_amt
	,0.0						AS file_cost_amt
	,0.0						AS fsc_comm_amt
	,[status_code]
	,'IMP'						AS [source_cd]
	,[SourceCode]				AS adj_type_code

	,[fsc_comm_group_cd]		AS [cust_comm_group_cd]
	,'.'						AS [item_comm_group_cd]

	,'GP'						AS gp_code
	,[teeth_share_rt]			AS [ma_estimate_factor]
	,[comm_note_txt]

	,[isr_code]
	,[isr_comm_group_cd]
	,[isr_salesperson_key_id]

 FROM 
	[comm].[customer_rebate] s

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

-- SELECT  top 10 * FROM [comm].[customer_rebate_export] order by ID

-- SELECT  * FROM [comm].[customer_rebate_export]  order by transaction_amt asc         



