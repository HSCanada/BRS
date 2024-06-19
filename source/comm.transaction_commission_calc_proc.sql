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
**	22 Sep 20	tmc		Add ISR commission logic, track FSC & share fsc_comm    
**	27 Sep 20	tmc		Fix Transfer FSC bug, code changed bug not key
**	27 Oct 20	tmc		Fix ISR commission locic bug, use seperate comm_group
**  20 Nov 20	tmc		setup table-driven parts promotion logic
**  16 Dec 21	tmc		add ISR logic
**	14 May 24	tmc		add FTA logic to replace PMTS
**  17 Jun 24	tmc		add Medical Threshold logic, based in GM
*******************************************************************************/

Declare @nErrorCode int, @nTranCount int
Declare @sMessage varchar(255)

Set @nErrorCode = @@Error
Set @nTranCount = @@Trancount

Declare @nCurrentFiscalYearmoNum int
Declare @nBatchStatus int

Declare @sCommPartpromSupplier char(6)
Declare @sCommPartpromGroup char(6)
Declare @sCommPartpromGroupFocus char(6)

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

		,@sCommPartpromSupplier = comm_partprom_supplier
		,@sCommPartpromGroup = comm_partprom_group_cd
		,@sCommPartpromGroupFocus = comm_partprom_group_focus_cd

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
-- New - FSC
------------------------------------------------------------------------------------------------------

	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '1. FSC, CPS, EPS, ISR, EST update plan & terr - JDE'

		UPDATE
			comm.transaction_F555115
		SET
			-- reference cust version
			[cust_comm_group_cd] = s.HIST_cust_comm_group_cd

			,fsc_code = s.HIST_TerritoryCd
			,fsc_salesperson_key_id = s.HIST_fsc_salesperson_key_id
			,fsc_comm_plan_id = s.HIST_fsc_comm_plan_id

			-- migrate from PMTS to FSA
			,cps_code = [WSCAG__cagess_code]
			,cps_salesperson_key_id = ''
			,cps_comm_plan_id = ''

			,eps_code = s.HIST_eps_code
			,eps_salesperson_key_id = s.HIST_eps_salesperson_key_id
			,eps_comm_plan_id = s.HIST_eps_comm_plan_id

			,isr_code = s.HIST_TsTerritoryCd
			,isr_salesperson_key_id = s.HIST_isr_salesperson_key_id
			,isr_comm_plan_id = s.HIST_isr_comm_plan_id

			,est_code = s.HIST_est_code
			,est_salesperson_key_id = s.HIST_est_salesperson_key_id
			,est_comm_plan_id = s.HIST_est_comm_plan_id

			-- plan and Key set downstream in ESS calc section
			-- ESS code reset, saved on load proc
			,ess_code = [WS$ESS_equipment_specialist_code]
			,ess_salesperson_key_id = ''
			,ess_comm_plan_id = ''

			-- reset calc for repeatabilty on rate / scope changes 
			,[fsc_calc_key]=NULL
			,[ess_calc_key]=NULL
			,[cps_calc_key]=NULL
			,[eps_calc_key]=NULL
			,[isr_calc_key]=NULL
			,[est_calc_key]=NULL

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
			print '2. transfer - directed (1 of 2)'

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
			--- FIX, only run once for ESS, FSC is reset? or store fixed ESS code and reset as well (better)
--			(t.xfer_key is null) AND		-- only run once 
			(r.SalesOrderNumber > 0) AND	-- non rule-based 
			(t.FiscalMonth = @nCurrentFiscalYearmoNum) AND
			(1=1)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '3. transfer - rule-based (2 of 2)'

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
--			(t.xfer_key is null) AND		-- only run once
			(r.SalesOrderNumber = 0) AND	-- rule-based
			(t.FiscalMonth = @nCurrentFiscalYearmoNum) AND
			(1=1)

		Set @nErrorCode = @@Error
	End

