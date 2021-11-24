SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [fg].[order_load_proc]
	@bDebug as smallint = 1
AS
/******************************************************************************
**	File:	
**	Name: fg.order_load_proc
**	Desc: load free goods orders from stage to prod (based on flex.*)
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
**	Date: 27 Oct 21
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
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
	Print '---------------------------------------------------------'
	Print 'Proc: fg.order_load_proc'
	Print 'Desc: load free good orders from stage to prod'
	Print 'Mode: DEBUG'
	Print '---------------------------------------------------------'
End

------------------------------------------------------------------------------------------------------------
-- Init routines.  
------------------------------------------------------------------------------------------------------------
SET NOCOUNT ON;

if (@bDebug <> 0)
	SET NOCOUNT OFF;

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
		@nBatchStatus = [fg_status_cd]
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
	Print 'Confirm BatchStatus NOT locked'
	Print @nCurrentFiscalYearmoNum
	Print Convert(varchar, @nBatchStatus)
	Print 'Checking steps 1 - 4'
End

-- only run once
If (@nBatchStatus <> 0)
Begin
	print 'Exiting:  cannot run load more than once!'
	Set @nErrorCode = 999
End
Else
Begin

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '1. [Integration].[F5554240_fg_redeem_Staging] - set dates'

	-- set dates
	UPDATE
		Integration.F5554240_fg_redeem_Staging  
	SET
		WKDATE_order_date = CONVERT(DATE,WKDATE_order_date_text)
		,CalMonthOrder = FORMAT(CONVERT(DATE,WKDATE_order_date_text),'yyyyMM')
		,CalMonthRedeem = (SELECT [PriorFiscalMonth] from [dbo].[BRS_Config])

	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '2. [Integration].[F5554240_fg_redeem_Staging] - set order xref'

	-- clear values
	UPDATE 
		Integration.F5554240_fg_redeem_Staging 
			SET [WKLNNO_line_number] = null
			, ID_source_ref = null

	-- link free good transactions to [dbo].[STAGE_BRS_TransactionDW]
	UPDATE 
		Integration.F5554240_fg_redeem_Staging 
	SET 
		[WKLNNO_line_number] = s.LineNumber
		,ID_source_ref = s.id
	--test
	-- SELECT * 
	FROM
		Integration.F5554240_fg_redeem_Staging
		INNER JOIN
			(
			-->
			SELECT
				WKDOCO_salesorder_number, [WKDCTO_order_type], WKLITM_item_number, line_id, [WKDATE_order_date_text], [WKUORG_quantity], ID,
				row_number() over(PARTITION BY WKDOCO_salesorder_number, WKLITM_item_number order by ID) rno_dst2
			FROM
				Integration.F5554240_fg_redeem_Staging 
			WHERE
				-- no internal
				([WKAC10_division_code]<>'AZA') AND
				([WKLNTY_line_type] NOT IN ('M2', 'MS')) AND
				-- by definition, no adjustments or NON free goods included (ensure stage and DW match)
				-- test
--				(WKDOCO_salesorder_number in(14485298)) AND (WKLITM_item_number in('7720768')) AND
				--(WKDOCO_salesorder_number in(14492625)) AND (WKLITM_item_number in('3783903')) AND
				--(WKDOCO_salesorder_number in(14498659)) AND (WKLITM_item_number in('5874352')) AND
				(1=1)
			--<
			) d
			ON Integration.F5554240_fg_redeem_Staging.ID = d.ID

			INNER JOIN 
			(
			-->
			SELECT
				[SalesOrderNumber], [DocType], [item], [LineNumber], [Date], [ShippedQty], ID,
				row_number() over(PARTITION BY [SalesOrderNumber], [item] order by ID) rno_src2
			FROM
				[dbo].[BRS_TransactionDW]
			WHERE 
				EXISTS (SELECT * FROM Integration.F5554240_fg_redeem_Staging WHERE [SalesOrderNumber] = WKDOCO_salesorder_number) AND
				-- exclude previously loaded lines (allow backorders to be loaded)
				NOT EXISTS (
					SELECT * FROM [fg].[transaction_F5554240] dd 
					WHERE dd.[WKDOCO_salesorder_number] = [dbo].[BRS_TransactionDW].[SalesOrderNumber] AND 
						dd.[WKLITM_item_number] = [item] AND
						dd.ID_source_ref = [dbo].[BRS_TransactionDW].[ID] AND
						1=1
				) AND

				-- no internal
				([SalesDivision]<>'AZA') AND
				-- no adjustments
				(DocType <> 'AA') AND
				-- free goods only (relax qty = 0 for price adj, likely be to be ignored downstream
		--		([ShippedQty] <> 0) AND
				([NetSalesAmt] = 0) AND
				-- test
--				(SalesOrderNumber in(14485298)) AND (item in ('7720768')) AND
				--(SalesOrderNumber in(14492625)) AND (item in ('3783903')) AND
				--(SalesOrderNumber in(14498659)) AND (item in ('5874352')) AND
				(1=1)
			--<
			) s
			ON d.WKDOCO_salesorder_number = s.[SalesOrderNumber] AND
				d.[WKDCTO_order_type] = s.[DocType] AND
				RTRIM(d.WKLITM_item_number) = RTRIM(s.[item]) AND
				d.rno_dst2 = s.rno_src2 AND
				(1=1)
		WHERE
			-- test
			--(Integration.F5554240_fg_redeem_Staging.ID = 4263) AND
			(1=1)


	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '3. integration.flex_order_lines_Staging - prep for loaded (order line exists and no dups)'

	-- reset
	UPDATE
		Integration.F5554240_fg_redeem_Staging 
	SET
		status_code = -1

	-- mark internal
	UPDATE
		Integration.F5554240_fg_redeem_Staging 
	SET
		status_code = 0
	WHERE
		([WKAC10_division_code]='AZA') OR ([WKLNTY_line_type] IN ('M2', 'MS')) 

	-- mark match
	UPDATE
		Integration.F5554240_fg_redeem_Staging 
	SET
		status_code = 5
	WHERE
		(ID_source_ref IS NOT NULL) AND
		NOT EXISTS 
		(
			SELECT * FROM [fg].[transaction_F5554240] d 
			WHERE 
				(Integration.F5554240_fg_redeem_Staging.[WKDOCO_salesorder_number] = d.[WKDOCO_salesorder_number]) AND
				(Integration.F5554240_fg_redeem_Staging.[WKDCTO_order_type] = d.[WKDCTO_order_type]) AND
				(Integration.F5554240_fg_redeem_Staging.[WKLNNO_line_number] = d.[WKLNNO_line_number]) AND
				(1=1)
		)

	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '4. [fg].[transaction_F5554240] - load'

	INSERT INTO [fg].[transaction_F5554240]
	(
		[WKDOCO_salesorder_number]
		,[WKDCTO_order_type]
		,[WKLNNO_line_number]
		,[ID_source_ref]
		,[CalMonthRedeem]
		,[CalMonthOrder]
		,[fg_exempt_cd]
		,[fg_offer_id]
		,[fg_offer_note]
		,[WK$ODN_free_goods_contract_number]
		,[WKDATE_order_date]
		,[WKSHAN_shipto]
		,[WKLITM_item_number]
		,[WKUORG_quantity]
		,[WKECST_extended_cost]
		,[WKUNCS_unit_cost]
		,[WKCRCD_currency_code]
		,[WKDSC1_description]
		,[WKPMID_promo_code]
		,[VPA]
		,[WKLNTY_line_type]
		,[WKAC10_division_code]
		,[MajorProductClass]
		,[WK$SPC_supplier_code]
		,[WKPSN__invoice_number]
		,[OriginalSalesOrderNumber]
		,[WKDSC2_pricing_adjustment_line]
		,[WKAN8__billto]
		,[WKKEY__key]
		,[WKCITM_customersupplier_item_number]
		,[WKUOM__um]
		,[WKALPH_billto_name]
		,[WKNAME_shipto_name]
		,[WK$HGS_status_code_high]
		,[WKFRGD_from_grade]
		,[WKTHGD_thru_grade]
		,[WKDL01_promo_description]
		,[status_code]
		,[order_file_name]
		,[line_id]
		,[Specialty]
		,[Label]
	)
	SELECT
		[WKDOCO_salesorder_number]
		,[WKDCTO_order_type]
		,[WKLNNO_line_number]
		,[ID_source_ref]
		,[CalMonthRedeem]
		,[CalMonthOrder]
		,'' AS [fg_exempt_cd]
		,0 AS [fg_offer_id]
		,'' AS [fg_offer_note]
		,ISNULL([WK$ODN_free_goods_contract_number],'')
		,[WKDATE_order_date]
		,[WKSHAN_shipto]
		,[WKLITM_item_number]
		,[WKUORG_quantity]
		,[WKECST_extended_cost]
		,[WKUNCS_unit_cost]
		,[WKCRCD_currency_code]
		,[WKDSC1_description]
		,ISNULL([WKTHGD_thru_grade],'') AS [WKPMID_promo_code]
		,'' AS [VPA]
		,[WKLNTY_line_type]
		,[WKAC10_division_code]
		,'' AS [MajorProductClass]
		,[WK$SPC_supplier_code]
		,[WKPSN__invoice_number]
		,0 AS [OriginalSalesOrderNumber]
		,ISNULL([WKDSC2_pricing_adjustment_line],'')
		,[WKAN8__billto]
		,ISNULL([WKKEY__key],'')
		,[WKCITM_customersupplier_item_number]
		,[WKUOM__um]
		,[WKALPH_billto_name]
		,[WKNAME_shipto_name]
		,[WK$HGS_status_code_high]
		,ISNULL([WKFRGD_from_grade],'')
		,ISNULL([WKTHGD_thru_grade],'')
		,ISNULL([WKDL01_promo_description],'')
		,[status_code]
		,[order_file_name]
		,[line_id]
		,'' AS [Specialty]
		,'' AS [Label]
	FROM
		[Integration].[F5554240_fg_redeem_Staging] AS s 
	WHERE
		status_code = 5

	Set @nErrorCode = @@Error
End



If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print 'Integration.F5554240_fg_redeem_Staging - clear'

	DELETE FROM [Integration].[F5554240_fg_redeem_Staging] where [status_code] in(0, 5)

	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print 'Integration.F5554240_fg_redeem_Staging - clear test'

	SELECT @nRowCount = count(*) FROM [Integration].[F5554240_fg_redeem_Staging]
	if (@bDebug <> 0 AND @nRowCount > 0)
	Begin
		print 'FALED: non zero rows =' + @nRowCount
		Set @nErrorCode = 512
	end

	Set @nErrorCode = @@Error
End


------------------------------------------------------------------------------------------------------------
-- Wrap-up routines.  
------------------------------------------------------------------------------------------------------------

If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			Print 'Set BatchStatus to Processed'	

		Update
			[dbo].[BRS_FiscalMonth]
		Set 
			fg_status_cd = 10
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
	Set @sMessage = 'fg.order_load_proc'
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

-- Prod
-- EXEC fg.order_load_proc @bDebug=0

-- Debug
-- EXEC fg.order_load_proc @bDebug=1
