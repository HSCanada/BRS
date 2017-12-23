SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE BRS_TS_Cube_proc 
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
		@nFirstFiscalMonth_LY	= FirstFiscalMonth_LY,
		@dtLastDay				= SalesDateLastWeekly
	FROM
		BRS_TS_Config g

	--Pull Cube based on Params

	SELECT     
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

--	Select FiscalMonth, PriorFiscalMonth, FirstFiscalMonth_LY, SalesDateLastWeekly FROM BRS_TS_Config g

-- Debug
-- BRS_TS_Cube_proc 

-- Prod
-- BRS_TS_Cube_proc 0

