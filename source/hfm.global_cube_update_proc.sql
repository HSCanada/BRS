SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE hfm.global_cube_update_proc
	@bDebug as smallint = 1
AS
/******************************************************************************
**	File:	
**	Name: hfm.global_cube_update_proc
**	Desc: update gps analysis codes
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
**	Date: 12 Apr 23
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
	Print 'Proc: hfm.global_cube_update_proc'
	Print 'Desc: update gps analysis codes'
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
	Print 'Confirm BatchStatus finalized (>=10)'
	Print @nCurrentFiscalYearmoNum
	Print Convert(varchar, @nBatchStatus)
	Print 'updating steps 1 - 6'
End

-- only run once
If (@nBatchStatus <10)
Begin
	print 'Exiting:  monthend not finalized!'
	Set @nErrorCode = 999
End
Else
Begin


-------------------------------------------------------------------------------
-- Part 4 - GPS update, run after ME adjustment loaded
-------------------------------------------------------------------------------

-- Set GPS rules at the BRS_Transaction.GpsKey level

-- seq 0 of 2

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '1. clear GpsKey'
		
		UPDATE
			BRS_Transaction
		SET
			GpsKey = NULL
		WHERE
			(NOT GpsKey IS NULL) AND
			(BRS_Transaction.FiscalMonth = @nCurrentFiscalYearmoNum)

		Set @nErrorCode = @@Error
	End

	-- 1 min
	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '2. set GpsKey 1 of 2'

		UPDATE
			BRS_Transaction
		SET
			GpsKey = g.GpsKey
			-- SELECT count(*) 
		FROM
			BRS_ItemHistory AS h 

			INNER JOIN BRS_Transaction 
			ON h.Item = BRS_Transaction.Item AND 
				h.FiscalMonth = BRS_Transaction.FiscalMonth 

			INNER JOIN hfm.gps_code_rule AS r 
			ON BRS_Transaction.GLBU_Class LIKE RTRIM(r.GLBU_Class_WhereClauseLike) AND 
				BRS_Transaction.GL_BusinessUnit LIKE RTRIM(r.BusinessUnit_WhereClauseLike) AND 
				h.MinorProductClass LIKE RTRIM(r.MinorProductClass_WhereClauseLike) AND 
				h.Supplier LIKE RTRIM(r.Supplier_WhereClauseLike) AND 
				BRS_Transaction.SalesDivision LIKE RTRIM(r.SalesDivision_WhereClauseLike) AND
				1 = 1 

			INNER JOIN hfm.gps_code AS g 
			ON r.Gps_Code_TargKey = g.GpsCode
		WHERE
			-- live
			(r.Sequence in (110, 120)) AND 
			(BRS_Transaction.FiscalMonth=@nCurrentFiscalYearmoNum)

		Set @nErrorCode = @@Error
	End

	-- 30s
	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '3. set GpsKey 2 of 2'

		UPDATE
			BRS_Transaction
		SET
			GpsKey = g.GpsKey
			-- SELECT count(*)
		FROM
			BRS_ItemHistory AS h 
			INNER JOIN BRS_Transaction 
			ON h.Item = BRS_Transaction.Item AND 
			h.FiscalMonth = BRS_Transaction.FiscalMonth 

			INNER JOIN hfm.gps_code_rule AS r 
			ON BRS_Transaction.GLBU_Class LIKE RTRIM(r.GLBU_Class_WhereClauseLike) AND 
			BRS_Transaction.GL_BusinessUnit LIKE RTRIM(r.BusinessUnit_WhereClauseLike) AND 
			h.MinorProductClass LIKE RTRIM(r.MinorProductClass_WhereClauseLike) AND 
			h.Supplier LIKE RTRIM(r.Supplier_WhereClauseLike) AND 
			BRS_Transaction.SalesDivision LIKE RTRIM(r.SalesDivision_WhereClauseLike) AND
			1 = 1 

			INNER JOIN hfm.gps_code AS g 
			ON r.Gps_Code_TargKey = g.GpsCode
		WHERE
			(BRS_Transaction.GpsKey IS NULL) AND
			-- live
			(r.Sequence in (230, 240)) AND 
			(BRS_Transaction.FiscalMonth=@nCurrentFiscalYearmoNum)
			
		Set @nErrorCode = @@Error
	End

--
	-- 30s
	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '4. patch global code (where JDE is incorrect.  Temp fix)'

		UPDATE
			BRS_Transaction
		SET
			global_product_class_key = s.global_product_class_key
			, global_product_class_keyORG = BRS_Transaction.global_product_class_key
		FROM
			BRS_Transaction 

			INNER JOIN hfm.gps_fix_item_jde_temp AS fix 
			ON BRS_Transaction.Item = fix.Item 

			INNER JOIN hfm.global_product AS s 
			ON fix.global_product_class_new = s.global_product_class AND 
			ISNULL(BRS_Transaction.global_product_class_key, 0) <> s.global_product_class_key

		WHERE
			(BRS_Transaction.FiscalMonth = @nCurrentFiscalYearmoNum)

			
		Set @nErrorCode = @@Error
	End

--
	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print ('5. GPS crosswalk fix - Lab')

		UPDATE
			BRS_Transaction
		SET
			GpsKey = gps_new.[GpsKey]
		-- SELECT  s.[FiscalMonth] ID, s.GLBU_Class, s.[DocType], s.item, iglob.[global_product_class], RTRIM(ch.HIST_MarketClass) HIST_MarketClass, [GpsCode_Den], [GpsCode_Lab], gps.[GpsCode] GpsCodeCURR, gps_new.[GpsCode]
		FROM
			BRS_Transaction s

			-- customer history
			INNER JOIN [dbo].[BRS_CustomerFSC_History] as ch
			ON s.Shipto = ch.[Shipto] AND
				s.[FiscalMonth] = ch.[FiscalMonth]

			-- Current Global
			INNER JOIN [hfm].[global_product] as iglob
			ON s.[global_product_class_key] = iglob.global_product_class_key

			-- GPS Current
			LEFT JOIN [hfm].[gps_code] gps
			ON s.GpsKey = gps.[GpsKey]

			-- GPS Lab New
			INNER JOIN [hfm].[gps_code] gps_new
			ON iglob.GpsCode_Lab = gps_new.[GpsCode]

		WHERE
			-- exclude internal
			(s.SalesDivision < 'AZA') AND 
			-- exclude GL based lines
			(s.GLBU_Class NOT IN('ZZZZZ', 'PROMX', 'PROMC', 'PROMM', 'ALLOE', 'ALLOM', 'ALLOT', 'CAMLG', 'FREIG', 'REBAT', 'EXNSW', 'BSOLN'  )) AND
			-- include item base global (these set by prior rules)
			(iglob.[global_product_class] <> '') AND

			-- Lab select
			(LEFT(ch.HIST_MarketClass,1)='Z') AND
			(ISNULL(gps.[GpsCode],'') <> ISNULL([GpsCode_Lab],'')) AND

			-- Update Time Select
			(s.FiscalMonth=@nCurrentFiscalYearmoNum) AND 
			(1 = 1)
		-- stop here for update
		-- Order by 1

		Set @nErrorCode = @@Error
	End


	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print ('6. GPS crosswalk fix - Den')

		UPDATE
			BRS_Transaction
		SET
			GpsKey = gps_new.[GpsKey]
		-- SELECT  s.[FiscalMonth] ID, s.GLBU_Class, s.[DocType], s.item, iglob.[global_product_class], RTRIM(ch.HIST_MarketClass) HIST_MarketClass, [GpsCode_Den], [GpsCode_Lab], gps.[GpsCode] GpsCodeCURR, gps_new.[GpsCode]
		FROM
			BRS_Transaction s

			-- customer history
			INNER JOIN [dbo].[BRS_CustomerFSC_History] as ch
			ON s.Shipto = ch.[Shipto] AND
				s.[FiscalMonth] = ch.[FiscalMonth]

			-- Current Global
			INNER JOIN [hfm].[global_product] as iglob
			ON s.[global_product_class_key] = iglob.global_product_class_key

			-- GPS Current
			LEFT JOIN [hfm].[gps_code] gps
			ON s.GpsKey = gps.[GpsKey]

			-- GPS Den New
			INNER JOIN [hfm].[gps_code] gps_new
			ON iglob.GpsCode_Den = gps_new.[GpsCode]

		WHERE
			-- exclude internal
			(s.SalesDivision < 'AZA') AND 
			-- exclude GL based lines
			(s.GLBU_Class NOT IN('ZZZZZ', 'PROMX', 'PROMC', 'PROMM', 'ALLOE', 'ALLOM', 'ALLOT', 'CAMLG', 'FREIG', 'REBAT', 'EXNSW', 'BSOLN'  )) AND
			-- include item base global (these set by prior rules)
			(iglob.[global_product_class] <> '') AND

			-- Den select
			(LEFT(ch.HIST_MarketClass,1)<>'Z') AND
			(ISNULL(gps.[GpsCode],'') <> ISNULL([GpsCode_Den],'')) AND

			-- Update Time Select
			(s.FiscalMonth=@nCurrentFiscalYearmoNum) AND 
			(1 = 1)
		-- stop here for update
		-- Order by 7

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
			[me_status_cd] = 15
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
	Set @sMessage = 'hfm.global_cube_update_proc'
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
-- EXEC hfm.global_cube_update_proc @bDebug=0

-- Debug, 2m
-- EXEC hfm.global_cube_update_proc @bDebug=1

