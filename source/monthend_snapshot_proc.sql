SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[monthend_snapshot_proc] 
	@bDebug as smallint = 1
AS
/******************************************************************************
**	File:	
**	Name: monthend_snapshot_proc
**	Desc: store monthend state for further repeatable processing
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
**	Date: 13 Jun 20
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	22 Sep 20	tmc		Add ISR commission logic
**	21 Dec 20	tmc		Add sales summary logic to help with rebate allocation
**						Add EST and fix ISR snapshots
**  16 Dec 21	tmc		add ISR logic
**    
*******************************************************************************/

Declare @nErrorCode int, @nTranCount int, @nRowCount int
Declare @sMessage varchar(255)

Set @nErrorCode = @@Error
Set @nTranCount = @@Trancount
Set @nRowCount	= @@ROWCOUNT

Declare @nCurrentFiscalYearmoNum int
Declare @nBatchStatus int

SET NOCOUNT ON;
if (@bDebug <> 0)
	SET NOCOUNT OFF;

if (@bDebug <> 0) 
Begin
	Print '------------------------------------------------------------'
	Print 'Proc: monthend_snapshot_proc'
	Print 'Desc: store monthend state for further repeatable processing'
	Print 'Mode: DEBUG'
	Print '------------------------------------------------------------'
End

------------------------------------------------------------------------------------------------------------
-- Init routines.  
------------------------------------------------------------------------------------------------------------

Set @nCurrentFiscalYearmoNum = -1
Set @nBatchStatus = -1

-- Start transaction
if (@nTranCount = 0)
	Begin Tran mytran
Else
	Save Tran mytran

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Get Current Fiscal Month'

	Select 	
		@nCurrentFiscalYearmoNum = [PriorFiscalMonth]
	From 
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
		[FiscalMonth] = @nCurrentFiscalYearmoNum
	
	Set @nErrorCode = @@Error
End

------------------------------------------------------------------------------------------------------------
-- Update routines.  
------------------------------------------------------------------------------------------------------------

if (@bDebug <> 0)
Begin
	Print 'Confirm BatchStatus NOT run (0)'
	Print @nCurrentFiscalYearmoNum
	Print Convert(varchar, @nBatchStatus)
	Print 'pre-process: checking steps 1 - 4'
End

-- only run once
If (@nBatchStatus <> 0)
Begin
	print 'Exiting:  cannot run snapshot more than once!'
	Set @nErrorCode = 999
End
Else
Begin

------------------------------------------------------------------------------------------------------
-- pre-process
------------------------------------------------------------------------------------------------------

-- sych & check
	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '1. check - fsc cust (full check)'

		SELECT    @nRowCount = COUNT(*)
		-- select top 100 *
		FROM  
			[dbo].[BRS_Customer] c

			INNER JOIN BRS_FSC_Rollup AS fsc
			ON fsc.TerritoryCd = c.TerritoryCd

			LEFT JOIN [comm].[salesperson_master] fsc_comm
			ON fsc_comm.[salesperson_key_id] = fsc.comm_salesperson_key_id
		
		WHERE 
			(c.Shipto > 0) AND
			(c.SalesDivision NOT IN ('AZA','AZE')) AND
			(
				(c.TerritoryCd ='') OR
				ISNULL(fsc_comm.comm_plan_id,'') = ''
			)

		Set @nErrorCode = @@Error
		If @nRowCount > 0 Set @nErrorCode = 1
	End

	-- due to timing, some new codes do not have groups
	-- ensure items have comm codes where transactions in prior month
	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '2. check - fsc item (comm code on active skus)'

		SELECT    @nRowCount = COUNT(*)
		-- select top 100 *
		FROM
			BRS_Item AS i 
			INNER JOIN BRS_Transaction AS t 
			ON i.Item = t.Item
		WHERE
			(i.Item > '0') AND 
			(i.comm_group_cd = '') AND 
			(t.FiscalMonth = @nCurrentFiscalYearmoNum) AND
			(1 = 1) 

		Set @nErrorCode = @@Error
		If @nRowCount > 0 Set @nErrorCode = 2
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '3. check - eps cust (partial check)'

		SELECT    @nRowCount = COUNT(*)
		-- select top 10 *
		FROM  [dbo].[BRS_Customer]
		WHERE 
			-- since eps_code not defined for all accounts
			-- picking partial test rather than no test
			(Shipto > 0) AND
			([PostalCode] like 'M%') AND
			(eps_code = '') AND
			(Specialty = 'GENP') AND
			([SalesDivision] = 'AAD') AND
			(1=1)

		Set @nErrorCode = @@Error
		If @nRowCount > 0 Set @nErrorCode = 3
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '4. check - cps cust (partial check)'

		SELECT    @nRowCount = COUNT(*)
		-- select top 10 Shipto, [Country], [SalesDivision], [PostalCode], cps_code, * 
		FROM  [dbo].[BRS_Customer]
		WHERE 
			(Shipto > 0) AND
			([Country] = 'CA') AND
			([SalesDivision] IN('AAD', 'AAL')) AND
			([PostalCode] <> '') AND
			(cps_code = '') AND
			(1=1)

		Set @nErrorCode = @@Error
		If @nRowCount > 0 Set @nErrorCode = 4
	End

