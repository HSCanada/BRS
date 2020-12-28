
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [comm].[freegoods_export]
AS

/******************************************************************************
**	File: 
**	Name: [comm].[freeoods_export]
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
-- keep at lowest level
SELECT
	[FiscalMonth]
	,'BR'			AS owner_code
	,[original_line_number] AS [original_line_number]	
	,ISNULL(NULLIF([fsc_code],'.'),'') AS fsc_code
	,ISNULL(NULLIF([ess_code],'.'),'') AS ess_code
	,[ShipTo]			AS [ShipTo]
	,LEFT([PracticeName],25)	AS customer_name
	,[SalesOrderNumber]	AS salesorder_num
	,[Item] AS item_id
	,LEFT([ItemDescription],30)	AS details
	,0							AS [transaction_amt] 
	,[SourceCode]				AS adj_type_code
	,[fg_fsc_comm_group_cd]
	,[fg_ess_comm_group_cd]
	-- calc
	,(-[ExtFileCostCadAmt])		AS gp_ext_amt
/*
	,CASE [gp_code]
		WHEN 'CC' THEN (-[ExtFileCostCadAmt])
		WHEN 'CF' THEN (-[ExtFileCostCadAmt] * [ma_estimate_factor])
		-- error
		ELSE NULL
	END							AS gp_ext_amt
*/

	,0							AS [fsc_comm_amt]
	,[ExtFileCostCadAmt]			AS file_cost_amt
	,[DocType]		AS order_type
	--
	,[ID]
	,[cust_comm_group_cd]
	,[item_comm_group_cd]
	,[ma_estimate_factor]
	,[comm_note_txt]

	,[fsc_comm_group_cd]
	,[ess_comm_group_cd]
	,[isr_code]
	,[isr_comm_group_cd]
	,[fg_isr_comm_group_cd]
	,[eps_code]
	,[eps_comm_group_cd]
	,[fg_eps_comm_group_cd]

	,[status_code]
 FROM 
	[comm].[freegoods]
 WHERE 
	FiscalMonth = (SELECT [PriorFiscalMonth] FROM [dbo].[BRS_Config])


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



