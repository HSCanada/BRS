
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Fact].[Commission]
AS

/******************************************************************************
**	File: 
**	Name: Sale
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
**	Date: 7 Dec 17
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

SELECT        
	t.ID											AS FactKey
	,t.FiscalMonth									AS FiscalMonth	
	,fsc.salesperson_master_key						AS FSC_SalespersonKey
	,fsc_grp.comm_group_key							AS FSC_CommGroupKey
	,ess.salesperson_master_key						AS ESS_SalespersonKey
	,ess_grp.comm_group_key							AS ESS_CommGroupKey


	,t.[WSSHAN_shipto]								AS ShipTo
	,i.ItemKey										AS ItemKey

	,t.[WSDOCO_salesorder_number]					AS SalesOrderNumber
	,doct.DocTypeKey								AS DocTypeKey
	,t.[WSLNID_line_number]							AS LineNumber

	,CAST(t.[WSDGL__gl_date] AS date)				AS DateKey
	,t.[WSAN8__billto]								AS BillTo
	,src.source_key									AS SourceKey

	,(t.[WSUORG_quantity])							AS Quantity
	,(t.[transaction_amt])							AS SalesAmt
	,(t.[gp_ext_amt])								AS GPAmt
	,(t.[fsc_comm_amt])								AS FSC_CommAmt
	,(t.[ess_comm_amt])								AS ESS_CommAmt

/*

[fsc_comm_group_cd]
[ess_comm_group_cd]


*/
FROM            
	[comm].[transaction_F555115] AS t 

	INNER JOIN BRS_SalesDay AS d 
	ON d.SalesDate = t.WSDGL__gl_date 

	INNER JOIN BRS_Item AS i 
	ON i.Item = t.[WSLITM_item_number]

	INNER JOIN [comm].[source] as src
	ON src.source_cd = t.source_cd

	INNER JOIN [dbo].[BRS_DocType] as doct
	ON doct.DocType = t.[WSDCTO_order_type]

	INNER JOIN [comm].[salesperson_master] as fsc
	ON fsc.salesperson_key_id = t.[fsc_salesperson_key_id]

	INNER JOIN [comm].[salesperson_master] as ess
	ON ess.salesperson_key_id = t.[ess_salesperson_key_id]

	INNER JOIN [comm].[group] as fsc_grp
	ON fsc_grp.comm_group_cd = t.[fsc_comm_group_cd]

	INNER JOIN [comm].[group] as ess_grp
	ON ess_grp.comm_group_cd = t.[ess_comm_group_cd]


WHERE        
	(EXISTS (SELECT * FROM [Dimension].[Period] dd WHERE t.FiscalMonth = dd.FiscalMonth)) AND

	-- test

	(1 = 1)

GO

-- SELECT top 10 * FROM Fact.Sale ORDER BY 1 

SELECT 
TOP 10 
* 
FROM Fact.Commission
WHERE [FiscalMonth] = 201710 


-- SELECT count(*) FROM Fact.[Commission] 
-- org 5 377 237, 10s