/*
	-- activeate once EVERY account has ISR terr
	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '5. check - isr cust (partial check)'

		SELECT    @nRowCount = COUNT(*)
		-- select top 10 *
		FROM  [dbo].[BRS_Customer]
		WHERE 
			(Shipto > 0) AND
			([Country] = 'CA') AND
			([SalesDivision] IN('AAD', 'AAL')) AND
			([PostalCode] <> '') AND
			([TsTerritoryCd] = '') AND
			(1=1)

		Set @nErrorCode = @@Error
		If @nRowCount > 0 Set @nErrorCode = 4
	End
*/
-----------------------------
-- process
------------------------------------------------------------------------------------------------------

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '5. snapshot item'

		INSERT INTO BRS_ItemHistory 
		(
			Item
			,FiscalMonth
			,Supplier
			,[MinorProductClass]
			,[Label]
			,[Brand]
			,[HIST_comm_group_cd]
			,[HIST_comm_group_cps_cd]
			,[HIST_comm_group_eps_cd]
			,[HIST_comm_group_est_cd]
			,[HIST_comm_group_isr_cd]
		)
		SELECT     
			BRS_Item.Item
			,@nCurrentFiscalYearmoNum AS FiscalMonth
			,BRS_Item.Supplier
			,[MinorProductClass]
			,[Label]
			,[Brand]
			,[comm_group_cd]
			,[comm_group_cps_cd]
			,[comm_group_eps_cd]
			,[comm_group_est_cd]
			,[comm_group_isr_cd]

		FROM         
			BRS_Item 

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '6. snapshot customer'

		INSERT INTO BRS_CustomerFSC_History
		(
			Shipto
			,FiscalMonth
			,HIST_TerritoryCd
			,HIST_VPA
			,HIST_Specialty
			,HIST_MarketClass
			,HIST_SegCd
			,HIST_TsTerritoryCd
			,HIST_SalesDivision
			,[HIST_cust_comm_group_cd]
			-- new comm history
			,[HIST_fsc_salesperson_key_id]
			,[HIST_fsc_comm_plan_id]

			,[HIST_cps_code]
			,[HIST_cps_salesperson_key_id]
			,[HIST_cps_comm_plan_id]

			,[HIST_eps_code]
			,[HIST_eps_salesperson_key_id]
			,[HIST_eps_comm_plan_id]

			-- dup, see HIST_TsTerritoryCd
			--	,[HIST_isr_code]
			,[HIST_isr_salesperson_key_id]
			,[HIST_isr_comm_plan_id]

			,[HIST_est_code]
			,[HIST_est_salesperson_key_id]
			,[HIST_est_comm_plan_id]

		)
		SELECT     
			c.ShipTo
			,@nCurrentFiscalYearmoNum AS FiscalMonth
			,c.TerritoryCd
			,c.VPA
			,c.Specialty
			,c.MarketClass
			,c.SegCd			-- ok, use this, not new
			,c.TsTerritoryCd
			,c.SalesDivision
			,c.comm_status_cd
			-- new comm history
			,ISNULL(fsc_comm.salesperson_key_id,'')
			,ISNULL(fsc_comm.comm_plan_id,'')

			,c.cps_code
			,ISNULL(cps_comm.salesperson_key_id,'')
			,ISNULL(cps_comm.comm_plan_id, '')

			,c.eps_code
			,ISNULL(eps_comm.salesperson_key_id,'')
			,ISNULL(eps_comm.comm_plan_id,'')

			-- dup, see HIST_TsTerritoryCd
			-- ,c.TsTerritoryCd
			,ISNULL(isr_comm.salesperson_key_id,'')
			,ISNULL(isr_comm.comm_plan_id,'')

			,c.est_code
			,ISNULL(est_comm.salesperson_key_id,'')
			,ISNULL(est_comm.comm_plan_id,'')

		FROM         
			BRS_Customer c

			-- fsc (full)
			INNER JOIN BRS_FSC_Rollup AS fsc
			ON fsc.TerritoryCd = c.TerritoryCd

			LEFT JOIN [comm].[salesperson_master] fsc_comm
			ON fsc_comm.[salesperson_key_id] = fsc.comm_salesperson_key_id

			-- eps 
			INNER JOIN BRS_FSC_Rollup AS eps 
			ON eps.TerritoryCd = c.eps_code

			LEFT JOIN [comm].[salesperson_master] eps_comm
			ON eps_comm.[salesperson_key_id] = eps.comm_salesperson_key_id

			-- cps 
			INNER JOIN BRS_FSC_Rollup AS cps 
			ON cps.TerritoryCd = c.cps_code

			LEFT JOIN [comm].[salesperson_master] cps_comm
			ON cps_comm.[salesperson_key_id] = cps.comm_salesperson_key_id

			-- isr
			LEFT JOIN BRS_FSC_Rollup AS isr
			ON isr.TerritoryCd = c.TsTerritoryCd AND
				c.TsTerritoryCd <> '**' AND
				c.TsTerritoryCd <> '' AND
				(1=1)

			LEFT JOIN [comm].[salesperson_master] isr_comm
			ON isr_comm.[salesperson_key_id] = isr.comm_salesperson_key_id


			-- est
			LEFT JOIN BRS_FSC_Rollup AS est
			ON est.TerritoryCd = c.est_code AND
				c.est_code <> 'NA'

			LEFT JOIN [comm].[salesperson_master] est_comm
			ON est_comm.[salesperson_key_id] = est.comm_salesperson_key_id

		Set @nErrorCode = @@Error
	End

