
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
**    
*******************************************************************************/

-- rebate merch
SELECT
	[FiscalMonth]
	,'BR'						AS owner_code
	,[original_line_number]	
	,[fsc_code]
	,''							AS ess_code
	,[ShipTo]
	,[PracticeName]				AS customer_name
	,0							AS salesorder_num
	,''							AS item_id
	,'Rebate - Merchandise'		AS details
	,-1.0 * [rebate_amt] * (1-[teeth_share_rt]) as transaction_amt
	,'REB'						AS adj_type_code
	,'REBSND'					AS comm_group
	,'GP'						AS gp_code
	,-1.0 * [rebate_amt] * (1-[teeth_share_rt]) as gp_ext_amt 
	,0.0						AS file_cost_amt
	,[ID]
	,[SourceCode]				AS [source_cd]
	,[comm_note_txt]
	,[fsc_salesperson_key_id]
	,[fsc_comm_group_cd]
	,[isr_salesperson_key_id]
	,[isr_comm_group_cd]
	,[isr_code]
	,[teeth_share_rt]
	,[status_code]
 FROM 
	[comm].[customer_rebate] s
 WHERE 
	FiscalMonth = (SELECT [PriorFiscalMonth] FROM [dbo].[BRS_Config])

UNION ALL

-- rebate teeth
SELECT
	[FiscalMonth]
	,'BR'						AS owner_code
	,[original_line_number]	
	,[fsc_code]
	,''							AS ess_code
	,[ShipTo]
	,[PracticeName]				AS customer_name
	,0							AS salesorder_num
	,''							AS item_id
	,'Rebate - Teeth'			AS details
	,-1.0 * [rebate_amt] * ([teeth_share_rt]) as transaction_amt
	,'REB'						AS adj_type_code
	,'REBTEE'					AS comm_group
	,'GP'						AS gp_code
	,-1.0 * [rebate_amt] * ([teeth_share_rt]) as gp_ext_amt
	,0.0						AS file_cost_amt
	,[ID]
	,[SourceCode]				AS [source_cd]
	,[comm_note_txt]
	,[fsc_salesperson_key_id]
	,[fsc_comm_group_cd]
	,[isr_salesperson_key_id]
	,[isr_comm_group_cd]
	,[isr_code]
	,[teeth_share_rt]
	,[status_code]
 FROM 
	[comm].[customer_rebate] s
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
-- SELECT  top 10      * FROM [comm].[customer_rebate_export]           where [ShipTo] = 3906546
-- SELECT  * FROM [comm].[customer_rebate_export]  order by transaction_amt asc         



