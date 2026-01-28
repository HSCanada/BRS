		SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE BRS_BE_Dimension_load_proc
	@bClearStage as smallint = 0, 
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
**  @bClearStage - clear stage & exit
**	@bDebug - debug = rollback changes
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
**	20 Sep 16	tmc		added TS territory load
**	07 Dec 16	tmc		Moved new BT for RI logic
**	25 May 17	tmc		Added FSA for GEO ranking
**	19 Jul 17	tmc		Added Brand to Item for Pricing
**  23 Oct 17	tmc		Added @bClearStage option to simplify rights
**	03 Jan 18	tmc		sunset BRS_TS_Rollup
**	05 Oct 18	tmc		Add Brand to supplier load for RI
**	9 Jun 19	tmc		add subminorcode
**	16 Dec 20	tmc		add EST
**	06 Apr 21	tmc		teeth stocking MA fix
**	14 Oct 21	tmc		add pma and freight ind for commission modelling
**	19 Sep 22	tmc		add privileges code for business review model
**	04 Jan 23	tmc		add trims to correct for cloud backend escapes, @gt
**	19 Jun 23	tmc		add JDE marketclass to allow synch
**	29 Oct 24	tmc		add AR clear table [Integration].[F564201_AgingBillto]
**	14 Mar 25	tmc		synch HS Global rules for finance and commissions
**	19 Jan 26	tmc		add eps synch from JDE territory

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
			Print '0. Clear tables.'

		TRUNCATE TABLE STAGE_BRS_CustomerFull
		TRUNCATE TABLE STAGE_BRS_ItemFull

		TRUNCATE TABLE [Integration].[F564201_AgingBillto]

		Set @nErrorCode = @@Error

	End
	Else
	Begin

		If (@nErrorCode = 0) 
		Begin
			if (@bDebug <> 0)
				Print '1. Add new VPA ...'

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
				Print '2. Add new FSC (from Cust FULL)...'

				INSERT INTO BRS_FSC_Rollup
									  (TerritoryCd, FSCRollup, Branch)
				SELECT DISTINCT TerritoryCd, TerritoryCd, '' AS br
				FROM         STAGE_BRS_CustomerFull AS c
				WHERE     (NOT EXISTS
										  (SELECT     *
											FROM          BRS_FSC_Rollup AS s
											WHERE       s.TerritoryCd = c.TerritoryCd ))
			Set @nErrorCode = @@Error
		End

	-- 19 Jan 26 add EPS terr
		If (@nErrorCode = 0) 
		Begin
			if (@bDebug <> 0)
				Print '2b. Add new HSPS (from Cust FULL)...'

				INSERT INTO BRS_FSC_Rollup
									  (TerritoryCd, FSCRollup, Branch)
				SELECT DISTINCT TerritoryCd, TerritoryCd, '' AS br
				FROM         STAGE_BRS_CustomerFull AS c
				WHERE     (NOT EXISTS
										  (SELECT     *
											FROM          BRS_FSC_Rollup AS s
											WHERE       s.TerritoryCd = c.ExclusiveLevel4Cd ))
			Set @nErrorCode = @@Error
		End


	--	20 Sep 16	tmc		added TS territory load

		If (@nErrorCode = 0) 
		Begin
			if (@bDebug <> 0)
				Print '3. Add new TS (from Cust FULL)...'

				INSERT INTO BRS_FSC_Rollup
					  (TerritoryCd, FSCRollup, Branch)
				SELECT DISTINCT TsTerritoryCd, '', ''
				FROM         STAGE_BRS_CustomerFull AS c
				WHERE     (NOT EXISTS
										  (SELECT     *
											FROM          BRS_FSC_Rollup AS s
											WHERE       s.TerritoryCd = c.TsTerritoryCd ))
			Set @nErrorCode = @@Error
		End

	--	16 Dec 20 add EST territory load

		If (@nErrorCode = 0) 
		Begin
			if (@bDebug <> 0)
				Print '4. Add new EST (from Cust FULL)...'

				INSERT INTO BRS_FSC_Rollup
					  (TerritoryCd, FSCRollup, Branch, group_type)
				SELECT DISTINCT EstTerritoryCd, '', '', 'DEST' 
				FROM         STAGE_BRS_CustomerFull AS c
				WHERE     (NOT EXISTS
										  (SELECT     *
											FROM          BRS_FSC_Rollup AS s
											WHERE       s.TerritoryCd = c.EstTerritoryCd ))
			Set @nErrorCode = @@Error
		End


		--	07 Dec 16	tmc		Moved new BT for RI logic 
		-- added 24 Aug 15, tmc
		If (@nErrorCode = 0) 
		Begin
			if (@bDebug <> 0)
				Print '5. Add new BT (from Stage)...'

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
				Print '6. Add new FSA (from Stage)...'

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
				Print '6b. Add new privileges (from Stage)...'

			INSERT INTO 
				nes.[privileges]
				(privileges_code, privileges_descr)
			SELECT DISTINCT
				PrivilegesCode, ''
			FROM
				STAGE_BRS_CustomerFull AS s
			WHERE
				(PrivilegesCode IS NOT NULL) AND 
				(NOT EXISTS
					(SELECT        privileges_code, privileges_descr, privileges_key, priority_code, pma_ind
					FROM            nes.[privileges] AS d
					WHERE        (privileges_code = s.PrivilegesCode)
					)
				)

			Set @nErrorCode = @@Error
		End


		If (@nErrorCode = 0) 
		Begin

			if (@bDebug <> 0)
				Print '7. UPDATE BRS_Customer changes'

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

				TsTerritoryCd = ISNULL(s.TsTerritoryCd, ''),
				est_code = ISNULL(s.EstTerritoryCd, ''),

				FSA = LEFT(ISNULL(s.PostalCode, ''), 3)
				,[PrivilegesCode] = LEFT(ISNULL(s.[PrivilegesCode], ''), 5)
				,[ApplyFreightInd] = ISNULL(s.[ApplyFreightInd], '')
				,[ApplySmallOrderChargesInd] = ISNULL(s.[ApplySmallOrderChargesInd], '')
				
				,[SegCd_JDE] = ISNULL(s.[SegCd], '')
				,[MarketClass_JDE] = ISNULL(s.[MarketClass],'')

				,eps_code = ISNULL(ExclusiveLevel4Cd, '')



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

				BRS_Customer.TsTerritoryCd <> ISNULL(s.TsTerritoryCd, '')  OR
				BRS_Customer.est_code <> ISNULL(s.EstTerritoryCd, '')  OR
				BRS_Customer.FSA <> LEFT(ISNULL(s.PostalCode, ''), 3) OR

				-- fix bad logic, tmc, 19 Sep 22
				BRS_Customer.[PrivilegesCode] <> LEFT(ISNULL(s.[PrivilegesCode], ''), 5) OR
				BRS_Customer.[ApplyFreightInd] <> ISNULL(s.[ApplyFreightInd], '') OR
				BRS_Customer.[ApplySmallOrderChargesInd] <> ISNULL(s.[ApplySmallOrderChargesInd], '') OR

				-- add marketclass
				BRS_Customer.[SegCd_JDE] <> ISNULL(s.[SegCd], '') OR
				BRS_Customer.[MarketClass_JDE] <> ISNULL(s.[MarketClass], '') OR

				BRS_Customer.eps_code <> ISNULL(ExclusiveLevel4Cd, '')


			Set @nErrorCode = @@Error
		End


		If (@nErrorCode = 0) 
		Begin

			if (@bDebug <> 0)
				Print '8. ADD BRS_Customer NEW'

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
				est_code,
				FSA
				,PrivilegesCode
				,[ApplyFreightInd]
				,[ApplySmallOrderChargesInd]
				,[SegCd_JDE] 
				,[MarketClass_JDE]

				,eps_code

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

				ISNULL(s.TsTerritoryCd, '')  AS TsTerritoryCd,
				ISNULL(s.EstTerritoryCd, '')  AS EstTerritoryCd,
				LEFT(ISNULL(s.PostalCode, ''), 3) AS FSA

				,LEFT(ISNULL(s.[PrivilegesCode], ''), 5)	AS PrivilegesCode
				,ISNULL(s.[ApplyFreightInd], '')			AS [ApplyFreightInd]
				,ISNULL(s.[ApplySmallOrderChargesInd], '')	AS [ApplySmallOrderChargesInd]

				,ISNULL(s.[SegCd], '')						AS SegCd_JDE
				,ISNULL(s.[MarketClass], '')				AS MarketClass_JDE

				,ISNULL(s.ExclusiveLevel4Cd,'')				AS eps_code

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
				Print '9. Add new MPC (ItemFull) ...'

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
				Print '10. Add new MinorProductClass (ItemFull) ...'

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
				Print '11. Add new Supplier (ItemFull) ...'

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
				Print '12. Add new Brand (ItemFull) ...'

				INSERT INTO BRS_ItemSupplier
									  (Supplier)
				SELECT DISTINCT ISNULL(t.Brand,'') AS dt
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
				Print '13. UPDATE BRS_Item changes'

			UPDATE    BRS_Item
			SET 

				ItemDescription= LEFT(ISNULL(s.ItemDescription, ''),40), 
				Supplier= ISNULL(s.Supplier, ''), 
				Size= LEFT(ISNULL(s.Size, ''), 8), 
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

				INNER JOIN BRS_Item d
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
				Print '14. ADD BRS_Item NEW'

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
				Brand,
				[SubMinorProductCodec]
			)

			SELECT 
				s.Item, 
				LEFT(ISNULL(s.ItemDescription, ''),40) ItemDescription,
				ISNULL(s.Supplier, '')  Supplier, 
				LEFT(ISNULL(s.Size, ''),8)  Size,
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
										FROM	BRS_Item AS BRS_Item_1
										WHERE	Item = s.Item)
					)

			Set @nErrorCode = @@Error
		End

	End -- not clear stage

	-- note that this is set to non-stock from system (#13) then overridden to stocking for MA reason (#15)
	If (@nErrorCode = 0) 
		Begin
			if (@bDebug <> 0)
				Print '15. set teeth to stocking (correct bad DNA work-around for MA)'

			UPDATE
				BRS_Item
			SET
				StockingType = 'S'
			WHERE
				(SalesCategory = 'TEETH') AND 
				(StockingType <> 'S')

			Set @nErrorCode = @@Error
		End


	If (@nErrorCode = 0) 
		Begin
			if (@bDebug <> 0)
				Print '16. synch HS Global rules for finance and commissions'

			UPDATE       BRS_Item
			SET                Excl_Code =  h.Excl_Code
			FROM            BRS_Item i INNER JOIN
									 hfm.exclusive_product_rule_item AS h ON i.Item = h.item
			WHERE
				i.Excl_Code <>  h.Excl_Code

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

-- This must be run AFTER the Daily sales update (to catch any new FSC territories, 10 Nov 15


-- Prod
-- Exec BRS_BE_Dimension_load_proc @bClearStage=0, @bDebug=0

-- Debug

-- Exec BRS_BE_Dimension_load_proc @bClearStage=1, @bDebug=1

-- Exec BRS_BE_Dimension_load_proc @bClearStage=0, @bDebug=1



