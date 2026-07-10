

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[BRS_BE_Transaction_DW_load_proc] 
	@bClearStage as smallint = 0, 
	@bDebug as smallint = 1
AS

/******************************************************************************
**	File: 
**	Name: BRS_BE_Transaction_DW_load_proc
**	Desc: Load DW Transactions, in prod 27 Jan 17 
**
**              
**	Return values:  @@Error
**
**	Called by:   
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**  @bClearStage			If 1, clear stage & exit; else load
**	@bDebug - debug = rollback changes
**
**	Auth: tmc
**	Date: 22 Sep 16
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
--	15 Sep 16	tmc		Add P&G Free good work-aournd to exclude P&G Free Goods after 1 Sept 16;  Proper fix once new Free Goods in place
--	23 Sep 16	tmc		Map Promo tagged TS to Order-level TS Code 
--	26 Sep 16	tmc		Design fix:  BRS_TransactionDW_Ext stored at order level, not line level
--	07 Dec 06	tmc		Added Ext Price and Disc to correct Advance Price Order Promo
--  09 Dec 16	tmc		Update Metrics load logic, Disc, Zero load skip ***TBD***
--	13 Dec 16	tmc		Added Update Promo logic,
--	18 Dec 16	tmc		Added Freegood auto and Astea fields
--  16 Jan 17   tmc     Fixed Chargeback Number load so * maps to 0
--  22 Jan 17   tmc     Added logic so that empty update does not fail
--  27 Jan 17   tmc     Finalized Discount and Free Goods logic
--  06 Feb 17	tmc		Add restock to price adj correction
--	13 Feb 17	tmc		Final Discount logic fix
--  23 Oct 17	tmc		Added @bClearStage option to simplify rights
--	17 Dec 17	tmc		Add DW Chargeback info to DS trans
-- 03 Jan 18	tmc		sunset BRS_TS_Rollup
**	07 Feb 18	tmc		Bug fix (found by TS team).  RI fix broke PO update
**							Updating PO from BRS_BE_Transaction_load_proc fix
--	05 Oct 18	tmc		fix alert logic to use text
--	22 Aug 19	tmc		add new entered_by logic
--	20 Jul 20	tmc		add credit info load logic for returns dashboard
--	09 Mar 22	tmc		exclude Private label from free goods (billing in 2022)
--	04 Jan 23	tmc		fix first ship date defaults 0 -> Null -> 1/1/1980
--  27 Mar 23	tmc		fix credit info addend bug
--	22 Sep 25	tmc		add GEP order Flag
--	15 Mar 26	tmc		add GEP promo (**reversed by tmc to allow 08 Jul patch)
--	08 Jul 26	tmc		GEP bug fix -- salesperson is missing from JDE
**    
*******************************************************************************/
BEGIN

	Declare @nErrorCode int, @nTranCount int
	Declare @nRowCount int
	Declare @sMessage varchar(255)

	Set @nErrorCode = @@Error
	Set @nTranCount = @@Trancount
	Set @nRowCount = 0

	if (@bDebug <> 0) 
	Begin
		Print '---------------------------------------------------------'
		Print 'Proc: BRS_BE_Transaction_DW_load_proc'
		Print 'Desc: Update DW Table with new transaction details'
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

------------------------------------------------------------------------------------------------------------
-- Update routines.  
------------------------------------------------------------------------------------------------------------
	-- Clear stage tables, OR
	if (@bClearStage <> 0)
	Begin
		if (@bDebug <> 0)
			Print '00. Clear tables.'

		TRUNCATE TABLE STAGE_BRS_Promotion
		TRUNCATE TABLE STAGE_BRS_TransactionDW
		TRUNCATE TABLE [Integration].[BRS_CreditInfo]

		TRUNCATE TABLE STAGE_BRS_Promotion_GEP

		Set @nErrorCode = @@Error

	End
	Else
	-- Load Tables
	Begin
		--	13 Dec 16	tmc		Added Update Promo logic
		If (@nErrorCode = 0) 
		Begin
			if (@bDebug <> 0)
				Print '01. Add new Promo...'

			INSERT INTO BRS_Promotion
				(PromotionCode)
			SELECT	DISTINCT PMCD 
			FROM	STAGE_BRS_Promotion 
			WHERE	NOT EXISTS (SELECT * FROM BRS_Promotion WHERE PMCD=PromotionCode) 

			Set @nErrorCode = @@Error
		End


		If (@nErrorCode = 0) 
		Begin
			if (@bDebug <> 0)
				Print '02. Updated Changed Promo...'

			UPDATE    
				BRS_Promotion
			SET              
				PromotionDescription		= p.PMDE0,
				PromotionId					= p.PMID,
				MarketingProgramIndicator	= MKTPGIN,
				PromotionStartDate			= PMSTDT,
				PromotionEndDate			= PMENDT,
				PromotionSalesDivision		= SDCD0,
				PromotionStatus				= PMSTCD,
				PromotionType				= PMTYDE

			FROM         
				STAGE_BRS_Promotion p

				INNER JOIN (SELECT     PMCD, MAX(PMID) AS PMID FROM STAGE_BRS_Promotion GROUP BY PMCD) ps
				ON p.PMID = ps.PMID

			WHERE 
				(PromotionCode = p.PMCD) AND 
				(
					(PromotionDescription		<> PMDE0)	OR
					(PromotionId				<> p.PMID)	OR
					(MarketingProgramIndicator	<> MKTPGIN)	OR
					(PromotionStartDate			<> PMSTDT)	OR
					(PromotionEndDate			<> PMENDT)	OR
					(PromotionSalesDivision		<> SDCD0)	OR
					(PromotionStatus			<> PMSTCD)	OR
					(PromotionType				<> PMTYDE)
				)
			Set @nErrorCode = @@Error
		End

		If (@nErrorCode = 0) 
		Begin
			if (@bDebug <> 0)
				Print '03. Add new Promo GEP - Promo Line'

			INSERT INTO BRS_Promotion_GEP
				(Promo_Code_GEP)
			SELECT	DISTINCT RTRIM(s.[Line_Promo_Code_GEP])
			FROM	STAGE_BRS_Promotion_GEP s
			WHERE	NOT EXISTS (SELECT * FROM BRS_Promotion_GEP WHERE s.[Line_Promo_Code_GEP]=[Promo_Code_GEP]) 

			Set @nErrorCode = @@Error
		End

		If (@nErrorCode = 0) 
		Begin
			if (@bDebug <> 0)
				Print '04. Add new Promo GEP - Promo Order'

			INSERT INTO BRS_Promotion_GEP
				(Promo_Code_GEP)
			SELECT	DISTINCT RTRIM(s.[Order_Level_Promo_Code_GEP])
			FROM	STAGE_BRS_Promotion_GEP s
			WHERE	NOT EXISTS (SELECT * FROM BRS_Promotion_GEP WHERE s.[Order_Level_Promo_Code_GEP]=[Promo_Code_GEP]) 

			Set @nErrorCode = @@Error
		End

		If (@nErrorCode = 0) 
		Begin
			if (@bDebug <> 0)
				Print '05. Add new Promo GEP - Tx Line'

			INSERT INTO BRS_Promotion_GEP
				(Promo_Code_GEP)
			SELECT	DISTINCT RTRIM(s.[Line_Promo_Coupon_GEP])
			FROM	[dbo].[STAGE_BRS_TransactionDW] s
			WHERE	NOT EXISTS (SELECT * FROM BRS_Promotion_GEP WHERE RTRIM(s.[Line_Promo_Coupon_GEP])=RTRIM([Promo_Code_GEP]))  ORDER BY 1

			Set @nErrorCode = @@Error
		End

		If (@nErrorCode = 0) 
		Begin
			if (@bDebug <> 0)
				Print '06. Add new Promo GEP - Tx Order'

			INSERT INTO BRS_Promotion_GEP
				(Promo_Code_GEP)
			SELECT	DISTINCT RTRIM(s.[Order_Level_Promo_Code_GEP])
			FROM	[dbo].[STAGE_BRS_TransactionDW] s
			WHERE	NOT EXISTS (SELECT * FROM BRS_Promotion_GEP WHERE s.[Order_Level_Promo_Code_GEP]=[Promo_Code_GEP]) 

			Set @nErrorCode = @@Error
		End

