

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
			Print 'Clear tables.'

		TRUNCATE TABLE STAGE_BRS_Promotion
		TRUNCATE TABLE STAGE_BRS_TransactionDW
		TRUNCATE TABLE [Integration].[BRS_CreditInfo]

		Set @nErrorCode = @@Error

	End
	Else
	-- Load Tables
	Begin
		--	13 Dec 16	tmc		Added Update Promo logic
		If (@nErrorCode = 0) 
		Begin
			if (@bDebug <> 0)
				Print 'Add new Promo...'

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
				Print 'Updated Changed Promo...'

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
				Print 'Add new BU...'

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
				Print 'Add new ESS...'

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
				Print 'Add new CCS...'

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
				Print 'Add new TSS...'

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
				Print 'Add new DTX...'

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
				Print 'Add new entered_by...'

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
				Print 'Add new Sales Orders to BRS_TransactionDW_Ext...'

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
				Print 'Update PO Text ...'

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
				Print 'Map Promo tagged TS to Order-level TS Code...'

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
				Print 'Update Credit lookup table'

		INSERT INTO 
			[dbo].[BRS_Creditinfo]
		(
			[CreditMinorReasonCode]
			, [CreditTypeCode]
		)
		SELECT 
			DISTINCT CRMNRECD AS CreditMinorReasonCode
			, CRTYCD AS CreditTypeCode
		FROM
			Integration.BRS_CreditInfo s
		WHERE 
			NOT EXISTS
			(
				SELECT * 
				FROM [dbo].[BRS_Creditinfo] d 
				WHERE s.CRMNRECD = d.CreditMinorReasonCode AND 
					s.CRTYCD = d.CreditTypeCode)

			Set @nErrorCode = @@Error
		End
--
		If (@nErrorCode = 0) 
		Begin
			if (@bDebug <> 0)
				Print 'LOAD BRS_TransactionDW'


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

				)
				SELECT     
				s.JDEORNO AS SalesOrderNumber, 
				s.ORDOTYCD AS DocType, 
				ROUND(s.LNNO * 1000,0) AS LineNumber, 
				s.CMID AS CalMonth, 
				s.PDDT AS Date, 
				s.ADNOID AS Shipto, 
				s.ITLONO AS Item, 

				s.ENBYNA AS EnteredBy, 
				s.ORTKBYID AS OrderTakenBy, 
				s.ORSCCD AS OrderSourceCode, 
				LEFT(s.RF1TT,25) AS CustomerPOText1, 
				s.PRMDCD AS PriceMethod, 
				ISNULL(s.SPCDID,'') AS VPA, 

				s.LNTY AS LineTypeOrder, 
				s.HSDCDID AS SalesDivision, 
				s.MJPRCLID AS MajorProductClass, 

				--  16 Jan 17   tmc     Fixed Chargeback Number load so * maps to 0
				CASE WHEN s.CBCONTRNO = '*' THEN 0 ELSE ISNULL(s.CBCONTRNO,0) END AS ChargebackContractNumber, 
		--		ISNULL(s.CBCONTRNO,0) AS ChargebackContractNumber, 
				ISNULL(s.GLBUNO,'') AS GLBusinessUnit, 
				ISNULL(s.ORFISHDT, '1 Jan 1980') AS OrderFirstShipDate, 
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
					WHEN s.PDDT = s.ORFISHDT 
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
		--      CASE WHEN ShippedQty <> 0 AND NetSalesAmt = 0 AND ABS(GPAtFileCostAmt) > 0.02 * ShippedQty THEN 1 ELSE 0 END AS FreeGoodsInvoicedInd

				-- Free goods estimate model can be improved, 27 Jan 17
				CASE 
					WHEN s.WJXBFS2 = 0 AND dt.FreeGoodsEstInd = 1 AND 
						buc.FreeGoodsEstInd = 1 AND mpc.FreeGoodsEstInd = 1 
					THEN 1 ELSE 0 
				END                                             AS FreeGoodsEstInd,

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

			FROM         
				STAGE_BRS_TransactionDW AS s 

				LEFT OUTER JOIN STAGE_BRS_Promotion AS p2 
				ON s.OPMID = p2.PMID 

				LEFT OUTER JOIN STAGE_BRS_Promotion AS p1 
				ON s.PMID = p1.PMID

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


		--	15 Sep 16	tmc		Add P&G Free good work-aournd to exclude P&G Free Goods after 1 Sept 16;  Proper fix once new Free Goods in place

		If (@nErrorCode = 0 And @nRowCount > 0) 
		Begin

			If (@bDebug <> 0)
			Begin
				Print '------------------------------------------------------------------------------------------------------------'
				Print 'Free Goods P&G correction to remove free goods estimate for PROCGA >= 1 Sep 16'
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
			if (@bDebug <> 0)
				Print 'Update SalesDateLastWeekly'	

			UPDATE    
				BRS_Config
			SET              
				SalesDateLastWeekly = (SELECT     MAX(PDDT) FROM         STAGE_BRS_TransactionDW)
	
			Set @nErrorCode = @@Error
		End

		If (@nErrorCode = 0 And @nRowCount > 0) 
		Begin

			If (@bDebug <> 0)
			Begin
				Print '--------------------------------------------------------------------------------'
				Print 'add chargeback side-effect here, copy CB amt from DW to DS, tmc, 17 Dec 17 '
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

		--
		If (@nErrorCode = 0 And @nRowCount > 0) 
		Begin
			if (@bDebug <> 0)
				Print 'Update Credit Info'

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
--


		If (@nErrorCode = 0) 
		Begin
			if (@bDebug <> 0)
				Print 'Clear STAGE_BRS_TransactionDW'	

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


-- Test logic

-- prod run 
-- BRS_BE_Transaction_DW_load_proc @bDebug=0

-- Dev run (5.45m)
-- BRS_BE_Transaction_DW_load_proc @bDebug=1

