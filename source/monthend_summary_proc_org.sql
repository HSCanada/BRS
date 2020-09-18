SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[monthend_summary_proc] 
	@bDebug as smallint = 1
AS
/******************************************************************************
**	File:	
**	Name: monthend_summary_proc
**	Desc: build legacy summary tables for daily sales.  future:  use SSAS
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
**	Date: 19 Dec 15
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
-- 	19 Jan 16	tmc		Added Shadow adjustments to sales to track X codes for 
--							380 recon

--	29 Feb 16	tmc		Updated documentation, pre automation
--	29 Mar 16	tmc		Set month flag to 10 after rebuild (ME adj and logic 
--							still TBD)

--	6 May 16	tmc		Fixed missing FSC for adjustments
--	6 May 16	tmc		Remove X code shawdow track (not used & conflicts 
--							with FG est logic)

-- 23 Sep 16	tmc		Add TS territory to snapshot
-- 25 Sep 16	tmc		Add DW Summary (BRS_AGG_CMI_DW_Sales) builder
-- 26 Sep 16	tmc		Add Cursor summary logic to reduce transaction load
-- 27 Sep 16	tmc		Optimize cursors for DS - 1h 15m for full update...
-- 03 Oct 16	tmc		moved manual BRS_AGG_IMD_Sales script end.  Needs to 
--							be added to proc
-- 24 Oct 16	tmc		Record last build date
-- 28 Oct 16	tmc		re-org to true-up FSC on last day of month
-- 11 Jan 17    tmc     build BRS_AGG_CDBGAD_Sales by day for same day rollup
-- 02 Feb 17	tmc		Consolidate, add Discount and Chargeback
-- 17 Feb 17	tmc		Fix Summary Bug caught by Gary W
-- 20 Feb 17	tmc		Make BRS_AGG_ICMBGAD_Sales symetrical ...
--							to BRS_AGG_CMBGAD_Sales
--	15 Feb 17	tmc		Add extra items to history for hfm
--	12 Jun 20	tmc		add commision state to history for commBE_new
--	13 Jun 20	tmc		migrated code from stand-alone script    
*******************************************************************************/

Declare @nErrorCode int, @nTranCount int, @nRowCount int
Declare @sMessage varchar(255)

Set @nErrorCode = @@Error
Set @nTranCount = @@Trancount
Set @nRowCount	= @@ROWCOUNT

Declare @nFiscalTo int, @nFiscalFrom int, @nFiscalCurrent int

Declare @nBatchStatus int, @nNotifyID int

SET NOCOUNT ON;
if (@bDebug <> 0)
	SET NOCOUNT OFF;

if (@bDebug <> 0) 
Begin
	Print '------------------------------------------------------------'
	Print 'Proc: monthend_summary_proc'
	Print 'Desc: build legacy summary tables'
	Print 'Mode: DEBUG'
	Print '------------------------------------------------------------'
End

------------------------------------------------------------------------------------------------------------
-- Init routines.  
------------------------------------------------------------------------------------------------------------

Set @nBatchStatus = -1

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Get Params to pull Fiscal months to cover for Fiscal / Same Day / Calendar'

	Select
		@nFiscalCurrent 	= FiscalMonth,
		@nFiscalFrom		= YearFirstFiscalMonth_HIST,
		@nFiscalTo			= PriorFiscalMonth
	FROM
		BRS_Rollup_Support01 g

	Select
		@nNotifyID			= [notify_operator_id]
	FROM
		[dbo].[BRS_Config]


	Set @nErrorCode = @@Error
End

	
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Get BatchStatus'

	Select 	
		@nBatchStatus = [me_status_cd]
	From 
		[dbo].[BRS_FiscalMonth]
	Where
		[FiscalMonth] = @nFiscalTo
	
	Set @nErrorCode = @@Error
End

------------------------------------------------------------------------------------------------------------
-- Update routines.  
------------------------------------------------------------------------------------------------------------

