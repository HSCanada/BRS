SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [comm].[comm_stage_update_proc] 
	@bDebug as smallint = 1
AS
/******************************************************************************
**	File:	
**	Name: comm_synch_proc
**	Desc: apply staged changes to current commission groups
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
**    
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
	Print 'Proc: comm_stage_update_proc'
	Print 'Desc: apply staged changes to current commission groups'
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
		print '1. BRS_Item - Update'

	UPDATE
		BRS_Item
	SET
		[comm_group_cd] = s.[fsc_comm_group_cd],
		[comm_note_txt] = LEFT(s.[fsc_comm_note_txt],50)
	FROM
		[Integration].[comm_item_Staging] AS s 
		INNER JOIN BRS_Item d
		ON s.[Item] = d.item
	WHERE
		(d.[comm_group_cd] <> s.[fsc_comm_group_cd]) OR
		(ISNULL(d.[comm_note_txt],'') <> s.[fsc_comm_note_txt])

	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '2. BRS_Customer - Update'

	UPDATE
		BRS_Customer
	SET                
		comm_status_cd = m.[cust_comm_group_cd],
		comm_note_txt = s.comm_note_txt
	--SELECT s.*
	FROM
		[Integration].[comm_customer_Staging] s 

		INNER JOIN [comm].[special_market_map] m
		ON m.[merch_comm_cd] = s.merch_comm_cd AND
		m.[equip_comm_cd] = s.equip_comm_cd

	WHERE	
		(s.ShipTo = BRS_Customer.ShipTo) AND
		(BRS_Customer.comm_status_cd <> m.[cust_comm_group_cd])

	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '3. salesperson_master - Update'

	UPDATE 
		comm.salesperson_master
	SET
		[salesperson_nm] = s.[salesperson_nm]
		,[comm_plan_id] = s.[comm_plan_id]
		,territory_start_dt = ISNULL(s.territory_start_dt,'1980-01-01')
		,[note_txt] = s.[comm_note_txt]
		,[CostCenter]=s.[CostCenter]
		,[salary_draw_amt]= s.[salary_draw_amt]
		,[deficit_amt]=s.[deficit_amt]

	FROM  
		[Integration].[comm_salesperson_master_Staging] s
	WHERE
		(s.[employee_num] = comm.salesperson_master.[employee_num]) AND
		(s.[master_salesperson_cd] = comm.salesperson_master.[master_salesperson_cd])

		-- XXX
		-- add delta filter here...

	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '4. salesperson_master - Add'

	INSERT INTO comm.salesperson_master
	(
		[FiscalMonth]
		,[employee_num]
		,[master_salesperson_cd]
		,[salesperson_nm]
		,[comm_plan_id]
		,[territory_start_dt]
		,[CostCenter]
		,[salary_draw_amt]
		,[deficit_amt]
		,[note_txt]
		,[flag_ind]
	)
	SELECT        
		[FiscalMonth]
		,[employee_num]
		,[master_salesperson_cd]
		,[salesperson_nm]
		,[comm_plan_id]
		,territory_start_dt
		,[CostCenter]
		,[salary_draw_amt]
		,[deficit_amt]
		,[comm_note_txt]
		,[email_ind]
	FROM
		[Integration].[comm_salesperson_master_Staging] s
	WHERE 
		salesperson_key_id <> '' AND 
		NOT EXISTS
		(
			SELECT * FROM comm.salesperson_master d
			WHERE 
				(s.[employee_num] = d.[employee_num]) AND
				(s.[master_salesperson_cd] = d.[master_salesperson_cd])
		)

	Set @nErrorCode = @@Error
End


-- TBD display set, then rate update
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '5. plan_group_rate - Add'

	INSERT INTO   [comm].[plan_group_rate] 
	(
		comm_plan_id, 
		[item_comm_group_cd], 
		[cust_comm_group_cd], 
		[source_cd]
	)
	SELECT *  FROM
	(
		SELECT  
			DISTINCT [comm_plan_id] 
		FROM 
			[comm].[plan] 
	) s
	CROSS JOIN
	( 
		SELECT 
			[comm_group_cd] as item_comm_group_cd 
		FROM 
			[comm].[group] 
		WHERE 
			[source_cd] in ('JDE', 'IMP', 'PAY') OR
			-- added blank code to serve as undefinded senario placeholder for rollups
			[comm_group_cd] = ''
	) s2
	CROSS JOIN
	(
		SELECT  
			DISTINCT [comm_status_cd] as cust_comm_group_cd 
		FROM 
			[dbo].[BRS_Customer]
	) s3
	CROSS JOIN
	( 
		SELECT 
			[source_cd] 
		FROM 
			[comm].[source] 
		WHERE 
			[source_cd] in ('JDE', 'IMP', 'PAY') 
	) s4
	WHERE 
		NOT EXISTS 
		(
			SELECT 
				* 
			FROM 
				[comm].[plan_group_rate] d 
			WHERE
				d.comm_plan_id = s.comm_plan_id AND
				d.[item_comm_group_cd] = s2.[item_comm_group_cd] AND
				d.[cust_comm_group_cd] = s3.[cust_comm_group_cd] AND
				d.[source_cd] = s4.[source_cd]
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
	Set @sMessage = 'comm_stage_update_proc'
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
-- EXEC comm.comm_stage_update_proc @bDebug=0

-- Debug
-- EXEC comm.comm_stage_update_proc @bDebug=1
