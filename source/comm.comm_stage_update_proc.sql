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
**	23 Dec 20	tmc		add new commission mapping
**	01 Feb 21	tmc		small rebate default fix to remove Ref Integrity issue
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

-- update / overwrite [salesperson_key_id] to ensure this does not change
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '3. salesperson_master - Update pre'

	UPDATE 
		[Integration].[comm_salesperson_master_Staging]
	SET
		[salesperson_key_id]=s.[salesperson_key_id]
	FROM  
		comm.salesperson_master s
	WHERE
		(s.[employee_num] = [Integration].[comm_salesperson_master_Staging].[employee_num]) AND
		(s.[master_salesperson_cd] = [Integration].[comm_salesperson_master_Staging].[master_salesperson_cd]) AND
		(s.[salesperson_key_id]<>'') AND
		(s.[salesperson_key_id]<>ISNULL([Integration].[comm_salesperson_master_Staging].[salesperson_key_id],'')) AND
		(1=1)

	Set @nErrorCode = @@Error
End

--
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '4. salesperson_master - Update'

	UPDATE 
		comm.salesperson_master
	SET
		[FiscalMonth]=s.FiscalMonth
		,[salesperson_nm] = s.[salesperson_nm]
		,[comm_plan_id] = s.[comm_plan_id]
		,territory_start_dt = s.territory_start_dt
		,[CostCenter]=s.[CostCenter]
		,[salary_draw_amt]= s.[salary_draw_amt]
		,[deficit_amt]=s.[deficit_amt]
		,[note_txt] = ISNULL(s.[comm_note_txt],'')
		,[flag_ind] = CASE WHEN s.email_ind LIKE 'Y%' THEN 1 ELSE 0 END

	FROM  
		[Integration].[comm_salesperson_master_Staging] s
	WHERE
		(s.[employee_num] = comm.salesperson_master.[employee_num]) AND
		(s.[master_salesperson_cd] = comm.salesperson_master.[master_salesperson_cd]) AND
		(
			(s.FiscalMonth <> comm.salesperson_master.[FiscalMonth]) OR
			(s.[salesperson_nm] <> comm.salesperson_master.[salesperson_nm]) OR
			(s.[comm_plan_id] <> comm.salesperson_master.[comm_plan_id]) OR
			(s.territory_start_dt <> comm.salesperson_master.territory_start_dt) OR
			(s.[CostCenter] <> comm.salesperson_master.[CostCenter]) OR
			(s.[salary_draw_amt] <> comm.salesperson_master.[salary_draw_amt]) OR
			(s.[deficit_amt] <> comm.salesperson_master.[deficit_amt]) OR
			(ISNULL(s.[comm_note_txt],'') <> [note_txt]) OR
			(CASE WHEN s.email_ind LIKE 'Y%' THEN 1 ELSE 0 END <> [flag_ind])
		) AND
		(1=1)

	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '5. hr_employee - Add'

	INSERT INTO [comm].[hr_employee]
	(
		[employee_num]
		,[CostCenter]
		,[first_name]
		,[last_name]
		,[job_title]
		,[location]
		,[status_code]
	)
	SELECT        
		[employee_num]
		,[CostCenter]
		,[salesperson_nm]
		,''
		,''
		,[master_salesperson_cd]
		,''

	FROM
		[Integration].[comm_salesperson_master_Staging] s
	WHERE 
		salesperson_key_id <> '' AND 
		NOT EXISTS
		(
			SELECT * FROM [comm].[hr_employee] d
			WHERE 
				(s.[employee_num] = d.[employee_num]) 
		)

	Set @nErrorCode = @@Error
End

--
-- load ONLY if [salesperson_key_id] <>'', one-time set 
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '6. salesperson_master - Add'

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
		,salesperson_key_id
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
		,ISNULL([comm_note_txt],'')
		,CASE WHEN [email_ind] LIKE 'Y%' THEN 1 ELSE 0 END
		,salesperson_key_id
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
		print '7. plan_group_rate - Add'

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

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '8. add dup salesorder with generic doctype AA for simplified adjustment RI'

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

