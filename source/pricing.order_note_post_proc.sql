﻿SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE pricing.order_note_post_proc
	@bDebug as smallint = 1
AS

/******************************************************************************
**	File: 
**	Name: order_note_post_proc
**	Desc: update pricing tables after ETL pull from JDE 
**
**              
**	Return values:  @@Error
**
**	Called by:   pricing job
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**	
**
**	Auth: tmc
**	Date: 21 Feb 20
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	27 Mar 20	tmc		fix update bug where doctype changes (unexpected)
**  13 Sep 22	tmc		Add Astea note load to process
**  14 Sep 22	tmc		add ScheinSaver & Backorder load
**	28 Nov 22	tmc		update ScheinSaver header info (they get recycled)
**	27 Mar 23	tmc		add hfm to proc (weekly)
**  03 Apr 23	tmc		duplicate note work around - remove French Lang (PK iss)
**	25 May 23	tmc		fixed bug where items NOT in US item were being excluded
*******************************************************************************/

Declare @nErrorCode int,
@nTranCount int
Declare @sMessage varchar(255)

Set @nErrorCode = @@Error
Set @nTranCount = @@Trancount

SET NOCOUNT ON;
if (@bDebug <> 0)
	SET NOCOUNT OFF;

if (@bDebug <> 0) 
Begin
	Print '---------------------------------------------------------'
	Print 'Proc: order_note_post_proc'
	Print 'Desc: copy pricing from stage to prod'
	Print 'Mode: DEBUG'
	Print '---------------------------------------------------------'
End

------------------------------------------------------------------------------------------------------------
-- Init routines.  
------------------------------------------------------------------------------------------------------------

-- Start transaction
if (@nTranCount = 0)
	Begin Tran mytran
Else
	Save Tran mytran

------------------------------------------------------------------------------------------------------------
-- Update routines.  
------------------------------------------------------------------------------------------------------------


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '1. JDE update changed notes'

UPDATE
	Pricing.order_header_note_F5503
SET
	Q3DCTO_order_type = s.Q3DCTO_order_type,
	Q3KCOO_order_number_document_company = s.Q3KCOO_order_number_document_company,
	Q3$APC_application_code = s.Q3$APC_application_code,
	Q3$PMQ_program_parameter = s.Q3$PMQ_program_parameter,
	Q3LNGP_language = s.Q3LNGP_language,
	QCTRDJ_order_date = s.QCTRDJ_order_date,
	chksum = s.chksum 

FROM
	Integration.F5503_canned_message_file_parameters_Staging AS s 
	INNER JOIN Pricing.order_header_note_F5503 d ON 
	s.Q3DOCO_salesorder_number = d.Q3DOCO_salesorder_number AND 
	s.Q3INMG_print_message = d.Q3INMG_print_message AND 
	s.Q3$SNB_sequence_number = d.Q3$SNB_sequence_number AND 
	s.Q3LNID_line_number = d.Q3LNID_line_number AND 
	s.chksum <> d.chksum

	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '2. JDE add new notes'

	INSERT INTO Pricing.order_header_note_F5503 (
		Q3KCOO_order_number_document_company,
		Q3DCTO_order_type,
		Q3DOCO_salesorder_number,
		Q3LNID_line_number,
		Q3$APC_application_code,
		Q3$PMQ_program_parameter,
		Q3LNGP_language,
		Q3INMG_print_message,
		Q3$SNB_sequence_number,
		QCTRDJ_order_date,
		chksum
	)
	SELECT
		Q3KCOO_order_number_document_company,
		Q3DCTO_order_type,
		Q3DOCO_salesorder_number,
		Q3LNID_line_number,
		Q3$APC_application_code,
		Q3$PMQ_program_parameter,
		Q3LNGP_language,
		Q3INMG_print_message,
		Q3$SNB_sequence_number,
		QCTRDJ_order_date,
		chksum
	FROM
		Integration.F5503_canned_message_file_parameters_Staging s
	WHERE 
		NOT EXISTS (	SELECT * 
						FROM Pricing.order_header_note_F5503 d 
						WHERE
							s.[Q3DOCO_salesorder_number] = d.[Q3DOCO_salesorder_number] AND
							s.[Q3INMG_print_message] = d.[Q3INMG_print_message] AND
							s.[Q3$SNB_sequence_number] =d.[Q3$SNB_sequence_number] AND
							s.[Q3LNID_line_number] = d.[Q3LNID_line_number] AND
							-- s.[Q3DCTO_order_type] = d.[Q3DCTO_order_type] AND
							(1=1)
					) AND
		-- hack to exclude duplicate order.   Remove French?  
		s.Q3LNGP_language <> 'F'
		-- s.[Q3DOCO_salesorder_number] not in (1360497)
		

	Set @nErrorCode = @@Error
