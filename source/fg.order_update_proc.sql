SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [fg].[order_update_proc]
	@bDebug as smallint = 1
AS
/******************************************************************************
**	File:	
**	Name: fg.order_update_proc
**	Desc: update fg orders support and exempt codes, based on flex
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
**	Date: 28 Oct 21
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	19 Sep 22	tmc		link last backorder to month
**	03 Feb 23	tmc		de-couple fiscal data lockin so can run FG any time
*******************************************************************************/

Declare @nErrorCode int, @nTranCount int, @nRowCount int
Declare @sMessage varchar(255)
Declare @dtDate date

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
	Print 'Proc: fg.order_update_proc'
	Print 'Desc: update fg orders support and exempt codes'
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
End

If (@nBatchStatus >= 10 and @nBatchStatus < 999)
Begin

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '1. update VPA, Specialty'

	UPDATE
		fg.transaction_F5554240
	SET
		VPA = s.HIST_VPA
		, Specialty = s.HIST_Specialty
	FROM
		fg.transaction_F5554240 
		INNER JOIN BRS_CustomerFSC_History AS s 
		ON fg.transaction_F5554240.CalMonthRedeem = s.FiscalMonth AND 
		fg.transaction_F5554240.WKSHAN_shipto = s.Shipto
	WHERE 
		CalMonthRedeem = @nCurrentFiscalYearmoNum AND
		((VPA <> s.HIST_VPA) OR (Specialty <> s.HIST_Specialty))

	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '2. update MPC, Label'

	UPDATE
		fg.transaction_F5554240
	SET
		MajorProductClass = LEFT(s.MinorProductClass,3)
		, Label = s.Label
	FROM
		fg.transaction_F5554240 
		INNER JOIN [dbo].[BRS_ItemHistory] AS s 
		ON fg.transaction_F5554240.CalMonthRedeem = s.FiscalMonth AND 
		fg.transaction_F5554240.WKLITM_item_number = s.Item
	WHERE 
		CalMonthRedeem = @nCurrentFiscalYearmoNum AND
		(MajorProductClass <> LEFT(s.MinorProductClass,3))

		Set @nErrorCode = @@Error
	End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '3. EnteredBy'

	UPDATE
		fg.transaction_F5554240
	SET
		fg.transaction_F5554240.[EnteredBy] = s.[EnteredBy]
	FROM
		fg.transaction_F5554240 

		INNER JOIN [dbo].[BRS_TransactionDW] AS s 
		ON fg.transaction_F5554240.ID_source_ref = s.ID
	WHERE 
		CalMonthRedeem = @nCurrentFiscalYearmoNum AND
		fg.transaction_F5554240.[EnteredBy] <> s.[EnteredBy]

		Set @nErrorCode = @@Error

End

--
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '4. OriginalSalesOrderNumber'

	UPDATE
		fg.transaction_F5554240
	SET
		fg.transaction_F5554240.[OriginalSalesOrderNumber] = s.[OriginalSalesOrderNumber]
		,fg.transaction_F5554240.[OriginalOrderDocumentType] = s.[OriginalOrderDocumentType]
		,fg.transaction_F5554240.[OriginalOrderLineNumber] = s.[OriginalOrderLineNumber]

	FROM
		fg.transaction_F5554240 

		INNER JOIN [dbo].[BRS_TransactionDW] AS s 
		ON fg.transaction_F5554240.ID_source_ref = s.ID
	WHERE 
		CalMonthRedeem = @nCurrentFiscalYearmoNum AND
		fg.transaction_F5554240.[OriginalSalesOrderNumber] <> s.[OriginalSalesOrderNumber] AND
		(1=1)

		Set @nErrorCode = @@Error

End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '5. ChargebackContractNumber update'

	UPDATE
		fg.transaction_F5554240
	SET
		[WK$ODN_free_goods_contract_number] = s.ChargebackContractNumber

	FROM
		fg.transaction_F5554240 

		INNER JOIN [dbo].[BRS_TransactionDW] AS s 
		ON fg.transaction_F5554240.ID_source_ref = s.ID
	WHERE 
		(CalMonthRedeem = @nCurrentFiscalYearmoNum) AND
		(fg.transaction_F5554240.[WK$ODN_free_goods_contract_number] <> s.ChargebackContractNumber) AND
		(1=1)

		Set @nErrorCode = @@Error