/*
	-- skipping now, until GEP promo further tested

		If (@nErrorCode = 0) 
		Begin
			if (@bDebug <> 0)
				Print '07. Update Promo GEP - Line'

			UPDATE
				BRS_Promotion_GEP
			SET
				Line_Promo_Campaigns_GEP = ISNULL(s.[Line_Promo_Campaigns_GEP], '') 
				, Line_Promo_Coupon_X_Ref_GEP = ISNULL(s.[Line_Promo_Coupon_X_Ref_GEP], '') 
				, Line_Promo_Coupon_GEP = ISNULL(s.[Line_Promo_Coupon_GEP], '')
				, Line_Promo_Description_GEP = ISNULL(s.[Line_Promo_Description_GEP], '')
				, Line_Promo_End_Date_GEP = ISNULL(s.[Line_Promo_End_Date_GEP], 0)
				, Line_Promo_Message_GEP = ISNULL(s.[Line_Promo_Message_GEP], '')
				, Line_Promo_Redeem_Instructions_GEP = ISNULL(s.[Line_Promo_Redeem_Instructions_GEP], '')
				, Line_Promo_Sales_Division_GEP = ISNULL(s.[Line_Promo_Sales_Division_GEP], '')
				, Line_Promo_Start_Date_GEP = ISNULL(s.[Line_Promo_Start_Date_GEP], 0)
				, Line_Promo_Status_GEP = ISNULL(s.[Line_Promo_Status_GEP], '')
				, Line_Promo_Type_GEP = ISNULL(s.[Line_Promo_Type_GEP], '')
			FROM
				STAGE_BRS_Promotion_GEP AS s 
	
				INNER JOIN
				(
					SELECT        Line_Promo_Code_GEP, MIN(ID) AS ID_REF
					FROM            STAGE_BRS_Promotion_GEP
					GROUP BY Line_Promo_Code_GEP
				) AS gep 
				ON s.ID = gep.ID_REF 
		
				INNER JOIN BRS_Promotion_GEP 
				ON s.Line_Promo_Code_GEP = BRS_Promotion_GEP.Promo_Code_GEP

			WHERE
				BRS_Promotion_GEP.Line_Promo_Campaigns_GEP <> ISNULL(s.[Line_Promo_Campaigns_GEP], '') OR
				BRS_Promotion_GEP.Line_Promo_Coupon_X_Ref_GEP <> ISNULL(s.[Line_Promo_Coupon_X_Ref_GEP], '') OR
				BRS_Promotion_GEP.Line_Promo_Coupon_GEP <> ISNULL(s.[Line_Promo_Coupon_GEP], '') OR
				BRS_Promotion_GEP.Line_Promo_Description_GEP <> ISNULL(s.[Line_Promo_Description_GEP], '') OR
				BRS_Promotion_GEP.Line_Promo_End_Date_GEP <> ISNULL(s.[Line_Promo_End_Date_GEP], 0) OR
				BRS_Promotion_GEP.Line_Promo_Message_GEP <> ISNULL(s.[Line_Promo_Message_GEP], '') OR
				BRS_Promotion_GEP.Line_Promo_Redeem_Instructions_GEP <> ISNULL(s.[Line_Promo_Redeem_Instructions_GEP], '') OR
				BRS_Promotion_GEP.Line_Promo_Sales_Division_GEP <> ISNULL(s.[Line_Promo_Sales_Division_GEP], '') OR
				BRS_Promotion_GEP.Line_Promo_Start_Date_GEP <> ISNULL(s.[Line_Promo_Start_Date_GEP], 0) OR
				BRS_Promotion_GEP.Line_Promo_Status_GEP <> ISNULL(s.[Line_Promo_Status_GEP], '') OR
				BRS_Promotion_GEP.Line_Promo_Type_GEP <> ISNULL(s.[Line_Promo_Type_GEP], '') 

			Set @nErrorCode = @@Error
		End


		If (@nErrorCode = 0) 
		Begin
			if (@bDebug <> 0)
				Print '08. Update Promo GEP - Order'

			UPDATE
				BRS_Promotion_GEP
			SET
				Order_Level_Coupon_X_Ref_GEP = ISNULL(s.[Order_Level_Coupon_X_Ref_GEP], '') 
				, Order_Level_Coupon_GEP = ISNULL(s.[Order_Level_Coupon_GEP], '')
				, Order_Level_Promo_Campaigns_GEP = ISNULL(s.[Order_Level_Promo_Campaigns_GEP], '') 
				, Order_Level_Promo_Description_GEP = ISNULL(s.[Order_Level_Promo_Description_GEP], '')
				, Order_Level_Promo_End_Date_GEP = ISNULL(s.[Order_Level_Promo_End_Date_GEP], 0)
				, Line_Promo_Message_GEP = ISNULL(s.[Order_Level_Promo_Message_GEP], '')
				, Order_Level_Promo_Redeem_Instructions_GEP = ISNULL(s.[Order_Level_Promo_Redeem_Instructions_GEP], '')
				, Order_Level_Promo_Sales_Division_GEP = ISNULL(s.[Order_Level_Promo_Sales_Division_GEP], '')
				, Order_Level_Promo_Start_Date_GEP = ISNULL(s.[Order_Level_Promo_Start_Date_GEP], 0)
				, Order_Level_Promo_Status_GEP = ISNULL(s.[Order_Level_Promo_Status_GEP], '')
				, Order_Level_Promo_Type_GEP = ISNULL(s.[Order_Level_Promo_Type_GEP], '')
			-- SELECT s.* 
			FROM
				STAGE_BRS_Promotion_GEP AS s 
	
				INNER JOIN (
					SELECT        Order_Level_Promo_Code_GEP, MIN(ID) AS ID_REF
					FROM            STAGE_BRS_Promotion_GEP
					GROUP BY Order_Level_Promo_Code_GEP
				) AS gep 
				ON s.ID = gep.ID_REF 
		
				INNER JOIN BRS_Promotion_GEP 
				ON s.Line_Promo_Code_GEP = BRS_Promotion_GEP.Promo_Code_GEP
			WHERE
				BRS_Promotion_GEP.Order_Level_Coupon_X_Ref_GEP <> ISNULL(s.[Order_Level_Coupon_X_Ref_GEP], '') OR
				BRS_Promotion_GEP.Order_Level_Coupon_GEP <> ISNULL(s.[Order_Level_Coupon_GEP], '') OR
				BRS_Promotion_GEP.Order_Level_Promo_Campaigns_GEP <> ISNULL(s.[Order_Level_Promo_Campaigns_GEP], '')  OR
				BRS_Promotion_GEP.Order_Level_Promo_Description_GEP <> ISNULL(s.[Order_Level_Promo_Description_GEP], '') OR
				BRS_Promotion_GEP.Order_Level_Promo_End_Date_GEP <> ISNULL(s.[Order_Level_Promo_End_Date_GEP], 0) OR
				BRS_Promotion_GEP.Line_Promo_Message_GEP <> ISNULL(s.[Order_Level_Promo_Message_GEP], '') OR
				BRS_Promotion_GEP.Order_Level_Promo_Redeem_Instructions_GEP <> ISNULL(s.[Order_Level_Promo_Redeem_Instructions_GEP], '') OR
				BRS_Promotion_GEP.Order_Level_Promo_Sales_Division_GEP <> ISNULL(s.[Order_Level_Promo_Sales_Division_GEP], '') OR
				BRS_Promotion_GEP.Order_Level_Promo_Start_Date_GEP <> ISNULL(s.[Order_Level_Promo_Start_Date_GEP], 0) OR
				BRS_Promotion_GEP.Order_Level_Promo_Status_GEP <> ISNULL(s.[Order_Level_Promo_Status_GEP], '') OR
				BRS_Promotion_GEP.Order_Level_Promo_Type_GEP <> ISNULL(s.[Order_Level_Promo_Type_GEP], '') 


			Set @nErrorCode = @@Error
		End

*/

		If (@nErrorCode = 0) 
		Begin
			if (@bDebug <> 0)
				Print '09. Add new BU...'

				INSERT INTO BRS_BusinessUnit
									  (BusinessUnit)
				SELECT DISTINCT LEFT(ISNULL(t.GLBUNO,''), 12) AS bu
				FROM         STAGE_BRS_TransactionDW AS t
				WHERE     (NOT EXISTS
										  (SELECT     *
											FROM          BRS_BusinessUnit AS BRS_BusinessUnit_1
											WHERE       BusinessUnit = ISNULL(t.GLBUNO,'') ))
			Set @nErrorCode = @@Error
		End


		-- ESS
		If (@nErrorCode = 0) 
		Begin
			if (@bDebug <> 0)
				Print '10. Add new ESS...'

			INSERT INTO [dbo].[BRS_FSC_Rollup] ([TerritoryCd], [Branch])
			SELECT DISTINCT [ESSCD], ''
			FROM            STAGE_BRS_TransactionDW 
			WHERE 
				([ESSCD] IS NOT NULL) AND
				NOT EXISTS (SELECT * FROM [dbo].[BRS_FSC_Rollup] WHERE [ESSCD] = [TerritoryCd])

			Set @nErrorCode = @@Error
		End

		-- CCS
		If (@nErrorCode = 0) 
		Begin
			if (@bDebug <> 0)
				Print '11. Add new CCS...'

			INSERT INTO [dbo].[BRS_FSC_Rollup] ([TerritoryCd], [Branch])
			SELECT DISTINCT [CCSCD], ''
			FROM            STAGE_BRS_TransactionDW 
			WHERE 
				([CCSCD] IS NOT NULL) AND
				NOT EXISTS (SELECT * FROM [dbo].[BRS_FSC_Rollup] WHERE [CCSCD] = [TerritoryCd])

			Set @nErrorCode = @@Error
		End

		-- TSS
		If (@nErrorCode = 0) 
		Begin
			if (@bDebug <> 0)
				Print '12. Add new TSS...'

			INSERT INTO [dbo].[BRS_FSC_Rollup] ([TerritoryCd], [Branch])
			SELECT DISTINCT [TSSCD], ''
			FROM            STAGE_BRS_TransactionDW 
			WHERE 
				([TSSCD] IS NOT NULL) AND
				NOT EXISTS (SELECT * FROM [dbo].[BRS_FSC_Rollup] WHERE [TSSCD] = [TerritoryCd])

			Set @nErrorCode = @@Error
		End

		-- DTX
		If (@nErrorCode = 0) 
		Begin
			if (@bDebug <> 0)
				Print '13. Add new DTX...'

			INSERT INTO [dbo].[BRS_FSC_Rollup] ([TerritoryCd], [Branch])
			SELECT DISTINCT [CAGREPCD], ''
			FROM            STAGE_BRS_TransactionDW 
			WHERE 
				([CAGREPCD] IS NOT NULL) AND
				NOT EXISTS (SELECT * FROM [dbo].[BRS_FSC_Rollup] WHERE [CAGREPCD] = [TerritoryCd])

			Set @nErrorCode = @@Error
		End

		-- entered_by
		If (@nErrorCode = 0) 
		Begin
			if (@bDebug <> 0)
				Print '14. Add new entered_by...'

			INSERT INTO [Pricing].[entered_by] ([entered_by_code])
			SELECT DISTINCT [ENBYNA]
			FROM            STAGE_BRS_TransactionDW 
			WHERE 
				([ENBYNA] IS NOT NULL) AND
				NOT EXISTS (SELECT * FROM [Pricing].[entered_by] WHERE [ENBYNA] = [entered_by_code])

			Set @nErrorCode = @@Error
		End

		If (@nErrorCode = 0) 
		Begin
			if (@bDebug <> 0)
				Print '15. Add new Sales Orders to BRS_TransactionDW_Ext...'

			INSERT INTO 
				BRS_TransactionDW_Ext (
					SalesOrderNumber, 
					DocType, 
					CustomerPOText1
				)
			SELECT     
					JDEORNO as SalesOrderNumber, 
					ORDOTYCD, 
					Left(MIN(RF1TT), 25) AS CustomerPOText1
			FROM         
					STAGE_BRS_TransactionDW
			WHERE     NOT EXISTS
			(
				Select 
					* 
				From 
					BRS_TransactionDW_Ext s
				Where 
					JDEORNO = s.SalesOrderNumber And
					ORDOTYCD = s.DocType 
			)

			GROUP BY 
				JDEORNO, 
				ORDOTYCD 

			Set @nErrorCode = @@Error
		End

