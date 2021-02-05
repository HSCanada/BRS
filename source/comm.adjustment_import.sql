
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [comm].[adjustment_import]
AS

/******************************************************************************
**	File: 
**	Name: [comm].[adjustment_import]
**	Desc: import hub format, based on adjustment_export
**			ensure that formate matches export and view is updateable
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
**	Date: 31 Jan 21
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

SELECT
	[FiscalMonth]
	,[WSVR01_reference]				AS owner_code
	,[WSOGNO_original_line_number]	AS [original_line_number]	

	,fsc_code
	,[fsc_comm_group_cd]
	,[fsc_salesperson_key_id]

	,[ess_code]
	,[ess_comm_group_cd]
	,[ess_salesperson_key_id]

	,[WSSHAN_shipto]				AS [ShipTo]
	,[WSVR02_reference_2]			AS customer_name
	,[WSDOC__document_number]		AS salesorder_num

	,[WSDCTO_order_type]			AS order_type

	,[WSLITM_item_number]			AS item_id
	,[WSDSC1_description]			AS details
	,WSDGL__gl_date					AS transaction_date
	,[transaction_amt] 
	,gp_ext_amt
	,[WS$UNC_sales_order_cost_markup]	AS file_cost_amt
	,[fsc_comm_amt]
	,[status_code]
	,[source_cd]
	,[WSSRP6_manufacturer]			AS adj_type_code
	,[cust_comm_group_cd]
	,[item_comm_group_cd]			AS [item_comm_group_cd]
	,[gp_code]
	,[ma_estimate_factor]
	,[comm_note_txt]

	,[isr_code]
	,[isr_comm_group_cd]			AS [isr_comm_group_cd]
	,[isr_salesperson_key_id]

	,[eps_code]
	,[eps_comm_group_cd]			AS [eps_comm_group_cd]
	,[eps_salesperson_key_id]

	,[est_code]
	,[est_comm_group_cd]			AS [est_comm_group_cd]
	,[est_salesperson_key_id]

	,[cps_code]
	,[cps_comm_group_cd]			AS [cps_comm_group_cd]
	,[cps_salesperson_key_id]

	,[WSDOCO_salesorder_number]
	,[ID_legacy]
	,[ID]

--	,ISNULL(NULLIF([fsc_code],'.'),'') AS fsc_code

 FROM 
	[Integration].[comm_adjustment_Staging] 

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- test details
-- SELECT  top 10      * FROM [comm].[adjustment_import]




