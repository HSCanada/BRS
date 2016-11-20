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
**    
*******************************************************************************/

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Declare @nFiscalMonth int, @nFirstFiscalMonth_LY int

	SET NOCOUNT ON

	if (@bDebug <> 0)
		SET NOCOUNT OFF;

	if (@bDebug <> 0)
		Print 'BRS_TS_Cube_proc - DEBUG MODE.'

	--Get Params
	 
	Select
		@nFiscalMonth			= PriorFiscalMonth,
		@nFirstFiscalMonth_LY	= FirstFiscalMonth_LY
	FROM
		BRS_Rollup_Support02 g

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
		(t.FreeGoodsEstInd = 0) AND

		(t.FiscalMonth BETWEEN @nFirstFiscalMonth_LY AND @nFiscalMonth) AND 

		(1=1)

	GROUP BY 
		t.FiscalMonth, 
		t.SalesCategory, 
		t.TAG_TsTerritoryCd, 
		t.Shipto,
		ic.CategoryRollup
END

GO

-- Debug
-- BRS_TS_Cube_proc 

-- Prod
-- BRS_TS_Cube_proc 0