End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '6. [fg].[exempt_supplier_rule] add new'

	INSERT INTO [fg].[exempt_supplier_rule]
	(
		[ChargebackContractNumber]
		,[Supplier]
		,[VPA]
		,[fg_exempt_cd_target]
		,[rule_name_txt]
		,[active_ind]
		,[sequence_num]
		,[signoff_note_txt]
	)
	SELECT DISTINCT 
		[WK$ODN_free_goods_contract_number]
		,WK$SPC_supplier_code
		,VPA
		,'XXXCBM' AS [fg_exempt_cd_target]
		,'.' AS [rule_name_txt]
		,0 AS [active_ind]
		,0 AS [sequence_num]
		,'.' AS [signoff_note_txt]
	FROM
		fg.transaction_F5554240 s
	WHERE 
		(CalMonthRedeem = @nCurrentFiscalYearmoNum) AND
--		(CalMonthRedeem = 202109) AND
		(NOT EXISTS (
			SELECT * 
			FROM [fg].[exempt_supplier_rule] d 
			WHERE 
				s.[WK$ODN_free_goods_contract_number] = d.[ChargebackContractNumber] AND
				s.WK$SPC_supplier_code = d.[Supplier] AND
				s.VPA = d.[VPA] 
		)) AND

		(1=1)

		Set @nErrorCode = @@Error

End

--> exempt logic begin
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '100. BRS_SalesDivision exempt'

	-- ('ZZZDIV','[BRS_SalesDivision]','',1,10,'.')
	UPDATE
		fg.transaction_F5554240
	SET
		fg_exempt_cd = 'ZZZDIV'
	FROM
		fg.transaction_F5554240
		INNER JOIN BRS_SalesDivision AS s 
		ON fg.transaction_F5554240.WKAC10_division_code = s.SalesDivision
	WHERE
		(fg.transaction_F5554240.CalMonthRedeem) = @nCurrentFiscalYearmoNum AND
		(fg.transaction_F5554240.fg_exempt_cd = '') AND
		s.freegoods_exempt_cd = 1 

		Set @nErrorCode = @@Error
End

-- run MPC before docs so we can ID credit rebill
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '110. BRS_ItemMPC exempt'

	-- ('XXXMPC','[BRS_ItemMPC]','',1,10,'.')
	UPDATE
		fg.transaction_F5554240
	SET
		fg_exempt_cd = 'XXXMPC'
	FROM
		fg.transaction_F5554240
		INNER JOIN [BRS_ItemMPC] AS s 
		ON fg.transaction_F5554240.MajorProductClass = s.MajorProductClass
	WHERE
		(fg.transaction_F5554240.CalMonthRedeem) = @nCurrentFiscalYearmoNum AND
		(fg.transaction_F5554240.fg_exempt_cd = '') AND
		s.freegoods_exempt_cd = 1 

		Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '120. BRS_LineTypeOrder exempt'

	-- 	,('ZZZLNT','[BRS_LineTypeOrder]','',1,10,'.')
	UPDATE
		fg.transaction_F5554240
	SET
		fg_exempt_cd = 'ZZZLNT'
	FROM
		fg.transaction_F5554240
		INNER JOIN [BRS_LineTypeOrder] AS s 
		ON fg.transaction_F5554240.WKLNTY_line_type = s.LineTypeOrder
	WHERE
		(fg.transaction_F5554240.CalMonthRedeem) = @nCurrentFiscalYearmoNum AND
		(fg.transaction_F5554240.fg_exempt_cd = '') AND
		s.freegoods_exempt_cd = 1 

		Set @nErrorCode = @@Error

End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '130. BRS_DocType exempt'

	-- 	,('XXXDOC','[BRS_DocType]','',1,10,'.')
	UPDATE
		fg.transaction_F5554240
	SET
		fg_exempt_cd = 'XXXDOC'
	FROM
		fg.transaction_F5554240
		INNER JOIN [BRS_DocType] AS s 
		ON fg.transaction_F5554240.WKDCTO_order_type = s.DocType
	WHERE
		(fg.transaction_F5554240.CalMonthRedeem) = @nCurrentFiscalYearmoNum AND
		(fg.transaction_F5554240.fg_exempt_cd = '') AND
		s.freegoods_exempt_cd = 1 

		Set @nErrorCode = @@Error

End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '140. BRS_ItemSupplier exempt'

	-- ,('XXXSUP','[BRS_ItemSupplier]','',1,10,'.')
	UPDATE
		fg.transaction_F5554240
	SET
		fg_exempt_cd = 'XXXSUP'
	FROM
		fg.transaction_F5554240
		INNER JOIN [BRS_ItemSupplier] AS s 
		ON fg.transaction_F5554240.WK$SPC_supplier_code = s.Supplier
	WHERE
		(fg.transaction_F5554240.CalMonthRedeem) = @nCurrentFiscalYearmoNum AND
		(fg.transaction_F5554240.fg_exempt_cd = '') AND
		s.freegoods_exempt_cd = 1 

		Set @nErrorCode = @@Error