---
		If (@nErrorCode = 0) 
		Begin
			if (@bDebug <> 0)
				Print '16. Update PO Text ...'

			UPDATE    
				BRS_TransactionDW_Ext
			SET              
				[CustomerPOText1] =	[NEW_CustomerPOText1]

--			select SalesOrderNumber, CustomerPOText1, NEW_CustomerPOText1
			FROM         
				BRS_TransactionDW_Ext 

				INNER JOIN 
				(
					SELECT     
							JDEORNO, 
							ORDOTYCD, 
							Left(MIN(RF1TT), 25) AS NEW_CustomerPOText1
					FROM         
							STAGE_BRS_TransactionDW
					GROUP BY 
						JDEORNO, 
						ORDOTYCD 
				) header
				ON [SalesOrderNumber] = JDEORNO
			WHERE 
				-- magic init message set by BRS_BE_Transaction_load_proc
				-- This ensure that ONLY init POs are updated, not post
				-- changes
				CustomerPOText1 = '<TO BE UPDATED>'


			Set @nErrorCode = @@Error
		End

---

		--	23 Sep 16	tmc		Map Promo tagged TS to Order-level TS Code 

		If (@nErrorCode = 0) 
		Begin
			if (@bDebug <> 0)
				Print '17. Map Promo tagged TS to Order-level TS Code...'

			UPDATE    
				BRS_TransactionDW_Ext
			SET              
				TsTerritoryOrgCd =	r.[TerritoryCd],
				TsTerritoryCd=		r.[TerritoryCd]

