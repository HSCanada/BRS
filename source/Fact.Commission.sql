
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
**  25 Sep 19	tmc		add cps & EPS salesperson and commission 
**	25 Nov 19	tmc		replace comm group with smart version (based on calc)
**    
*******************************************************************************/

SELECT        
	t.ID											AS FactKey
	,t.FiscalMonth									AS FiscalMonth	

	-- Note, default FSC = 2 is a magic number -- too late to fix...

	,ISNULL(fsc.salesperson_master_key, 2) 			AS FSC_SalespersonKey
	,ISNULL(fsc_code.[FscKey], 2) 					AS FSC_SalespersonCodeKey
	,ISNULL(fsc_grp_map.comm_group_key, 1) 			AS FSC_CommGroupKey

	,ISNULL(ess.salesperson_master_key, 2)			AS ESS_SalespersonKey
	,ISNULL(ess_grp_map.comm_group_key, 1)			AS ESS_CommGroupKey

	,ISNULL(cps.salesperson_master_key, 2)			AS CPS_SalespersonKey
	,ISNULL(cps_grp_map.comm_group_key, 1)			AS CPS_CommGroupKey

	,ISNULL(eps.salesperson_master_key, 2)			AS EPS_SalespersonKey
	,ISNULL(eps_grp_map.comm_group_key, 1)			AS EPS_CommGroupKey

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

	,ISNULL((t.[fsc_comm_amt]),0)					AS FSC_CommAmt
	,ISNULL((t.[ess_comm_amt]),0)					AS ESS_CommAmt
	,ISNULL((t.[cps_comm_amt]),0)					AS CPS_CommAmt
	,ISNULL((t.[eps_comm_amt]),0)					AS EPS_CommAmt


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

	-- Dim Customer
	LEFT JOIN [comm].[salesperson_master] as fsc
	ON fsc.salesperson_key_id = t.[fsc_salesperson_key_id]

	LEFT JOIN [dbo].[BRS_FSC_Rollup] as fsc_code
	ON fsc_code.[TerritoryCd] = t.fsc_code

	LEFT JOIN [comm].[salesperson_master] as ess
	ON ess.salesperson_key_id = t.[ess_salesperson_key_id]

	LEFT JOIN [comm].[salesperson_master] as cps
	ON cps.salesperson_key_id = t.[cps_salesperson_key_id]

	LEFT JOIN [comm].[salesperson_master] as eps
	ON eps.salesperson_key_id = t.[eps_salesperson_key_id]

	-- Dim Item

	-- fsc	
	LEFT JOIN [comm].[plan_group_rate] fc
	ON t.fsc_calc_key = fc.calc_key

	LEFT JOIN [comm].[group] as fsc_grp_map
	ON fsc_grp_map.comm_group_cd = fc.disp_comm_group_cd

	-- ess
	LEFT JOIN [comm].[plan_group_rate] ec
	ON t.ess_calc_key = ec.calc_key

	LEFT JOIN [comm].[group] as ess_grp_map
	ON ess_grp_map.comm_group_cd = ec.disp_comm_group_cd

	-- cps
	LEFT JOIN [comm].[plan_group_rate] cc
	ON t.cps_calc_key = cc.calc_key

	LEFT JOIN [comm].[group] as cps_grp_map
	ON cps_grp_map.comm_group_cd = cc.disp_comm_group_cd

	-- eps
	LEFT JOIN [comm].[plan_group_rate] pc
	ON t.eps_calc_key = pc.calc_key

	LEFT JOIN [comm].[group] as eps_grp_map
	ON eps_grp_map.comm_group_cd = pc.disp_comm_group_cd


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

-- SELECT * FROM Fact.Commission where FiscalMonth = 201812
/*
SELECT 
TOP 10 
* 
FROM Fact.Commission
WHERE [FiscalMonth] = 201910 and source_cd ='JDE' and ESS_salespersonKey <> 2
*/

-- SELECT count(*) FROM Fact.[Commission] where [FiscalMonth] = 201812
-- ORG 208 627, 2s


-- select distinct FSC_SalespersonCodeKey from Fact.Commission 

SELECT
	top 10

	FactKey,
	FiscalMonth,

	FSC_SalespersonKey,
	FSC_SalespersonCodeKey,
	FSC_CommGroupKey,

	ESS_SalespersonKey,
	ESS_CommGroupKey,

	CPS_SalespersonKey,
	CPS_CommGroupKey,

	EPS_SalespersonKey,
	EPS_CommGroupKey,

	ShipTo,
	ItemKey,
	SalesOrderNumber,
	DocTypeKey,
	LineNumber,
	DateKey,
	BillTo,
	SourceKey,
	FreeGoodsInvoicedInd,
	FreeGoodsEstInd,
	FreeGoodsRedeemedInd,

	Quantity,
	SalesAmt,
	GPAmt,
	FSC_CommAmt,
	ESS_CommAmt,
	EPS_CommAmt,
	CPS_CommAmt

FROM
	Fact.Commission
