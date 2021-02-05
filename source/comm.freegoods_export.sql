
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [comm].[freegoods_export]
AS

/******************************************************************************
**	File: 
**	Name: [comm].[freegoods_export]
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
-- keep at lowest level
SELECT
	[ID]
	,s.[FiscalMonth]
	,'BR'			AS owner_code
	,[original_line_number] AS [original_line_number]	
	,fsc_code
	,fg_fsc_comm_group_cd		AS [fsc_comm_group_cd]
	,[fsc_salesperson_key_id]

	,ess_code
	,fg_ess_comm_group_cd		AS [ess_comm_group_cd]
	,[ess_salesperson_key_id]

	,[ShipTo]					AS [ShipTo]
	,LEFT([PracticeName],25)	AS customer_name
	,[SalesOrderNumber]			AS salesorder_num
	,[DocType]					AS order_type

	,[Item]						AS item_id
	,LEFT([ItemDescription],30)	AS details
	,m.EndDt					AS transaction_date
	,0							AS [transaction_amt] 
	-- new GP method (use CommCost for GP), effective Jan 2021, assume GP +ive
	,([ExtFileCostCadAmt] * [ma_estimate_factor]) AS gp_ext_amt
	-- legacy GP method (use File Cost CAD)
	-- ,([ExtFileCostCadAmt])		AS gp_ext_amtOLD

	,[ExtFileCostCadAmt]		AS file_cost_amt
	,0.0						AS fsc_comm_amt
	--
	,[status_code]
	,'IMP'						AS [source_cd]
	,[SourceCode]				AS adj_type_code
	,[cust_comm_group_cd]
	,[item_comm_group_cd]
	,'GP'						AS gp_code
	,[ma_estimate_factor]
	,[comm_note_txt]

	,[isr_code]
	,[fg_isr_comm_group_cd]		AS [isr_comm_group_cd]
	,[isr_salesperson_key_id]

	,[eps_code]
	,[fg_eps_comm_group_cd]		AS [eps_comm_group_cd]
	,[eps_salesperson_key_id]

 FROM 
	[comm].[freegoods] s

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
SELECT  * FROM  [comm].[freegoods_export] where status_code <> 0
*/

-- test details
--SELECT  top 10      * FROM [comm].[freegoods_export]
--SELECT  * FROM [comm].[freegoods_export]  order by transaction_amt asc         