--
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '9. update support fields for [Integration].[comm_customer_rebate_Staging]'

	UPDATE
		Integration.comm_customer_rebate_Staging
	SET
		fsc_salesperson_key_id = [HIST_fsc_salesperson_key_id]
		-- to be split to merch and teeth.  cust will help
		, fsc_comm_group_cd = [HIST_cust_comm_group_cd]
		, fsc_code = [HIST_TerritoryCd]
		-- future
		, isr_salesperson_key_id = [HIST_isr_salesperson_key_id]
		-- space, not dot as rebate_export is used to load to adjustment direct (RI)
		, isr_comm_group_cd = ''
		, isr_code = [HIST_TsTerritoryCd]
		, teeth_share_rt = 
			CASE 
				WHEN [merch_month_sales_amt] > 0 AND [teeth_month_sales_amt] > 0
				THEN [teeth_month_sales_amt]/([merch_month_sales_amt]+[teeth_month_sales_amt])
				ELSE 0.0
			END
--		ISNULL( [teeth_month_sales_amt]/ NULLIF(([merch_month_sales_amt]+[teeth_month_sales_amt]),0),0)
		, status_code = 0
	FROM
		Integration.comm_customer_rebate_Staging 
		INNER JOIN BRS_CustomerFSC_History AS src 
		ON Integration.comm_customer_rebate_Staging.ShipTo = src.Shipto AND 
		Integration.comm_customer_rebate_Staging.FiscalMonth = src.FiscalMonth
	
	Set @nErrorCode = @@Error
End

--
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '10. update support fields for [Integration].[comm_freegoods_Staging]'

	UPDATE
		Integration.comm_freegoods_Staging
	SET
		fsc_salesperson_key_id = ch.[HIST_fsc_salesperson_key_id]
		, eps_salesperson_key_id = ch.[HIST_eps_salesperson_key_id]
		, isr_salesperson_key_id = ch.[HIST_isr_salesperson_key_id]
		, cust_comm_group_cd = ch.[HIST_cust_comm_group_cd]

		, fsc_code = ch.[HIST_TerritoryCd]
		, eps_code = ch.[HIST_eps_code]
		, isr_code = ch.[HIST_TsTerritoryCd]
		, fsc_comm_plan_id = ch.[HIST_fsc_comm_plan_id]
		, eps_comm_plan_id = ch.[HIST_eps_comm_plan_id]
		, isr_comm_plan_id = ch.[HIST_isr_comm_plan_id]

		, ess_salesperson_key_id = doc.[HIST_ess_salesperson_key_id]

		, ess_code = doc.[HIST_ess_code]
		, ess_comm_plan_id = doc.HIST_ess_comm_plan_id

		, fsc_comm_group_cd = ih.[HIST_comm_group_cd]
		, eps_comm_group_cd = ih.[HIST_comm_group_eps_cd]
		, ess_comm_group_cd = ih.[HIST_comm_group_cd]
		, isr_comm_group_cd = ih.[HIST_comm_group_cd]
		, item_comm_group_cd = ih.[HIST_comm_group_cd]

		, ma_estimate_factor = cat.ma_estimate_factor


		-- set to temp value for next step
		, status_code = 100
	FROM
		BRS_ItemSalesCategory AS cat 

		INNER JOIN BRS_Item AS i 
		ON cat.SalesCategory = i.SalesCategory 
	
		INNER JOIN Integration.comm_freegoods_Staging 
	
		INNER JOIN BRS_ItemHistory AS ih 
		ON Integration.comm_freegoods_Staging.Item = ih.Item AND 
			Integration.comm_freegoods_Staging.FiscalMonth = ih.FiscalMonth 
	
		INNER JOIN BRS_TransactionDW_Ext AS doc 
		ON Integration.comm_freegoods_Staging.SalesOrderNumber = doc.SalesOrderNumber AND 
			Integration.comm_freegoods_Staging.DocType = doc.DocType 
		
		INNER JOIN BRS_CustomerFSC_History AS ch 
		ON Integration.comm_freegoods_Staging.ShipTo = ch.Shipto AND 
		Integration.comm_freegoods_Staging.FiscalMonth = ch.FiscalMonth 
	
		ON i.Item = Integration.comm_freegoods_Staging.Item
	
	Set @nErrorCode = @@Error
End

