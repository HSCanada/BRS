
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
**	16 Sep 18	tmc		add fsc territory for branch split
**    
*******************************************************************************/

SELECT        
	t.ID											AS FactKey
	,t.FiscalMonth									AS FiscalMonth	
	,fsc.salesperson_master_key						AS FSC_SalespersonKey
	,fsc_code.[FscKey]								AS FSC_SalespersonCodeKey
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

	-- tbd
	,t.FreeGoodsInvoicedInd							AS FreeGoodsInvoicedInd
	,t.FreeGoodsEstInd								AS FreeGoodsEstInd
	,t.FreeGoodsRedeemedInd							AS FreeGoodsRedeemedInd

	,(t.[WSSOQS_quantity_shipped])					AS Quantity
	,(t.[transaction_amt])							AS SalesAmt
	,(t.[gp_ext_amt])								AS GPAmt
	,(t.[fsc_comm_amt])								AS FSC_CommAmt
	,(t.[ess_comm_amt])								AS ESS_CommAmt

	,(t.source_cd)

	-- Lookup fields for Salesorder dimension
	,ISNULL(hdr.IDMin,0)							AS FactKeyFirst
	,ISNULL([WSDCTO_order_type], '')				AS DocType
	,ISNULL([WS$OSC_order_source_code], '')			AS OrderSourceCode
	,ISNULL([WSENTB_entered_by], '') 				AS EnteredBy
	,ISNULL([WSTKBY_order_taken_by], '')			AS OrderTakenBy
	,ISNULL([WS$PMC_promotion_code_price_method], '') AS PriceMethod
	,ISNULL([WSVR01_reference], '')					AS CustomerPOText1
	,ISNULL([WSORD__equipment_order], '')			AS EquipmentOrderNumber


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

	INNER JOIN [dbo].[BRS_FSC_Rollup] as fsc_code
	ON fsc_code.[TerritoryCd] = t.fsc_code

	-- identify first sales order (for sales order dimension)
	LEFT JOIN 
	(
		SELECT
			h.[WSDOCO_salesorder_number], 
			MIN(h.ID) AS IDMin
		FROM
			[comm].[transaction_F555115] AS h 
		WHERE ((h.[WSDOCO_salesorder_number] > 0) AND h.source_cd = 'JDE')

		GROUP BY h.[WSDOCO_salesorder_number]
	) AS hdr
	ON t.[WSDOCO_salesorder_number] = hdr.[WSDOCO_salesorder_number]


WHERE        
	(EXISTS (SELECT * FROM [Dimension].[Period] dd WHERE t.FiscalMonth = dd.FiscalMonth)) AND

	-- test

	(1 = 1)

GO

-- SELECT top 10 * FROM Fact.Commission 
/*
SELECT 
TOP 10 
* 
FROM Fact.Commission
WHERE [FiscalMonth] = 201710 and source_cd <>'JDE'
*/

-- SELECT count(*) FROM Fact.[Commission] 
-- org 5 377 237, 10s

-- select distinct FSC_SalespersonCodeKey from Fact.Commission 