--			select SalesOrderNumber, r.[TerritoryCd], CustomerPOText1
			FROM         
				BRS_TransactionDW_Ext 

				INNER JOIN [dbo].[BRS_FSC_Rollup]  r
				ON BRS_TransactionDW_Ext.CustomerPOText1 LIKE r.Rule_WhereClauseLike AND
					r.Rule_WhereClauseLike <>''
			WHERE     
				EXISTS
				(
					Select * From [dbo].[STAGE_BRS_TransactionDW] s
					Where JDEORNO = SalesOrderNumber 
				)

			Set @nErrorCode = @@Error
		End

		--
		If (@nErrorCode = 0) 
		Begin
			if (@bDebug <> 0)
				Print '18. Append Credit lookup table'

		INSERT INTO 
			[dbo].[BRS_Creditinfo]
		(
			[CreditMinorReasonCode]
			, [CreditTypeCode]
		)
		SELECT 
			DISTINCT 
				ISNULL(CRMNRECD,'') AS CreditMinorReasonCode
				,ISNULL(CRTYCD, '') AS CreditTypeCode
		FROM
			Integration.BRS_CreditInfo s
		WHERE 
			NOT EXISTS
			(
				SELECT * 
				FROM [dbo].[BRS_Creditinfo] d 
				WHERE ISNULL(s.CRMNRECD, '') = d.CreditMinorReasonCode AND 
					ISNULL(s.CRTYCD, '') = d.CreditTypeCode)

			Set @nErrorCode = @@Error
		End