End

--
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '3. D1 update changed notes'

	UPDATE
		nes.order_note_D1ICMTPF
	SET
		ICMMSG_comments = s.ICMMSG_comments
	FROM
		Integration.D1ICMTPF_order_note_Stage AS s 

		INNER JOIN nes.order_note_D1ICMTPF 
		ON s.ICMOWO_work_order_number = nes.order_note_D1ICMTPF.ICMOWO_work_order_number AND 
			s.ICMORD_ets_order_number = nes.order_note_D1ICMTPF.ICMORD_ets_order_number AND 
			s.ICMTYP2_header_detail = nes.order_note_D1ICMTPF.ICMTYP2_header_detail AND 
			s.ICMLNE_detail_line_sequence = nes.order_note_D1ICMTPF.ICMLNE_detail_line_sequence AND 
			s.ICMSEQ_comments_sequence = nes.order_note_D1ICMTPF.ICMSEQ_comments_sequence AND 
			s.ICMBCH_batch_number = nes.order_note_D1ICMTPF.ICMBCH_batch_number AND 
			s.ICMTYP1_record_type = nes.order_note_D1ICMTPF.ICMTYP1_record_type
	WHERE
		(nes.order_note_D1ICMTPF.ICMMSG_comments <> s.ICMMSG_comments)

	Set @nErrorCode = @@Error
End

-- 
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '4. D1 add wo forRI'

	INSERT INTO 
		[nes].[order]([work_order_num], note)
	SELECT 
		DISTINCT ICMOWO_work_order_number, '' 
	FROM 
		Integration.D1ICMTPF_order_note_Stage 
	WHERE 
		NOT EXISTS (SELECT * FROM [nes].[order] WHERE ICMOWO_work_order_number = [work_order_num])

	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '5. D1 add new notes'

INSERT INTO 
nes.order_note_D1ICMTPF
(
	ICMOWO_work_order_number
	,ICMORD_ets_order_number
	,ICMTYP2_header_detail
	,ICMLNE_detail_line_sequence
	,ICMSEQ_comments_sequence
	,ICMMSG_comments
	,ICMBCH_batch_number
	,ICMTYP1_record_type
)
SELECT
	ICMOWO_work_order_number
	,ICMORD_ets_order_number
	,ICMTYP2_header_detail
	,ICMLNE_detail_line_sequence
	,ICMSEQ_comments_sequence
	,ICMMSG_comments
	,ICMBCH_batch_number
	,ICMTYP1_record_type
FROM
	Integration.D1ICMTPF_order_note_Stage s
WHERE
	NOT EXISTS 
	(
		SELECT * FROM nes.order_note_D1ICMTPF 
		WHERE
			s.ICMOWO_work_order_number = nes.order_note_D1ICMTPF.ICMOWO_work_order_number AND 
			s.ICMORD_ets_order_number = nes.order_note_D1ICMTPF.ICMORD_ets_order_number AND 
			s.ICMTYP2_header_detail = nes.order_note_D1ICMTPF.ICMTYP2_header_detail AND 
			s.ICMLNE_detail_line_sequence = nes.order_note_D1ICMTPF.ICMLNE_detail_line_sequence AND 
			s.ICMSEQ_comments_sequence = nes.order_note_D1ICMTPF.ICMSEQ_comments_sequence AND 
			s.ICMBCH_batch_number = nes.order_note_D1ICMTPF.ICMBCH_batch_number AND 
			s.ICMTYP1_record_type = nes.order_note_D1ICMTPF.ICMTYP1_record_type
	)

	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '6. ScheinSaver clear prod'

	truncate table Redemptions_tbl_Main
	truncate table Redemptions_tbl_Items

	-- inster dummy
	INSERT INTO [dbo].[Redemptions_tbl_Main]
			   ([RecID]
			   ,[Buy]
			   ,[Get])
		 VALUES
			   (0, '', '')

	Set @nErrorCode = @@Error
