
/****** Object:  StoredProcedure [dbo].[BRS_BE_Transaction_load_proc]    Script Date: 11/23/2023 10:56:55 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [ds].[jde_transaction_extract_proc] 
	@bDebug as smallint = 1
AS

/******************************************************************************
**	File: 
**	Name: [ds].[jde_transaction_extract_proc] 
**	Desc: pull the Daily Sales table to stage table from linked JDE
**
**	Todo:   
**		1. Parameterized Date logic so today - 4 (long weekend) (param?)
**		2. load all 300 fields              
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
**	Date: 23 Nov 23
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/
BEGIN


Declare @nErrorCode int, @nTranCount int
Declare @sMessage varchar(255)

Set @nErrorCode = @@Error
Set @nTranCount = @@Trancount

Declare @dtSalesDay datetime
Declare @nBatchStatus int
Declare @nFiscalMonth int

SET NOCOUNT ON;



if (@bDebug <> 0)
	SET NOCOUNT OFF;

Set @nBatchStatus = -1

-- Start transaction
if (@nTranCount = 0)
	Begin Tran mytran
Else
	Save Tran mytran


if (@bDebug <> 0)
	Print 'DEBUG MODE.  Lookup Current Day & Month '

If (@nErrorCode = 0) 
Begin
	Select 	
		@dtSalesDay = SalesDate, @nFiscalMonth = FiscalMonth
	From 
		dbo.BRS_Config

	Set @nErrorCode = @@Error
End



If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Clear Stage trans'	

	Delete FROM Integration.F55520_daily_sales_order_header_detail_workfile

	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Extract JDE last X days to Stage trans'

-- tc fix this to pulll 300 fields -- see '20231117 DS patch process.sql' file
INSERT INTO Integration.F55520_daily_sales_order_header_detail_workfile
(
	WODOCO_salesorder_number
	,WODCTO_order_type
	,WOKCOO_order_number_document_company
	,WOLNID_line_number
	,WODMCT_contract_number
	,WOSHAN_shipto
	,WOTRDJ_order_date
	,WODGL__gl_date
	,WOLITM_item_number
	,WOLNTY_line_type
	,WOUORG_quantity
	,WO$CBA_chargeback_amount
	,WO$LDC_landed_cost
	,WO$FCS_file_cost
	,WOSRP6_manufacturer
	,WO$SPM_secondary_promotion_code
	,WOORBY_ordered_by
	,WOTKBY_order_taken_by 
)

SELECT 
--    Top 10

    "WODOCO" AS WODOCO_salesorder_number
	, "WODCTO" AS WODCTO_order_type
	, "WOKCOO" AS WOKCOO_order_number_document_company
	, "WOLNID" AS WOLNID_line_number
	, "WODMCT" AS WODMCT_contract_number
	, "WOSHAN" AS WOSHAN_shipto
	, "WOTRDJ" AS WOTRDJ_order_date
	, "WODGL" AS WODGL__gl_date
	, "WOLITM" AS WOLITM_item_number
	, "WOLNTY" AS WOLNTY_line_type
	, "WOUORG" AS WOUORG_quantity
	, "WO$CBA" AS WO$CBA_chargeback_amount
	, "WO$LDC" AS WO$LDC_landed_cost
	, "WO$FCS" AS WO$FCS_file_cost
	, "WOSRP6" AS WOSRP6_manufacturer
	, "WO$SPM" AS WO$SPM_secondary_promotion_code
	, "WOORBY" AS WOORBY_ordered_by
	, "WOTKBY" AS WOTKBY_order_taken_by 

-- INTO Integration.F55520_daily_sales_order_header_detail_workfile

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		WODOCO
		,WODCTO
		,WOKCOO
		,CAST((WOLNID)/1000.0 AS DEC(15,3)) AS WOLNID
		,WODMCT
		,WOSHAN
		,CASE WHEN WOTRDJ IS NOT NULL THEN DATE(DIGITS(DEC(WOTRDJ+ 1900000,7,0))) ELSE NULL END AS WOTRDJ
		,CASE WHEN WODGL IS NOT NULL THEN DATE(DIGITS(DEC(WODGL+ 1900000,7,0))) ELSE NULL END AS WODGL
		,WOLITM
		,WOLNTY
		,WOUORG
		,CAST((WO$CBA)/100.0 AS DEC(15,2)) AS WO$CBA
		,CAST((WO$LDC)/100.0 AS DEC(15,2)) AS WO$LDC
		,CAST((WO$FCS)/100.0 AS DEC(15,2)) AS WO$FCS
		,WOSRP6
		,WO$SPM
		,WOORBY
		,WOTKBY

	FROM
		ARCPDTA71.F55520
    WHERE

--		PROD 1 Oct 23
--      WODGL >= 123274
-- 546148 rows @ 4m25s
--      WODGL >= >= trunc(sysdate-1,''DD'')
--	TC lookupdate date logic in github
      WODGL >= (124284-5)
  

--    ORDER BY
--        <insert custom code here>
')

	Set @nErrorCode = @@Error
End



if (@bDebug <> 0)
	Set @nErrorCode = 512

-- Call error message on Error
if (@nErrorCode <> 0)
Begin
	Set @sMessage = '[ds].[jde_transaction_extract_proc]'
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

GRANT EXECUTE ON [ds].[jde_transaction_extract_proc] TO [maint_role]
GO

-- prod run
-- EXECUTE [ds].[jde_transaction_extract_proc] @bDebug=0


-- debug run
-- EXECUTE [ds].[jde_transaction_extract_proc] @bDebug=1
-- 178 128 @ 1m37

-- testing

-- select top 10 * from Integration.F55520_daily_sales_order_header_detail_workfile
-- select count(*) from Integration.F55520_daily_sales_order_header_detail_workfile