if (@bDebug <> 0)
Begin
	Print 'Confirm BatchStatus NOT run (0)'
	Print @nFiscalTo
	Print Convert(varchar, @nBatchStatus)
	Print 'pre-process: checking steps 1 - 3'
End

/*
-- Start transaction
if (@nTranCount = 0) 
	Begin Tran mytran
Else
	Save Tran mytran
*/

-- only run once
If (@nBatchStatus < 5 )
Begin
	print 'Exiting:  snapshot not complete!'
	Set @nErrorCode = 999
End
Else
Begin

	DECLARE c CURSOR 
	LOCAL STATIC FORWARD_ONLY READ_ONLY
	FOR 
		SELECT 
			FiscalMonth
		FROM 
			BRS_FiscalMonth
		WHERE 
			FiscalMonth BETWEEN @nFiscalFrom AND @nFiscalTo
		ORDER BY 
			FiscalMonth

------------------------------------------------------------------------------------------------------
-- pre-process
------------------------------------------------------------------------------------------------------

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '1. clear summary tables'

		-- moved from trucate due to rights
		-- first pass
		TRUNCATE TABLE BRS_AGG_CDBGAD_Sales
		TRUNCATE TABLE BRS_AGG_CMBGAD_Sales
		-- second pass
		TRUNCATE TABLE BRS_AGG_ICMBGAD_Sales
		TRUNCATE TABLE BRS_AGG_CMI_DW_Sales
		TRUNCATE TABLE BRS_AGG_IMD_Sales

		Set @nErrorCode = @@Error
	End

-----------------------------
-- process
------------------------------------------------------------------------------------------------------

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			Print '2. Primary Update...'

		SET @sMessage = N'monthend_summary_proc(1 of 3) - ' + DB_NAME()
		EXEC msdb.dbo.sp_notify_operator
			@id = @nNotifyID,
			@subject = @sMessage,  
--			@subject = N'monthend_summary_proc(1 of 3)',  
			@body = N'Daily Sales - start (est 15m)... ';

