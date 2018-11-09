SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [Fact].Sales_isr
	@bDebug as smallint = 1
AS

/******************************************************************************
**	File: 
**	Name: [Fact].Sales_isr
**	Desc: Telesales Sales pull  
**
**              
**	Return values:  @@Error
**
**	Called by:   
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**	@bDebug
**
**	Auth: tmc
**	Date: 11 Oct 16
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
--	07 Nov 16	tmc		Added additional metrics
--  08 Nov 16	tmc		Clarified Tag coding Y/N -> TS_TAG / NO
--	29 Dec 16	tmc		Add MTD Logic
--	05 Feb 17	tmc		Changed from goods logic from Est to Billed at zero
--	22 Feb 18	tmc		update to daily for consolidator
**    
*******************************************************************************/

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SET NOCOUNT ON

	if (@bDebug <> 0)
		SET NOCOUNT OFF;

	if (@bDebug <> 0)
		Print 'BRS_TS_Cube_proc - DEBUG MODE.'

	--Get Params
	 
	--Pull Cube based on Params

	SELECT     
		t.ID							AS FactKey
		,CAST(d.SalesDate as date)		AS SalesDate
--		,d.FiscalMonth
		,t.Shipto
		,i.ItemKey						AS ItemKey

		,t.[SalesOrderNumber]			AS SalesOrderNumber
		,t.[LineNumber]					AS LineNumber
		,ISNULL(isr_emp.[EmployeeKey], 1) AS IsrEmployeeKey
		,src.OrderSourceCodeKey
		,dtype.DocTypeKey

		,CASE 
			WHEN (t2.TsTerritoryCd) = '' 
			THEN 0 
			ELSE 1
		END								AS TsTagInd

		,CASE 
			WHEN 
				t.Item = hdr.Item And 
				t.Shipto = hdr.Shipto AND
				t.Date = hdr.LastSalesDate
			THEN 1
			ELSE 0
		END								AS LastOrderInd

		,t.[ShippedQty]					AS Quantity
		,t.NetSalesAmt					AS SalesAmt
		,t.GPAtCommCostAmt				AS GPcommAmt


	FROM         
		dbo.BRS_TransactionDW AS t 

		INNER JOIN [dbo].[BRS_Item] AS i
		on t.item = i.item	

		INNER JOIN [dbo].[BRS_Customer] as c
		on t.Shipto = c.ShipTo

		INNER JOIN [dbo].[BRS_FSC_Rollup] isr
		ON c.TsTerritoryCd = isr.TerritoryCd
		
		LEFT JOIN [dbo].[BRS_Employee] isr_emp
		ON isr.FSCRollup = isr_emp.IsrRollupCd 

		INNER JOIN BRS_SalesDay AS d 
		ON d.SalesDate = t.Date 

	    INNER JOIN BRS_TransactionDW_Ext AS t2 
		ON t.SalesOrderNumber = t2.SalesOrderNumber AND 
			t.DocType = t2.DocType 

		INNER JOIN [dbo].[BRS_DocType] AS dtype
		ON t.DocType = dtype.DocType

		INNER JOIN [dbo].[BRS_OrderSource] as src
		ON t.OrderSourceCode = src.OrderSourceCode

		-- identify last customer / item order
		LEFT JOIN 
		(
			SELECT
				tlast.shipto,
				tlast.item,
				Max(tlast.Date) AS LastSalesDate
			FROM
				dbo.BRS_TransactionDW AS tlast 
			WHERE     
				-- ensure sub-range and full match
				(tlast.FreeGoodsInvoicedInd = 0) AND
				(EXISTS 
					(SELECT * FROM [Dimension].[Day] dd2 
					WHERE tlast.Date = dd2.SalesDate)
				) AND
				(1=1)
			GROUP BY 
				tlast.[Shipto],
				tlast.Item
		) AS hdr
		ON t.Shipto = hdr.Shipto AND
			t.Item= hdr.Item

	WHERE     
		(t.FreeGoodsInvoicedInd = 0) AND
		(EXISTS (SELECT * FROM [Dimension].[Day] dd WHERE t.Date = dd.SalesDate)) AND
--		(d.FiscalMonth = 201802 ) AND 
		(1=1)

END

GO

--	Select FiscalMonth, PriorFiscalMonth, FirstFiscalMonth_LY, SalesDateLastWeekly FROM BRS_TS_Config g


-- Prod
-- [Fact].Sales_isr 0

-- Debug
-- [Fact].Sales_isr
