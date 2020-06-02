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

if (@bDebug <> 0)
Begin
	Print 'Confirm BatchStatus NOT locked'
	Print @nCurrentFiscalYearmoNum
	Print Convert(varchar, @nBatchStatus)
End


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
-- New - Transfer
------------------------------------------------------------------------------------------------------
	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '1. tranfer - directed (1 of 2)'

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
			print '2. tranfer - rule-based (2 of 2)'

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

------------------------------------------------------------------------------------------------------
-- Legacy - FSC
------------------------------------------------------------------------------------------------------
	If (@nErrorCode = 0 AND @bLegacy = 1) 
	Begin
		if (@bDebug <> 0)
			print '3x. FSC legacy - set calc_key'

		UPDATE
			comm.transaction_F555115
		SET
			[fsc_calc_key] = r.calc_key
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
			(t.fsc_code <> '') AND
			(t.fsc_comm_group_cd <> '') AND 
			(t.FiscalMonth = @nCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

------------------------------------------------------------------------------------------------------
-- Legacy - ESS/CCS
------------------------------------------------------------------------------------------------------
	If (@nErrorCode = 0 AND @bLegacy = 1) 
	Begin
		if (@bDebug <> 0)
			print '9x. Ess/CCS legacy - set calc_key'

		UPDATE
			comm.transaction_F555115
		SET
			[ess_calc_key] = r.calc_key

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
			(t.ess_comm_group_cd <> '') AND 
			(t.FiscalMonth = @nCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

------------------------------------------------------------------------------------------------------
-- New - FSC
------------------------------------------------------------------------------------------------------
	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '3. FSC update plan & terr'

		UPDATE
			comm.transaction_F555115
		SET
			fsc_salesperson_key_id = s.salesperson_key_id, 
			fsc_comm_plan_id = s.comm_plan_id
		FROM
			comm.salesperson_master AS s 

			INNER JOIN BRS_FSC_Rollup AS f 
			ON s.salesperson_key_id = f.comm_salesperson_key_id 
	
			INNER JOIN comm.transaction_F555115 ON 
			f.TerritoryCd = comm.transaction_F555115.[fsc_code]

		WHERE
			(comm.transaction_F555115.FiscalMonth = @nCurrentFiscalYearmoNum)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '4. FSC update item commgroup - JDE'

		UPDATE
			comm.transaction_F555115
		SET
			fsc_comm_group_cd = i.HIST_comm_group_cd
		FROM
			comm.transaction_F555115 t

			INNER JOIN [dbo].[BRS_ItemHistory] AS i 
			ON i.Item = t.WSLITM_item_number AND
			i.FiscalMonth = t.FiscalMonth
		WHERE        
			(t.fsc_comm_plan_id <> '') AND
			(t.source_cd = 'JDE') AND
			(i.HIST_comm_group_cd <> '') AND
			(t.FiscalMonth = @nCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '5. FSC update commgroup - ITMPAR -> ITMFO3 promotion'
		
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
			print '6. FSC update commgroup - IMP'

		UPDATE
			comm.transaction_F555115
		SET
			fsc_comm_group_cd = i.HIST_comm_group_cd
		-- SELECT t.* 
		FROM
			comm.transaction_F555115 t

			INNER JOIN [dbo].[BRS_ItemHistory] AS i 
			ON i.Item = t.WSLITM_item_number AND
			i.FiscalMonth = t.FiscalMonth
		WHERE        
			(t.fsc_comm_plan_id <> '') AND
			(t.source_cd = 'IMP') AND
			(i.HIST_comm_group_cd <> '') AND
			-- If Source IMP, and the CommCode is supplied, do not override.
			(t.WSLITM_item_number <> '') AND
			(ISNULL(t.fsc_comm_group_cd,'') = '') AND
			(t.FiscalMonth = @nCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '7. FSC update comm - non-booking -new'

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
			print '8. FSC update comm - pay'

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
			print '9. ESS/CCS update plan & terr'

		UPDATE
			comm.transaction_F555115
		SET
			ess_salesperson_key_id = s.salesperson_key_id, 
			ess_comm_plan_id = s.comm_plan_id
		FROM
			comm.salesperson_master AS s 

			INNER JOIN BRS_FSC_Rollup AS f ON 
			s.salesperson_key_id = f.comm_salesperson_key_id 

			INNER JOIN comm.transaction_F555115 
			ON f.TerritoryCd = comm.transaction_F555115.ess_code
		WHERE
			(comm.transaction_F555115.FiscalMonth = @nCurrentFiscalYearmoNum) AND
			(1=1)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '10. ESS/CCS update commgroup - JDE'

		UPDATE
			comm.transaction_F555115
		SET
			ess_comm_group_cd = i.HIST_comm_group_cd
		FROM
			comm.transaction_F555115 t 

			INNER JOIN [dbo].[BRS_ItemHistory] AS i 
			ON i.Item = t.WSLITM_item_number AND
			i.FiscalMonth = t.FiscalMonth
		WHERE        
			(t.ess_comm_plan_id <> '') AND
			(t.source_cd = 'JDE') AND
			(i.HIST_comm_group_cd <> '') AND 

			(t.FiscalMonth = @nCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '11. ESS/CCS update commgroup - ITMPAR -> ITMFO3 promotion'

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
			print '12. ESS/CCS update commgroup - IMP'

		UPDATE
			comm.transaction_F555115
		SET
			ess_comm_group_cd = i.HIST_comm_group_cd
		-- SELECT t.* 
		FROM
			comm.transaction_F555115 t

			INNER JOIN [dbo].[BRS_ItemHistory] AS i 
			ON i.Item = t.WSLITM_item_number AND
			i.FiscalMonth = t.FiscalMonth
		WHERE        
			(t.ess_comm_plan_id <> '') AND
			(t.source_cd = 'IMP') AND
			(i.HIST_comm_group_cd <> '') AND
			-- If Source IMP, and the CommCode is supplied, do not override.
			(t.WSLITM_item_number <> '') AND
			(ISNULL(t.ess_comm_group_cd,'') = '') AND
			(t.FiscalMonth = @nCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0 AND @bLegacy = 0) 
	Begin
		if (@bDebug <> 0)
			print '13. ESS/CCS update comm - non-booking -new'

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
			print '14. ESS/CSS update comm - pay'

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
			print '15. CPS update plan & terr'

		UPDATE
			comm.transaction_F555115
		SET
			cps_salesperson_key_id = sales_key.comm_salesperson_key_id , 
			cps_comm_plan_id = m.comm_plan_id , 
			cps_code = m.TerritoryCd
		FROM
			comm.transaction_F555115 

			INNER JOIN BRS_Customer AS c 
			ON comm.transaction_F555115.WSSHAN_shipto = c.ShipTo 

			INNER JOIN comm.plan_region_map AS m 
			ON m.comm_plan_id = 'CPSGP' AND 
				c.PostalCode LIKE m.postal_code_where_clause_like AND 
				1 = 1 

			INNER JOIN BRS_FSC_Rollup AS sales_key 
			ON sales_key.TerritoryCd = m.TerritoryCd

		WHERE
			-- must be valid customer, as postal code driven based on Current address
			(comm.transaction_F555115.WSSHAN_shipto > 0) AND 
			(comm.transaction_F555115.FiscalMonth = @nCurrentFiscalYearmoNum) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '16. update CPS item'

		UPDATE       comm.transaction_F555115
		SET                cps_comm_group_cd = i.HIST_comm_group_cps_cd
		FROM
			comm.transaction_F555115 t 

			INNER JOIN [dbo].[BRS_ItemHistory] AS i 
			ON i.Item = t.WSLITM_item_number AND
			i.FiscalMonth = t.FiscalMonth

		WHERE        
			(t.cps_code <> '') AND
			(i.HIST_comm_group_cps_cd <> '') AND 
			(t.FiscalMonth = @nCurrentFiscalYearmoNum) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '17. CPS update comm - non-booking -new'

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
			(t.cps_code <> '') AND
			(t.cps_comm_group_cd <> '') AND 
			(g.booking_rt = 0) AND
			(t.FiscalMonth = @nCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '18. CPS update comm - booking - new'

		UPDATE       comm.transaction_F555115
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
			(t.cps_code <> '') AND
			(t.cps_comm_group_cd <> '') AND 
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
			print '19. EPS update plan & terr'

		UPDATE
			comm.transaction_F555115
		SET
			eps_salesperson_key_id = sales_key.comm_salesperson_key_id , 
			eps_comm_plan_id = m.comm_plan_id , 
			eps_code = m.[master_salesperson_cd]
		FROM
			comm.transaction_F555115 

			INNER JOIN [eps].[Customer] AS c 
			ON comm.transaction_F555115.WSSHAN_shipto = c.[Customer_Number]

			INNER JOIN BRS_FSC_Rollup AS sales_key 
			ON sales_key.TerritoryCd = c.Eps_Code

			INNER JOIN [comm].[salesperson_master] m
			ON m.[salesperson_key_id] = sales_key.comm_salesperson_key_id

		WHERE
			(comm.transaction_F555115.WSSHAN_shipto > 0) AND 
			(comm.transaction_F555115.FiscalMonth = @nCurrentFiscalYearmoNum) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '20. update EPS item'

		UPDATE       comm.transaction_F555115
		SET                eps_comm_group_cd = i.HIST_comm_group_eps_cd
		FROM
			comm.transaction_F555115 t

			INNER JOIN [dbo].[BRS_ItemHistory] AS i 
			ON i.Item = t.WSLITM_item_number AND
			i.FiscalMonth = t.FiscalMonth

		WHERE   
			(t.eps_code <> '') AND
			(i.HIST_comm_group_eps_cd <> ISNULL(t.eps_comm_group_cd, '')) AND
			(t.FiscalMonth = @nCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '21. EPS update comm - cleanup calc'

		UPDATE
			comm.transaction_F555115
		SET
			[eps_calc_key] = null 
		FROM
			comm.transaction_F555115 t
		WHERE        
			[eps_calc_key] is not null AND
			(t.FiscalMonth = @nCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '22. EPS update comm - non-booking -new'

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
			(t.eps_code <> '') AND
			(t.eps_comm_group_cd <> '') AND 
			(g.booking_rt = 0) AND
			(t.FiscalMonth = @nCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '23. EPS update comm - booking - new'

		UPDATE       comm.transaction_F555115
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
			(t.eps_code <> '') AND
			(t.eps_comm_group_cd <> '') AND 
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