--,DB_NAME())
		OPEN c;
		FETCH NEXT FROM c INTO @nFiscalCurrent;

		WHILE @@FETCH_STATUS = 0
		BEGIN

			if (@bDebug <> 0)
			begin
				Print '...Building Core summary by *DAY* - BRS_AGG_CDBGAD_Sales, used by Daily Sales...'
				Print @nFiscalCurrent
			end

			INSERT INTO BRS_AGG_CDBGAD_Sales
			(
				SalesDate,
				Branch, 
				GLBU_Class, 
				AdjCode, 
				SalesDivision, 
				Shipto, 
				FreeGoodsEstInd, 
				OrderSourceCode, 
				SalesAmt, 
				GPAmt, 
				GP_Org_Amt,
				ExtChargebackAmt,
				FactCount,
				ID_MAX,
				HIST_Specialty,
				HIST_MarketClass,
				HIST_TerritoryCd,
				HIST_VPA,
				HIST_SegCd
			)
			SELECT     
				t.SalesDate,
				Branch, 
				t.GLBU_Class, 
				t.AdjCode, 
				SalesDivision, 
				t.Shipto, 
				t.FreeGoodsEstInd, 
				OrderSourceCode, 
				SUM(NetSalesAmt) AS SalesAmt, 
				CASE 
					WHEN MIN(glru.ReportingClass) = 'NSA' 
					THEN 0 
					ELSE SUM(NetSalesAmt - (ExtendedCostAmt - ISNULL(ExtChargebackAmt,0))) 
				END  AS GPAmt, 
				CASE 
					WHEN MIN(glru.ReportingClass) = 'NSA' 
					THEN 0 
					ELSE SUM(NetSalesAmt - ExtendedCostAmt) 
				END AS GP_Org_Amt, 
				SUM(ISNULL(ExtChargebackAmt,0)) AS ExtChargebackAmt, 
				COUNT(*) AS FactCount,
				MAX(t.ID) as ID_MAX,
				ISNULL( MAX(c.HIST_Specialty), '') AS HIST_Specialty,
				ISNULL( MAX(c.HIST_MarketClass), '') AS HIST_MarketClass,
				ISNULL( MAX(c.HIST_TerritoryCd),'') AS HIST_TerritoryCd,
				ISNULL( MAX(c.HIST_VPA), '') AS HIST_VPA,
				ISNULL( MAX(c.HIST_SegCd), '') AS HIST_SegCd
			FROM         
				BRS_Transaction AS t

				INNER JOIN BRS_DS_GLBU_Rollup AS glru
				ON	t.GLBU_Class = glru.GLBU_Class

				LEFT JOIN BRS_CustomerFSC_History AS c 
				ON c.ShipTo = t.Shipto   AND
					c.FiscalMonth = t.FiscalMonth
			WHERE     
				(t.FiscalMonth = @nFiscalCurrent)

			GROUP BY 
				t.SalesDate,
				Branch, 
				t.GLBU_Class, 
				t.AdjCode,	
				SalesDivision, 
				t.Shipto, 
				t.FreeGoodsEstInd, 
				OrderSourceCode

			if (@bDebug <> 0)
				Print '...Building Core summary by *MONTH* - BRS_AGG_CMBGAD_Sales, used by Daily Sales...'

			INSERT INTO BRS_AGG_CMBGAD_Sales
			(
				FiscalMonth, 
				Branch, 
				GLBU_Class, 
				AdjCode, 
				SalesDivision, 
				Shipto, 
				FreeGoodsEstInd, 
				OrderSourceCode, 
				SalesAmt, 
				GPAmt, 
				GP_Org_Amt,
				ExtChargebackAmt,
				FactCount,
				ID_MAX,
				HIST_Specialty,
				HIST_MarketClass,
				HIST_TerritoryCd,
				HIST_VPA,
				HIST_SegCd
			)
			SELECT     
				t.FiscalMonth, 
				Branch, 
				t.GLBU_Class, 
				t.AdjCode, 
				SalesDivision, 
				t.Shipto, 
				t.FreeGoodsEstInd, 
				OrderSourceCode, 
				SUM(NetSalesAmt) AS SalesAmt, 
				CASE 
					WHEN MIN(glru.ReportingClass) = 'NSA' 
					THEN 0 
					ELSE SUM(NetSalesAmt - (ExtendedCostAmt - ISNULL(ExtChargebackAmt,0))) 
				END  AS GPAmt, 
				CASE 
					WHEN MIN(glru.ReportingClass) = 'NSA' 
					THEN 0 
					ELSE SUM(NetSalesAmt - ExtendedCostAmt) 
				END AS GP_Org_Amt, 
				SUM(ISNULL(ExtChargebackAmt,0)) AS ExtChargebackAmt, 
				COUNT(*) AS FactCount,
				MAX(t.ID) as ID_MAX,
				ISNULL( MAX(c.HIST_Specialty), '') AS HIST_Specialty,
				ISNULL( MAX(c.HIST_MarketClass), '') AS HIST_MarketClass,
				ISNULL( MAX(c.HIST_TerritoryCd),'') AS HIST_TerritoryCd,
				ISNULL( MAX(c.HIST_VPA), '') AS HIST_VPA,
				ISNULL( MAX(c.HIST_SegCd), '') AS HIST_SegCd
			FROM         
				BRS_Transaction AS t

				INNER JOIN BRS_DS_GLBU_Rollup AS glru
				ON	t.GLBU_Class = glru.GLBU_Class

				LEFT JOIN BRS_CustomerFSC_History AS c 
				ON c.ShipTo = t.Shipto   AND
					c.FiscalMonth = t.FiscalMonth
			WHERE     
				(t.FiscalMonth = @nFiscalCurrent)
			GROUP BY 
				t.FiscalMonth, 
				Branch, 
				t.GLBU_Class, 
				t.AdjCode,	
				SalesDivision, 
				t.Shipto, 
				t.FreeGoodsEstInd, 
				OrderSourceCode

			FETCH NEXT FROM c INTO @nFiscalCurrent;
		END 
		CLOSE c;

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			Print '3. Mark month stataus as complete'

		--	Set month flag to 10 after rebuild (ME adj and logic TBD)
		UPDATE    
			BRS_FiscalMonth
		SET              
			StatusCd = 10, LastSummaryUpdateDt = GetDate()
		WHERE     
			(FiscalMonth = @nFiscalTo)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			Print '4. Secondary Update...'

		SET @sMessage = N'monthend_summary_proc(2 of 3) - ' + DB_NAME()
		EXEC msdb.dbo.sp_notify_operator
			@id = @nNotifyID,
			@subject = @sMessage,  
