		SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE BRS_BE_Dimension_load_proc 
	@bDebug as smallint = 1
AS

/******************************************************************************
**	File: 
**	Name: BRS_BE_Dimension_load_proc
**	Desc: Load Weekly Customer & Item Dimentions 
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
**	Date: 9 Jan 15
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	21 Jan 15	tmc		Fix Postal coded to truncate char(10)
**  19 Feb 15	tmc		Add update NEW logic for BRS_ItemCategory & BRS_ItemSupplier
**	23 Feb 15	tmc		Fixed 19 Feb update so that new Supplier BEFORE Item update (RI)
**	28 May 15	tmc		Added Parent field to update
**	04 Dec 15	tmc		Corrected for widened Desc and Strect field (added Left(...).  Due to French corruption of output
**	08 Jan 16	tmc		renamed to BRS_BE* and moved to production
--	20 Sep 16	tmc		added TS territory load
--	07 Dec 16	tmc		Moved new BT for RI logic
--	25 May 17	tmc		Added FSA for GEO ranking
--	19 Jul 17	tmc		Added Brand to Item for Pricing
**    
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

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			Print 'Add new VPA ...'

			INSERT INTO BRS_CustomerVPA
								  (VPA)
			SELECT DISTINCT ISNULL(t.VPA,'') AS dt
			FROM         STAGE_BRS_CustomerFull AS t
			WHERE     (NOT EXISTS
									  (SELECT     *
										FROM          BRS_CustomerVPA AS BRS_CustomerVPA_1
										WHERE       VPA = ISNULL(t.VPA,'') ))
		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			Print 'Add new FSC (from Cust FULL)...'

			INSERT INTO BRS_FSC_Rollup
								  (TerritoryCd, FSCRollup, Branch)
			SELECT DISTINCT TerritoryCd, TerritoryCd, '' AS br
			FROM         STAGE_BRS_CustomerFull AS c
			WHERE     (NOT EXISTS
									  (SELECT     *
										FROM          BRS_FSC_Rollup AS BRS_TS_Rollup_1
										WHERE       TerritoryCd = c.TerritoryCd ))
		Set @nErrorCode = @@Error
	End

--	20 Sep 16	tmc		added TS territory load

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			Print 'Add new TS (from Cust FULL)...'

			INSERT INTO BRS_TS_Rollup
								  (TsTerritoryCd)
			SELECT DISTINCT TsTerritoryCd
			FROM         STAGE_BRS_CustomerFull AS c
			WHERE     (NOT EXISTS
									  (SELECT     *
										FROM          BRS_TS_Rollup AS BRS_TS_Rollup_1
										WHERE       TsTerritoryCd = c.TsTerritoryCd ))
		Set @nErrorCode = @@Error
	End


	--	07 Dec 16	tmc		Moved new BT for RI logic 
	-- added 24 Aug 15, tmc
	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			Print 'Add new BT (from Stage)...'

			INSERT INTO BRS_CustomerBT
								  (BillTo, ShipToPrimary)
			SELECT     
				BillTo AS BillTo, 
				MIN(ShipTo) AS ShipToPrimary
			FROM         
				STAGE_BRS_CustomerFull AS t
			WHERE     (NOT EXISTS
									  (SELECT     *
										FROM          BRS_CustomerBT AS BRS_Customer_1
										WHERE      (BillTo = t.BillTo)))
			GROUP BY BillTo	

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			Print 'Add new FSA (from Stage)...'

			INSERT INTO BRS_Customer_FSA
								  (FSA)
			SELECT     
				DISTINCT LEFT(ISNULL(s.PostalCode, ''), 3) AS FSA
			FROM         
				STAGE_BRS_CustomerFull AS s
			WHERE     (NOT EXISTS
									  (SELECT     *
										FROM          BRS_Customer_FSA AS BRS_Customer_FSA_1
										WHERE      (FSA  = LEFT(ISNULL(s.PostalCode, ''), 3))))

		Set @nErrorCode = @@Error
	End


	If (@nErrorCode = 0) 
	Begin

		if (@bDebug <> 0)
			Print 'UPDATE BRS_Customer changes'

		UPDATE    BRS_Customer
		SET              
			BillTo = ISNULL(s.BillTo, 0), 
			PracticeName = ISNULL(s.PracticeName, ''), 
			MailingName = ISNULL(s.MailingName, ''), 
			AddressLine1 = ISNULL(s.AddressLine1, ''), 
			AddressLine3 = ISNULL(s.AddressLine3, ''), 
			AddressLine4 = ISNULL(s.AddressLine4, ''), 
			City = ISNULL(s.City, ''), 
			Province = ISNULL(s.Province, ''), 
			Specialty = ISNULL(s.Specialty, ''), 
			PracticeType = ISNULL(s.PracticeType, ''), 
			VPA = ISNULL(s.VPA, ''), 
			TerritoryCd = ISNULL(s.TerritoryCd, ''), 
			PostalCode = LEFT(ISNULL(s.PostalCode, ''), 10), 
			DentalGeoBranch = ISNULL(s.DentalGeoBranch, ''), 
			Country = ISNULL(s.Country, ''), 
			PhoneNo = LEFT(ISNULL(s.PhoneNo, ''),15), 
			DateAccountOpened = ISNULL(s.DateAccountOpened, '1 Jan 1980'), 
			AccountType = ISNULL(s.AccountType, ''), 
			SalesDivision = ISNULL(s.SalesDivision, ''), 
			FlyerMailOutFlag = ISNULL(s.FlyerMailOutFlag, ''), 
			SpecialHandlingInstCd = ISNULL(s.SpecialHandlingInstCd, ''),
			ParentCustomerNumber = ISNULL(s.ParentCustomerNumber, 0),

			TsTerritoryCd = ISNULL(s.TsTerritoryCd, 0),

			FSA = LEFT(ISNULL(s.PostalCode, ''), 3)


		FROM         
			STAGE_BRS_CustomerFull AS s 

			INNER JOIN BRS_Customer 
			ON s.ShipTo = BRS_Customer.ShipTo

		WHERE

			BRS_Customer.BillTo <> ISNULL(s.BillTo, 0) OR 
			BRS_Customer.PracticeName <> ISNULL(s.PracticeName, '') OR 
			BRS_Customer.MailingName <> ISNULL(s.MailingName, '') OR  
			BRS_Customer.AddressLine1 <> ISNULL(s.AddressLine1, '') OR  
			BRS_Customer.AddressLine3 <> ISNULL(s.AddressLine3, '') OR  
			BRS_Customer.AddressLine4 <> ISNULL(s.AddressLine4, '') OR  
			BRS_Customer.City <> ISNULL(s.City, '') OR  
			BRS_Customer.Province <> ISNULL(s.Province, '') OR  
			BRS_Customer.Specialty <> ISNULL(s.Specialty, '') OR  
			BRS_Customer.PracticeType <> ISNULL(s.PracticeType, '') OR  
			BRS_Customer.VPA <> ISNULL(s.VPA, '') OR  
			BRS_Customer.TerritoryCd <> ISNULL(s.TerritoryCd, '') OR  
			BRS_Customer.PostalCode <> LEFT(ISNULL(s.PostalCode, ''),10) OR  
			BRS_Customer.DentalGeoBranch <> ISNULL(s.DentalGeoBranch, '') OR  
			BRS_Customer.Country <> ISNULL(s.Country, '') OR  
			BRS_Customer.PhoneNo <> LEFT(ISNULL(s.PhoneNo, ''),15) OR  
			BRS_Customer.DateAccountOpened <> ISNULL(s.DateAccountOpened, '1 Jan 1980') OR  
			BRS_Customer.AccountType <> ISNULL(s.AccountType, '') OR  
			BRS_Customer.SalesDivision <> ISNULL(s.SalesDivision, '') OR  
			BRS_Customer.FlyerMailOutFlag <> ISNULL(s.FlyerMailOutFlag, '') OR  
			BRS_Customer.SpecialHandlingInstCd <> ISNULL(s.SpecialHandlingInstCd, '') OR
			BRS_Customer.ParentCustomerNumber <> ISNULL(s.ParentCustomerNumber, 0) OR

			BRS_Customer.TsTerritoryCd <> ISNULL(s.TsTerritoryCd, 0)  OR
			BRS_Customer.FSA <> LEFT(ISNULL(s.PostalCode, ''), 3)

		Set @nErrorCode = @@Error
	End


	If (@nErrorCode = 0) 
	Begin

		if (@bDebug <> 0)
			Print 'ADD BRS_Customer NEW'

		INSERT INTO BRS_Customer (
			s.ShipTo, 
			BillTo, 
			PracticeName, 
			MailingName, 
			AddressLine1, 
			AddressLine3, 
			AddressLine4, 
			City, 
			Province, 
			Specialty, 
			PracticeType, 
			VPA, 
			TerritoryCd, 
			PostalCode, 
			DentalGeoBranch, 
			Country, 
			PhoneNo, 
			DateAccountOpened, 
			AccountType, 
			SalesDivision, 
			FlyerMailOutFlag, 
			SpecialHandlingInstCd,
			ParentCustomerNumber,
			TsTerritoryCd,
			FSA

		)

		SELECT 
			s.ShipTo, 
			ISNULL(s.BillTo, 0) AS BillTo, 
			ISNULL(s.PracticeName, '') AS PracticeName, 
			ISNULL(s.MailingName, '') AS MailingName, 
			ISNULL(s.AddressLine1, '') AS AddressLine1, 
			ISNULL(s.AddressLine3, '') AS AddressLine3, 
			ISNULL(s.AddressLine4, '') AS AddressLine4, 
			ISNULL(s.City, '') AS City, 
			ISNULL(s.Province, '') AS Province, 
			ISNULL(s.Specialty, '') AS Specialty, 
			ISNULL(s.PracticeType, '') AS PracticeType, 
			ISNULL(s.VPA, '') AS VPA, 
			ISNULL(s.TerritoryCd, '') AS TerritoryCd, 
			LEFT(ISNULL(s.PostalCode, ''),10) AS PostalCode, 
			ISNULL(s.DentalGeoBranch, '') AS DentalGeoBranch, 
			ISNULL(s.Country, '') AS Country, 
			LEFT(ISNULL(s.PhoneNo, ''),15) AS PhoneNo, 
			ISNULL(s.DateAccountOpened, '1 Jan 1980') AS DateAccountOpened, 
			ISNULL(s.AccountType, '') AS AccountType, 
			ISNULL(s.SalesDivision, '') AS SalesDivision, 
			ISNULL(s.FlyerMailOutFlag, '') AS FlyerMailOutFlag, 
			ISNULL(s.SpecialHandlingInstCd, '') AS SpecialHandlingInstCd,
			ISNULL(s.ParentCustomerNumber, 0) AS ParentCustomerNumber,

			ISNULL(s.TsTerritoryCd, 0)  AS TsTerritoryCd,
			LEFT(ISNULL(s.PostalCode, ''), 3) AS FSA

		FROM         
			STAGE_BRS_CustomerFull AS s
		WHERE	(NOT EXISTS
								  (SELECT	*
									FROM	BRS_Customer AS BRS_Customer_1
									WHERE	ShipTo = s.ShipTo)
				)

		Set @nErrorCode = @@Error
	End


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

-- Update dbo.BRS_ItemCategory, tmc, 19 Feb 15

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

			INSERT INTO BRS_ItemSupplier
								  (Supplier)
			SELECT DISTINCT ISNULL(t.Supplier,'') AS dt
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
			Print 'UPDATE BRS_Item changes'

		UPDATE    BRS_Item
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
			Brand = ISNULL(s.Brand, '')
             
		FROM         
			STAGE_BRS_ItemFull AS s 

			INNER JOIN BRS_Item 
			ON s.Item = BRS_Item.Item

		WHERE

			BRS_Item.ItemDescription <> LEFT(ISNULL(s.ItemDescription, ''),40) OR 
			BRS_Item.Supplier <> ISNULL(s.Supplier, '')  OR  
			BRS_Item.Size <> ISNULL(s.Size, '')  OR 
			BRS_Item.Strength <> LEFT(ISNULL(s.Strength, ''),12)  OR 
			BRS_Item.ManufPartNumber <> Left(ISNULL(s.ManufPartNumber, ''),15) OR  
			BRS_Item.FamilySetLeader <> ISNULL(s.FamilySetLeader, '') OR  
			BRS_Item.ItemStatus <> ISNULL(s.ItemStatus, '') OR  
			BRS_Item.Label <> ISNULL(s.Label, '') OR  
			BRS_Item.StockingType <> ISNULL(s.StockingType, '') OR   
			BRS_Item.GLCategory <> ISNULL(s.GLCategory, '') OR  
			BRS_Item.TagableItemFlag <> ISNULL(s.TagableItemFlag, '') OR  
			BRS_Item.ItemCreationDate <> ISNULL(s.ItemCreationDate, '1 Jan 1980') OR  
			BRS_Item.SalesCategory <> ISNULL(s.SalesCategory, '') OR  
			BRS_Item.MajorProductClass <> ISNULL(s.MajorProductClass, '') OR  
			BRS_Item.SubMajorProdClass <> ISNULL(s.SubMajorProdClass, '') OR  
			BRS_Item.MinorProductClass <> ISNULL(s.MinorProductClass, '') OR  
			BRS_Item.CurrentFileCost <> ISNULL(s.CurrentFileCost, 0) OR  
			BRS_Item.FreightAdjPct <> ISNULL(s.FreightAdjPct, 0) OR  
			BRS_Item.CorporateMarketAdjustmentPct <> ISNULL(s.CorporateMarketAdjustmentPct, 0) OR  
			BRS_Item.DivisionalMarketAdjustmentPct <> ISNULL(s.DivisionalMarketAdjustmentPct, 0) OR  
			BRS_Item.CurrentCorporatePrice <> ISNULL(s.CurrentCorporatePrice, 0) OR
			BRS_Item.Brand <> ISNULL(s.Brand, '')

		Set @nErrorCode = @@Error
	End


	If (@nErrorCode = 0) 
	Begin

		if (@bDebug <> 0)
			Print 'ADD BRS_Item NEW'

		INSERT INTO BRS_Item (

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
			Brand
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
			ISNULL(Brand,'')
		FROM         
			STAGE_BRS_ItemFull AS s
		WHERE	(NOT EXISTS
								  (SELECT	*
									FROM	BRS_Item AS BRS_Item_1
									WHERE	Item = s.Item)
				)

		Set @nErrorCode = @@Error
	End

------------------------------------------------------------------------------------------------------------
-- Wrap-up routines.  
------------------------------------------------------------------------------------------------------------

	if (@bDebug <> 0)
		Set @nErrorCode = 512

	-- Call error message on Error
	if (@nErrorCode <> 0)
	Begin
		Set @sMessage = '[BRS_BE_Dimension_load_proc]'
		Set @sMessage = @sMessage + ':  Return(' + Convert(varchar, @nErrorCode) + ')'
		Set @sMessage = @sMessage +  ', ' + convert(varchar, @bDebug)

		RAISERROR (50060, 9, 1, @sMessage )

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

-- This must be run AFTER the Daily sales update (to catch any new FSC territories, 10 Nov 15

/*

-- 1 of 4:  Clear tables

truncate table STAGE_BRS_CustomerFull
truncate table STAGE_BRS_ItemFull

*/

-- 2 of 4:  run S:\Business Reporting\_BR_Sales\Upload BRS_Dimension_Load
 
-- 3 of 4:  Prod Load 
-- Exec BRS_BE_Dimension_load_proc 0

-- 4 of 4:  Cleanup info
-- Exec BRS_BE_Transaction_post_proc 0




