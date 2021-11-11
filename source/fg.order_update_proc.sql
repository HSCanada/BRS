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
		print '3c. OriginalSalesOrderNumber'

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

--> exempt logic begin
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '4. BRS_SalesDivision exempt'

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
		print '7. BRS_ItemMPC exempt'

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
		print '5. BRS_LineTypeOrder exempt'

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
		print '6. BRS_DocType exempt'

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
		print '8. BRS_ItemSupplier exempt'

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
		print '9. BRS_ItemLabel exempt'

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
		print '10. BRS_CustomerVPA exempt'

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
		print '11. BRS_CustomerSpecialty exempt'

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
		print '12. BRS_Promotion exempt'

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
		print '13. Chargeback Multi exempt'

	-- ,('XXXCBM','Chargeback Multi [fg].[exempt_supplier_rule]','',1,10,'.')
	UPDATE
		fg.transaction_F5554240
	SET
		fg_exempt_cd = 'XXXCBM'
	FROM
		fg.transaction_F5554240
		INNER JOIN [fg].[exempt_supplier_rule] AS s 
		ON fg.transaction_F5554240.WK$SPC_supplier_code LIKE s.Supplier_WhereClauseLike AND
			fg.transaction_F5554240.VPA LIKE s.VPA_WhereClauseLike AND
			fg.transaction_F5554240.Specialty LIKE s.Specialty_WhereClauseLike AND
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
		print '14. Chargeback VPA Supplier TBD'

-- TBD
--	,('XXXCBV','Chargeback VPA [fg].[exempt_supplier_rule]','',1,10,'.')
--	,('XXXCBS','Chargeback Supplier [fg].[exempt_supplier_rule]','',1,10,'.')

		Set @nErrorCode = @@Error

End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '15. Auto adds'

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
