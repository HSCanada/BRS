		SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE usd.BRS_BE_Dimension_load_proc
	@bClearStage as smallint = 0, 
	@bDebug as smallint = 1
AS

/******************************************************************************
**	File: 
**	Name: BRS_BE_Dimension_load_proc
**	Desc: Load US Item Dimentions 
**
**              
**	Return values:  @@Error
**
**	Called by:   
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**  @bClearStage - clear stage & exit
**	@bDebug - debug = rollback changes
**
**	Auth: tmc
**	Date: 22 Apr 19
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	9 Jun 19	tmc		add subminorcode
*******************************************************************************/

BEGIN

	Declare @nErrorCode int, @nTranCount int
	Declare @sMessage varchar(255)

	Set @nErrorCode = @@Error
	Set @nTranCount = @@Trancount

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


------------------------------------------------------------------------------------------------------------
-- Update routines.  
------------------------------------------------------------------------------------------------------------

	if (@bDebug <> 0)
		Print 'DEBUG MODE.'

	if (@bClearStage <> 0)
	Begin
		if (@bDebug <> 0)
			Print 'Clear tables.'

		TRUNCATE TABLE STAGE_BRS_ItemFull

		Set @nErrorCode = @@Error
	End
	Else
	Begin

		If (@nErrorCode = 0) 
		Begin
			if (@bDebug <> 0)
				Print 'Add new MPC (ItemFull) ...'

				INSERT INTO BRS_ItemMPC
									  (MajorProductClass)
				SELECT DISTINCT ISNULL(t.MajorProductClass,'') AS dt
				FROM         STAGE_BRS_ItemFull AS t
				WHERE     (NOT EXISTS
										  (SELECT     *
											FROM          BRS_ItemMPC AS BRS_ItemMPC_1
											WHERE       MajorProductClass = ISNULL(t.MajorProductClass,'') ))
			Set @nErrorCode = @@Error
		End

		If (@nErrorCode = 0) 
		Begin
			if (@bDebug <> 0)
				Print 'Add new MinorProductClass (ItemFull) ...'

				INSERT INTO dbo.BRS_ItemCategory
									  (MinorProductClass)
				SELECT DISTINCT ISNULL(t.MinorProductClass,'') AS dt
				FROM         STAGE_BRS_ItemFull AS t
				WHERE     (NOT EXISTS
										  (SELECT     *
											FROM          dbo.BRS_ItemCategory AS BRS_ItemCategory_1
											WHERE       MinorProductClass = ISNULL(t.MinorProductClass,'') ))
			Set @nErrorCode = @@Error
		End

	-- Update dbo.BRS_ItemSupplier

		If (@nErrorCode = 0) 
		Begin
			if (@bDebug <> 0)
				Print 'Add new Supplier (ItemFull) ...'

				INSERT INTO usd.BRS_ItemSupplier
									  (Supplier, supplier_nm, CountryGroup)
				SELECT DISTINCT ISNULL(t.Supplier,'') AS dt, '', ''
				FROM         STAGE_BRS_ItemFull AS t
				WHERE     (NOT EXISTS
										  (SELECT     *
											FROM          BRS_ItemSupplier AS BRS_ItemCategory_1
											WHERE       Supplier = ISNULL(t.Supplier,'') ))
			Set @nErrorCode = @@Error
		End

		If (@nErrorCode = 0) 
		Begin
			if (@bDebug <> 0)
				Print 'Add new Brand (ItemFull) ...'

				INSERT INTO usd.BRS_ItemSupplier
									  (Supplier, supplier_nm, CountryGroup)
				SELECT DISTINCT ISNULL(t.Brand,'') AS dt, '', ''
				FROM         STAGE_BRS_ItemFull AS t
				WHERE     (NOT EXISTS
										  (SELECT     *
											FROM          BRS_ItemSupplier AS BRS_ItemCategory_1
											WHERE       Supplier = ISNULL(t.Brand,'') ))
			Set @nErrorCode = @@Error
		End

		If (@nErrorCode = 0) 
		Begin

			if (@bDebug <> 0)
				Print 'UPDATE BRS_Item changes'

			UPDATE    usd.BRS_Item
			SET 

				ItemDescription= LEFT(ISNULL(s.ItemDescription, ''),40), 
				Supplier= ISNULL(s.Supplier, ''), 
				Size= ISNULL(s.Size, ''), 
				Strength= LEFT(ISNULL(s.Strength, ''),12), 
				ManufPartNumber= Left(ISNULL(s.ManufPartNumber, ''),15), 
				FamilySetLeader= ISNULL(s.FamilySetLeader, ''), 
				ItemStatus= ISNULL(s.ItemStatus, ''), 
				Label= ISNULL(s.Label, ''), 
				StockingType= ISNULL(s.StockingType, ''), 
				GLCategory= ISNULL(s.GLCategory, ''), 
				TagableItemFlag= ISNULL(s.TagableItemFlag, ''), 
				ItemCreationDate= ISNULL(s.ItemCreationDate, '1 Jan 1980'), 
				SalesCategory= ISNULL(s.SalesCategory, ''), 
				MajorProductClass= ISNULL(s.MajorProductClass, ''), 
				SubMajorProdClass= ISNULL(s.SubMajorProdClass, ''), 
				MinorProductClass= ISNULL(s.MinorProductClass, ''), 
				CurrentFileCost= ISNULL(s.CurrentFileCost, 0), 
				FreightAdjPct= ISNULL(s.FreightAdjPct, 0), 
				CorporateMarketAdjustmentPct= ISNULL(s.CorporateMarketAdjustmentPct, 0), 
				DivisionalMarketAdjustmentPct= ISNULL(s.DivisionalMarketAdjustmentPct, 0), 
				CurrentCorporatePrice= ISNULL(s.CurrentCorporatePrice, 0),
				Brand = ISNULL(s.Brand, ''),
				[SubMinorProductCodec] = ISNULL(s.SMNPRCLID,'*')

             
			FROM         
				STAGE_BRS_ItemFull AS s 

				INNER JOIN usd.BRS_Item d
				ON s.Item = d.Item

			WHERE

				d.ItemDescription <> LEFT(ISNULL(s.ItemDescription, ''),40) OR 
				d.Supplier <> ISNULL(s.Supplier, '')  OR  
				d.Size <> ISNULL(s.Size, '')  OR 
				d.Strength <> LEFT(ISNULL(s.Strength, ''),12)  OR 
				d.ManufPartNumber <> Left(ISNULL(s.ManufPartNumber, ''),15) OR  
				d.FamilySetLeader <> ISNULL(s.FamilySetLeader, '') OR  
				d.ItemStatus <> ISNULL(s.ItemStatus, '') OR  
				d.Label <> ISNULL(s.Label, '') OR  
				d.StockingType <> ISNULL(s.StockingType, '') OR   
				d.GLCategory <> ISNULL(s.GLCategory, '') OR  
				d.TagableItemFlag <> ISNULL(s.TagableItemFlag, '') OR  
				d.ItemCreationDate <> ISNULL(s.ItemCreationDate, '1 Jan 1980') OR  
				d.SalesCategory <> ISNULL(s.SalesCategory, '') OR  
				d.MajorProductClass <> ISNULL(s.MajorProductClass, '') OR  
				d.SubMajorProdClass <> ISNULL(s.SubMajorProdClass, '') OR  
				d.MinorProductClass <> ISNULL(s.MinorProductClass, '') OR  
				d.CurrentFileCost <> ISNULL(s.CurrentFileCost, 0) OR  
				d.FreightAdjPct <> ISNULL(s.FreightAdjPct, 0) OR  
				d.CorporateMarketAdjustmentPct <> ISNULL(s.CorporateMarketAdjustmentPct, 0) OR  
				d.DivisionalMarketAdjustmentPct <> ISNULL(s.DivisionalMarketAdjustmentPct, 0) OR  
				d.CurrentCorporatePrice <> ISNULL(s.CurrentCorporatePrice, 0) OR
				d.Brand <> ISNULL(s.Brand, '') OR
				d.[SubMinorProductCodec] <> ISNULL(s.SMNPRCLID,'*')

			Set @nErrorCode = @@Error
		End


		If (@nErrorCode = 0) 
		Begin

			if (@bDebug <> 0)
				Print 'ADD BRS_Item NEW'

			INSERT INTO usd.BRS_Item (

				Item, 
				ItemDescription,
				Supplier, 
				Size,
				Strength,
				ManufPartNumber, 
				FamilySetLeader,
				ItemStatus, 
				Label, 
				StockingType, 
				GLCategory, 
				TagableItemFlag,  
				ItemCreationDate,  
				SalesCategory,  
				MajorProductClass,  
				SubMajorProdClass,  
				MinorProductClass,  
				CurrentFileCost,  
				FreightAdjPct,  
				CorporateMarketAdjustmentPct, 
				DivisionalMarketAdjustmentPct,  
				CurrentCorporatePrice,
				Brand,
				[SubMinorProductCodec]
			)

			SELECT 
				s.Item, 
				LEFT(ISNULL(s.ItemDescription, ''),40) ItemDescription,
				ISNULL(s.Supplier, '')  Supplier, 
				ISNULL(s.Size, '')  Size,
				LEFT(ISNULL(s.Strength, ''),12)  Strength,
				Left(ISNULL(s.ManufPartNumber, ''),15) ManufPartNumber, 
				ISNULL(s.FamilySetLeader, '') FamilySetLeader,
				ISNULL(s.ItemStatus, '') ItemStatus, 
				ISNULL(s.Label, '') Label, 
				ISNULL(s.StockingType, '') StockingType, 
				ISNULL(s.GLCategory, '') GLCategory, 
				ISNULL(s.TagableItemFlag, '') TagableItemFlag,  
				ISNULL(s.ItemCreationDate, '1 Jan 1980') ItemCreationDate,  
				ISNULL(s.SalesCategory, '') SalesCategory,  
				ISNULL(s.MajorProductClass, '') MajorProductClass,  
				ISNULL(s.SubMajorProdClass, '') SubMajorProdClass,  
				ISNULL(s.MinorProductClass, '') MinorProductClass,  
				ISNULL(s.CurrentFileCost, 0) CurrentFileCost,  
				ISNULL(s.FreightAdjPct, 0) FreightAdjPct,  
				ISNULL(s.CorporateMarketAdjustmentPct, 0) CorporateMarketAdjustmentPct, 
				ISNULL(s.DivisionalMarketAdjustmentPct, 0) DivisionalMarketAdjustmentPct,  
				ISNULL(s.CurrentCorporatePrice, 0) CurrentCorporatePrice,
				ISNULL(Brand,''),
				ISNULL(s.SMNPRCLID,'*')
			FROM         
				STAGE_BRS_ItemFull AS s
			WHERE	(NOT EXISTS
									  (SELECT	*
										FROM	usd.BRS_Item AS BRS_Item_1
										WHERE	Item = s.Item)
					)

			Set @nErrorCode = @@Error
		End

	End -- not clear stage


	------------------------------------------------------------------------------------------------------------
	-- Wrap-up routines.  
	------------------------------------------------------------------------------------------------------------

	if (@bDebug <> 0)
		Set @nErrorCode = 512

	-- Call error message on Error
	if (@nErrorCode <> 0)
	Begin
		Set @sMessage = '[usd].[BRS_BE_Dimension_load_proc]'
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

-- Exec usd.BRS_BE_Dimension_load_proc @bClearStage=0, @bDebug=0

-- Exec usd.BRS_BE_Dimension_load_proc @bClearStage=0, @bDebug=1



