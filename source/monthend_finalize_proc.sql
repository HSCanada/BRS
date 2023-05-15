SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[monthend_finalize_proc] 
	@bDebug as smallint = 1
AS
/******************************************************************************
**	File:	
**	Name: [monthend_finalize_proc]
**	Desc: set final, post-close values.  Based on [monthend_snapshot_proc]
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
**	Date: 27 Mar 23
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
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
	Print 'Proc: monthend_finalize_proc'
	Print 'Desc: set final, post-close values'
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
	Print 'Confirm BatchStatus NOT finalized (5)'
	Print @nCurrentFiscalYearmoNum
	Print Convert(varchar, @nBatchStatus)
	Print 'post-process: checking steps 1 - 11'
End

-- only run once
If (@nBatchStatus <> 5)
Begin
	print 'Exiting:  cannot run finalize more than once!'
	Set @nErrorCode = 999
End
Else
Begin

------------------------------------------------------------------------------------------------------
-- post-process
------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- Part 3 - Global update that is consistent with finacial
--				run after ME adjustment loaded (day 7+)
-------------------------------------------------------------------------------

-- Global 

--> tests here - manual 
-- (see print ('T01: missing ENTITY_sales'), etc)
	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print ('1. correct lease GLBU based on GLBUClass')

		UPDATE       BRS_Transaction
		SET
			GL_BusinessUnit = '020019000000'
			,GL_Object_Sales = '4130'
			,GL_Subsidiary_Sales = ''
			,GL_Object_Cost = ''
			,GL_Subsidiary_Cost = ''
			,GL_Subsidiary_ChargeBack = ''
			,GL_Object_ChargeBack = ''
		WHERE
			(GLBU_Class = 'LEASE') AND 
			(GL_BusinessUnit = '') AND
			(BRS_Transaction.FiscalMonth = @nCurrentFiscalYearmoNum)

		Set @nErrorCode = @@Error
	End


-- SetGLBU 
	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print ('2. sales key update')

		UPDATE
			BRS_Transaction
		SET
			[gl_account_sales_key] = a.[gl_account_key]
		FROM
			hfm.account_master_F0901 AS a 
			INNER JOIN BRS_Transaction 
			ON a.GMMCU__business_unit = BRS_Transaction.GL_BusinessUnit AND 
				a.GMOBJ__object_account = BRS_Transaction.GL_Object_Sales AND 
				a.GMSUB__subsidiary = BRS_Transaction.GL_Subsidiary_Sales
		WHERE
			ISNULL([gl_account_sales_key],0) <> a.[gl_account_key] AND
			(BRS_Transaction.FiscalMonth = @nCurrentFiscalYearmoNum)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print ('3. cost key update')
	
		UPDATE
			BRS_Transaction
		SET
			[gl_account_cost_key] = a.[gl_account_key]
		FROM
			hfm.account_master_F0901 AS a 
			INNER JOIN BRS_Transaction 
			ON a.GMMCU__business_unit = BRS_Transaction.GL_BusinessUnit AND 
				a.GMOBJ__object_account = BRS_Transaction.GL_Object_Cost AND 
				a.GMSUB__subsidiary = BRS_Transaction.GL_Subsidiary_Cost
		WHERE
			ISNULL([gl_account_cost_key],0) <> a.[gl_account_key] AND
			(BRS_Transaction.FiscalMonth = @nCurrentFiscalYearmoNum)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print ('4. chargeback update')

		UPDATE
			BRS_Transaction
		SET
			[gl_account_chargeback_key] = a.[gl_account_key]
		FROM
			hfm.account_master_F0901 AS a 
			INNER JOIN BRS_Transaction 
			ON a.GMMCU__business_unit = BRS_Transaction.GL_BusinessUnit AND 
				a.GMOBJ__object_account = BRS_Transaction.GL_Object_ChargeBack AND 
				a.GMSUB__subsidiary = BRS_Transaction.GL_Subsidiary_ChargeBack
		WHERE
			ISNULL([gl_account_chargeback_key],0) <> a.[gl_account_key] AND
			(BRS_Transaction.FiscalMonth = @nCurrentFiscalYearmoNum)

		Set @nErrorCode = @@Error
	End

-- update BRS_ItemCategory!global for new codes first
	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '5. set Global Item Group - Lease except'
		UPDATE       BRS_ItemHistory
			SET [MinorProductClass] = '701-**-**'
		WHERE
			(BRS_ItemHistory.Item = '105ZZZZ') AND 
			FiscalMonth BETWEEN 202301 AND 202302

		UPDATE       [dbo].[BRS_Transaction]
			SET Item = '105ZZZZ'
		-- SELECT *
		FROM
			[dbo].[BRS_Transaction]
		WHERE
			([GLBU_Class]=  'LEASE') AND 
			-- ([GL_BusinessUnit] ='020019000000') AND
			(BRS_Transaction.FiscalMonth = @nCurrentFiscalYearmoNum)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '6. set Financial services dummy code - Transaction'
		UPDATE       [dbo].[BRS_Transaction]
			SET Item = '105ZZZZ'
		-- SELECT *
		FROM
			[dbo].[BRS_Transaction]
		WHERE
			([GLBU_Class]=  'LEASE') AND 
			-- ([GL_BusinessUnit] ='020019000000') AND
			(BRS_Transaction.FiscalMonth = @nCurrentFiscalYearmoNum)

		Set @nErrorCode = @@Error
	End

-------------------------------------------------------------------------------
-- xxx fix 3D printer new mapping, 10 Nov 21
-- update BRS_ItemCategory!global for new codes first

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '7. set Global Item Group - AFTER manual maint'
		UPDATE       BRS_ItemHistory
			SET global_product_class = BRS_ItemCategory.global_product_class
		FROM
			BRS_ItemHistory  INNER JOIN
			BRS_ItemCategory  ON BRS_ItemHistory.MinorProductClass = BRS_ItemCategory.MinorProductClass
		WHERE
			(BRS_ItemHistory.Item > '') AND 
			-- null filter not needed below
			BRS_ItemHistory.global_product_class <> BRS_ItemCategory.global_product_class  AND
			(FiscalMonth = @nCurrentFiscalYearmoNum)

		Set @nErrorCode = @@Error
	End

-- add the GL vs Global consistence rules corections here...
	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '8. set global - Transaction level'
		UPDATE
			BRS_Transaction
		SET
			global_product_class_key = ig.global_product_class_key
		FROM
			BRS_Transaction 

			INNER JOIN 	BRS_ItemHistory AS ih 
			ON BRS_Transaction.Item = ih.Item AND 
				BRS_Transaction.FiscalMonth = ih.FiscalMonth 
		
			INNER JOIN hfm.global_product AS ig 
			ON ih.global_product_class = ig.global_product_class
		WHERE
			(BRS_Transaction.Item > '') AND 
			(ISNULL(BRS_Transaction.global_product_class_key,0) <> ig.global_product_class_key) AND
			(BRS_Transaction.FiscalMonth = @nCurrentFiscalYearmoNum)

		Set @nErrorCode = @@Error
	End

-- 50s in dev
	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print ('9. global JDE - fix')
		UPDATE
			BRS_Transaction
		SET
			global_product_class_key = iglob_def.global_product_class_key
		FROM
			BRS_Transaction 

			INNER JOIN BRS_BusinessUnitClass AS bu_trans 
			ON BRS_Transaction.GLBU_Class = bu_trans.GLBU_Class 

			INNER JOIN hfm.global_product AS iglob 
			ON BRS_Transaction.global_product_class_key = iglob.global_product_class_key 

			INNER JOIN BRS_BusinessUnitClass AS iglob_bu 
			ON iglob.GLBU_Class_map = iglob_bu.GLBU_Class AND 
			bu_trans.GLBU_Class_map <> iglob_bu.GLBU_Class_map 

			INNER JOIN hfm.global_product AS iglob_def 
			ON bu_trans.global_product_class_default = iglob_def.global_product_class

		WHERE
		--	(BRS_Transaction.DocType <> 'AA') AND 
			(BRS_Transaction.SalesDivision < 'AZA') AND 
			(bu_trans.GLBU_ClassUS_L1 < 'ZZZZZ') AND 
			(bu_trans.global_product_class_default <> '') AND 
			(BRS_Transaction.global_product_class_key <> iglob_def.global_product_class_key) AND
			(BRS_Transaction.FiscalMonth = @nCurrentFiscalYearmoNum)

		Set @nErrorCode = @@Error
	End

-- set HiCAD to 850-99, if missing
	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print ('10. global - set HiCAD to 850-99, if missing')
		UPDATE       BRS_Transaction
		SET                global_product_class_key = 3310
		FROM            BRS_Transaction INNER JOIN
								 BRS_BusinessUnitClass AS bu_trans ON BRS_Transaction.GLBU_Class = bu_trans.GLBU_Class
		WHERE
			(BRS_Transaction.SalesDivision < 'AZA') AND 
			(BRS_Transaction.GLBU_Class IN ('EQDIG', 'HICAD')) AND 
			(bu_trans.GLBU_ClassUS_L1 < 'ZZZZZ') AND 
			(BRS_Transaction.global_product_class_key IS NULL) AND 
			(BRS_Transaction.FiscalMonth = @nCurrentFiscalYearmoNum)

		Set @nErrorCode = @@Error
	End


-- set BSOLN to 930-99, if missing
	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print ('11. global - set BSOLN to 930-99, if missing')
		UPDATE       BRS_Transaction
		SET                global_product_class_key = 3311
		-- SELECT * 
		FROM            BRS_Transaction INNER JOIN
								 BRS_BusinessUnitClass AS bu_trans ON BRS_Transaction.GLBU_Class = bu_trans.GLBU_Class
		WHERE
			(BRS_Transaction.SalesDivision < 'AZA') AND 
			(BRS_Transaction.GLBU_Class IN ('BSOLN')) AND 
			(bu_trans.GLBU_ClassUS_L1 < 'ZZZZZ') AND 
			(BRS_Transaction.global_product_class_key IS NULL) AND 
			(BRS_Transaction.FiscalMonth = @nCurrentFiscalYearmoNum)

		Set @nErrorCode = @@Error
	End

--
------------------------------------------------------------------------------------------------------------
-- Wrap-up routines.  
------------------------------------------------------------------------------------------------------------

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			Print 'Set BatchStatus to Finalize complete'	

		Update
			[dbo].[BRS_FiscalMonth]
		Set 
			[me_status_cd] = 10
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

-- UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202303

-- Prod
-- EXEC dbo.monthend_finalize_proc @bDebug=0

-- Debug, 1m
-- EXEC dbo.monthend_finalize_proc @bDebug=1

