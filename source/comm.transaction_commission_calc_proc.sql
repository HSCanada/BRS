set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [comm].[transaction_commission_calc_proc] 
	@bDebug as smallint = 1, @bLegacy as smallint = 0
AS

/******************************************************************************
**	File: 
**	Name: comm_transaction_commission_calc_proc
**	Desc: Calculate commission tranaction details (port from legacy)
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
**	Date: 28 May 20
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

Declare @nErrorCode int, @nTranCount int
Declare @sMessage varchar(255)

Set @nErrorCode = @@Error
Set @nTranCount = @@Trancount

Declare @nCurrentFiscalYearmoNum int
Declare @nBatchStatus int

SET NOCOUNT ON;
if (@bDebug <> 0)
	SET NOCOUNT OFF;

if (@bDebug <> 0) 
Begin
	Print '---------------------------------------------------------'
	Print 'Proc: comm_transaction_commission_calc_proc'
	Print 'Desc: Calculate commission tranaction details'
	Print 'Mode: DEBUG, Legacy = ' + CAST(@bLegacy as varchar)
	Print '---------------------------------------------------------'
End

------------------------------------------------------------------------------------------------------------
-- Init routines.  
------------------------------------------------------------------------------------------------------------

Set @nCurrentFiscalYearmoNum = -1
Set @nBatchStatus = -1

-- Start transaction
if (@nTranCount = 0)
	Begin Tran mytran
Else
	Save Tran mytran

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Get Current Fiscal Month'

	Select 	
		@nCurrentFiscalYearmoNum = [PriorFiscalMonth]
	From 
		[dbo].[BRS_Config]

	Set @nErrorCode = @@Error
End

	
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Get BatchStatus'

	Select 	
		@nBatchStatus = [comm_status_cd]
	From 
		[dbo].[BRS_FiscalMonth]
	Where
		[FiscalMonth] = @nCurrentFiscalYearmoNum
	
	Set @nErrorCode = @@Error
End

------------------------------------------------------------------------------------------------------------
-- Update routines.  
------------------------------------------------------------------------------------------------------------

--	29 Feb 16	tmc		fix small but so that batch 10 is valid
if (@bDebug <> 0)
Begin
	Print 'Confirm BatchStatus NOT locked'
	Print @nCurrentFiscalYearmoNum
	Print Convert(varchar, @nBatchStatus)
End

If (@nBatchStatus >= 10 and @nBatchStatus < 999)
Begin

------------------------------------------------------------------------------------------------------
-- Legacy - FSC
------------------------------------------------------------------------------------------------------
	If (@nErrorCode = 0 AND @bLegacy = 1) 
	Begin
		if (@bDebug <> 0)
			print '1. FSC legacy - set calc_key'

		UPDATE
			comm.transaction_F555115
		SET
			[fsc_calc_key] = r.calc_key
--		test 1 of 2
--		SELECT TOP 10 t.FiscalMonth, t.WSSHAN_shipto, r.comm_plan_id, r.item_comm_group_cd, r.cust_comm_group_cd
--
		FROM
			comm.transaction_F555115 t

			INNER JOIN [dbo].[BRS_CustomerFSC_History] c
			ON t.WSSHAN_shipto = c.ShipTo AND
				t.FiscalMonth = c.FiscalMonth

			-- potential gap here, check?  or assume R updated
			INNER JOIN [comm].[plan_group_rate] AS r 
			ON t.fsc_comm_plan_id = r.comm_plan_id AND
				t.fsc_comm_group_cd = r.item_comm_group_cd AND
				c.[HIST_cust_comm_group_cd] = r.cust_comm_group_cd AND
				t.[source_cd] = r.[source_cd]
		WHERE        
			-- FSC must have a territory and item groupcode to lookup
			(t.fsc_code <> '') AND
			(t.fsc_comm_group_cd <> '') AND 
			(t.FiscalMonth = @nCurrentFiscalYearmoNum ) AND
			ISNULL(t.[fsc_calc_key],0) <> r.calc_key AND
--			test 2 of 2
--			(t.FiscalMonth = 201909 ) AND
--			(t.ID_legacy = 57534231) AND
--			(r.calc_key is null) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

------------------------------------------------------------------------------------------------------
-- Legacy - ESS/CCS
------------------------------------------------------------------------------------------------------
	If (@nErrorCode = 0 AND @bLegacy = 1) 
	Begin
		if (@bDebug <> 0)
			print '2. Ess/CCS legacy - set calc_key'

		UPDATE
			comm.transaction_F555115
		SET
			[ess_calc_key] = r.calc_key

--		SELECT top 10 * 
		FROM
			comm.transaction_F555115 t

			INNER JOIN [dbo].[BRS_CustomerFSC_History] c
			ON t.WSSHAN_shipto = c.ShipTo AND
				t.FiscalMonth = c.FiscalMonth

			INNER JOIN [comm].[plan_group_rate] AS r 
			ON t.ess_comm_plan_id = r.comm_plan_id AND
				t.ess_comm_group_cd = r.item_comm_group_cd AND
				c.[HIST_cust_comm_group_cd] = r.cust_comm_group_cd AND
				t.[source_cd] = r.[source_cd]
		WHERE        
			(t.ess_code <> '') AND
			-- relax ESS comm filter so if bad (blank), gets assigned to a key for auditing
--			(t.ess_comm_group_cd <> '') AND 
			(t.FiscalMonth = @nCurrentFiscalYearmoNum ) AND
			(ISNULL(t.[ess_calc_key],0) <> r.calc_key ) AND
--			test
--			(t.FiscalMonth >= 201901 ) AND
--			(r.calc_key is null) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

------------------------------------------------------------------------------------------------------
-- New - FSC
------------------------------------------------------------------------------------------------------

	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '3. FSC, CPS, EPS update plan & terr - JDE'

		UPDATE
			comm.transaction_F555115
		SET
			-- reference cust version
			[cust_comm_group_cd] = s.HIST_cust_comm_group_cd

			,fsc_code = s.HIST_TerritoryCd
			,fsc_salesperson_key_id = s.HIST_fsc_salesperson_key_id
			,fsc_comm_plan_id = s.HIST_fsc_comm_plan_id

			,cps_code = s.HIST_cps_code
			,cps_salesperson_key_id = s.HIST_cps_salesperson_key_id
			,cps_comm_plan_id = s.HIST_cps_comm_plan_id

			,eps_code = s.HIST_eps_code
			,eps_salesperson_key_id = s.HIST_eps_salesperson_key_id
			,eps_comm_plan_id = s.HIST_eps_comm_plan_id

		FROM
			[dbo].[BRS_CustomerFSC_History] AS s 

			INNER JOIN comm.transaction_F555115 d
			ON (d.WSSHAN_shipto = s.Shipto) AND
			(d.FiscalMonth = s.FiscalMonth) AND
			(d.source_cd = 'JDE')
		WHERE
			s.FiscalMonth = @nCurrentFiscalYearmoNum

		Set @nErrorCode = @@Error
	End

------------------------------------------------------------------------------------------------------
-- New - Transfer, after FSC / ESS territory assigned
------------------------------------------------------------------------------------------------------
	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '4. transfer - directed (1 of 2)'

		UPDATE
			comm.transaction_F555115
		SET
			xfer_key = r.[xfer_key], 

			xfer_fsc_code_org = t.fsc_code, 
			xfer_ess_code_org = t.ess_code,

			fsc_code = CASE WHEN r.[new_fsc_code] = '' THEN t.fsc_code ELSE r.[new_fsc_code] END, 
			ess_code = CASE WHEN r.[new_ess_code] = '' THEN t.ess_code ELSE r.[new_ess_code] END
		FROM
			comm.transfer_rule AS r 

			INNER JOIN comm.transaction_F555115 t 
			ON r.FiscalMonth = t.FiscalMonth AND 
				r.SalesOrderNumber = t.WSDOCO_salesorder_number
		WHERE        
			(t.source_cd = 'JDE') AND 
			(t.xfer_key is null) AND		-- only run once 
			(r.SalesOrderNumber > 0) AND	-- non rule-based 
			(t.FiscalMonth = @nCurrentFiscalYearmoNum) AND
			(1=1)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '5. transfer - rule-based (2 of 2)'

		UPDATE
			comm.transaction_F555115
		SET
			xfer_key = r.[xfer_key], 

			xfer_fsc_code_org = t.fsc_code, 
			xfer_ess_code_org = t.ess_code,

			fsc_code = CASE WHEN r.[new_fsc_code] = '' THEN t.fsc_code ELSE r.[new_fsc_code] END, 
			ess_code = CASE WHEN r.[new_ess_code] = '' THEN t.ess_code ELSE r.[new_ess_code] END
		FROM
			comm.transfer_rule AS r 

			INNER JOIN comm.transaction_F555115 t 
			ON r.FiscalMonth = t.FiscalMonth AND 
				(t.fsc_code like (CASE WHEN r.[fsc_code] = '' THEN '%' ELSE r.[fsc_code] END)) AND
				(t.ess_code like (CASE WHEN r.[ess_code] = '' THEN '%' ELSE r.[ess_code] END)) AND
				(1=1)
		WHERE        
			(t.source_cd = 'JDE') AND 
			(t.xfer_key is null) AND		-- only run once
			(r.SalesOrderNumber = 0) AND	-- rule-based
			(t.FiscalMonth = @nCurrentFiscalYearmoNum) AND
			(1=1)

		Set @nErrorCode = @@Error
	End

	
	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '6. FSC update item commgroup - JDE'

		UPDATE
			comm.transaction_F555115
		SET
			-- reference item version
			[item_comm_group_cd] = s.HIST_comm_group_cd
			,fsc_comm_group_cd = s.HIST_comm_group_cd

--		select s.* 
		FROM
			[dbo].[BRS_ItemHistory] s

			INNER JOIN comm.transaction_F555115 AS d 
			ON (d.WSLITM_item_number = s.Item) AND
			(d.FiscalMonth = s.FiscalMonth) AND
			(d.source_cd = 'JDE') AND
			(d.fsc_comm_plan_id <> '') AND
--			(s.HIST_comm_group_cd <> '') AND
			(1 = 1)
		WHERE 
			(s.FiscalMonth = @nCurrentFiscalYearmoNum) AND
			(s.HIST_comm_group_cd <> '') AND
--			test
--			(s.FiscalMonth >= 202001) AND
--			(s.HIST_comm_group_cd like 'SPM%') AND
			(1=1)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '7. FSC update commgroup - ITMPAR -> ITMFO3 promotion'
		
		UPDATE
			comm.transaction_F555115
		SET
			fsc_comm_group_cd = CASE 
									WHEN t.WSSRP6_manufacturer = 'PELTON' 
									THEN 'ITMFO1'
									ELSE 'ITMFO3'
								END
		FROM
			comm.transaction_F555115 t 
		WHERE        
			(t.fsc_comm_plan_id <> '') AND
			(t.source_cd = 'JDE') AND
			(t.WS$OSC_order_source_code IN ('A', 'L')) AND		-- Astea  EQ and Service
			(t.ess_code <> '') AND								-- Exclude Tech billing (No ESS code)
			(t.fsc_comm_group_cd = 'ITMPAR') AND				-- ONLY effect Parts 
			(t.FiscalMonth = @nCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '8. FSC update commgroup - IMP'

		UPDATE
			comm.transaction_F555115
		SET
			fsc_comm_group_cd = s.HIST_comm_group_cd
		-- SELECT t.* 
		FROM
			[dbo].[BRS_ItemHistory] AS s 

			INNER JOIN comm.transaction_F555115 d
			ON (d.WSLITM_item_number = s.Item) AND
			(d.FiscalMonth = s.FiscalMonth)
		WHERE        
			(d.fsc_comm_plan_id <> '') AND
			(d.source_cd = 'IMP') AND
			(s.HIST_comm_group_cd <> '') AND
			-- If Source IMP, and the CommCode is supplied, do not override.
			(d.WSLITM_item_number <> '') AND
			(ISNULL(d.fsc_comm_group_cd,'') = '') AND
			(d.FiscalMonth = @nCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '9. FSC update comm - non-booking -new'

		UPDATE
			comm.transaction_F555115
		SET
			[fsc_comm_rt] = r.comm_rt,
			[fsc_comm_amt] = t.[gp_ext_amt]*(r.[comm_rt]/100),
			[fsc_calc_key] = r.calc_key

		FROM
			comm.transaction_F555115 t

			INNER JOIN [dbo].[BRS_CustomerFSC_History] c
			ON t.WSSHAN_shipto = c.ShipTo AND
				t.FiscalMonth = c.FiscalMonth

			INNER JOIN [comm].[group] g
			ON t.fsc_comm_group_cd = g.comm_group_cd

			INNER JOIN [comm].[plan_group_rate] AS r 
			ON t.fsc_comm_plan_id = r.comm_plan_id AND
				t.fsc_comm_group_cd = r.item_comm_group_cd AND
				c.[HIST_cust_comm_group_cd] = r.cust_comm_group_cd AND
				t.[source_cd] = r.[source_cd]
		WHERE        
			(t.fsc_comm_plan_id <> '') AND
			(t.fsc_comm_group_cd <> '') AND 
			(t.source_cd <> 'PAY') AND
--			(g.booking_rt = 0) AND
			(t.FiscalMonth = @nCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '10. FSC update comm - pay'

		UPDATE
			comm.transaction_F555115
		SET
			[fsc_calc_key] = r.calc_key
		FROM
			comm.transaction_F555115 t

			INNER JOIN [dbo].[BRS_CustomerFSC_History] c
			ON t.WSSHAN_shipto = c.ShipTo AND
				t.FiscalMonth = c.FiscalMonth

			INNER JOIN [comm].[group] g
			ON t.fsc_comm_group_cd = g.comm_group_cd

			INNER JOIN [comm].[plan_group_rate] AS r 
			ON t.fsc_comm_plan_id = r.comm_plan_id AND
				t.fsc_comm_group_cd = r.item_comm_group_cd AND
				c.[HIST_cust_comm_group_cd] = r.cust_comm_group_cd AND
				t.[source_cd] = r.[source_cd]
		WHERE        
			(t.fsc_comm_plan_id <> '') AND
			(t.fsc_comm_group_cd <> '') AND 
			(t.source_cd = 'PAY') AND
			(t.FiscalMonth = @nCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

------------------------------------------------------------------------------------------------------
-- New - ESS/CCS
------------------------------------------------------------------------------------------------------

	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '11. ESS/CCS update plan & salesperson_key'

		UPDATE
			comm.transaction_F555115
		SET
			-- ess_code is supplied by JDE feed, history lookup not needed
			ess_salesperson_key_id = s.salesperson_key_id, 
			ess_comm_plan_id = s.comm_plan_id
		FROM
			comm.salesperson_master AS s 

			INNER JOIN BRS_FSC_Rollup AS f ON 
			s.salesperson_key_id = f.comm_salesperson_key_id 

			INNER JOIN comm.transaction_F555115 d
			ON (f.TerritoryCd = d.ess_code) AND
			(d.FiscalMonth = @nCurrentFiscalYearmoNum) AND
			(d.source_cd = 'JDE')

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '12. ESS/CCS update commgroup - JDE'

		UPDATE
			comm.transaction_F555115
		SET
			ess_comm_group_cd = s.HIST_comm_group_cd
		FROM
			[dbo].[BRS_ItemHistory] AS s

			INNER JOIN comm.transaction_F555115 AS d
			ON (d.WSLITM_item_number = s.Item) AND
			(s.FiscalMonth = d.FiscalMonth) AND
			(d.source_cd = 'JDE') AND
			(d.ess_comm_plan_id <> '') AND
			(s.HIST_comm_group_cd <> '') AND
			(1 = 1)
		WHERE        
			(s.FiscalMonth = @nCurrentFiscalYearmoNum )

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '13. ESS/CCS update commgroup - ITMPAR -> ITMFO3 promotion'

		UPDATE
			comm.transaction_F555115
		SET
			ess_comm_group_cd = CASE 
									WHEN t.WSSRP6_manufacturer = 'PELTON' 
									THEN 'ITMFO1'
									ELSE 'ITMFO3'
								END
		FROM
			comm.transaction_F555115 t 
		WHERE        
			(t.ess_comm_plan_id <> '') AND
			(t.source_cd = 'JDE') AND
			(t.WS$OSC_order_source_code IN ('A', 'L')) AND		-- Astea  EQ and Service
			(t.ess_code <> '') AND								-- Exclude Tech billing (No ESS code)
			(t.ess_comm_group_cd = 'ITMPAR') AND				-- ONLY effect Parts 
			(t.FiscalMonth = @nCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '14. ESS/CCS update commgroup - IMP'

		UPDATE
			comm.transaction_F555115
		SET
			ess_comm_group_cd = s.HIST_comm_group_cd
		-- SELECT t.* 
		FROM
			[dbo].[BRS_ItemHistory] s

			INNER JOIN comm.transaction_F555115 d
			ON (d.WSLITM_item_number = s.Item ) AND
			(d.FiscalMonth = s.FiscalMonth)
		WHERE        
			(d.ess_comm_plan_id <> '') AND
			(d.source_cd = 'IMP') AND
			(s.HIST_comm_group_cd <> '') AND
			-- If Source IMP, and the CommCode is supplied, do not override.
			(d.WSLITM_item_number <> '') AND
			(ISNULL(d.ess_comm_group_cd,'') = '') AND
			(d.FiscalMonth = @nCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '15. ESS/CCS update comm - non-booking -new'

		UPDATE
			comm.transaction_F555115
		SET
			[ess_comm_rt] = r.comm_rt,
			[ess_comm_amt] = t.[gp_ext_amt]*(r.[comm_rt]/100),
			[ess_calc_key] = r.calc_key

		FROM
			comm.transaction_F555115 t

			INNER JOIN [dbo].[BRS_CustomerFSC_History] c
			ON t.WSSHAN_shipto = c.ShipTo AND
				t.FiscalMonth = c.FiscalMonth

			INNER JOIN [comm].[group] g
			ON t.ess_comm_group_cd = g.comm_group_cd

			INNER JOIN [comm].[plan_group_rate] AS r 
			ON t.ess_comm_plan_id = r.comm_plan_id AND
				t.ess_comm_group_cd = r.item_comm_group_cd AND
				c.[HIST_cust_comm_group_cd] = r.cust_comm_group_cd AND
				t.[source_cd] = r.[source_cd]
		WHERE        
			(t.ess_comm_plan_id <> '') AND
			(t.ess_comm_group_cd <> '') AND 
			(t.source_cd <> 'PAY') AND
--			(g.booking_rt = 0) AND
			(t.FiscalMonth = @nCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '16. ESS/CSS update comm - pay'

		UPDATE
			comm.transaction_F555115
		SET
			[ess_calc_key] = r.calc_key
		FROM
			comm.transaction_F555115 t

			INNER JOIN [dbo].[BRS_CustomerFSC_History] c
			ON t.WSSHAN_shipto = c.ShipTo AND
				t.FiscalMonth = c.FiscalMonth

			INNER JOIN [comm].[group] g
			ON t.ess_comm_group_cd = g.comm_group_cd

			INNER JOIN [comm].[plan_group_rate] AS r 
			ON t.ess_comm_plan_id = r.comm_plan_id AND
				t.ess_comm_group_cd = r.item_comm_group_cd AND
				c.[HIST_cust_comm_group_cd] = r.cust_comm_group_cd AND
				t.[source_cd] = r.[source_cd]
		WHERE        
			(t.ess_comm_plan_id <> '') AND
			(t.ess_comm_group_cd <> '') AND 
			(t.source_cd = 'PAY') AND
			(t.FiscalMonth = @nCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

------------------------------------------------------------------------------------------------------
-- New & Legacy - CPS
------------------------------------------------------------------------------------------------------

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '17. CPS update item commgroup - JDE'

		UPDATE
			comm.transaction_F555115
		SET
			cps_comm_group_cd = s.HIST_comm_group_cps_cd
		FROM
			[dbo].[BRS_ItemHistory] AS s

			INNER JOIN comm.transaction_F555115 d
			ON (d.WSLITM_item_number = s.Item) AND
			(d.FiscalMonth = s.FiscalMonth) AND
			(d.source_cd = 'JDE') AND
			(d.cps_comm_plan_id <> '') AND
			(s.HIST_comm_group_cps_cd <> '') AND
			(1 = 1)
		WHERE        
			(s.FiscalMonth = @nCurrentFiscalYearmoNum)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '18. CPS update comm - non-booking -new'

		UPDATE
			comm.transaction_F555115
		SET
			[cps_comm_rt] = r.comm_rt,
			[cps_comm_amt] = t.[gp_ext_amt]*(r.[comm_rt]/100),
			[cps_calc_key] = r.calc_key

		FROM
			comm.transaction_F555115 t

			INNER JOIN [dbo].[BRS_CustomerFSC_History] c
			ON t.WSSHAN_shipto = c.ShipTo AND
				t.FiscalMonth = c.FiscalMonth

			INNER JOIN [comm].[group] g
			ON t.cps_comm_group_cd = g.comm_group_cd

			INNER JOIN [comm].[plan_group_rate] AS r 
			ON t.cps_comm_plan_id = r.comm_plan_id AND
				t.cps_comm_group_cd = r.item_comm_group_cd AND
				c.[HIST_cust_comm_group_cd] = r.cust_comm_group_cd AND
				t.[source_cd] = r.[source_cd]
		WHERE        
			(t.cps_comm_plan_id <> '') AND
			(t.cps_comm_group_cd <> '') AND 
			(t.source_cd <> 'PAY') AND
			(g.booking_rt = 0) AND
			(t.FiscalMonth = @nCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '19. CPS update comm - booking - new'

		UPDATE
			comm.transaction_F555115
		SET
			[cps_comm_rt] = g.booking_rt,
			[cps_comm_amt] =  t.transaction_amt * (g.booking_rt / 100.0) * (r.comm_rt / 100.0),
			[cps_calc_key] = r.calc_key
		FROM
			comm.transaction_F555115 t

			INNER JOIN [dbo].[BRS_CustomerFSC_History] c
			ON t.WSSHAN_shipto = c.ShipTo AND
				t.FiscalMonth = c.FiscalMonth

			INNER JOIN [comm].[group] g
			ON t.cps_comm_group_cd = g.comm_group_cd

			INNER JOIN [comm].[plan_group_rate] AS r 
			ON t.cps_comm_plan_id = r.comm_plan_id AND
				t.ess_comm_group_cd = r.item_comm_group_cd AND
				c.[HIST_cust_comm_group_cd] = r.cust_comm_group_cd AND
				t.[source_cd] = r.[source_cd]
		WHERE        
			(t.cps_comm_plan_id <> '') AND
			(t.cps_comm_group_cd <> '') AND 
			(t.source_cd <> 'PAY') AND
			(g.booking_rt <> 0) AND
			(t.FiscalMonth = @nCurrentFiscalYearmoNum) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

------------------------------------------------------------------------------------------------------
-- New & Legacy - EPS
------------------------------------------------------------------------------------------------------

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '20. EPS update item commgroup - JDE'

		UPDATE
			comm.transaction_F555115
		SET
			eps_comm_group_cd = s.HIST_comm_group_eps_cd
		FROM
			[dbo].[BRS_ItemHistory] AS s

			INNER JOIN comm.transaction_F555115 d
			ON (d.WSLITM_item_number = s.Item) AND
			(d.FiscalMonth = s.FiscalMonth) AND
			(d.source_cd = 'JDE') AND
			(d.eps_comm_plan_id <> '') AND
			(s.HIST_comm_group_eps_cd <> '') AND
			(1 = 1)
		WHERE   
			(s.FiscalMonth = @nCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End


	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '21. EPS update comm - non-booking -new'

		UPDATE
			comm.transaction_F555115
		SET
			[eps_comm_rt] = r.comm_rt,
			[eps_comm_amt] = t.[gp_ext_amt]*(r.[comm_rt]/100),
			[eps_calc_key] = r.calc_key

		FROM
			comm.transaction_F555115 t

			INNER JOIN [dbo].[BRS_CustomerFSC_History] c
			ON t.WSSHAN_shipto = c.ShipTo AND
				t.FiscalMonth = c.FiscalMonth

			INNER JOIN [comm].[group] g
			ON t.eps_comm_group_cd = g.comm_group_cd

			INNER JOIN [comm].[plan_group_rate] AS r 
			ON t.eps_comm_plan_id = r.comm_plan_id AND
				t.eps_comm_group_cd = r.item_comm_group_cd AND
				c.[HIST_cust_comm_group_cd] = r.cust_comm_group_cd AND
				t.[source_cd] = r.[source_cd]
		WHERE        
			(t.eps_comm_plan_id <> '') AND
			(t.eps_comm_group_cd <> '') AND 
			(t.source_cd <> 'PAY') AND
			(g.booking_rt = 0) AND
			(t.FiscalMonth = @nCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '22. EPS update comm - booking - new'

		UPDATE
			comm.transaction_F555115
		SET
			[eps_comm_rt] = g.booking_rt,
			[eps_comm_amt] =  t.transaction_amt * (g.booking_rt / 100.0) * (r.comm_rt / 100.0),
			[eps_calc_key] = r.calc_key
		FROM
			comm.transaction_F555115 t

			INNER JOIN [dbo].[BRS_CustomerFSC_History] c
			ON t.WSSHAN_shipto = c.ShipTo AND
				t.FiscalMonth = c.FiscalMonth

			INNER JOIN [comm].[group] g
			ON t.eps_comm_group_cd = g.comm_group_cd

			INNER JOIN [comm].[plan_group_rate] AS r 
			ON t.eps_comm_plan_id = r.comm_plan_id AND
				t.eps_comm_group_cd = r.item_comm_group_cd AND
				c.[HIST_cust_comm_group_cd] = r.cust_comm_group_cd AND
				t.[source_cd] = r.[source_cd]
		WHERE        
			(t.eps_comm_plan_id <> '') AND
			(t.eps_comm_group_cd <> '') AND 
			(t.source_cd <> 'PAY') AND
			(g.booking_rt <> 0) AND
			(t.FiscalMonth =@nCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

------------------------------------------------------------------------------------------------------------
-- Wrap-up routines.  
------------------------------------------------------------------------------------------------------------

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			Print 'Set BatchStatus to Processed'	

		Update
			[dbo].[BRS_FiscalMonth]
		Set 
			[comm_status_cd] = 20
		Where 
			[FiscalMonth] = @nCurrentFiscalYearmoNum
	
		Set @nErrorCode = @@Error
	End

End

-- force error in debug
if (@bDebug <> 0 AND @nErrorCode = 0)
	Set @nErrorCode = 512

-- Call error message on Error
if (@nErrorCode <> 0)
Begin
	Set @sMessage = 'comm.transaction_commission_calc_proc'
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


-- Debug
-- Exec comm.transaction_commission_calc_proc @bDebug=1

-- Prod
-- Exec comm.transaction_commission_calc_proc @bDebug=0

