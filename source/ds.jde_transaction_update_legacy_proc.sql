
/****** Object:  StoredProcedure [dbo].[BRS_BE_Transaction_load_proc]    Script Date: 11/23/2023 10:56:55 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [ds].[jde_transaction_update_legacy_proc] 
	@bDebug as smallint = 1
AS

/******************************************************************************
**	File: 
**	Name: jde_transaction_update_legacy_proc]
**	Desc: update legacy Daily Sales and Datawarehouse from stage trans
**
**	Todo:   
**		1. ???
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
**	Date: 23 Nov 23
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/
BEGIN


Declare @nErrorCode int, @nTranCount int
Declare @sMessage varchar(255)

Set @nErrorCode = @@Error
Set @nTranCount = @@Trancount

Declare @dtSalesDay datetime
Declare @nBatchStatus int
Declare @nFiscalMonth int

SET NOCOUNT ON;



if (@bDebug <> 0)
	SET NOCOUNT OFF;

Set @nBatchStatus = -1

-- Start transaction
if (@nTranCount = 0)
	Begin Tran mytran
Else
	Save Tran mytran


if (@bDebug <> 0)
	Print 'DEBUG MODE.  Lookup Current Day & Month '

If (@nErrorCode = 0) 
Begin
	Select 	
		@dtSalesDay = SalesDate, @nFiscalMonth = FiscalMonth
	From 
		dbo.BRS_Config

	Set @nErrorCode = @@Error
End

-- add new xxx RI 
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print '1. Add new PromotionCode...'

	INSERT INTO BRS_Promotion
	(PromotionCode)
	SELECT
		DISTINCT [WO$SPM_secondary_promotion_code]
	FROM
		Integration.F55520_daily_sales_order_header_detail_workfile w 
	WHERE 
		NOT EXISTS 
			(SELECT * 
				FROM BRS_Promotion p 
				WHERE w.[WO$SPM_secondary_promotion_code] = p.PromotionCode
			) AND
		-- JDE promo can be 3, but we store 2 
		(LEN(w.[WO$SPM_secondary_promotion_code]) = 2) AND
		(1=1)


	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Update BRS_Transaction - Chargeback'

		-- update here
	UPDATE
		BRS_Transaction
	SET
		ExtChargebackAmt = WO$CBA_chargeback_amount * WOUORG_quantity
	FROM
		BRS_Transaction 
	
		INNER JOIN Integration.F55520_daily_sales_order_header_detail_workfile AS s 
		ON BRS_Transaction.SalesOrderNumberKEY = s.WODOCO_salesorder_number AND 
			BRS_Transaction.DocType = s.WODCTO_order_type AND 
			BRS_Transaction.LineNumber = ROUND(s.WOLNID_line_number * 1000, 0)
	WHERE
	--	(BRS_Transaction.FiscalMonth >= 202311) AND 
	--	(BRS_Transaction.SalesDate = '2023-08-22') AND 
		(ABS(ISNULL(BRS_Transaction.ExtChargebackAmt, 0) - s.WO$CBA_chargeback_amount * s.WOUORG_quantity) > 0.01) AND 
		(1 = 1)


	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Update BRS_TransactionDW - OrderPromotionCode'

	UPDATE
		BRS_TransactionDW
	SET
		OrderPromotionCode = LEFT([WO$SPM_secondary_promotion_code],2)
	FROM
		BRS_TransactionDW 
	
		INNER JOIN Integration.F55520_daily_sales_order_header_detail_workfile AS s 
	
		ON BRS_TransactionDW.SalesOrderNumber = s.WODOCO_salesorder_number AND 
		BRS_TransactionDW.DocType = s.WODCTO_order_type AND 
		BRS_TransactionDW.LineNumber = ROUND(s.WOLNID_line_number * 1000, 0) AND 
		BRS_TransactionDW.OrderPromotionCode <> s.WO$SPM_secondary_promotion_code
	WHERE
	--	(BRS_TransactionDW.CalMonth >= 202310) AND 
		(BRS_TransactionDW.OrderPromotionCode = '') AND 
	--	([WO$SPM_secondary_promotion_code] not in ('', 'FLE', 'MET')) AND
		(1 = 1)

	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Update BRS_TransactionDW - GPAtFileCostAmt'

	UPDATE
		BRS_TransactionDW
	SET
		GPAtFileCostAmt = BRS_TransactionDW.NetSalesAmt - s.WO$FCS_file_cost * ShippedQty
	FROM
		BRS_TransactionDW 

		INNER JOIN Integration.F55520_daily_sales_order_header_detail_workfile AS s 
	ON BRS_TransactionDW.SalesOrderNumber = s.WODOCO_salesorder_number AND 
		BRS_TransactionDW.DocType = s.WODCTO_order_type AND 
		BRS_TransactionDW.LineNumber = ROUND(s.WOLNID_line_number * 1000, 0)
	WHERE
--		(BRS_TransactionDW.CalMonth >= 202310) AND 
		-- do not change if set already
		(BRS_TransactionDW.GPAtFileCostAmt = 0) AND 

		-- set if initial
		(ABS(BRS_TransactionDW.NetSalesAmt - s.WO$FCS_file_cost * ShippedQty - BRS_TransactionDW.GPAtFileCostAmt) > 0.01) AND 
		(1 = 1)

	Set @nErrorCode = @@Error
End

--

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Clear Stage'	

	Delete FROM Integration.F55520_daily_sales_order_header_detail_workfile

	Set @nErrorCode = @@Error
End


if (@bDebug <> 0)
	Set @nErrorCode = 512

-- Call error message on Error
if (@nErrorCode <> 0)
Begin
	Set @sMessage = '[ds].[jde_transaction_update_legacy_proc]'
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


END
GO

GRANT EXECUTE ON [ds].[jde_transaction_update_legacy_proc] TO [maint_role]
GO


-- prod run
-- EXECUTE [ds].[jde_transaction_update_legacy_proc]  @bDebug=0


-- debug run
-- EXECUTE [ds].[jde_transaction_update_legacy_proc]  @bDebug=1
-- 178 128 @ 2m

-- testing


-- select distinct WODGL__gl_date from Integration.F55520_daily_sales_order_header_detail_workfile