--
		If (@nErrorCode = 0) 
		Begin
			if (@bDebug <> 0)
				Print '19. LOAD BRS_TransactionDW'


			INSERT INTO BRS_TransactionDW
			(
				SalesOrderNumber, 
				DocType, 
				LineNumber, 
				CalMonth, 
				Date, 
				Shipto, 
				Item, 

				EnteredBy, 
				OrderTakenBy, 
				OrderSourceCode, 
				CustomerPOText1, 
				PriceMethod, 
				VPA, 

				LineTypeOrder, 
				SalesDivision, 
				MajorProductClass, 

				ChargebackContractNumber, 
				GLBusinessUnit, 
				OrderFirstShipDate, 
				InvoiceNumber, 

				--  09 Dec 16	tmc		Update Metrics load logic
				ShippedQty, 
				GPAmt, 
				GPAtFileCostAmt, 
				GPAtCommCostAmt, 
				ExtChargebackAmt, 
				NetSalesAmt, 
				PromotionCode,
				OrderPromotionCode,

				-- Custom Logic Section BEGIN -----------------------------------------

				ExtPriceORG,                    
				ExtListPriceORG, 
               
				BackorderInd,                 
				FreeGoodsRedeemedInd,

				[OriginalSalesOrderNumber],		-- [OORN]		
				[OriginalOrderDocumentType],	-- [OORTY]		
				[OriginalOrderLineNumber],		-- [OORLINO]	

				FreeGoodsInvoicedInd,   
				FreeGoodsEstInd,  
              
				ExtListPrice,
				ExtPrice,

				ExtDiscAmt,                     


				-- Custom Logic Section END -------------------------------------------

				[PricingAdjustmentLine],		-- [PCADLINO]	
				[SalesOrderBilltoNumber],		-- [BTADNO]	
				[EssCode],						-- [ESSCD]		
				[CcsCode],						-- [CCSCD]		
				[EstCode],						-- [ESTCD]		
				[TssCode],						-- [TSSCD]		
				[CagCode],						-- [CAGREPCD]	
				[EquipmentOrderNumber],			-- [EQORDNO]	
				[EquipmentOrderType]			-- [EQORDTYCD]	

				,[GEP_Order_Flag_ind]

				-- tc back-out reapply AFTER genpact live, 08 Jul 26
				--,[GEP_PromotionCode_key]
				--,[GEP_OrderPromotionCode_key]
				--
				)
				SELECT     
				s.JDEORNO AS SalesOrderNumber, 
				s.ORDOTYCD AS DocType, 
				ROUND(s.LNNO * 1000,0) AS LineNumber, 
				s.CMID AS CalMonth, 
				s.PDDT AS Date, 
				s.ADNOID AS Shipto, 
				s.ITLONO AS Item, 

				-- GEP bug fix -- salesperson is missing from JDE, 08 Jul 26
				ISNULL(s.ENBYNA, '') AS EnteredBy, 
				--
				ISNULL(s.ORTKBYID,'') AS OrderTakenBy, 
				s.ORSCCD AS OrderSourceCode, 
				LEFT(s.RF1TT,25) AS CustomerPOText1, 
				s.PRMDCD AS PriceMethod, 
				ISNULL(s.SPCDID,'') AS VPA, 

				s.LNTY AS LineTypeOrder, 
				s.HSDCDID AS SalesDivision, 
				ISNULL(s.MJPRCLID,'') AS MajorProductClass, 

				--  16 Jan 17   tmc     Fixed Chargeback Number load so * maps to 0
				CASE WHEN s.CBCONTRNO = '*' THEN 0 ELSE ISNULL(s.CBCONTRNO,0) END AS ChargebackContractNumber, 
		--		ISNULL(s.CBCONTRNO,0) AS ChargebackContractNumber, 
				ISNULL(s.GLBUNO,'') AS GLBusinessUnit, 
				ISNULL(NULLIF([ORFISHDT],'0'),'1980-01-10') AS OrderFirstShipDate, 
				-- ISNULL(s.ORFISHDT, '1 Jan 1980') AS OrderFirstShipDate, 
				s.IVNO AS InvoiceNumber, 

				--  09 Dec 16	tmc		Update Metrics load logic
				s.WJXBFS1 AS ShippedQty, 
				s.WJXBFS2 AS GPAmt, 
				s.WJXBFS3 AS GPAtFileCostAmt, 
				s.WJXBFS4 AS GPAtCommCostAmt, 
				s.WJXBFS5 AS ExtChargebackAmt, 
				s.WJXBFS6 AS NetSalesAmt,
				ISNULL(p1.PMCD, '') AS PromotionCode, 
				ISNULL(p2.PMCD, '') AS OrderPromotionCode,

				-- Custom Logic Section BEGIN 

				-- store ORG, ~ORG will be modified to follow
				s.WJXBFS7                                       AS ExtPriceORG,         
				s.WJXBFS8                                       AS ExtListPriceORG,     

				CASE 
					WHEN s.PDDT = ISNULL(NULLIF([ORFISHDT],'0'),'1980-01-10')
					THEN 0 ELSE 1 

				END                                             AS BackorderInd,		
				0                                               AS FreeGoodsRedeemedInd,

				-- Copy SO where Original SO missing to make Credit rebill matching easy
				CASE    
					WHEN s.OORNO = 0   
					THEN s.JDEORNO		
					ELSE s.OORNO    
				END                                             AS OriginalSalesOrderNumber,		 

				CASE    
					WHEN s.OORNO = 0   
					THEN s.ORDOTYCD		
					ELSE s.OORTY    
				END	                                            AS OriginalOrderDocumentType,	 

				CASE    
					WHEN s.OORNO = 0   
					THEN ROUND(s.LNNO * 1000, 0)	
					ELSE ROUND(ISNULL(s.OORLINO,0) * 1000, 0)   
				END	                                            AS OriginalOrderLineNumber,	

				CASE    
					WHEN s.WJXBFS1 <> 0 AND s.WJXBFS6 = 0.0 AND 
						ABS(s.WJXBFS3) > 0.02 * s.WJXBFS1 
					THEN 1 ELSE 0 
				END                                             AS FreeGoodsInvoicedInd,

				-- default to no free goods, fix later in post
				0 AS FreeGoodsEstInd,

