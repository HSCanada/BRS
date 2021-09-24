﻿
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [msg].[Transaction]
AS

/******************************************************************************
**	File: 
**	Name: 
**	Desc: based on Fact.Sales_qt 
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
**	Date: 28 Jul 21
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

SELECT
	t.SalesOrderNumber
	,t.[DocType]
	,t.LineNumber
	,t.OriginalSalesOrderNumber
	,t.OriginalOrderLineNumber
	,d.FiscalMonth									AS FISCAL_MONTH	
	,CAST(t.[OrderFirstShipDate] AS date)			AS ORDER_DATE
	,CAST(t.Date AS date)							AS POSTED_DATE

	,c.CUST_NUMBER
	,i.ITEM_NUMBER
	
	,(t.ShippedQty)									AS QUANTITY
	,(t.NetSalesAmt)								AS SALES
	,(t.GPAtCommCostAmt)							AS GPAtCommCostAmt

	,t.FreeGoodsInvoicedInd
	,t.ID											AS AuditKey

	,t.[OrderSourceCode]
	,t.[EnteredBy]
	,t.[OrderTakenBy]

FROM            
	BRS_TransactionDW AS t 

	INNER JOIN BRS_SalesDay AS d 
	ON d.SalesDate = t.Date 

	INNER JOIN msg.item AS i 
	ON t.Item  = i.ITEM_NUMBER 

	INNER JOIN msg.customer AS c 
	ON t.Shipto = c.CUST_NUMBER 

	INNER JOIN [dbo].[BRS_BusinessUnit] bu
	ON t.GLBusinessUnit = bu.BusinessUnit

WHERE  
	(bu.hs_branded_baseline_ind = 1) AND
	-- test
	--	(t.CalMonth = 202107) AND
	--	(d.FiscalMonth = 202106) AND
	-- test
	(1 = 1)

GO

-- SELECT top 10 * FROM msg.[Transaction] where FISCAL_MONTH = 202106
-- SELECT count (*) FROM msg.[Transaction] 
--1708 @ 1m27s

-- export tab delimited

-- 1. export item
-- 20210917_camsg_Item.txt
-- select  * from msg.item 	

-- 2. export customer
-- 20210917_camsg_Customer.txt
-- SELECT * FROM msg.Customer

-- 3. export sales
-- 20210917_camsg_Transaction.txt
-- SELECT * FROM msg.[Transaction] where FISCAL_MONTH between 202109 and 202109 AND POSTED_DATE <= '2021-09-17' ORDER BY POSTED_DATE