End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '150. BRS_ItemLabel exempt'

	-- 	,('XXXHSB','[BRS_ItemLabel]','',1,10,'.')
	UPDATE
		fg.transaction_F5554240
	SET
		fg_exempt_cd = 'XXXHSB'
	FROM
		fg.transaction_F5554240
		INNER JOIN [dbo].[BRS_ItemLabel] AS s 
		ON fg.transaction_F5554240.label = s.Label
	WHERE
		(fg.transaction_F5554240.CalMonthRedeem) = @nCurrentFiscalYearmoNum AND
		(fg.transaction_F5554240.fg_exempt_cd = '') AND
		s.freegoods_exempt_cd = 1 

		Set @nErrorCode = @@Error

End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '160. BRS_CustomerVPA exempt'

	-- ,('XXXVPA','[BRS_CustomerVPA]','',1,10,'.')
	UPDATE
		fg.transaction_F5554240
	SET
		fg_exempt_cd = 'XXXVPA'
	FROM
		fg.transaction_F5554240
		INNER JOIN [BRS_CustomerVPA] AS s 
		ON fg.transaction_F5554240.VPA = s.VPA
	WHERE
		(fg.transaction_F5554240.CalMonthRedeem) = @nCurrentFiscalYearmoNum AND
		(fg.transaction_F5554240.fg_exempt_cd = '') AND
		s.freegoods_exempt_cd = 1 

		Set @nErrorCode = @@Error

End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '170. BRS_CustomerSpecialty exempt'

	-- ,('XXXSPC','[BRS_CustomerSpecialty]','',1,10,'.')
	UPDATE
		fg.transaction_F5554240
	SET
		fg_exempt_cd = 'XXXSPC'
	FROM
		fg.transaction_F5554240
		INNER JOIN [BRS_CustomerSpecialty] AS s 
		ON fg.transaction_F5554240.Specialty = s.Specialty
	WHERE
		(fg.transaction_F5554240.CalMonthRedeem) = @nCurrentFiscalYearmoNum AND
		(fg.transaction_F5554240.fg_exempt_cd = '') AND
		s.freegoods_exempt_cd = 1 

		Set @nErrorCode = @@Error

End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '180. BRS_Promotion exempt'

	-- ,('XXXPRO','[BRS_Promotion]','',1,10,'.')
	UPDATE
		fg.transaction_F5554240
	SET
		fg_exempt_cd = 'XXXPRO'
	FROM
		fg.transaction_F5554240
		INNER JOIN [BRS_Promotion] AS s 
		ON fg.transaction_F5554240.[WKPMID_promo_code] = s.PromotionCode
	WHERE
		(fg.transaction_F5554240.CalMonthRedeem) = @nCurrentFiscalYearmoNum AND
		(fg.transaction_F5554240.fg_exempt_cd = '') AND
		s.freegoods_exempt_cd = 1 

		Set @nErrorCode = @@Error

End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '190. Chargeback Multi exempt, ensure that we do not redeem FG and CB where requested'

	-- ,('XXXCBM','Chargeback Multi [fg].[exempt_supplier_rule]','',1,10,'.')
	UPDATE
		fg.transaction_F5554240
	SET
		fg_exempt_cd = 'XXXCBM'
		,[exempt_supplier_rule_key] = s.[exempt_supplier_rule_key]
	FROM
		fg.transaction_F5554240
		INNER JOIN [fg].[exempt_supplier_rule] AS s 
		ON 
			(fg.transaction_F5554240.[WK$ODN_free_goods_contract_number] = s.[ChargebackContractNumber]) AND
			(fg.transaction_F5554240.WK$SPC_supplier_code = s.Supplier) AND
			(fg.transaction_F5554240.VPA LIKE s.VPA) AND
			(1=1)
	WHERE
		(fg.transaction_F5554240.CalMonthRedeem) = @nCurrentFiscalYearmoNum AND
		(fg.transaction_F5554240.fg_exempt_cd = '') AND
		s.active_ind = 1

		Set @nErrorCode = @@Error

End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '200. set cost extact date default, JDE extract'

	SELECT
		@dtDate = MAX(s.SalesDate)
	FROM
		BRS_Config AS c 
		INNER JOIN BRS_SalesDay AS d 
		ON c.PriorFiscalMonth = d.CalMonth 
			
		INNER JOIN BRS_ItemBaseHistoryDayLNK AS s 
		ON d.SalesDate = s.SalesDate
	GROUP BY 
		d.FiscalMonth

	UPDATE
		BRS_FiscalMonth
	SET
		fg_cost_date = @dtDate
	WHERE
		(FiscalMonth = @nCurrentFiscalYearmoNum) AND
		-- update if not set manully
		(fg_cost_date) is null AND
		(1=1)

		Set @nErrorCode = @@Error