/*
				-- Free goods estimate model can be improved, 27 Jan 17
				CASE 
					WHEN 
						s.WJXBFS2 = 0 AND 
						dt.FreeGoodsEstInd = 1 AND 
						buc.FreeGoodsEstInd = 1 AND 
						mpc.FreeGoodsEstInd = 1 
					THEN 1 ELSE 0 
				END                                             AS FreeGoodsEstInd,
*/

				-- Correct Ext List on price adjusmtent as the DW field incorrect
				CASE 
					WHEN s.LNTY IN ('CP', 'CL', 'CE')
					THEN 
						CASE 
							WHEN s.LNTY = 'CE'
							THEN s.WJXBFS6	
							ELSE 0
						END
					ELSE s.WJXBFS8 
				END                                             AS ExtListPrice,

				/*
		SET              
			ExtListPrice    = CASE WHEN LineTypeOrder IN ('CP', 'CL', 'CE')     THEN CASE WHEN LineTypeOrder = 'CE' THEN NetSalesAmt ELSE 0 END ELSE ExtListPriceORG END	
			, ExtPrice        = CASE WHEN OrderSourceCode IN ('A', 'L', 'K')    THEN NetSalesAmt ELSE ExtPriceORG END
		*/

				-- Correct Ext Price for non Advanced price as the DW field incorrect
				CASE 
					WHEN s.ORSCCD IN ('A', 'L', 'K')    
					THEN s.WJXBFS6 
					ELSE s.WJXBFS7 
				END                                             AS ExtPrice,

				-- Calc Total Discount based on correct fields.  Ugly Dup code needed?
				-- SUM(t.ExtListPrice  + t.ExtPrice -2*NetSalesAmt) AS ExtDiscTotal,

				CASE 
					WHEN s.LNTY IN ('CP', 'CL', 'CE')
					THEN 
						CASE 
							WHEN s.LNTY = 'CE'
							THEN s.WJXBFS6	
							ELSE 0
						END
					ELSE s.WJXBFS8 
				END 
				+
				CASE 
					WHEN s.ORSCCD IN ('A', 'L', 'K')    
					THEN s.WJXBFS6 
					ELSE s.WJXBFS7 
				END 
				- 
				2.0 * s.WJXBFS6                       AS ExtDiscAmt,


				-- Custom Logic Section END 
	 
				ISNULL(s.PCADLINO,'')	AS	PricingAdjustmentLine,		 
				ISNULL(s.BTADNO,0)		AS	SalesOrderBilltoNumber,		 
				ISNULL(s.ESSCD,'')		AS	EssCode,						 
				ISNULL(s.CCSCD,'')		AS	CcsCode,						 
				ISNULL(s.ESTCD,0)		AS	EstCode,						 
				ISNULL(s.TSSCD,'')		AS	TssCode,						 
				ISNULL(s.CAGREPCD,'')	AS	CagCode,						 
				ISNULL(s.EQORDNO,'')	AS	EquipmentOrderNumber,			 
				ISNULL(s.EQORDTYCD,'')	AS	EquipmentOrderType		
				
				,convert(bit, GEP_Order_Flag) AS GEP_Order_Flag_Ind

				--> tc back-out reapply AFTER genpact live, 08 Jul 26
				-- GEP Promo Head & Line Map
				--,gep_line.[Promo_Code_GEP_key] AS [GEP_PromotionCode_key]
				--,gep_order.[Promo_Code_GEP_key] AS [GEP_OrderPromotionCode_key]
				--< tc back-out reapply AFTER genpact live, 08 Jul 26


			FROM         
				STAGE_BRS_TransactionDW AS s 

				LEFT OUTER JOIN STAGE_BRS_Promotion AS p2 
				ON s.OPMID = p2.PMID 

				LEFT OUTER JOIN STAGE_BRS_Promotion AS p1 
				ON s.PMID = p1.PMID

				--> GEP promo add
				LEFT OUTER JOIN BRS_Promotion_GEP AS gep_line
				ON s.[Line_Promo_Coupon_GEP] = gep_line.[Promo_Code_GEP] AND
				s.[Line_Promo_Coupon_GEP] <> '***'

				LEFT OUTER JOIN BRS_Promotion_GEP AS gep_order
				ON s.[Order_Level_Promo_Code_GEP] = gep_order.[Promo_Code_GEP] AND
				s.[Order_Level_Promo_Code_GEP] <> '***'

				--< GEP promo add

				LEFT OUTER JOIN BRS_DocType as dt
				ON s.ORDOTYCD = dt.DocType

				LEFT OUTER JOIN BRS_ItemMPC AS mpc 
				ON s.MJPRCLID = mpc.MajorProductClass

				LEFT OUTER JOIN BRS_BusinessUnit AS bu
				ON ISNULL(s.GLBUNO,'') = bu.BusinessUnit

				LEFT OUTER JOIN BRS_BusinessUnitClass as buc
				ON  bu.GLBU_Class = buc.GLBU_Class

			WHERE     NOT EXISTS
			(
				Select 
					* 
				From 
					BRS_TransactionDW s
				Where 
					JDEORNO = s.SalesOrderNumber And
					ORDOTYCD = s.DocType And
					ROUND(LNNO * 1000,0) = s.LineNumber
			)

			Select @nErrorCode = @@Error, @nRowCount = @@Rowcount
		End

		If (@bDebug <> 0 And @nRowCount = 0)
		Begin
			Print '------------------------------------------------------------------------------------------------------------'
			Print 'No transactions to load.  Skipping to end. '
			Print '------------------------------------------------------------------------------------------------------------'
			Print ''
		End

		If (@nErrorCode = 0 And @nRowCount > 0) 
		Begin

			If (@bDebug <> 0)
			Begin
				Print '------------------------------------------------------------------------------------------------------------'
				Print '20. Free goods estimate model, updated to match Datawarehouse, 12 May 26 '
				Print '------------------------------------------------------------------------------------------------------------'
				Print ''
			End

			UPDATE    
				BRS_TransactionDW
			SET              
				FreeGoodsEstInd = 1
			-- SELECT *
			FROM         
				BRS_TransactionDW s
		
				INNER JOIN BRS_Item AS i 
				ON s.Item = i.Item

			WHERE     
				-- optimize for re-run
				s.FreeGoodsEstInd <> 1 AND

				-- include
				s.NetSalesAmt = 0 AND
				s.ShippedQty <> 0 AND
				i.[MajorProductClass] in (	'001','002','003','004','005','006','007','008','010','011','012','013','017','019','020','021','022','023','025', '074', '369',
											'054','057','058','124','125','300','316','320','340','364','370','083','082','076','084','355','024','073','071','372', '315') AND

				-- exclude
				s.DocType <> 'SN' AND
				i.Supplier NOT in( 'SIRONC','BAINTE','ROSSCH','IMPEXW','SABLEI','HENGLB','GLHEAL','PROCGA','USENDO','HENSCH','ORTHOT','SOUDEN','FKGDCH') AND
				i.Label <> 'P' AND 
				i.Item NOT in ('9394930','1381736','9395540') AND
	
				-- remove below 3 comments to retro-fix DW FG flags 