--			@subject = N'monthend_summary_proc(2 of 3)',  
			@body = N'Daily Sales - complete!' ;  

		OPEN c;
		FETCH NEXT FROM c INTO @nFiscalCurrent;

		WHILE @@FETCH_STATUS = 0
		BEGIN

			if (@bDebug <> 0)
			begin
				Print '...Building Item Summary (BRS_AGG_ICMBGAD_Sales), Vendor Sales ...'
				Print @nFiscalCurrent
			end

			INSERT INTO BRS_AGG_ICMBGAD_Sales
			(
				Item,
				FiscalMonth, 
				Shipto, 
				Branch, 
				GLBU_Class, 
				AdjCode, 
				SalesDivision, 
				FreeGoodsEstInd, 
				OrderSourceCode, 
				SalesAmt, 
				GPAmt, 
				GP_Org_Amt,
				ExtChargebackAmt,
				FactCount,
				ID_MAX,
				HIST_Specialty,
				HIST_MarketClass,
				HIST_TerritoryCd,
				HIST_VPA,
				HIST_SegCd
			)
			SELECT     
				Item,
				t.FiscalMonth, 
				t.Shipto, 
				Branch, 
				t.GLBU_Class, 
				t.AdjCode,	
				SalesDivision, 
				t.FreeGoodsEstInd, 
				OrderSourceCode, 
				SUM(NetSalesAmt) AS SalesAmt, 
				CASE 
					WHEN MIN(glru.ReportingClass) = 'NSA' 
					THEN 0 
					ELSE SUM(NetSalesAmt - (ExtendedCostAmt - ISNULL(ExtChargebackAmt,0))) 
				END  AS GPAmt, 
				CASE 
					WHEN MIN(glru.ReportingClass) = 'NSA' 
					THEN 0 
					ELSE SUM(NetSalesAmt - ExtendedCostAmt) 
				END AS GP_Org_Amt, 
				SUM(ISNULL(ExtChargebackAmt,0)) AS ExtChargebackAmt, 
				COUNT(*) AS FactCount,
				MAX(t.ID) as ID_MAX,
				ISNULL( MAX(c.HIST_Specialty), '') AS HIST_Specialty,
				ISNULL( MAX(c.HIST_MarketClass), '') AS HIST_MarketClass,
				ISNULL( MAX(c.HIST_TerritoryCd),'') AS HIST_TerritoryCd,
				ISNULL( MAX(c.HIST_VPA), '') AS HIST_VPA,
				ISNULL( MAX(c.HIST_SegCd), '') AS HIST_SegCd
			FROM         
				BRS_Transaction AS t

				INNER JOIN BRS_DS_GLBU_Rollup AS glru
				ON	t.GLBU_Class = glru.GLBU_Class

				LEFT JOIN BRS_CustomerFSC_History AS c 
				ON c.ShipTo = t.Shipto   AND
					c.FiscalMonth = t.FiscalMonth
			WHERE     
				(t.FiscalMonth = @nFiscalCurrent )
			GROUP BY 
				Item,
				t.FiscalMonth, 
				t.Shipto, 
				Branch, 
				t.GLBU_Class, 
				t.AdjCode,
				SalesDivision, 
				t.FreeGoodsEstInd, 
				OrderSourceCode, 
				Branch
 
			-- 25 Sep 16	tmc		Add DW Summary (BRS_AGG_CMI_DW_Sales) builder
			if (@bDebug <> 0)
				Print '...Building DW Summary (BRS_AGG_CMI_DW_Sales) ...'

			INSERT INTO BRS_AGG_CMI_DW_Sales
			(
				Shipto, 
				FiscalMonth,
				FreeGoodsInvoicedInd, 
				SalesCategory,
				TAG_TsTerritoryCd,
				Item,
				PriceMethod, 
				OrderSourceCode, 
				HIST_TsTerritoryCd,
				HIST_TerritoryCd,
				HIST_Specialty,
				HIST_MarketClass,
				HIST_VPA,
				HIST_SegCd,
				ShippedQty,
				SalesAmt, 
				GPAmt, 
				GPAtFileCostAmt, 
				GPAtCommCostAmt, 
				ExtChargebackAmt, 
				ExtDiscAmt, 
				[ExtBase],
				[ExtDiscLine],
				[ExtDiscOrder],
				FactCount,
				ID_MAX
			)
			SELECT 
				t.Shipto,     
				d.FiscalMonth, 
				t.FreeGoodsInvoicedInd, 
				i.SalesCategory,
				t2.TsTerritoryCd,
				t.Item,
				t.PriceMethod,
				t.OrderSourceCode, 
				ISNULL( MAX(c.HIST_TsTerritoryCd),'') AS HIST_TsTerritoryCd,
				ISNULL( MAX(c.HIST_TerritoryCd),'') AS HIST_TerritoryCd,
				ISNULL( MAX(c.HIST_Specialty), '') AS HIST_Specialty,
				ISNULL( MAX(c.HIST_MarketClass), '') AS HIST_MarketClass,
				ISNULL( MAX(c.HIST_VPA), '') AS HIST_VPA,
				ISNULL( MAX(c.HIST_SegCd), '') AS HIST_SegCd,
				SUM(t.ShippedQty) AS ShippedQty,
				SUM(t.NetSalesAmt) AS SalesAmt, 
				SUM(GPAmt + ISNULL(t.ExtChargebackAmt,0)) AS  GPAmt, 
				SUM(t.GPAtFileCostAmt) AS GPAtFileCostAmt, 
				SUM(t.GPAtCommCostAmt) AS GPAtCommCostAmt, 
				SUM(t.ExtChargebackAmt) AS ExtChargebackAmt, 
				SUM(t.ExtListPrice  + t.ExtPrice -2*NetSalesAmt)    AS ExtDiscTotal,
				SUM(t.ExtListPrice  + t.ExtPrice -  NetSalesAmt)    AS ExtBase,
				SUM(t.ExtListPrice  + 0          -  NetSalesAmt)    AS ExtDiscLine,
				SUM(0               + t.ExtPrice -  NetSalesAmt)    AS ExtDiscOrder,
				COUNT(*) AS FactCount,
				MAX(T.ID) AS ID_MAX
			FROM         
				BRS_TransactionDW AS t

				INNER JOIN BRS_SalesDay AS d 
				ON d.SalesDate = t.Date 

				INNER JOIN BRS_CustomerFSC_History AS c 
				ON c.ShipTo = t.Shipto   AND
					c.FiscalMonth = d.FiscalMonth

				INNER JOIN BRS_Item AS i 
				ON i.Item = t.Item 

				INNER JOIN BRS_TransactionDW_Ext AS t2 
				ON t.SalesOrderNumber = t2.SalesOrderNumber AND 
					t.DocType = t2.DocType 
			WHERE     
				(d.FiscalMonth = @nFiscalCurrent )
			GROUP BY 
				t.Shipto,     
				d.FiscalMonth, 
				t.FreeGoodsInvoicedInd, 
				i.SalesCategory,
				t2.TsTerritoryCd,
				t.Item,
				t.PriceMethod,
				t.OrderSourceCode

			if (@bDebug <> 0)
				Print '...Building DW Summary (BRS_AGG_IMD_Sales), used by Promo and Datamining...'

			INSERT INTO BRS_AGG_IMD_Sales
			(
				Item,
				t.CalMonth, 
				SalesDivision, 
				FreeGoodsInvoicedInd, 
				OrderSourceCode, 
				ShippedQty,
				NetSalesAmt, 
				GPAmt, 
				GPAtFileCostAmt, 
				GPAtCommCostAmt, 
				ExtChargebackAmt, 
				ExtDiscAmt, 
				[ExtBase],
				[ExtDiscLine],
				[ExtDiscOrder],
				FactCount
			)
			SELECT     
				Item,
				CalMonth, 
				SalesDivision, 
				FreeGoodsInvoicedInd, 
				OrderSourceCode, 
				SUM(ShippedQty) AS ShippedQty,
				SUM(NetSalesAmt) AS SalesAmt, 
				SUM(GPAmt + ISNULL(t.ExtChargebackAmt,0)) AS  GPAmt, 
				SUM(GPAtFileCostAmt) AS GPAtFileCostAmt, 
				SUM(GPAtCommCostAmt) AS GPAtCommCostAmt, 
				SUM(ExtChargebackAmt) AS ExtChargebackAmt, 
				SUM(t.ExtListPrice  + t.ExtPrice -2*NetSalesAmt)    AS ExtDiscTotal,
				SUM(t.ExtListPrice  + t.ExtPrice -  NetSalesAmt)    AS ExtBase,
				SUM(t.ExtListPrice  + 0          -  NetSalesAmt)    AS ExtDiscLine,
				SUM(0               + t.ExtPrice -  NetSalesAmt)    AS ExtDiscOrder,
				COUNT(*) AS FactCount
			FROM         
				BRS_TransactionDW AS t
			WHERE     
				(t.CalMonth = @nFiscalCurrent)
			GROUP BY 
				Item,
				CalMonth, 
				SalesDivision, 
				FreeGoodsInvoicedInd, 
				OrderSourceCode

			FETCH NEXT FROM c INTO @nFiscalCurrent;
		END 

		CLOSE c;
		DEALLOCATE c;

		Set @nErrorCode = @@Error
	End