End

--
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '200b. set backorder date default, Last extract of month'

	SELECT
		@dtDate = MAX(s.SalesDay)
	FROM
		BRS_Config AS c 
		INNER JOIN BRS_SalesDay AS d 
		ON c.PriorFiscalMonth = d.CalMonth 
			
		INNER JOIN [fg].[backorder_FBACKRPT1_history] AS s 
		ON d.SalesDate = s.SalesDay
	GROUP BY 
		d.FiscalMonth

	UPDATE
		BRS_FiscalMonth
	SET
		fg_backorder_date = @dtDate
	WHERE
		(FiscalMonth = @nCurrentFiscalYearmoNum) AND
		-- update if not set manully
		(fg_backorder_date) is null AND
		(1=1)

		Set @nErrorCode = @@Error
End

--

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '201. Correct Costs, JDE extract'

	UPDATE
		fg.transaction_F5554240
	SET
		[WKUNCS_unit_cost] = [SupplierCost]
		,[WKECST_extended_cost] = [SupplierCost] * [WKUORG_quantity]
		,[WKCRCD_currency_code] = [Currency]
		,PriceKey = s.PriceKey

		,[WKUNCS_unit_cost_org] = [WKUNCS_unit_cost]
		,[WKECST_extended_cost_org] = [WKECST_extended_cost]
		,[WKCRCD_currency_code_org] = [WKCRCD_currency_code]

	-- SELECT [WKLITM_item_number], [CalMonthOrder], [CalMonth], [WKUORG_quantity], [WKECST_extended_cost], [WKUNCS_unit_cost], [SupplierCost], [WKCRCD_currency_code], [Currency], [CorporatePrice], s.PriceKey
	FROM
		fg.transaction_F5554240
		INNER JOIN [fg].[item_cost_extract] AS s 
		ON 
			(fg.transaction_F5554240.[WKLITM_item_number] = s.[Item]) AND
			(1=1)
	WHERE
--		(fg.transaction_F5554240.CalMonthRedeem) = 202110 AND
		(fg.transaction_F5554240.CalMonthRedeem) = @nCurrentFiscalYearmoNum AND
		(abs(fg.transaction_F5554240.[WKUNCS_unit_cost] - [SupplierCost]) > 0.01 OR [WKCRCD_currency_code] <> [Currency]) AND
		([WKUNCS_unit_cost_org] IS NULL) AND
		(1=1)

		Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '205. Correct Costs, manual overrides'

	UPDATE
		fg.transaction_F5554240
	SET
		[WKUNCS_unit_cost] = s.[unit_cost]
		,[WKECST_extended_cost] = s.[unit_cost] * [WKUORG_quantity]
		,[WKCRCD_currency_code] = s.[currency_code]
		,[item_cost_extract_override_key] = s.[item_cost_extract_override_key]


	-- SELECT fg.transaction_F5554240.[WKUNCS_unit_cost] , s.*
	FROM
		fg.transaction_F5554240
		INNER JOIN [fg].[item_cost_extract_override] AS s 
		ON 
			(fg.transaction_F5554240.[WKLITM_item_number] = s.[Item]) AND
			([CalMonthRedeem] =  s.[calmonth]) AND
			(1=1)
	WHERE
--		(fg.transaction_F5554240.CalMonthRedeem) = 202110 AND
		(fg.transaction_F5554240.CalMonthRedeem) = @nCurrentFiscalYearmoNum AND
		(abs(fg.transaction_F5554240.[WKUNCS_unit_cost] - [unit_cost]) > 0.01 OR [WKCRCD_currency_code] <> s.[currency_code]) AND
		(1=1)

		Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '210. Auto adds'

	-- Auto adds WKDSC2_pricing_adjustment_line
	UPDATE
		fg.transaction_F5554240
	SET
		fg_exempt_cd = 'FGAUTO'
	WHERE
		(CalMonthRedeem) = @nCurrentFiscalYearmoNum AND
		(fg_exempt_cd = '') AND
		(WKDSC2_pricing_adjustment_line in ('PRBSKFG', 'DVBSKFG', 'PRLINFG', 'DVLINFG'))

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
			[fg_status_cd] = 20
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
	Set @sMessage = 'fg.order_update_proc'
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
-- EXEC fg.order_update_proc @bDebug=0

-- Debug
-- EXEC fg.order_update_proc @bDebug=1