--				/*
				EXISTS
				(
					Select 
						* 
					From 
						STAGE_BRS_TransactionDW s
					Where 
						SalesOrderNumber = s.JDEORNO And
						DocType = s.ORDOTYCD And
						LineNumber = ROUND(s.LNNO * 1000,0) 
				) AND
--				*/
--				[CalMonth] >= 202401 AND
				(1 = 1)

			Set @nErrorCode = @@Error


		End

/*

		--	15 Sep 16	tmc		Add P&G Free good work-aournd to exclude P&G Free Goods after 1 Sept 16;  Proper fix once new Free Goods in place

		If (@nErrorCode = 0 And @nRowCount > 0) 
		Begin

			If (@bDebug <> 0)
			Begin
				Print '------------------------------------------------------------------------------------------------------------'
				Print '20. Free Goods P&G correction to remove free goods estimate for PROCGA >= 1 Sep 16'
				Print 'Once on the new sytem this will re revisited.  tmc, 13 Sep 16'
				Print '------------------------------------------------------------------------------------------------------------'
				Print ''
			End

			UPDATE    
				BRS_TransactionDW
			SET              
				FreeGoodsEstInd = 0
			FROM         
				BRS_TransactionDW 
		
				INNER JOIN BRS_Item AS i 
				ON BRS_TransactionDW.Item = i.Item

			WHERE     
				(i.Supplier = 'PROCGA') AND 
				(BRS_TransactionDW.Date > '1 Sep 2016') AND 
				(BRS_TransactionDW.FreeGoodsEstInd = 1) AND
				EXISTS
				(
					Select 
						* 
					From 
						STAGE_BRS_TransactionDW s
					Where 
						SalesOrderNumber = s.JDEORNO And
						DocType = s.ORDOTYCD And
						LineNumber = ROUND(s.LNNO * 1000,0) 
				) AND
				(1 = 1)


			Set @nErrorCode = @@Error

		End

		If (@nErrorCode = 0 And @nRowCount > 0) 
		Begin

			If (@bDebug <> 0)
			Begin
				Print '------------------------------------------------------------------------------------------------------------'
				Print '21. Free Goods Private Label correction to remove free goods estimates for Label = P
				Print '------------------------------------------------------------------------------------------------------------'
				Print ''
			End

			UPDATE    
				BRS_TransactionDW
			SET              
				FreeGoodsEstInd = 0
			-- SELECT *
			FROM         
				BRS_TransactionDW 
		
				INNER JOIN BRS_Item AS i 
				ON BRS_TransactionDW.Item = i.Item

			WHERE     
				(i.Label = 'P') AND 
				(BRS_TransactionDW.Date >= '2022-01-01') AND 
				(BRS_TransactionDW.FreeGoodsEstInd = 1) AND
				/*
				EXISTS
				(
					Select 
						* 
					From 
						STAGE_BRS_TransactionDW s
					Where 
						SalesOrderNumber = s.JDEORNO And
						DocType = s.ORDOTYCD And
						LineNumber = ROUND(s.LNNO * 1000,0) 
				) AND
				*/
				(1 = 1)

			Set @nErrorCode = @@Error


		End
*/

		If (@nErrorCode = 0 And @nRowCount > 0) 
		Begin
			if (@bDebug <> 0)
				Print '21. Update SalesDateLastWeekly'	

			UPDATE    
				BRS_Config
			SET              
				SalesDateLastWeekly = (SELECT     MAX(PDDT) FROM         STAGE_BRS_TransactionDW)
	
			Set @nErrorCode = @@Error
		End


		If (@nErrorCode = 0 ) 
--		If (@nErrorCode = 0 And @nRowCount > 0) 
		Begin

			If (@bDebug <> 0)
			Begin
				Print '--------------------------------------------------------------------------------'
				Print '22. add chargeback side-effect here, copy CB amt from DW to DS, tmc, 17 Dec 17 '
				Print '--------------------------------------------------------------------------------'
				Print ''
			End

			--- 
			UPDATE    
				BRS_Transaction
			SET              
				ExtChargebackAmt = w.ExtChargebackAmt,
				[GL_Object_ChargeBack] = '4730',
				[GL_Subsidiary_ChargeBack] = ''