------------------------------------------------------------------------------------------------------
-- post-process
------------------------------------------------------------------------------------------------------
	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			Print '5. post-process - alert TBD'	

		SET @sMessage = N'monthend_summary_proc(3 of 3) - ' + DB_NAME()
		EXEC msdb.dbo.sp_notify_operator
			@id = @nNotifyID,
			@subject = @sMessage,  
--			@subject = N'monthend_summary_proc(3 of 3)',  
			@body = N'Complete.' ;  
	
		Set @nErrorCode = @@Error
	End

End

------------------------------------------------------------------------------------------------------------
-- Wrap-up routines.  
------------------------------------------------------------------------------------------------------------

-- force error in debug
if (@bDebug <> 0 AND @nErrorCode = 0)
	Set @nErrorCode = 512

-- Call error message on Error
if (@nErrorCode <> 0)
Begin
	Set @sMessage = 'monthend_summary_proc'
	Set @sMessage = @sMessage + ':  Return(' + Convert(varchar, @nErrorCode) + ')'
	Set @sMessage = @sMessage +  ', ' + convert(varchar, @bDebug)

	RAISERROR ('%s', 9, 1, @sMessage )
/*
	Rollback Tran mytran
*/
	return @nErrorCode
End
/*
-- Commit tran on Success
if (@nTranCount = 0)
Begin
	Commit Tran
End
*/

Return @nErrorCode
GO

-- UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202005
-- update BRS_FiscalMonth set [me_status_cd] = 10 where FiscalMonth = 202005


-- Prod
-- EXEC dbo.monthend_summary_proc @bDebug=0

-- Debug
-- EXEC dbo.monthend_summary_proc @bDebug=1
