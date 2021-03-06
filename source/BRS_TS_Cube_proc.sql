USE [BRSales]
GO
/****** Object:  StoredProcedure [dbo].[BRS_TS_Cube_proc]    Script Date: 21/02/22 6:52:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[BRS_TS_Cube_proc] 
	@bDebug as smallint = 1
AS

/******************************************************************************
**	File: 
**	Name: BRS_TS_Cube_proc
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
**	28 Apr 21	tmc		added covid correction to start at 2019
**    
*******************************************************************************/

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Declare @nFiscalMonth int, @nPriorFiscalMonth int, @nFirstFiscalMonth_LY int
	Declare @dtLastDay datetime


	SET NOCOUNT ON

	if (@bDebug <> 0)
		SET NOCOUNT OFF;

	if (@bDebug <> 0)
		Print 'BRS_TS_Cube_proc - DEBUG MODE.'

	--Get Params
	 
	Select
		@nFiscalMonth			= FiscalMonth,
		@nPriorFiscalMonth		= PriorFiscalMonth,
		-- add covid factor to pull 2019
		@nFirstFiscalMonth_LY	= FirstFiscalMonth_LY - 100,
		--
		@dtLastDay				= SalesDateLastWeekly
	FROM
		BRS_TS_Config g

	-- Select FiscalMonth,	PriorFiscalMonth, FirstFiscalMonth_LY, SalesDateLastWeekly FROM BRS_TS_Config

	--Pull Cube based on Params

	SELECT     
		-- comment out for model change (speed up calc with less data)
		--top 10
		--

		t.FiscalMonth, 
		t.SalesCategory, 
		CASE WHEN MIN(TAG_TsTerritoryCd) = '' THEN 'TS Not Tagged' ELSE 'TS Tagged' END AS TsTagInd,
		t.TAG_TsTerritoryCd TsTagTerritoryCd, 
		t.Shipto,
		
		ic.CategoryRollup,

		SUM(t.SalesAmt) AS SalesAmt, 
		SUM(t.GPAtCommCostAmt) AS GPcommAmt,
		SUM(t.ExtDiscAmt) AS ExtDiscAmt,

--	07 Nov 16	tmc		Added additional metrics
		SUM(t.GPAmt) AS ExtGPAmt,
		SUM(t.ExtChargebackAmt) AS ExtChargebackAmt

	FROM         
		BRS_AGG_CMI_DW_Sales AS t 

		INNER JOIN BRS_Item i
		ON t.Item = i.Item

		INNER JOIN BRS_ItemCategory ic
		ON i.MinorProductClass = ic.MinorProductClass


	WHERE     
		(t.FreeGoodsInvoicedInd = 0) AND
		(t.FiscalMonth BETWEEN @nFirstFiscalMonth_LY AND @nPriorFiscalMonth) AND 
--		(t.FiscalMonth BETWEEN 201801 AND 201801) AND 
		(1=1)

	GROUP BY 
		t.FiscalMonth, 
		t.SalesCategory, 
		t.TAG_TsTerritoryCd, 
		t.Shipto,
		ic.CategoryRollup

--	29 Dec 16	tmc		Add MTD Logic
	UNION ALL

	SELECT     

		-- comment out for model change (speed up calc with less data)
		--top 10
		--

		d.FiscalMonth, 
		i.SalesCategory, 
		CASE WHEN MIN(t2.TsTerritoryCd) = '' THEN 'TS Not Tagged' ELSE 'TS Tagged' END AS TsTagInd,
		t2.TsTerritoryCd TsTagTerritoryCd, 
		t.Shipto,
		
		ic.CategoryRollup,

		SUM(t.NetSalesAmt) AS SalesAmt, 
		SUM(t.GPAtCommCostAmt) AS GPcommAmt,
		SUM(t.ExtDiscAmt) AS ExtDiscAmt,

--	07 Nov 16	tmc		Added additional metrics
		SUM(t.GPAmt) AS ExtGPAmt,
		SUM(t.ExtChargebackAmt) AS ExtChargebackAmt

	FROM         
		dbo.BRS_TransactionDW AS t 

		INNER JOIN BRS_Item i
		ON t.Item = i.Item

		INNER JOIN BRS_ItemCategory ic
		ON i.MinorProductClass = ic.MinorProductClass

		INNER JOIN BRS_SalesDay AS d 
		ON d.SalesDate = t.Date 

	    INNER JOIN BRS_TransactionDW_Ext AS t2 
		ON t.SalesOrderNumber = t2.SalesOrderNumber AND 
			t.DocType = t2.DocType 


	WHERE     
		(t.FreeGoodsInvoicedInd = 0) AND
		(d.FiscalMonth = @nFiscalMonth ) AND 
--		(d.FiscalMonth = 201801 ) AND 
		(t.Date <= @dtLastDay ) AND
		
		(1=1)

	GROUP BY 
		d.FiscalMonth, 
		i.SalesCategory, 
		t2.TsTerritoryCd, 
		t.Shipto,
		ic.CategoryRollup

END
GO

-- Exec BRS_TS_Cube_proc 