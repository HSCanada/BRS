SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [flex].[order_load_proc]
	@bDebug as smallint = 1
AS
/******************************************************************************
**	File:	
**	Name: flex.order_load_proc
**	Desc: load flex orders from stage to prod
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
**	Date: 28 Jan 21
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
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
	Print '---------------------------------------------------------'
	Print 'Proc: flex.order_load_proc'
	Print 'Desc: load flex orders from stage to prod'
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

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '1. integration.flex_order_lines_Staging - assign flex_code'

	UPDATE
		[Integration].[flex_order_lines_Staging]
	SET
		[flex_code] = template.flex_code
		,status_code = 5
	FROM
		[flex].[batch_template] template
	WHERE
		Integration.flex_order_lines_Staging.order_file_name Like template.[flex_import_prefix] 

	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '2. integration.flex_order_lines_Staging - test flex_code'

	SELECT @nRowCount = count(*) 
	FROM
		[Integration].[flex_order_lines_Staging]
	WHERE
		flex_code is null

	if (@bDebug <> 0)
		print @nRowCount

	Set @nErrorCode = @nRowCount
End


-- update / overwrite [salesperson_key_id] to ensure this does not change
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '3. flex.order_file - load'

	INSERT INTO flex.order_file
		(order_file_name, flex_code, Supplier)
	SELECT
		s.order_file_name, s.flex_code, template.Supplier
	FROM
		Integration.flex_order_lines_Staging AS s 
		INNER JOIN flex.batch_template AS template 
		ON s.flex_code = template.flex_code
	GROUP BY 
		s.order_file_name, s.flex_code, template.Supplier

	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '4. flex.customer_xref - load'

	INSERT INTO flex.customer_xref
	(
	ACCOUNT
	, Supplier
	, ShipTo_Suggest

	, COMPANY
	, FIRSTLAST
	, ADDRESS1
	, ADDRESS2
	, ADDRESS3

	, CITY
	, ST
	, POSTALCODE
	, PHONE
	, COUNTRY
	)
	SELECT
		CAST(s.ACCOUNT as int) acct
		, flex.batch_template.Supplier
		, MIN(s.REFERENCE)

		, MIN(ISNULL((s.COMPANY),'')) AS minCOMPANY
		, MIN(ISNULL((s.FIRSTLAST),'')) AS minFIRSTLAST
		, MIN(ISNULL((s.ADDRESS1),'')) AS minADDRESS1
		, MIN(ISNULL((s.ADDRESS2),'')) AS minADDRESS2
		, MIN(ISNULL((s.ADDRESS3),'')) AS minADDRESS3

		, MIN(LEFT(ISNULL((s.CITY),''),10)) AS minCITY
		, MIN(ISNULL((s.ST),'')) AS minST
		, MIN(ISNULL((s.POSTALCODE),'')) AS minPOSTALCODE
		, MIN(ISNULL((s.PHONE),'')) AS minPHONE
		, MIN(ISNULL((s.COUNTRY),'')) AS minCOUNTRY

	FROM
		Integration.flex_order_lines_Staging AS s 
		INNER JOIN flex.batch_template 
		ON s.flex_code = flex.batch_template.flex_code

	WHERE
		NOT EXISTS(SELECT * FROM flex.customer_xref d WHERE d.ACCOUNT = s.ACCOUNT and d.Supplier = flex.batch_template.Supplier)

	GROUP BY
		s.ACCOUNT
		, flex.batch_template.Supplier

	Set @nErrorCode = @@Error
End

--
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '5. flex.order_header - load'

INSERT INTO flex.order_header
	(
	ORDERNO
	, Supplier
	, order_file_key
	, ACCOUNT
-- ok
	, REFERENCE

	, DATE

	, COMPANY
	, FIRSTLAST
	, ADDRESS1
	, ADDRESS2
	, ADDRESS3

	, CITY
	, ST
	, POSTALCODE
	, PHONE
	, COUNTRY
	, ORIGINAL_INVOICE

	)
SELECT
	LEFT(s.ORDERNO,10) as orderno
	, LEFT(MIN(ford.Supplier),6) AS minSupplier
	, MIN(ford.order_file_key) AS minorder_file_key
	, CAST(MIN(s.ACCOUNT) as int) AS minACCOUNT


	, MIN( LEFT(ISNULL((s.REFERENCE),''),30) ) AS minREFERENCE


--	, MIN(CAST (s.DATE as date)) AS minDATE
--	, MIN(CONVERT(date, s.DATE)) AS minDATE
	, MIN(CONVERT(DATE,s.date_text)) AS minDATE

	, MIN(ISNULL((s.COMPANY),'')) AS minCOMPANY
	, MIN(ISNULL((s.FIRSTLAST),'')) AS minFIRSTLAST
	, MIN(ISNULL((s.ADDRESS1),'')) AS minADDRESS1
	, MIN(ISNULL((s.ADDRESS2),'')) AS minADDRESS2
	, MIN(ISNULL((s.ADDRESS3),'')) AS minADDRESS3

	, MIN(LEFT(ISNULL((s.CITY),''),10)) AS minCITY
	, MIN(ISNULL((s.ST),'')) AS minST
	, MIN(ISNULL((s.POSTALCODE),'')) AS minPOSTALCODE
	, MIN(ISNULL((s.PHONE),'')) AS minPHONE
	, MIN(ISNULL((s.COUNTRY),'')) AS minCOUNTRY
	, MIN(ISNULL(s.ORIGINAL_INVOICE,0)) AS minORIGINAL_INVOICE


FROM
	Integration.flex_order_lines_Staging AS s 

	INNER JOIN flex.order_file AS ford 
	ON s.order_file_name = ford.order_file_name

GROUP BY s.ORDERNO

	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '6. flex.item_xref - load'

	INSERT INTO [flex].[item_xref]
		(
		ITEMNO
		, Supplier
		, ITEMDESC
		)
	SELECT
		RIGHT(s.ITEMNO,15)
		, LEFT(flex.batch_template.Supplier,6)
		, MIN(s.ITEMDESC)
	FROM
		Integration.flex_order_lines_Staging AS s 
	
		INNER JOIN flex.batch_template 
		ON s.flex_code = flex.batch_template.flex_code

		WHERE
			NOT EXISTS(SELECT * FROM flex.[item_xref] d WHERE d.ITEMNO = RIGHT(s.ITEMNO,15) and d.Supplier = flex.batch_template.Supplier)

		GROUP BY
			RIGHT(s.ITEMNO,15)
			, flex.batch_template.Supplier

	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '7. flex.order_detail - load'

INSERT INTO flex.order_detail
	(
	ORDERNO
	, Supplier
	, line_id
--	, status_code
	, ITEMNO
	, QTY

	, ITEMDESC
	, UPC
	, PRICE
	, FREEGDS
	, PROMOCODE
	, PROGRAMCODE

	)
SELECT
	LEFT(s.ORDERNO,10)
	, LEFT(flex.batch_template.Supplier,6)
	, s.line_id
--	, s.status_code
	, RIGHT(s.ITEMNO,15)
	, s.QTY

	, LEFT(s.ITEMDESC,50)
	, LEFT(s.UPC,15)
	, s.PRICE
	, LEFT(s.FREEGDS,1)
	, LEFT(s.PROMOCODE,10)
	, LEFT(s.PROGRAMCODE,10)

FROM
	Integration.flex_order_lines_Staging AS s 
	
	INNER JOIN flex.batch_template 
	ON s.flex_code = flex.batch_template.flex_code

	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '8. integration.flex_order_lines_Staging - clear'

	DELETE FROM [Integration].[flex_order_lines_Staging] where [status_code] = 5

	Set @nErrorCode = @@Error
End


------------------------------------------------------------------------------------------------------------
-- Wrap-up routines.  
------------------------------------------------------------------------------------------------------------

-- force error in debug
if (@bDebug <> 0 AND @nErrorCode = 0)
	Set @nErrorCode = 512

-- Call error message on Error
if (@nErrorCode <> 0)
Begin
	Set @sMessage = 'flex.order_load_proc'
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

-- Prod
-- EXEC flex.order_load_proc @bDebug=0

-- Debug
-- EXEC flex.order_load_proc @bDebug=1