--

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '10b. update support fields for [Integration].[comm_freegoods_Staging] - FG mapping'

	UPDATE
		Integration.comm_freegoods_Staging
	SET
		fg_fsc_comm_group_cd = fsc.[fg_comm_group_cd]
		, fg_eps_comm_group_cd = eps.[fg_comm_group_cd]
		, fg_ess_comm_group_cd = ess.[fg_comm_group_cd]
		, fg_isr_comm_group_cd = isr.[fg_comm_group_cd]

		, status_code = 0
	FROM
		[comm].[plan_group_rate] fsc
		, [comm].[plan_group_rate] eps
		, [comm].[plan_group_rate] ess
		, [comm].[plan_group_rate] isr
	WHERE
		(status_code = 100) AND

		(fsc.[comm_plan_id] = Integration.comm_freegoods_Staging.fsc_comm_plan_id) AND
		(fsc.[item_comm_group_cd] = Integration.comm_freegoods_Staging.item_comm_group_cd) AND
		(fsc.[cust_comm_group_cd] = Integration.comm_freegoods_Staging.cust_comm_group_cd) AND
		(fsc.[source_cd] = 'JDE') AND

		(eps.[comm_plan_id] = Integration.comm_freegoods_Staging.eps_comm_plan_id) AND
		(eps.[item_comm_group_cd] = Integration.comm_freegoods_Staging.item_comm_group_cd) AND
		(eps.[cust_comm_group_cd] = Integration.comm_freegoods_Staging.cust_comm_group_cd) AND
		(eps.[source_cd] = 'JDE') AND

		(ess.[comm_plan_id] = Integration.comm_freegoods_Staging.ess_comm_plan_id) AND
		(ess.[item_comm_group_cd] = Integration.comm_freegoods_Staging.item_comm_group_cd) AND
		(ess.[cust_comm_group_cd] = Integration.comm_freegoods_Staging.cust_comm_group_cd) AND
		(ess.[source_cd] = 'JDE') AND

		(isr.[comm_plan_id] = Integration.comm_freegoods_Staging.isr_comm_plan_id) AND
		(isr.[item_comm_group_cd] = Integration.comm_freegoods_Staging.item_comm_group_cd) AND
		(isr.[cust_comm_group_cd] = Integration.comm_freegoods_Staging.cust_comm_group_cd) AND
		(isr.[source_cd] = 'JDE') AND

		(1=1)

	Set @nErrorCode = @@Error
End

-- note:  
--	the adjustment table is used by the FreeGoods, Rebates, and Payrole tables
--	avoid re-processing by using the owner codes HR & BR
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '11. update support fields for [Integration].[comm_adjustment_Staging] - 1 of 3, FSC (required)'

	UPDATE
		Integration.comm_adjustment_Staging
	SET
		WSDGL__gl_date = m.[EndDt]
		, fsc_salesperson_key_id = ISNULL(f.comm_salesperson_key_id,'')
		, ess_salesperson_key_id = ISNULL(e.comm_salesperson_key_id,'')
		-- note:  does for missing primary required, space for missing derived
		, item_comm_group_cd = ISNULL(ih.[HIST_comm_group_cd],'.')
		-- set missing to item-based default, set ess futher down stream
		,[fsc_comm_group_cd] = ISNULL(NULLIF([fsc_comm_group_cd],'.'),ISNULL(ih.[HIST_comm_group_cd],'.'))
	FROM
		BRS_FiscalMonth AS m 
		INNER JOIN Integration.comm_adjustment_Staging 
	
		ON m.FiscalMonth = Integration.comm_adjustment_Staging.FiscalMonth 
	
		LEFT OUTER JOIN BRS_ItemHistory AS ih 
		ON Integration.comm_adjustment_Staging.WSLITM_item_number = NULLIF(ih.Item, '.') AND 
			Integration.comm_adjustment_Staging.FiscalMonth = ih.FiscalMonth 

		LEFT OUTER JOIN BRS_FSC_Rollup AS e 
		ON Integration.comm_adjustment_Staging.ess_code = NULLIF(e.TerritoryCd, '.')
	
		LEFT OUTER JOIN BRS_FSC_Rollup AS f 
		ON Integration.comm_adjustment_Staging.fsc_code = NULLIF(f.TerritoryCd, '.')

	-- avoid re-processing FreeGoods, Rebates, and Payrole tables
	WHERE [WSVR01_reference] not in ('BR', 'HR')
	
	Set @nErrorCode = @@Error
End

