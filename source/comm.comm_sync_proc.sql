SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [comm].[comm_sync_proc] 
	@bDebug as smallint = 1
AS
/******************************************************************************
**	File:	
**	Name: comm_synch_proc
**	Desc: ensure operational business rules and commission groups are in sync
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
**	Date: 17 Jun 20
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	29 Jan 21	tmc		add Private Label logic for 2021 plan    
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
	Print 'Proc: comm_sync_proc'
	Print 'Desc: ensure business rules and comm groups are in sync'
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
		print '1. sync item comm_group_eps_cd'
	UPDATE
		[dbo].[BRS_item]
	SET
		comm_group_eps_cd = s.[comm_group_eps_cd]
	FROM
		[eps].[item] AS s
	WHERE
		(s.Item_Number = Item) AND
		(s.[comm_group_eps_cd] <> [dbo].[BRS_item].comm_group_eps_cd) AND
		(1=1)

	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '2. revert eps back to merch comm_group_cd (removed from 2021 plan)'

	UPDATE
		[dbo].[BRS_item]
	SET
		comm_group_cd = 'ITMSND'
	FROM
		[dbo].[BRS_item]
	WHERE
		(comm_group_cd = 'ITMEPS') AND
		(1=1)

	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '2b. map merch private label comm_group_cd '

	UPDATE
		[dbo].[BRS_item]
	SET
		comm_group_cd = 'ITMPVT'
	FROM
		[dbo].[BRS_item]
	WHERE
		(comm_group_cd = 'ITMSND') AND
		([Label]='P') AND
		(1=1)

	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '3. synch eps terr - current'

	UPDATE
		[dbo].[BRS_Customer]
	SET
		eps_code = s.Eps_Code
	FROM
		[eps].[Customer] AS s
	WHERE
		(s.Customer_Number = [ShipTo]) AND
		(s.Eps_Code <> [dbo].[BRS_Customer].eps_code) AND
		(1 = 1)

	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '4. synch cps terr - current'

	UPDATE
		[dbo].[BRS_Customer]
	SET
		cps_code = map.TerritoryCd
	FROM
		comm.plan_region_map AS map
	WHERE
		-- must be valid customer, as postal code driven based on Current address
		(shipto > 0) AND 
		(Postalcode <>'') AND
		(map.comm_plan_id = 'CPSGP') AND 
		(PostalCode LIKE map.postal_code_where_clause_like) AND 
		(cps_code <> map.TerritoryCd) AND
		(1 = 1)

	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '5. add new [item_group_rule]'

	INSERT INTO [comm].[item_group_rule]
	(
		[MinorProductClass]
		,[Supplier]
		,[comm_group_cd]
		,[confidence_rt]
	)
	SELECT Distinct 
		[MinorProductClass]
		,[Supplier]
		,''
		,0
	FROM [dbo].[BRS_Item] s
	WHERE
		NOT EXISTS (
			SELECT * 
			FROM [comm].[item_group_rule] d 
			where (d.MinorProductClass = s.MinorProductClass) AND
			(d.Supplier = s.Supplier)
		)

	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '7. add dup salesorder with generic doctype AA for simplified adjustment RI'

	INSERT INTO 
		[dbo].[BRS_TransactionDW_Ext] 
		(
			[SalesOrderNumber], 
			DocType
		)
	SELECT DISTINCT 
		s.SalesOrderNumber, 
		'AA' DocType
	FROM
		[dbo].[BRS_TransactionDW_Ext]  s 
	WHERE
		NOT EXISTS 
		(
			SELECT * 
			FROM [dbo].[BRS_TransactionDW_Ext]  d
			WHERE d.SalesOrderNumber = s.[SalesOrderNumber] AND 
			d.DocType = 'AA'
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
	Set @sMessage = 'comm_sync_proc'
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
-- EXEC comm.comm_sync_proc @bDebug=0

-- Debug, 40s
-- EXEC comm.comm_sync_proc @bDebug=1
