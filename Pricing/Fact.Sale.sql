
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Fact].[Sale]
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
**	Date: 14 Jun 17
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

SELECT        
	t.ID											AS FactKey
	,fsc.FscKey
	,fsa.FsaKey
	,d.FiscalMonth									AS FiscalMonth	
	,t.Date											AS DateKey
	,t.SalesOrderNumber
	,t.LineNumber
	,dt.DocTypeKey
	,t.Shipto										AS ShipTo
	,c.BillTo
	,cg.CustGrpKey									AS CustomerGroupKey
	,vpa.VpaKey										AS SalesplanKey
	,i.ItemKey										AS ItemKey
	,s.SupplierKey
	,os.OrderSourceCodeKey
	,pm.PriceMethodKey
	,prom.PromotionId								AS PromotionKey
	,t.FreeGoodsInvoicedInd
	-- TBD !!
	,0												AS PriceAdjustmentKey

	,(t.ShippedQty)									AS Quantity
	,(t.NetSalesAmt)								AS SalesAmt
	,(GPAmt + ISNULL(t.ExtChargebackAmt,0))			AS GPAmt
	,(t.GPAtFileCostAmt)							AS GPAtFileCostAmt
	,(t.GPAtCommCostAmt)							AS GPAtCommCostAmt
	,(t.ExtChargebackAmt)							AS ExtChargebackAmt

	,(t.ExtListPrice  + t.ExtPrice -  NetSalesAmt)  AS ExtBaseAmt
	,(t.ExtListPrice  + t.ExtPrice -2*NetSalesAmt)  AS DiscountAmt
	,(t.ExtListPrice  + 0          -  NetSalesAmt)  AS DiscountLineAmt
	,(0               + t.ExtPrice -  NetSalesAmt)  AS DiscountOrderAmt


FROM            
	BRS_TransactionDW AS t 

	INNER JOIN BRS_SalesDay AS d 
	ON d.SalesDate = t.Date 

	INNER JOIN BRS_Item AS i 
	ON i.Item = t.Item 

	INNER JOIN BRS_ItemSupplier as s
	ON s.Supplier = i.Supplier

	INNER JOIN BRS_Customer AS c 
	ON t.Shipto = c.ShipTo 

	INNER JOIN BRS_DocType AS dt 
	ON t.DocType = dt.DocType 

	INNER JOIN BRS_FSC_Rollup AS fsc 
	ON c.TerritoryCd = fsc.TerritoryCd 

	INNER JOIN BRS_OrderSource AS os 
	ON t.OrderSourceCode = os.OrderSourceCode 

	INNER JOIN BRS_PriceMethod AS pm 
	ON t.PriceMethod = pm.PriceMethod 

	INNER JOIN BRS_Promotion AS prom 
	ON t.PromotionCode = prom.PromotionCode 
		AND t.OrderPromotionCode = prom.PromotionCode 
	
	INNER JOIN BRS_CustomerGroup AS cg 
	ON c.CustGrpWrk = cg.CustGrp 

	INNER JOIN BRS_Customer_FSA AS fsa 
	ON c.FSA = fsa.FSA 

	INNER JOIN BRS_CustomerVPA AS vpa 
	ON c.VPA = vpa.VPA


WHERE        
	(NOT (t.OrderSourceCode IN ('A', 'L'))) AND 
	-- temp
	(EXISTS (SELECT * FROM [Dimension].[Date] dd WHERE d.FiscalMonth = dd.FiscalMonth)) AND
--	(d.FiscalMonth BETWEEN 201501 AND 201707) AND 
	(1 = 1)

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- SELECT top 10 * FROM Fact.Sale

-- SELECT count(*) FROM Fact.Sale 
-- ORG 5846557 lines, 2 s 
-- NEW 5846557 lines, 3 s