--
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '12. update support fields for [Integration].[comm_adjustment_Staging] - 2 of 3, Non FSC/ESS (experimental)'

	UPDATE
		Integration.comm_adjustment_Staging
	SET
		cust_comm_group_cd = [HIST_cust_comm_group_cd]
		, cps_salesperson_key_id = [HIST_cps_salesperson_key_id]
		, cps_code = [HIST_cps_code]

		, eps_salesperson_key_id = [HIST_eps_salesperson_key_id]
		, eps_code = [HIST_eps_code]

		, isr_salesperson_key_id = [HIST_isr_salesperson_key_id]
		, isr_code = [HIST_TsTerritoryCd]

		, est_salesperson_key_id = [HIST_est_salesperson_key_id]
		, est_code = [HIST_est_code]

	  -- item History
      ,[cps_comm_group_cd] = ISNULL([HIST_comm_group_cps_cd],'.')
      ,[eps_comm_group_cd] = ISNULL([HIST_comm_group_eps_cd],'.')
      ,[isr_comm_group_cd] = ISNULL([HIST_comm_group_cd],'.')
      ,[est_comm_group_cd] = ISNULL([HIST_comm_group_est_cd],'.')

	FROM
		Integration.comm_adjustment_Staging

		INNER JOIN BRS_CustomerFSC_History AS ch 
		ON Integration.comm_adjustment_Staging.FiscalMonth = ch.FiscalMonth AND 
			Integration.comm_adjustment_Staging.WSSHAN_shipto = ch.Shipto

		LEFT JOIN [dbo].[BRS_ItemHistory] AS ih 
		ON Integration.comm_adjustment_Staging.FiscalMonth = ih.FiscalMonth AND 
			Integration.comm_adjustment_Staging.WSLITM_item_number = ih.[Item]

	WHERE
		(Integration.comm_adjustment_Staging.WSSHAN_shipto > 0) AND 
		-- set customer specific plan for FSC, non  duplidated ESS adj
		(NOT (Integration.comm_adjustment_Staging.fsc_code IN ('', '.'))) AND	  

		-- avoid re-processing FreeGoods, Rebates, and Payrole tables
		[WSVR01_reference] not in ('BR', 'HR')
	
	Set @nErrorCode = @@Error
End

-- do we need to worry about back order -> line 0 colisions?   28 Jun 21
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '13. update support fields for [Integration].[comm_adjustment_Staging] - 3 of 3, check order, set ess code, set complete'

	UPDATE
		Integration.comm_adjustment_Staging
	SET
		-- ensure valid document number & stash original
		WSDOC__document_number = ISNULL(doc.SalesOrderNumber,0)
		, WSDOCO_salesorder_number = WSDOC__document_number

		-- close fsc code to ess if valid ESS and original adjustment only
		,[ess_comm_group_cd] = CASE 
									WHEN
										-- avoid re-processing FreeGoods, Rebates, and Payrole tables
										([WSVR01_reference] not in ('BR', 'HR')) AND 
										-- valid ESS?
										([ess_salesperson_key_id] <> '') AND
										([ess_comm_group_cd] = '')
									THEN [fsc_comm_group_cd]
									-- no change
									ELSE [ess_comm_group_cd]
								END


		-- used to calc GP from costs
		-- avoid re-processing FreeGoods, Rebates, and Payrole tables
		, ma_estimate_factor =	CASE 
									WHEN [WSVR01_reference] not in ('BR', 'HR') 
									THEN cat.ma_estimate_factor 
									-- no change
									ELSE Integration.comm_adjustment_Staging.ma_estimate_factor 
								END
		, status_code = 0
	FROM
		Integration.comm_adjustment_Staging 

		-- group (join)
		INNER JOIN comm.[group] AS g 
		ON Integration.comm_adjustment_Staging.fsc_comm_group_cd = g.comm_group_cd 
	
		INNER JOIN BRS_ItemSalesCategory AS cat 
		ON g.SalesCategory = cat.SalesCategory AND 
			g.SalesCategory = cat.SalesCategory 
		
		LEFT OUTER JOIN BRS_TransactionDW_Ext AS doc 
		ON NULLIF(Integration.comm_adjustment_Staging.WSDOC__document_number,0) = doc.SalesOrderNumber AND 
			Integration.comm_adjustment_Staging.WSDCTO_order_type = doc.DocType
	WHERE
		-- valid adjust must have valid comm group (join) and either FSC or ESS
		fsc_code <> '.' OR
		ess_code <> '.' 

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

