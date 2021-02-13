SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [flex].[order_update_proc]
	@bDebug as smallint = 1
AS
/******************************************************************************
**	File:	
**	Name: flex.order_update_proc
**	Desc: update flex orders item and customer xref
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
	Print 'Proc: flex.order_update_proc'
	Print 'Desc: update flex orders item and customer xref'
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
		print '1. flex.order_detail - update item xref'

	UPDATE
		flex.order_detail
	SET
		status_code = 0
		, Item = i.Item
	FROM
		flex.order_detail 
	
		INNER JOIN flex.item_xref AS i 
		ON flex.order_detail.ITEMNO = i.ITEMNO AND 
		flex.order_detail.Supplier = i.Supplier

	WHERE
		(flex.order_detail.status_code <> 0) AND 
		(i.status_code = 0)

	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '2. flex.order_header - update cust xref'

	UPDATE
		flex.order_header
	SET
		status_code = 0
		, ShipTo = c.ShipTo
	FROM
		flex.order_header 
		INNER JOIN flex.customer_xref AS c 
		ON flex.order_header.ACCOUNT = c.ACCOUNT AND 
		flex.order_header.Supplier = c.Supplier
	WHERE
		(flex.order_header.status_code <> 0) AND 
		(c.status_code = 0)

		Set @nErrorCode = @@Error
	End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '3. integration.flex_order_lines_Staging - test flex_code'

	UPDATE
		flex.order_file
	SET 
		[status_code] = 0
	WHERE
		([status_code] <> 0) AND
		NOT EXISTS 
		(
			SELECT * FROM
			(
				SELECT
					f.order_file_name
					, COUNT(distinct h.ORDERNO) AS bad_order
					, COUNT(*) AS bad_lines
				FROM
					flex.order_file AS f
					INNER JOIN flex.order_header AS h 
					ON f.order_file_key = h.order_file_key 
	
					INNER JOIN flex.order_detail AS d 
					ON h.ORDERNO = d.ORDERNO AND 
					h.Supplier = d.Supplier
				WHERE
					(f.status_code <> 0) AND (h.status_code <> 0) OR
					(f.status_code <> 0) AND (d.status_code <> 0)
				GROUP BY
					f.order_file_name
			) chk
			WHERE
				(flex.order_file.order_file_name = chk.order_file_name) AND
				(chk.bad_lines > 0) AND
				(1=1)
		)

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
	Set @sMessage = 'flex.order_update_proc'
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
-- EXEC flex.order_update_proc @bDebug=0

-- Debug
-- EXEC flex.order_update_proc @bDebug=1
