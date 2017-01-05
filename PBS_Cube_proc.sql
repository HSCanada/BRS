

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[PBS_Cube_proc] 
    @dtFrom as datetime = 0,
    @dtTo as datetime = 0

AS

/******************************************************************************
**	File: 
**	Name: PBS_Cube_proc
**	Desc: Supply Priviges Benefit Stagement with 
**		o Sales
**		o Discount
** 		o Free Goods
**		o Events 
**		o Order Source
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
**	Date: 5 Jan 17
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/
BEGIN

Declare @nErrorCode int, @nTranCount int, @bDebug int
Declare @sMessage varchar(255)

Set @nErrorCode = @@Error
Set @nTranCount = @@Trancount

Set @bDebug = CASE WHEN @dtFrom = 0 THEN 1 ELSE 0 END

if (@bDebug <> 0) 
Begin
	Print '---------------------------------------------------------'
	Print 'Proc: PBS_Cube_proc'
    Print ''
	Print 'Desc: Supply Priviges Benefit Stagement with '
	Print '	o Sales'
	Print '	o Discount'
	Print '	o Free Goods'
	Print '	o Conventions (nonblank for shows '
	Print '	o Order Source (with Order Taken = CUSTOMER or FSC'
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

--
-- 20 Nov 16	tmc		Swap out JDE direct extract in place of broken NEO extract

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Add Current Base and Supplier Cost to STAGE_BRS_ItemBaseHistory ...'


SELECT     
    d.FiscalMonth, 
    t.Shipto, 
    t.Item, 
    MAX (i.SalesCategory)               AS SalesCategory, 
    t.OrderSourceCode,
    t.OrderTakenBy, 
    t.FreeGoodsInvoicedInd, 

    p.PromotionTrackingCode             AS PromotionTrackingCode, 

    SUM(t.ShippedQty)                   AS ShippedQty, 
    SUM(t.NetSalesAmt)                  AS NetSalesAmt, 
    SUM(t.ExtListPrice - t.NetSalesAmt) AS ExtDiscAmt, 
    SUM(t.ExtListPrice)                 AS ExtListPrice, 
    SUM(t.ExtPrice)                     AS ExtPrice


FROM         

    BRS_TransactionDW AS t 
    
    INNER JOIN BRS_Item AS i 
    ON t.Item = i.Item 

    INNER JOIN BRS_SalesDay AS d 
    ON t.Date = d.SalesDate 

    INNER JOIN BRS_Promotion AS p 
    ON t.OrderPromotionCode = p.PromotionCode

WHERE     
    (d.FiscalMonth between  @dtFrom and @dtTo) AND
    (t.Shipto = 1643036) AND
    (1=1)

GROUP BY 
    d.FiscalMonth, 
    t.Shipto, 
    t.Item, 
    t.OrderSourceCode, 
    t.OrderTakenBy, 
    t.FreeGoodsInvoicedInd,
    p.PromotionTrackingCode
 
	Set @nErrorCode = @@Error
End


------------------------------------------------------------------------------------------------------------
-- Wrap-up routines.  
------------------------------------------------------------------------------------------------------------


-- Monthend commit

if (@bDebug <> 0)
	Set @nErrorCode = 512

-- Call error message on Error
if (@nErrorCode <> 0)
Begin
	Set @sMessage = '[PBS_Cube_proc]'
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


-- Exec [PBS_Cube_proc] 201301, 201612






