SET ANSI_NULLS ON
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
					)

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
		print '6a. ScheinSaver clear prod'

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

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '6b. ScheinSaver add deal header'

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
		print '6c. ScheinSaver add deal line'

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
		print '6d. add new chargback'

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
		print '7a. add new salesorder from backorder for RI'

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
		print '7b. add new backorder'

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
		,SDLNID_line_number * 1000
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
	FROM
		Integration.FBACKRPT1_backorder_Staging AS FBACKRPT1_backorder_Staging_1
	WHERE
		(SDSOBK_quantity_backordered <> 0) AND 
		(SDLNTY_line_type <> 'MS') AND 
		(QCAC10_division_code <> 'AZA') AND 
		(1 = 1)
	Set @nErrorCode = @@Error
End

--

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



--EXECUTE pricing.order_note_post_proc @bDebug=1
--EXECUTE pricing.order_note_post_proc @bDebug=0

