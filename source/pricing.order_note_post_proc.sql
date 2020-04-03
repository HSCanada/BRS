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
		print '1. update notes'

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
		print '1. add notes'

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

/*
select * from Integration.F5503_canned_message_file_parameters_Staging 
where 
[Q3DOCO_salesorder_number] = 1179270 AND
[Q3INMG_print_message] = 9898 AND
[Q3$SNB_sequence_number] = 0.01 AND
[Q3LNID_line_number] = -999.999 AND
(1=1)

select * from Pricing.order_header_note_F5503
where 
[Q3DOCO_salesorder_number] = 1179270 AND
[Q3INMG_print_message] = 9898 AND
[Q3$SNB_sequence_number] = 0.01 AND
[Q3LNID_line_number] = -999.999 AND
(1=1)
*/