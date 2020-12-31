
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [comm].[adjustment_export]
AS

/******************************************************************************
**	File: 
**	Name: [comm].[adjustment_export]
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

SELECT
	[FiscalMonth]
	,[WSVR01_reference]			AS owner_code
	,[WSOGNO_original_line_number] AS [original_line_number]	
	,ISNULL(NULLIF([fsc_code],'.'),'') AS fsc_code
	,ISNULL(NULLIF([ess_code],'.'),'') AS ess_code
	,[WSSHAN_shipto]			AS [ShipTo]
	,LEFT([WSVR02_reference_2],25)	AS customer_name
	,[WSDOC__document_number]	AS salesorder_num
	,ISNULL(NULLIF([WSLITM_item_number],'.'),'') AS item_id
	,LEFT([WSDSC1_description],30)	AS details
	,WSDGL__gl_date				AS transaction_date
	,[transaction_amt] 
	,[WSSRP6_manufacturer]		AS adj_type_code
	,[fsc_comm_group_cd]
	,[ess_comm_group_cd]
	-- calc
	,CASE [gp_code]
		WHEN 'GP' THEN [gp_ext_amt]
		WHEN 'CC' THEN ([transaction_amt] -[WS$UNC_sales_order_cost_markup])
		WHEN 'CF' THEN ([transaction_amt] -[WS$UNC_sales_order_cost_markup] * [ma_estimate_factor])
		-- error
		ELSE NULL
	END							AS gp_ext_amt
	,[fsc_comm_amt]
	,[WS$UNC_sales_order_cost_markup]			AS file_cost_amt
	,[WSDCTO_order_type]		AS order_type
	--
	,[ID]
	,[cust_comm_group_cd]
	,[item_comm_group_cd]
	,[gp_code]
	,[ma_estimate_factor]
	,[source_cd]
	,[comm_note_txt]

	,[isr_code]
	,[isr_comm_group_cd]
	,[eps_code]
	,[eps_comm_group_cd]
	,[est_code]
	,[est_comm_group_cd]
	,[cps_code]
	,[cps_comm_group_cd]
	,[WSDOCO_salesorder_number]
	,[status_code]
 FROM 
	[Integration].[comm_adjustment_Staging] 
 WHERE 
	FiscalMonth = (SELECT [PriorFiscalMonth] FROM [dbo].[BRS_Config])


GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/*
print 'integrity checks (s/b 0):'
SELECT  * FROM [comm].[adjustment_export] where [gp_ext_amt] is null
*/

-- test details
--SELECT  top 10      * FROM [comm].[adjustment_export]
--SELECT  * FROM [comm].[adjustment_export]  order by transaction_amt asc         