---
	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '4. FSC Post transfer update plan & salesperson_key update'

		UPDATE
			comm.transaction_F555115
		SET
			-- if fsc_code changed, update plan & key.  ESS / CSS fixed downstream
			fsc_salesperson_key_id = s.salesperson_key_id, 
			fsc_comm_plan_id = s.comm_plan_id
		-- Select s.salesperson_key_id, s.comm_plan_id, d.* 
		FROM
			comm.salesperson_master AS s 

			INNER JOIN BRS_FSC_Rollup AS f ON 
			s.salesperson_key_id = f.comm_salesperson_key_id 

			INNER JOIN comm.transaction_F555115 d
			ON (f.TerritoryCd = d.fsc_code) AND
			-- only review CHANGED FSC (1 is unassigned)
			(d.[xfer_key] > 1) AND
			(d.xfer_fsc_code_org <> d.fsc_code) AND
			--test
--			(d.FiscalMonth between 201901 and 201912) AND
			--
			(d.FiscalMonth = @nCurrentFiscalYearmoNum) AND
			(d.source_cd = 'JDE')

		Set @nErrorCode = @@Error
	End

---
	
	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '5. FSC update item commgroup - JDE'

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

	-- fix ITMF03 hardcode for 2021 plan
	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '6. FSC update commgroup - ITMPAR -> ITMFO3 promotion'
		
		UPDATE
			comm.transaction_F555115
		SET
			fsc_comm_group_cd = CASE 
									WHEN t.WSSRP6_manufacturer = @sCommPartpromSupplier 
									THEN @sCommPartpromGroupFocus
									ELSE @sCommPartpromGroup
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
			print '7. FSC update commgroup - IMP'

		UPDATE
			comm.transaction_F555115
		SET
			fsc_comm_group_cd = s.HIST_comm_group_cd
		-- SELECT d.* 
		FROM
			[dbo].[BRS_ItemHistory] AS s 

			INNER JOIN comm.transaction_F555115 d
			ON (d.WSLITM_item_number = s.Item) AND
			(d.FiscalMonth = s.FiscalMonth)
		WHERE        
/*
			(d.FiscalMonth = 202101 ) AND
			(d.source_cd = 'IMP') AND
			(s.HIST_comm_group_cd <> '') AND
			(d.WSLITM_item_number <> '') AND
--			(ISNULL(d.fsc_comm_group_cd,'') = '') AND
			(1 = 1)
*/
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

-- FSC standard
	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '8. FSC update comm - non-booking -new'

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
				t.[source_cd] = r.[source_cd] AND
				r.[comm_gm_threshold_cd] = '' AND
				r.[comm_gm_threshold_ind] = 0 
		WHERE        
			(t.fsc_comm_plan_id <> '') AND
			(t.fsc_comm_group_cd <> '') AND 
			(t.source_cd <> 'PAY') AND