End

-- update free good header for now (ensure redeem and free goods in sync)
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '7. fg.deal - update'

	UPDATE fg.deal
		Set SalesDivision = ISNULL(s.div,'')
		,Supplier = ISNULL(s.VendorID,'')
		,supplier_nmOrg = ISNULL(s.VendorName,'')
		,BuyOrg = CAST(ISNULL(s.buy,'') AS varchar(255)) 
		,GetOrg = CAST(ISNULL(s.get,'') AS varchar(255))
		,RedeemOrg = ISNULL(s.Redeem,'')
		,QuarterOrg = ISNULL(s.Quarter,'')

		,deal_txt = LEFT(ISNULL(s.SetLeader_Name,''),50)
		,NoteOrg = ISNULL(s.Note,'')
		,EffDate = s.EffDate
		,Expired =s.Expired
		,auto_add_ind = s.AutoAdd

		-- future
		--,Setleader = s.Setleader

	-- SELECT * 
	FROM            
		Redemptions..tbl_Main s
	WHERE        
		-- update date
		( (SELECT [SalesDateLastWeekly] FROM [dbo].[BRS_Config]) BETWEEN s.EffDate AND s.Expired) AND
		(deal_id = s.RecID) AND
		(1=1)

	Set @nErrorCode = @@Error
End

--
--

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '8. ScheinSaver deal header - add'

	INSERT INTO Redemptions_tbl_Main
		(
		RecID, Div, Buy, Get, VendorName, Redeem, Quarter, Note, EffDate, Expired
		,Setleader
		,VendorID
		,SetLeader_Name
		,AutoAdd
		)
	SELECT        RecID, Div, Buy, Get, VendorName, Redeem, Quarter, Note, EffDate, Expired
		,Setleader
		,VendorID
		,SetLeader_Name
		,AutoAdd
	FROM            
		Redemptions..tbl_Main
	WHERE        
		-- update date
		( (SELECT [SalesDateLastWeekly] FROM [dbo].[BRS_Config]) BETWEEN EffDate AND Expired) AND
		(1=1)

	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '9. ScheinSaver add deal line'

	INSERT INTO Redemptions_tbl_Items
		(RecID, ItemNumber, ItemID)
	SELECT        
		(MIN(i.RecID)), ibr.Item, MAX(ibr.ItemKey) AS ItemID
	FROM            
		Redemptions..tbl_Items AS i 

		INNER JOIN Redemptions_tbl_Main AS d 
		ON i.RecID = d.RecID 
	
		INNER JOIN BRS_Item AS ibr 
		ON i.ItemNumber = ibr.Item
	WHERE 
	--	(i.RecID IN (30310, 30311, 30312, 30313, 30314, 30315, 30316, 30317)) AND
	--	(i.ItemNumber = '1263888') AND
		(1=1)
	GROUP BY 
		ibr.Item

	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '10. add new chargback'

	INSERT INTO [fg].[chargeback]
	(
		[cb_contract_num]
		,[note_txt]
	)
	SELECT DISTINCT [ChargebackContractNumber], 'init' 
	FROM [dbo].[BRS_TransactionDW] dw 
	WHERE [ChargebackContractNumber] > 0 and 
		NOT EXISTS (
			SELECT * 
			FROM  [fg].[chargeback] cb 
			WHERE cb.cb_contract_num = dw.ChargebackContractNumber
		)

	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '11. add new salesorder from backorder for RI'

	INSERT INTO 
		BRS_TransactionDW_Ext
		(SalesOrderNumber, DocType)
	SELECT DISTINCT
		SDDOCO_salesorder_number, SDDCTO_order_type
	FROM
		Integration.FBACKRPT1_backorder_Staging AS s
	WHERE
		(SDSOBK_quantity_backordered <> 0) AND 
		(SDLNTY_line_type <> 'MS') AND 
		(QCAC10_division_code <> 'AZA') AND 
	--	(1=1)
		(NOT EXISTS
					(SELECT        *
					FROM            BRS_TransactionDW_Ext AS d
					WHERE        (s.SDDOCO_salesorder_number = d.SalesOrderNumber) AND (s.SDDCTO_order_type = d.DocType))
		) 

	Set @nErrorCode = @@Error
