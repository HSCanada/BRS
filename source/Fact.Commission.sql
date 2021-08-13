
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Fact].[Commission]
AS

/******************************************************************************
**	File: 
**	Name: Sales for Commission model
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
**	13 May 20	tmc		clarified calc_key->display_comm_group
**	01 Jul 20	tmc		add adjustments
**	22 Oct 20	tmc		add Inside Sales Rep (ISR)
**	21 Dec 20	tmc		add Equipment Service Tech (EST)
**	09 Jul 21	tmc		add HS Branded Baseline flag
**	09 Aug 21	tmc		disable HS Branded Baseline flag (set to 0)
**							Commisssion GLBU is not accurate at line level
**    
*******************************************************************************/

SELECT        
--	top 10

	t.ID											AS FactKey
	,t.FiscalMonth									AS FiscalMonth	

	-- Note, default FSC = 2 is a magic number -- too late to fix...
	--		also, the item calc groups are being remapped to 
	--			the commission group.  ERD @ gdocs

	,ISNULL(fsc.salesperson_master_key, 2) 			AS FSC_SalespersonKey
	,ISNULL(fsc_code.[FscKey], 2) 					AS FSC_SalespersonCodeKey
	,ISNULL(comm_group_fsc.comm_group_key, 1) 		AS FSC_CommGroupKey

	,ISNULL(isr.salesperson_master_key, 2) 			AS ISR_SalespersonKey
	,ISNULL(comm_group_isr.comm_group_key, 1) 		AS ISR_CommGroupKey

	,ISNULL(ess.salesperson_master_key, 2)			AS ESS_SalespersonKey
	,ISNULL(comm_group_ess.comm_group_key, 1)		AS ESS_CommGroupKey

	,ISNULL(cps.salesperson_master_key, 2)			AS CPS_SalespersonKey
	,ISNULL(comm_group_cps.comm_group_key, 1)		AS CPS_CommGroupKey

	,ISNULL(eps.salesperson_master_key, 2)			AS EPS_SalespersonKey
	,ISNULL(comm_group_eps.comm_group_key, 1)		AS EPS_CommGroupKey

	,ISNULL(est.salesperson_master_key, 2)			AS EST_SalespersonKey
	,ISNULL(comm_group_est.comm_group_key, 1)		AS EST_CommGroupKey

	,t.[WSSHAN_shipto]								AS ShipTo
	,i.ItemKey										AS ItemKey
	,t.[WSDOCO_salesorder_number]					AS SalesOrderNumber
	,doct.DocTypeKey								AS DocTypeKey
	,t.[WSLNID_line_number]							AS LineNumber
	,CAST(t.[WSDGL__gl_date] AS date)				AS DateKey
	,t.[WSAN8__billto]								AS BillTo
	,src.source_key									AS SourceKey
	,ISNULL(adj.adj_key,1)							AS AdjKey

	-- tbd
	,t.FreeGoodsInvoicedInd							AS FreeGoodsInvoicedInd
	,t.FreeGoodsEstInd								AS FreeGoodsEstInd
	,t.FreeGoodsRedeemedInd							AS FreeGoodsRedeemedInd

	,(t.[WSSOQS_quantity_shipped])					AS Quantity
	,(t.[transaction_amt])							AS SalesAmt
	,(t.[gp_ext_amt])								AS GPAmt

	,ISNULL((t.[fsc_comm_amt]),0)					AS FSC_CommAmt
	,ISNULL((t.[isr_comm_amt]),0)					AS ISR_CommAmt
	,ISNULL((t.[ess_comm_amt]),0)					AS ESS_CommAmt
	,ISNULL((t.[cps_comm_amt]),0)					AS CPS_CommAmt
	,ISNULL((t.[eps_comm_amt]),0)					AS EPS_CommAmt
	,ISNULL((t.[est_comm_amt]),0)					AS EST_CommAmt

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

	
	-- Disable this, as the Commisssion GLBU is not accurate at the line level, tmc, 9 Aug 21
	,0 AS hs_branded_baseline_ind
	-- ,bu.hs_branded_baseline_ind

	,WSEMCU_header_business_unit


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

	-- HSB baseline
	INNER JOIN [dbo].[BRS_BusinessUnit] as bu
	ON t.WSEMCU_header_business_unit = bu.BusinessUnit

	-- Dim Customer
	LEFT JOIN [comm].[salesperson_master] as fsc
	ON fsc.salesperson_key_id = t.[fsc_salesperson_key_id]

	LEFT JOIN [dbo].[BRS_FSC_Rollup] as fsc_code
	ON fsc_code.[TerritoryCd] = t.fsc_code

	LEFT JOIN [comm].[salesperson_master] as isr
	ON isr.salesperson_key_id = t.[isr_salesperson_key_id]

	LEFT JOIN [comm].[salesperson_master] as ess
	ON ess.salesperson_key_id = t.[ess_salesperson_key_id]

	LEFT JOIN [comm].[salesperson_master] as cps
	ON cps.salesperson_key_id = t.[cps_salesperson_key_id]

	LEFT JOIN [comm].[salesperson_master] as eps
	ON eps.salesperson_key_id = t.[eps_salesperson_key_id]

	LEFT JOIN [comm].[salesperson_master] as est
	ON est.salesperson_key_id = t.[est_salesperson_key_id]

	-- Dim Item

	-- fsc	
	LEFT JOIN [comm].[plan_group_rate] plan_group_rate_fsc
	ON t.fsc_calc_key = plan_group_rate_fsc.calc_key

	LEFT JOIN [comm].[group] as comm_group_fsc
	ON comm_group_fsc.comm_group_cd = plan_group_rate_fsc.disp_comm_group_cd

	-- isr
	LEFT JOIN [comm].[plan_group_rate] plan_group_rate_isr
	ON t.isr_calc_key = plan_group_rate_isr.calc_key

	LEFT JOIN [comm].[group] as comm_group_isr
	ON comm_group_isr.comm_group_cd = plan_group_rate_isr.disp_comm_group_cd

	-- ess
	LEFT JOIN [comm].[plan_group_rate] plan_group_rate_ess
	ON t.ess_calc_key = plan_group_rate_ess.calc_key

	LEFT JOIN [comm].[group] as comm_group_ess
	ON comm_group_ess.comm_group_cd = plan_group_rate_ess.disp_comm_group_cd

	-- cps
	LEFT JOIN [comm].[plan_group_rate] plan_group_rate_cps
	ON t.cps_calc_key = plan_group_rate_cps.calc_key

	LEFT JOIN [comm].[group] as comm_group_cps
	ON comm_group_cps.comm_group_cd = plan_group_rate_cps.disp_comm_group_cd

	-- eps
	LEFT JOIN [comm].[plan_group_rate] plan_group_rate_eps
	ON t.eps_calc_key = plan_group_rate_eps.calc_key

	LEFT JOIN [comm].[group] as comm_group_eps
	ON comm_group_eps.comm_group_cd = plan_group_rate_eps.disp_comm_group_cd

	-- est
	LEFT JOIN [comm].[plan_group_rate] plan_group_rate_est
	ON t.est_calc_key = plan_group_rate_est.calc_key

	LEFT JOIN [comm].[group] as comm_group_est
	ON comm_group_est.comm_group_cd = plan_group_rate_est.disp_comm_group_cd

	-- adjustment
	LEFT JOIN [comm].[adjustment] as adj
	ON (adj.[adj_comment_org] = ISNULL(t.[WSDSC1_description],'')) AND
		(adj.[adj_source_org] = UPPER(ISNULL(t.[WSVR01_reference],'')))

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

-- SELECT top 10 * FROM Fact.Commission where adjKey is null
-- SELECT top 10 * FROM Fact.Commission where hs_branded_baseline_ind = 0
-- SELECT * FROM Fact.Commission where SalesOrderNumber = 1131213

-- 30s

-- SELECT * FROM Fact.Commission where FiscalMonth = 201901