------------------------------------------------------------------------------------------------------
-- post-process
------------------------------------------------------------------------------------------------------

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '7. add dup salesorder with generic doctype AA for simplified adjustment RI'

		INSERT INTO 
			[dbo].[BRS_TransactionDW_Ext] 
			(
				[SalesOrderNumber], 
				DocType
			)
		SELECT DISTINCT 
			s.SalesOrderNumber, 
			'AA' DocType
		FROM
			[dbo].[BRS_TransactionDW_Ext]  s 
		WHERE
			NOT EXISTS 
			(
				SELECT * 
				FROM [dbo].[BRS_TransactionDW_Ext]  d
				WHERE d.SalesOrderNumber = s.[SalesOrderNumber] AND 
				d.DocType = 'AA'
			) 

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '8. set ME trans FSC & branch to match snapshot - mimic commission logic'

		UPDATE   
			BRS_Transaction
		SET              
			TerritoryCd = s.HIST_TerritoryCd,
			Branch = sb.Branch
		FROM         
			BRS_Transaction d
			
			INNER JOIN BRS_CustomerFSC_History AS s
			ON s.FiscalMonth = d.FiscalMonth AND 
				s.Shipto = d.Shipto AND 
				s.HIST_TerritoryCd <> d.TerritoryCd

			INNER JOIN BRS_FSC_Rollup AS sb 
			ON sb.TerritoryCd = s.HIST_TerritoryCd

		WHERE     
			-- do not touch adjustments
			(d.Shipto > 0) AND 
			(d.DocType <> 'AA') AND 
			--
			(d.FiscalMonth = @nCurrentFiscalYearmoNum) 

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '9. set summary sales by shipto'

		UPDATE 
			dbo.BRS_CustomerFSC_History
		SET
			total_month_sales_amt = src.total_sales,
			merch_month_sales_amt = src.merch_sales,
			teeth_month_sales_amt = src.teeth_sales
		FROM
		(
			SELECT
				s.FiscalMonth, s.Shipto, 
				SUM(s.NetSalesAmt) AS total_sales, 
				SUM(CASE WHEN i.SalesCategory = 'MERCH' THEN s.NetSalesAmt ELSE 0 END) AS merch_sales, 
				SUM(CASE WHEN i.SalesCategory = 'TEETH' THEN s.NetSalesAmt ELSE 0 END) AS teeth_sales
			FROM
				BRS_Transaction AS s 

				INNER JOIN BRS_Item AS i 
				ON s.Item = i.Item
			WHERE
				(s.SalesDivision IN ('AAD', 'AAL', 'AAM', 'AAV')) AND 
				(s.DocType <> 'AA') AND 
				(1 = 1)
			GROUP BY 
				s.FiscalMonth, s.Shipto
			HAVING
				(s.FiscalMonth = @nCurrentFiscalYearmoNum) 
		) src
		WHERE
			dbo.BRS_CustomerFSC_History.[Shipto] = src.Shipto AND
			dbo.BRS_CustomerFSC_History.[FiscalMonth] = src.FiscalMonth

		Set @nErrorCode = @@Error
	End

------------------------------------------------------------------------------------------------------------
-- Wrap-up routines.  
------------------------------------------------------------------------------------------------------------

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			Print 'Set BatchStatus to Snapshot complete'	

		Update
			[dbo].[BRS_FiscalMonth]
		Set 
			[me_status_cd] = 5
		Where 
			[FiscalMonth] = @nCurrentFiscalYearmoNum
	
		Set @nErrorCode = @@Error
	End

End

-- force error in debug
if (@bDebug <> 0 AND @nErrorCode = 0)
	Set @nErrorCode = 512

-- Call error message on Error
if (@nErrorCode <> 0)
Begin
	Set @sMessage = 'monthend_snapshot_proc'
	Set @sMessage = @sMessage + ':  Return(' + Convert(varchar, @nErrorCode) + ')'
	Set @sMessage = @sMessage +  ', ' + convert(varchar, @bDebug)

	RAISERROR ('%s', 9, 1, @sMessage )

	Rollback Tran mytran

	return @nErrorCode
End

-- Commit tran on Success
if (@nTranCount = 0)
Begin
	Commit Tran
End

Return @nErrorCode
GO

-- UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202012

-- Prod
-- EXEC dbo.monthend_snapshot_proc @bDebug=0

-- Debug, 1m
-- EXEC dbo.monthend_snapshot_proc @bDebug=1