End


--
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '12. add new backorder'

	INSERT INTO 
		fg.backorder_FBACKRPT1_history 
		(
			SalesDay
			,SDDOCO_salesorder_number
			,SDDCTO_order_type
			,SDLNID_line_number
			,SDDOC__document_number
			,SDSHAN_shipto
			,SDLITM_item_number

			,QN$SPC_supplier_code
			,QCTRDJ_order_date
			,SDUPRC_unit_price
			,SDSOBK_quantity_backordered
			,SDUORG_quantity
			,IMBUYR_buyer_number
			,SDDSC1_description
			,QV$PRI_pricing_info
			,QV$AVC_availability_code
			,QV$CLC_classification_code
			,SDSHAN01_mailing_name

			,GIADDZ_postal_code

			,GICTY1_city

			,GIADDS_state

			,GICTR__country
			,QCAC10_division_code
			,SDLNTY_line_type
			,IMLNTY_line_type

			,SDMCU__business_unit
			,SDVR01_reference
			,SDVR02_reference_2
			,QCENTB_entered_by
			,SDRSDJ_promised_delivery
			,SDNXTR_status_code_next

		)
	SELECT
	(
		(SELECT MAX(QCTRDJ_order_date) AS SalesDay FROM Integration.FBACKRPT1_backorder_Staging)) AS SalesDay
		,SDDOCO_salesorder_number
		,SDDCTO_order_type
		-- convert fload to int (same as other trans)
		,SDLNID_line_number * 1000 AS line_number
		,SDDOC__document_number
		,SDSHAN_shipto
		,RTRIM(SDLITM_item_number) AS item

		,QN$SPC_supplier_code
		,QCTRDJ_order_date
		,SDUPRC_unit_price
		,SDSOBK_quantity_backordered
		,SDUORG_quantity
		,IMBUYR_buyer_number
		,SDDSC1_description
		,QV$PRI_pricing_info
		,QV$AVC_availability_code
		,QV$CLC_classification_code
		,SDSHAN01_mailing_name

		,LEFT(GIADDZ_postal_code,10)  AS GIADDZ_postal_code

		,GICTY1_city

		,GIADDS_state

		,GICTR__country
		,QCAC10_division_code
		,SDLNTY_line_type
		,IMLNTY_line_type

		,SDMCU__business_unit
		,SDVR01_reference
		,SDVR02_reference_2
		,QCENTB_entered_by
		,SDRSDJ_promised_delivery
		,SDNXTR_status_code_next

	FROM
		Integration.FBACKRPT1_backorder_Staging AS s
	WHERE
		(SDSOBK_quantity_backordered <> 0) AND 
		(SDLNTY_line_type <> 'MS') AND 
		(QCAC10_division_code <> 'AZA') AND 

		NOT EXISTS 
		(
			SELECT * FROM fg.backorder_FBACKRPT1_history  d 
			WHERE 
				(d.[SalesDay] = (SELECT MAX(QCTRDJ_order_date) AS SalesDay FROM Integration.FBACKRPT1_backorder_Staging)) AND
				(d.SDDOCO_salesorder_number = s.SDDOCO_salesorder_number) AND
				(d.[SDDCTO_order_type] = s.[SDDCTO_order_type]) AND
				(d.[SDLNID_line_number] = s.[SDLNID_line_number] * 1000)
		) AND

		EXISTS (SELECT * FROM [dbo].[BRS_Item] i where s.SDLITM_item_number = i.item) AND
		-- test
		--(SDDOCO_salesorder_number = 16148903) AND
		--
		(1 = 1)

	Set @nErrorCode = @@Error
End

--
-------------------------------------------------------------------------------
-- Part 1 - HFM update, run any time
-------------------------------------------------------------------------------

--- update F0901 from ETL - run package to update F0901, F0909
-- Doc this in Wiki -- DO IT! 31 May 22

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
print '13. add new [dbo].[BRS_BusinessUnit]'

	INSERT INTO [dbo].[BRS_BusinessUnit]
	(BusinessUnit)
	SELECT        Distinct GMMCU__business_unit 
	FROM            Integration.F0901_account_master AS s
	WHERE NOT EXISTS 
	(
		SELECT * FROM [dbo].[BRS_BusinessUnit] b
		WHERE s.GMMCU__business_unit = b.BusinessUnit
	)
	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