--			(g.booking_rt = 0) AND
			(t.FiscalMonth = @nCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

-- FSC threshold model, new tmc 18 Jun 24
	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '9. FSC update comm - threshold with defined GM'

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
				t.[source_cd] = r.[source_cd] AND

				--r.[comm_gm_threshold_cd] = '' AND
				-- threshold WITH defined GM
				(r.[comm_gm_threshold_ind] = 1) AND
				(t.transaction_amt <> 0) AND
				(r.[comm_gm_threshold_min] <= (t.gp_ext_amt / t.transaction_amt)*100.0) AND
				(r.[comm_gm_threshold_max] > (t.gp_ext_amt / t.transaction_amt)*100.0) AND
				(1=1)
		WHERE        
			(t.fsc_comm_plan_id <> '') AND
			(t.fsc_comm_group_cd <> '') AND 
			(t.source_cd <> 'PAY') AND
--			(g.booking_rt = 0) AND
			(t.FiscalMonth = @nCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

-- FSC threshold model, new tmc 18 Jun 24
	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '10. FSC update comm - threshold with UNDEFINED GM'

		UPDATE
			comm.transaction_F555115
		SET
			[fsc_comm_rt] = r.comm_rt,
			[fsc_comm_amt] = t.[gp_ext_amt]*(r.[comm_rt]/100),
			[fsc_calc_key] = r.calc_key

		-- Select t.*
		FROM
			comm.transaction_F555115 t

			INNER JOIN [dbo].[BRS_CustomerFSC_History] c
			ON t.WSSHAN_shipto = c.ShipTo AND
				t.FiscalMonth = c.FiscalMonth

			INNER JOIN [comm].[group] g
			ON t.fsc_comm_group_cd = g.comm_group_cd
			
			--test
			--LEFT JOIN [comm].[plan_group_rate] AS r 
			--
			INNER JOIN [comm].[plan_group_rate] AS r 
			ON t.fsc_comm_plan_id = r.comm_plan_id AND
				t.fsc_comm_group_cd = r.item_comm_group_cd AND
				c.[HIST_cust_comm_group_cd] = r.cust_comm_group_cd AND
				t.[source_cd] = r.[source_cd] AND

				-- threshold with UNDEFINED GM
				(r.[comm_gm_threshold_ind] = 1) AND
				(t.transaction_amt = 0) AND
				(r.[comm_gm_threshold_cd] = '') AND
				(1=1)
		WHERE        
			(t.fsc_comm_plan_id <> '') AND
			(t.fsc_comm_group_cd <> '') AND 
			(t.source_cd <> 'PAY') AND

			(t.FiscalMonth = @nCurrentFiscalYearmoNum ) AND
			-- test
			-- (t.FiscalMonth = 202405 ) AND
			-- (t.ID = 18239600) AND
			--
			(1 = 1)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '11. FSC update comm - pay'

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
				t.[source_cd] = r.[source_cd] AND
				r.[comm_gm_threshold_cd] = '' AND
				-- payroll will work for both threshold and non
				-- r.[comm_gm_threshold_ind] = 0 
				(1=1)
		WHERE        
			(t.fsc_comm_plan_id <> '') AND
			(t.fsc_comm_group_cd <> '') AND 
			(t.source_cd = 'PAY') AND
			(t.FiscalMonth = @nCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

--

------------------------------------------------------------------------------------------------------
-- New - ESS/CCS
------------------------------------------------------------------------------------------------------

	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '12. ESS/CCS update plan & salesperson_key'

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
			print '13. ESS/CCS update commgroup - JDE'

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
			print '14. ESS/CCS update commgroup - ITMPAR -> ITMFO3 promotion'

		UPDATE
			comm.transaction_F555115
		SET
			ess_comm_group_cd = CASE 
									WHEN t.WSSRP6_manufacturer = @sCommPartpromSupplier 
									THEN @sCommPartpromGroupFocus
									ELSE @sCommPartpromGroup
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
			print '15. ESS/CCS update commgroup - IMP'

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
			print '16. ESS/CCS update comm - non-booking -new'

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
				t.[source_cd] = r.[source_cd] AND
				r.[comm_gm_threshold_cd] = '' AND
				r.[comm_gm_threshold_ind] = 0 
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
			print '17. ESS/CSS update comm - pay'

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
				t.[source_cd] = r.[source_cd] AND
				r.[comm_gm_threshold_cd] = '' AND
				r.[comm_gm_threshold_ind] = 0 
		WHERE        
			(t.ess_comm_plan_id <> '') AND
			(t.ess_comm_group_cd <> '') AND 
			(t.source_cd = 'PAY') AND
			(t.FiscalMonth = @nCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

------------------------------------------------------------------------------------------------------
-- New & Legacy - FTA
------------------------------------------------------------------------------------------------------
	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '18. FTA update update plan & salesperson_key'

		UPDATE
			comm.transaction_F555115
		SET
			-- cps_code is supplied by JDE feed, history lookup not needed
			cps_salesperson_key_id = s.salesperson_key_id, 
			cps_comm_plan_id = s.comm_plan_id
		FROM
			comm.salesperson_master AS s 

			INNER JOIN BRS_FSC_Rollup AS f ON 
			s.salesperson_key_id = f.comm_salesperson_key_id 

			INNER JOIN comm.transaction_F555115 d
			ON (f.TerritoryCd = d.cps_code) AND
			(d.FiscalMonth = @nCurrentFiscalYearmoNum) AND
			(d.source_cd = 'JDE')
		WHERE
			-- do not calc comm for PMTS, only Fast Track Assistent plan
			s.comm_plan_id like 'FTA%'

		Set @nErrorCode = @@Error
	End


	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '19. FTA update item commgroup - JDE'

		UPDATE
			comm.transaction_F555115
		SET
			cps_comm_group_cd = s.HIST_comm_group_cd
		FROM
			[dbo].[BRS_ItemHistory] AS s

			INNER JOIN comm.transaction_F555115 d
			ON (d.WSLITM_item_number = s.Item) AND
			(d.FiscalMonth = s.FiscalMonth) AND
			(d.source_cd = 'JDE') AND
			(d.cps_comm_plan_id <> '') AND
			(s.HIST_comm_group_cd <> '') AND
			(1 = 1)
		WHERE        
			(s.FiscalMonth = @nCurrentFiscalYearmoNum)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '20. FTA update commgroup - ITMPAR -> ITMFO3 promotion'

		UPDATE
			comm.transaction_F555115
		SET
			cps_comm_group_cd = CASE 
									WHEN t.WSSRP6_manufacturer = @sCommPartpromSupplier 
									THEN @sCommPartpromGroupFocus
									ELSE @sCommPartpromGroup
								END
		FROM
			comm.transaction_F555115 t 
		WHERE        
			(t.cps_comm_plan_id <> '') AND
			(t.source_cd = 'JDE') AND
			(t.WS$OSC_order_source_code IN ('A', 'L')) AND		-- Astea  EQ and Service
			(t.cps_code <> '') AND								-- Exclude Tech billing (No ESS code)
			(t.cps_comm_group_cd = 'ITMPAR') AND				-- ONLY effect Parts 
			(t.FiscalMonth = @nCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '21. fta update commgroup - IMP'

		UPDATE
			comm.transaction_F555115
		SET
			cps_comm_group_cd = s.HIST_comm_group_cd
		-- SELECT t.* 
		FROM
			[dbo].[BRS_ItemHistory] s

			INNER JOIN comm.transaction_F555115 d
			ON (d.WSLITM_item_number = s.Item ) AND
			(d.FiscalMonth = s.FiscalMonth)
		WHERE        
			(d.cps_comm_plan_id <> '') AND
			(d.source_cd = 'IMP') AND
			(s.HIST_comm_group_cd <> '') AND
			-- If Source IMP, and the CommCode is supplied, do not override.
			(d.WSLITM_item_number <> '') AND
			(ISNULL(d.cps_comm_group_cd,'') = '') AND
			(d.FiscalMonth = @nCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End


	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '22. FTA update comm - non-booking -new'

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
				t.[source_cd] = r.[source_cd] AND
				r.[comm_gm_threshold_cd] = '' AND
				r.[comm_gm_threshold_ind] = 0 
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
			print '23. FTA update comm - booking - new'

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
				t.cps_comm_group_cd = r.item_comm_group_cd AND
				c.[HIST_cust_comm_group_cd] = r.cust_comm_group_cd AND
				t.[source_cd] = r.[source_cd] AND
				r.[comm_gm_threshold_cd] = '' AND
				r.[comm_gm_threshold_ind] = 0 
		WHERE        
			(t.cps_comm_plan_id <> '') AND
			(t.cps_comm_group_cd <> '') AND 
			(t.source_cd <> 'PAY') AND
			(g.booking_rt <> 0) AND
			(t.FiscalMonth = @nCurrentFiscalYearmoNum) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '24. fta update comm - pay'

		UPDATE
			comm.transaction_F555115
		SET
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
				t.[source_cd] = r.[source_cd] AND
				r.[comm_gm_threshold_cd] = '' AND
				r.[comm_gm_threshold_ind] = 0 
		WHERE        
			(t.cps_comm_plan_id <> '') AND
			(t.cps_comm_group_cd <> '') AND 
			(t.source_cd = 'PAY') AND
			(t.FiscalMonth = @nCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End


------------------------------------------------------------------------------------------------------
-- New & Legacy - EPS
------------------------------------------------------------------------------------------------------

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '25. EPS update item commgroup - JDE'

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
			print '26. EPS update comm - non-booking -new'

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
				t.[source_cd] = r.[source_cd] AND
				r.[comm_gm_threshold_cd] = '' AND
				r.[comm_gm_threshold_ind] = 0 
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
			print '27. EPS update comm - booking - new'

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
				t.[source_cd] = r.[source_cd] AND
				r.[comm_gm_threshold_cd] = '' AND
				r.[comm_gm_threshold_ind] = 0 
		WHERE        
			(t.eps_comm_plan_id <> '') AND
			(t.eps_comm_group_cd <> '') AND 
			(t.source_cd <> 'PAY') AND
			(g.booking_rt <> 0) AND
			(t.FiscalMonth =@nCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

------------------------------------------------------------------------------------------------------
-- New & Legacy - ISR
------------------------------------------------------------------------------------------------------

	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '28. ISR update item commgroup - JDE'

		UPDATE
			comm.transaction_F555115
		SET
			-- reference item version
			isr_comm_group_cd = s.[HIST_comm_group_isr_cd]

--		select s.* 
		FROM
			[dbo].[BRS_ItemHistory] s

			INNER JOIN comm.transaction_F555115 AS d 
			ON (d.WSLITM_item_number = s.Item) AND
			(d.FiscalMonth = s.FiscalMonth) AND
			(d.source_cd = 'JDE') AND
			(d.isr_comm_plan_id <> '') AND
--			(s.HIST_comm_group_cd <> '') AND
			(1 = 1)
		WHERE 
			(s.FiscalMonth = @nCurrentFiscalYearmoNum) AND
			(s.[HIST_comm_group_isr_cd] <> '') AND
--			test
--			(d.id = 9992704) AND
--			(s.FiscalMonth >= 202001) AND
--			(s.HIST_comm_group_cd like 'SPM%') AND
			(1=1)

		Set @nErrorCode = @@Error
	End
--

	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '29. ISR update commgroup - IMP'

		UPDATE
			comm.transaction_F555115
		SET
			isr_comm_group_cd = s.[HIST_comm_group_isr_cd]
		-- SELECT t.* 
		FROM
			[dbo].[BRS_ItemHistory] AS s 

			INNER JOIN comm.transaction_F555115 d
			ON (d.WSLITM_item_number = s.Item) AND
			(d.FiscalMonth = s.FiscalMonth)
		WHERE        
			(d.isr_comm_plan_id <> '') AND
			(d.source_cd = 'IMP') AND
			(s.[HIST_comm_group_isr_cd] <> '') AND
			-- If Source IMP, and the CommCode is supplied, do not override.
			(d.WSLITM_item_number <> '') AND
			(ISNULL(d.isr_comm_group_cd,'') = '') AND
			(d.FiscalMonth = @nCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End
--

----
	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '30. ISR update comm - non-booking -new'

		UPDATE
			comm.transaction_F555115
		SET
			[isr_comm_rt] = r.comm_rt,
			[isr_comm_amt] = t.[gp_ext_amt]*(r.[comm_rt]/100),
			[isr_calc_key] = r.calc_key

--		select g.*, * 
		FROM
			comm.transaction_F555115 t

			INNER JOIN [dbo].[BRS_CustomerFSC_History] c
			ON t.WSSHAN_shipto = c.ShipTo AND
				t.FiscalMonth = c.FiscalMonth

			INNER JOIN [comm].[group] g
			ON t.isr_comm_group_cd = g.comm_group_cd

			INNER JOIN [comm].[plan_group_rate] AS r 
			ON t.isr_comm_plan_id = r.comm_plan_id AND
				t.isr_comm_group_cd = r.item_comm_group_cd AND
				c.[HIST_cust_comm_group_cd] = r.cust_comm_group_cd AND
				t.[source_cd] = r.[source_cd] AND
				r.[comm_gm_threshold_cd] = '' AND
				r.[comm_gm_threshold_ind] = 0 
		WHERE        
			(t.isr_comm_plan_id <> '') AND
			(t.isr_comm_group_cd <> '') AND 
			(t.source_cd <> 'PAY') AND
			--(g.booking_rt = 0) AND
			(r.active_ind = 1) AND
			(t.FiscalMonth = @nCurrentFiscalYearmoNum ) AND

			-- test
			-- (t.id=9992704) AND
			-- (t.FiscalMonth = 201912 ) AND
			-- (t.source_cd = 'IMP') AND
			-- (t.isr_comm_group_cd='REBSND') AND 
			--
			(1 = 1)

		Set @nErrorCode = @@Error
	End
------------------------------------------------------------------------------------------------------
-- ESS history populate
------------------------------------------------------------------------------------------------------

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '31. ESS history populate'


		UPDATE [dbo].[BRS_TransactionDW_Ext]
		SET 
			  [HIST_ess_salesperson_key_id] = s.ess_key
			  ,[HIST_ess_comm_plan_id] = s.ess_plan
			  ,[HIST_ess_code] = s.ess_code
		FROM
			(SELECT
		--	 TOP (10) 
			WSDOCO_salesorder_number, WSDCTO_order_type, MIN(ess_code) ess_code, MIN(ess_salesperson_key_id) ess_key,  MIN(ess_comm_plan_id) ess_plan
			FROM            comm.transaction_F555115
			WHERE        
			(WSDCTO_order_type <> 'AA') AND (ess_code <> '')
			GROUP BY WSDOCO_salesorder_number, WSDCTO_order_type
			) s
	
		WHERE 
			s.WSDOCO_salesorder_number = [BRS_TransactionDW_Ext].SalesOrderNumber AND
			s.ess_code <> [BRS_TransactionDW_Ext].[HIST_ess_code]

		Set @nErrorCode = @@Error
	End

--
------------------------------------------------------------------------------------------------------
-- New & Legacy - EST
------------------------------------------------------------------------------------------------------

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '32. EST update item commgroup - JDE'

		UPDATE
			comm.transaction_F555115
		SET
			est_comm_group_cd = s.HIST_comm_group_est_cd
		FROM
			[dbo].[BRS_ItemHistory] AS s

			INNER JOIN comm.transaction_F555115 d
			ON (d.WSLITM_item_number = s.Item) AND
			(d.FiscalMonth = s.FiscalMonth) AND
			(d.source_cd = 'JDE') AND
			(d.est_comm_plan_id <> '') AND
			(s.HIST_comm_group_est_cd <> '') AND
			(1 = 1)
		WHERE   
			(s.FiscalMonth = @nCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '33. EST update comm - non-booking -new'

		UPDATE
			comm.transaction_F555115
		SET
			[est_comm_rt] = r.comm_rt,
			[est_comm_amt] = t.[gp_ext_amt]*(r.[comm_rt]/100),
			[est_calc_key] = r.calc_key

--		select * 
		FROM
			comm.transaction_F555115 t

			INNER JOIN [dbo].[BRS_CustomerFSC_History] c
			ON t.WSSHAN_shipto = c.ShipTo AND
				t.FiscalMonth = c.FiscalMonth

			INNER JOIN [comm].[group] g
			ON t.est_comm_group_cd = g.comm_group_cd

			INNER JOIN [comm].[plan_group_rate] AS r 
			ON t.est_comm_plan_id = r.comm_plan_id AND
				t.est_comm_group_cd = r.item_comm_group_cd AND
				c.[HIST_cust_comm_group_cd] = r.cust_comm_group_cd AND
				t.[source_cd] = r.[source_cd] AND
				r.[comm_gm_threshold_cd] = '' AND
				r.[comm_gm_threshold_ind] = 0 
		WHERE        
			(t.est_comm_plan_id <> '') AND
			(t.est_comm_group_cd <> '') AND 
			(t.source_cd <> 'PAY') AND
			(g.booking_rt = 0) AND
			(r.active_ind = 1) AND

			-- test
			-- (t.FiscalMonth = 201912 ) AND
			-- (t.source_cd = 'IMP') AND
			-- (t.isr_comm_group_cd='REBSND') AND 
			--
			(t.FiscalMonth = @nCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '34. EST update comm - booking - new'

		UPDATE
			comm.transaction_F555115
		SET
			[est_comm_rt] = g.booking_rt,
			[est_comm_amt] =  t.transaction_amt * (g.booking_rt / 100.0) * (r.comm_rt / 100.0),
			[est_calc_key] = r.calc_key
		FROM
			comm.transaction_F555115 t

			INNER JOIN [dbo].[BRS_CustomerFSC_History] c
			ON t.WSSHAN_shipto = c.ShipTo AND
				t.FiscalMonth = c.FiscalMonth

			INNER JOIN [comm].[group] g
			ON t.est_comm_group_cd = g.comm_group_cd

			INNER JOIN [comm].[plan_group_rate] AS r 
			ON t.est_comm_plan_id = r.comm_plan_id AND
				t.est_comm_group_cd = r.item_comm_group_cd AND
				c.[HIST_cust_comm_group_cd] = r.cust_comm_group_cd AND
				t.[source_cd] = r.[source_cd] AND
				r.[comm_gm_threshold_cd] = '' AND
				r.[comm_gm_threshold_ind] = 0 
		WHERE        
			(t.est_comm_plan_id <> '') AND
			(t.est_comm_group_cd <> '') AND 
			(t.source_cd <> 'PAY') AND
			(g.booking_rt <> 0) AND
			(r.active_ind = 1) AND
			(t.FiscalMonth =@nCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

--

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

-- SELECT FiscalMonth, comm_status_cd FROM BRS_FiscalMonth  where FiscalMonth between 201901 and 202112
-- UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202010

-- Prod
-- Exec comm.transaction_commission_calc_proc @bDebug=0

-- Debug, 2m
-- Exec comm.transaction_commission_calc_proc @bDebug=1

-- testing
-- 1.00m - ORG
-- 1.07m - set JDE codes
-- 1.14m - set IMP codes
-- 1.21m - calc rates


-- test cps / FTA

-- EXEC comm.comm_stage_update_proc @bDebug=1
-- EXEC comm.comm_stage_update_proc @bDebug=0

/*

-- test
SELECT        
FiscalMonth
,WSDOCO_salesorder_number
,WSDCTO_order_type
,WSENTB_entered_by
,fsc_code
,WS$ESS_equipment_specialist_code
,WSCAG__cagess_code
,cps_code
,WSEST__employment_status
,WS$TSS_tech_specialist_code
,transaction_amt
,gp_ext_amt
,cps_calc_key
,cps_salesperson_key_id 
,cps_comm_plan_id
,cps_comm_group_cd
,[cps_comm_rt]
,[cps_comm_amt]

FROM            comm.transaction_F555115
WHERE        (FiscalMonth = 202404) AND (WSDOCO_salesorder_number IN (17120823, 17124797, 17148187, 17128141))
GO

-- patch

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [FiscalMonth]
      ,[WSCO___company]
      ,[WSDOCO_salesorder_number]
      ,[WSDCTO_order_type]
      ,[ID]
      ,[transaction_amt]
      ,[gp_ext_amt]
      ,[cps_salesperson_key_id]
      ,[cps_comm_plan_id]
      ,[cps_comm_group_cd]
      ,[cps_comm_rt]
      ,[cps_comm_amt]
      ,[cps_calc_key]
  FROM [comm].[transaction_F555115]
  where 
   [FiscalMonth] >= 202301 AND
  [cps_calc_key] is not null
  order by 1

/****** Script for SelectTopNRows command from SSMS  ******/

UPDATE       comm.transaction_F555115
SET                cps_salesperson_key_id = '', cps_comm_plan_id = '', cps_comm_group_cd = '', cps_comm_rt = 0, cps_comm_amt = 0, cps_calc_key = NULL
WHERE        (FiscalMonth >= 202301) AND (cps_calc_key IS NOT NULL)


-- test all CPS
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [FiscalMonth]
      ,[WSCO___company]
      ,[WSDOCO_salesorder_number]
      ,[WSDCTO_order_type]
      ,[ID]
      ,[transaction_amt]
      ,[gp_ext_amt]
      ,[cps_salesperson_key_id]
      ,[cps_comm_plan_id]
      ,[cps_comm_group_cd]
      ,[cps_comm_rt]
      ,[cps_comm_amt]
      ,[cps_calc_key]
  FROM [comm].[transaction_F555115]
  where 
   [FiscalMonth] >= 202301 AND
  [cps_calc_key] is not null
  order by 1

  */