--			SELECT *  
			FROM         
				BRS_TransactionDW AS w 
				INNER JOIN BRS_Transaction 
				ON w.SalesOrderNumber = BRS_Transaction.SalesOrderNumberKEY AND 
					w.DocType = BRS_Transaction.DocType AND
					w.LineNumber = BRS_Transaction.LineNumber AND 
					w.Date = BRS_Transaction.SalesDate AND 
					w.Shipto = BRS_Transaction.Shipto AND
					w.Item = BRS_Transaction.Item AND 
					w.LineTypeOrder = BRS_Transaction.LineTypeOrder
			WHERE     
				-- XXX TBD 18 Dec 2017 missing?
				(ISNULL(BRS_Transaction.ExtChargebackAmt,0) <> w.ExtChargebackAmt)  AND
				EXISTS
				(
					Select * 
					From STAGE_BRS_TransactionDW s
					Where 
						w.SalesOrderNumber = s.JDEORNO And
						w.DocType = s.ORDOTYCD And
						w.LineNumber = ROUND(s.LNNO * 1000,0) 
				) AND
				(1 = 1)
--			ORDER BY DATE 

			Set @nErrorCode = @@Error
		End

		If (@nErrorCode = 0 ) 
--		If (@nErrorCode = 0 And @nRowCount > 0) 
		Begin

			If (@bDebug <> 0)
			Begin
				Print '--------------------------------------------------------------------------------'
				Print '23. add FG side-effect here, copy FG flag from DW to DS, tmc, 14 May 26'
				Print '--------------------------------------------------------------------------------'
				Print ''
			End

			--- 
			UPDATE    
				BRS_Transaction
			SET
				FreeGoodsEstInd = w.[FreeGoodsEstInd],
				AdjCode = CASE WHEN w.[FreeGoodsEstInd] =1  THEN 'XXXFGE' ELSE '' END,
				AdjNote = CASE WHEN w.[FreeGoodsEstInd] =1  THEN 'XXXFGE' ELSE '' END
				
			-- SELECT w.SalesOrderNumber, w.DocType, w.LineNumber, w.Item, w.FreeGoodsInvoicedInd, w.FreeGoodsEstInd, t.FreeGoodsEstInd, t.FiscalMonth, t.ExtendedCostAmt, t.AdjCode, t.AdjNote
			FROM         
				BRS_TransactionDW AS w 
				INNER JOIN BRS_Transaction t
				ON w.SalesOrderNumber = t.SalesOrderNumberKEY AND 
					w.DocType = t.DocType AND
					w.LineNumber = t.LineNumber AND 

					-- needed?
					w.Date = t.SalesDate AND 
					w.Shipto = t.Shipto AND
					w.Item = t.Item AND 
					w.LineTypeOrder = t.LineTypeOrder
			WHERE     
				(t.FreeGoodsEstInd <> w.FreeGoodsEstInd)  AND

				-- remove below 3 comments to retro-fix DS FG flags 
--				/*
				EXISTS
				(
					Select * 
					From STAGE_BRS_TransactionDW s
					Where 
						w.SalesOrderNumber = s.JDEORNO And
						w.DocType = s.ORDOTYCD And
						w.LineNumber = ROUND(s.LNNO * 1000,0) 
				) AND
--				*/
--				[CalMonth] >= 202401 AND
				(1 = 1)


			Set @nErrorCode = @@Error
		End

		--
		If (@nErrorCode = 0 And @nRowCount > 0) 
		Begin
			if (@bDebug <> 0)
				Print '24. Update Credit Info'

			UPDATE
				BRS_TransactionDW
			SET
				CreditMinorReasonCode = ISNULL(s.CRMNRECD,'')
				,CreditTypeCode = ISNULL(s.CRTYCD,'')
			FROM
				Integration.BRS_CreditInfo AS s 

				INNER JOIN BRS_TransactionDW 
				ON s.JDEORNO = BRS_TransactionDW.SalesOrderNumber AND 
					s.ORDOTYCD = BRS_TransactionDW.DocType AND 
					ROUND(s.LNNO * 1000,0) = BRS_TransactionDW.LineNumber

			Set @nErrorCode = @@Error
		End


		If (@nErrorCode = 0) 
		Begin
			if (@bDebug <> 0)
				Print '25. Clear STAGE_BRS_TransactionDW'	

			Delete FROM STAGE_BRS_TransactionDW

			Set @nErrorCode = @@Error
		End

	End -- not clear stage

	------------------------------------------------------------------------------------------------------------
	-- Wrap-up routines.  
	------------------------------------------------------------------------------------------------------------


	-- Monthend commit

	if (@bDebug <> 0)
		Set @nErrorCode = 512

	-- Call error message on Error
	if (@nErrorCode <> 0)
	Begin
		Set @sMessage = '[BRS_BE_Transaction_DW_load_proc]'
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


-- Fixes
/*
-- Chargeback fix of last resort (2m, QA)
SELECT top 10 * FROM [BRS_TransactionDW] where date = '2021-03-23'
DELETE FROM [BRS_TransactionDW] where date = '2021-03-23'

-- ISR fix
			UPDATE    
				BRS_TransactionDW_Ext
			SET              
				TsTerritoryOrgCd =	r.[TerritoryCd],
				TsTerritoryCd=		r.[TerritoryCd]

--			select SalesOrderNumber, r.[TerritoryCd], CustomerPOText1
			FROM         
				BRS_TransactionDW_Ext 

				INNER JOIN [dbo].[BRS_FSC_Rollup]  r
				ON BRS_TransactionDW_Ext.CustomerPOText1 LIKE r.Rule_WhereClauseLike AND
					r.Rule_WhereClauseLike <>''
			WHERE   
				(TsTerritoryCd <> r.[TerritoryCd]) AND
				(ID between 19139663 and 21577839) AND
				(1=1)

*/

-- Exec BRS_BE_Dimension_load_proc @bClearStage=0, @bDebug=1
-- Exec BRS_BE_Dimension_load_proc @bClearStage=0, @bDebug=0

-- prod run 
-- BRS_BE_Transaction_DW_load_proc @bDebug=0

-- Dev run (21s)
-- BRS_BE_Transaction_DW_load_proc @bDebug=1