print '14. add new [dbo].[BRS_Object]'

	INSERT INTO [dbo].[BRS_Object]
	([GLAcctNumberObj])
	SELECT        Distinct GMOBJ__object_account 
	FROM            Integration.F0901_account_master AS s
	WHERE NOT EXISTS 
	(
		SELECT * FROM [dbo].[BRS_Object] o
		WHERE s.GMOBJ__object_account = o.[GLAcctNumberObj]
	)

	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
print '15. add new hfm.account_master_F0901'

	INSERT INTO hfm.account_master_F0901
							 (GMCO___company, GMAID__account_id, GMMCU__business_unit, GMOBJ__object_account, GMSUB__subsidiary, GMANS__free_form_3rd_acct_no, 
							 GMDL01_description, GMLDA__account_level_of_detail, GMBPC__budget_pattern_code, GMPEC__posting_edit, GMUSER_user_id, GMPID__program_id, 
							 GMJOBN_work_station_id, GMUPMJ_date_updated_JDT, GMUPMT_time_last_updated)
	SELECT        GMCO___company, GMAID__account_id, GMMCU__business_unit, GMOBJ__object_account, GMSUB__subsidiary, GMANS__free_form_3rd_acct_no, 
							 GMDL01_description, GMLDA__account_level_of_detail, GMBPC__budget_pattern_code, GMPEC__posting_edit, GMUSER_user_id, GMPID__program_id, 
							 GMJOBN_work_station_id, GMUPMJ_date_updated_JDT, GMUPMT_time_last_updated
	FROM            Integration.F0901_account_master AS s
	WHERE NOT EXISTS 
	(
		SELECT * FROM hfm.account_master_F0901 d
		WHERE 
			s.[GMMCU__business_unit]=d.[GMMCU__business_unit] AND 
			s.[GMOBJ__object_account] = d.[GMOBJ__object_account] AND
			s.[GMSUB__subsidiary] = d.[GMSUB__subsidiary]
	)

	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
print '16. update bu map - hfm.account_master_F0901'

	UPDATE       
		hfm.account_master_F0901
	SET                
		HFM_CostCenter = b.CostCenter, 
		[LastUpdated]  = getdate()
	FROM            
		[dbo].[BRS_BusinessUnit] b 
		INNER JOIN hfm.account_master_F0901 m
	ON 
		m.[GMMCU__business_unit] = b.BusinessUnit 
	WHERE 
		b.CostCenter <>'' AND
		ISNULL(HFM_CostCenter,'') <> b.CostCenter

	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)

	print '17. update Obj map - hfm.account_master_F0901'
	UPDATE       hfm.account_master_F0901
	SET                HFM_Account = [HFM_Account_TargetKey]
	FROM            hfm.account_master_F0901 INNER JOIN
							 hfm.object_to_account_map_rule AS m ON 
							 hfm.account_master_F0901.GMMCU__business_unit + hfm.account_master_F0901.GMOBJ__object_account + hfm.account_master_F0901.GMSUB__subsidiary LIKE
							  REPLACE(REPLACE(m.Rule_WhereClauseLike, '?', '_'), '*', '%')
	WHERE        (m.ActiveInd = 1) AND ISNULL(HFM_Account, '') <> [HFM_Account_TargetKey]

	Set @nErrorCode = @@Error
End

--

------------------------------------------------------------------------------------------------------------
-- Wrap-up routines.  
------------------------------------------------------------------------------------------------------------


if (@bDebug <> 0)
	Set @nErrorCode = 512

-- Call error message on Error
if (@nErrorCode <> 0)
Begin
	Set @sMessage = 'pricing.etl_post_proc'
	Set @sMessage = @sMessage + ': ' + convert(varchar,
@bDebug)

	RAISERROR ('%s',
9,
1,
@sMessage )
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

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- Prod
-- EXECUTE pricing.order_note_post_proc @bDebug=0

-- Debug
-- EXECUTE pricing.order_note_post_proc @bDebug=1

-- *** fix dup so that if salesdate is there the batch is NOT reloaded

