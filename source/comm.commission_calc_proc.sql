set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE comm.commission_calc_proc 
	@bDebug as smallint = 1
AS

/******************************************************************************
**	File: 
**	Name: comm_transaction_commission_calc_proc
**	Desc: Calculate commission tranaction details
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
**	Date: 19 July 06
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	15 May 07	tmc		Updated logic for new 2007 FSC plan
**  08 May 13   tmc		Add GP$ to calculation
**	04 Feb 15	tmc		Add Parts to EQ correction
--	29 Jan 16	tmc 	Update for 2016 Plan
--	24 Feb 16	tmc		Finalize Automation (SM EQ optout, Booking), remove legacy, and set Debug to default
--	29 Feb 16	tmc		fix small but so that batch 10 is valid
--	22 Dec 17	tmc		port to new backend
--	30 Dec 17	tmc		finalize new backend logic for FSC and ESS
--  24 Dec 19	tmc		update comm with new backend
**    
*******************************************************************************/

Declare @nErrorCode int, @nTranCount int
Declare @sMessage varchar(255)

Set @nErrorCode = @@Error
Set @nTranCount = @@Trancount

Declare @sCurrentFiscalYearmoNum int
Declare @nBatchStatus int

SET NOCOUNT ON;
if (@bDebug <> 0)
	SET NOCOUNT OFF;

if (@bDebug <> 0) 
Begin
	Print '---------------------------------------------------------'
	Print 'Proc: comm_transaction_commission_calc_proc'
	Print 'Desc: Calculate commission tranaction details'
	Print 'Mode: DEBUG'
	Print '---------------------------------------------------------'
End

------------------------------------------------------------------------------------------------------------
-- Init routines.  
------------------------------------------------------------------------------------------------------------

Set @sCurrentFiscalYearmoNum = 0
Set @nBatchStatus = -1

-- Start transaction
if (@nTranCount = 0)
	Begin Tran mytran
Else
	Save Tran mytran

if (@bDebug <> 0)
	Print 'Get Current Fiscal Month'

If (@nErrorCode = 0) 
Begin
	Select 	
		@sCurrentFiscalYearmoNum = [PriorFiscalMonth]
	From 
		[dbo].[BRS_Config]

	Set @nErrorCode = @@Error
End

if (@bDebug <> 0)
	Print 'Get BatchStatus'
	
If (@nErrorCode = 0) 
Begin
	Select 	
		@nBatchStatus = [comm_status_cd]
	From 
		[dbo].[BRS_FiscalMonth]
	Where
		[FiscalMonth] = @sCurrentFiscalYearmoNum
	
	Set @nErrorCode = @@Error
End


------------------------------------------------------------------------------------------------------------
-- Update routines.  
------------------------------------------------------------------------------------------------------------

if (@bDebug <> 0)
Begin
	Print '1. Check:  Month Loaded and NOT locked'
	Print @sCurrentFiscalYearmoNum
	Print Convert(varchar, @nBatchStatus)
End

If (@nBatchStatus >= 10 and @nBatchStatus < 999)
Begin

--> BEGIN NEW

-- Transfer
	if (@bDebug <> 0)
		Print '2. tranfer - directed (1 of 2)'

	If (@nErrorCode = 0) 
	Begin
		UPDATE
			comm.transaction_F555115
		SET
			xfer_key = r.[xfer_key], 

			xfer_fsc_code_org = t.fsc_code, 
			xfer_ess_code_org = t.WS$ESS_equipment_specialist_code,

			fsc_code = CASE WHEN r.[new_fsc_code] = '' THEN t.fsc_code ELSE r.[new_fsc_code] END, 
			[WS$ESS_equipment_specialist_code] = CASE WHEN r.[new_ess_code] = '' THEN t.WS$ESS_equipment_specialist_code ELSE r.[new_ess_code] END
		FROM
			comm.transfer_rule AS r 

			INNER JOIN comm.transaction_F555115 t 
			ON r.FiscalMonth = t.FiscalMonth AND 
				r.SalesOrderNumber = t.WSDOCO_salesorder_number
		WHERE        
			(t.source_cd = 'JDE') AND 
			-- only run once
			(t.xfer_key is null) AND 
			(r.SalesOrderNumber > 0) AND 
			(t.FiscalMonth = @sCurrentFiscalYearmoNum) AND
			(1=1)

		Set @nErrorCode = @@Error
	End

	if (@bDebug <> 0)
		print '3. tranfer - rule-based (2 of 2)'

	If (@nErrorCode = 0) 
	Begin
		UPDATE
			comm.transaction_F555115
		SET
			xfer_key = r.[xfer_key], 

			xfer_fsc_code_org = t.fsc_code, 
			xfer_ess_code_org = t.WS$ESS_equipment_specialist_code,

			fsc_code = CASE WHEN r.[new_fsc_code] = '' THEN t.fsc_code ELSE r.[new_fsc_code] END, 
			[WS$ESS_equipment_specialist_code] = CASE WHEN r.[new_ess_code] = '' THEN t.WS$ESS_equipment_specialist_code ELSE r.[new_ess_code] END
		FROM
			comm.transfer_rule AS r 

			INNER JOIN comm.transaction_F555115 t 
			ON r.FiscalMonth = t.FiscalMonth AND 
				(t.fsc_code like (CASE WHEN r.[fsc_code] = '' THEN '%' ELSE r.[fsc_code] END)) AND
				(t.[WS$ESS_equipment_specialist_code] like (CASE WHEN r.[ess_code] = '' THEN '%' ELSE r.[ess_code] END)) AND
				(1=1)
		WHERE        
			(t.source_cd = 'JDE') AND 
			-- only run once
			(t.xfer_key is null) AND 
			(r.SalesOrderNumber = 0) AND 
			(t.FiscalMonth = @sCurrentFiscalYearmoNum) AND
			(1=1)

		Set @nErrorCode = @@Error
	End

-- FSC
	if (@bDebug <> 0)
		print '4. FSC update plan & terr'

	If (@nErrorCode = 0) 
	Begin
		UPDATE       comm.transaction_F555115
		SET
			fsc_salesperson_key_id = s.salesperson_key_id, 
			fsc_comm_plan_id = s.comm_plan_id
		FROM
					comm.salesperson_master AS s INNER JOIN
								 BRS_FSC_Rollup AS f ON s.salesperson_key_id = f.comm_salesperson_key_id INNER JOIN
								 comm.transaction_F555115 ON f.TerritoryCd = comm.transaction_F555115.[fsc_code]
		WHERE        (comm.transaction_F555115.FiscalMonth = @sCurrentFiscalYearmoNum)

		Set @nErrorCode = @@Error
	End

	if (@bDebug <> 0)
		print '5. FSC update item'

	If (@nErrorCode = 0) 
	Begin
		UPDATE       comm.transaction_F555115
		SET                fsc_comm_group_cd = i.comm_group_cd
		FROM            comm.transaction_F555115 t INNER JOIN
								 BRS_Item AS i ON t.WSLITM_item_number = i.Item
		WHERE        
			(i.comm_group_cd <> '') AND 
			(t.fsc_comm_plan_id <> '') AND
			(t.FiscalMonth = @sCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

	if (@bDebug <> 0)
		print '6. FSC update comm - non-booking -new'

	If (@nErrorCode = 0) 
	Begin
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
			(t.fsc_comm_group_cd <> '') AND 
			(t.fsc_comm_plan_id <> '') AND
			(g.booking_rt = 0) AND
			(t.FiscalMonth = @sCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End


	if (@bDebug <> 0)
		print '7. FSC update comm - booking - new'

	If (@nErrorCode = 0) 
	Begin
		UPDATE       comm.transaction_F555115
		SET
			[fsc_comm_rt] = g.booking_rt,
			[fsc_comm_amt] =  t.transaction_amt * (g.booking_rt / 100.0) * (r.comm_rt / 100.0),
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
			(t.fsc_comm_group_cd <> '') AND 
			(t.fsc_comm_plan_id <> '') AND
			(g.booking_rt <> 0) AND
			(t.FiscalMonth = @sCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

-- ESS
	if (@bDebug <> 0)
		print '8. ESS update plan & terr'

	If (@nErrorCode = 0) 
	Begin
		UPDATE       comm.transaction_F555115
		SET
			ess_salesperson_key_id = s.salesperson_key_id, 
			ess_comm_plan_id = s.comm_plan_id
		FROM            comm.salesperson_master AS s INNER JOIN
								 BRS_FSC_Rollup AS f ON s.salesperson_key_id = f.comm_salesperson_key_id INNER JOIN
								 comm.transaction_F555115 ON f.TerritoryCd = comm.transaction_F555115.WS$ESS_equipment_specialist_code
		WHERE        (comm.transaction_F555115.FiscalMonth = @sCurrentFiscalYearmoNum)

		Set @nErrorCode = @@Error
	End

	if (@bDebug <> 0)
		print '9. ESS update item'

	If (@nErrorCode = 0) 
	Begin
		UPDATE       comm.transaction_F555115
		SET                ess_comm_group_cd = i.comm_group_cd
		FROM            comm.transaction_F555115 t INNER JOIN
								 BRS_Item AS i ON t.WSLITM_item_number = i.Item
		WHERE        
			(i.comm_group_cd <> '') AND 
			(t.ess_comm_plan_id <> '') AND
			(t.FiscalMonth = @sCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

	if (@bDebug <> 0)
		print '10. ESS update comm - non-booking -new'

	If (@nErrorCode = 0) 
	Begin
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
			(t.ess_comm_group_cd <> '') AND 
			(t.ess_comm_plan_id <> '') AND
			(g.booking_rt = 0) AND
			(t.FiscalMonth = @sCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

	if (@bDebug <> 0)
		print '11. ESS update comm - booking - new'

	If (@nErrorCode = 0) 
	Begin
		UPDATE       comm.transaction_F555115
		SET
			[ess_comm_rt] = g.booking_rt,
			[ess_comm_amt] =  t.transaction_amt * (g.booking_rt / 100.0) * (r.comm_rt / 100.0),
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
			(t.ess_comm_group_cd <> '') AND 
			(t.ess_comm_plan_id <> '') AND
			(g.booking_rt <> 0) AND
			(t.FiscalMonth = @sCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

-- CPS
	if (@bDebug <> 0)
		print '12. CPS update plan & terr'

	If (@nErrorCode = 0) 
	Begin
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

			INNER JOIN BRS_FSC_Rollup AS f 
			ON comm.transaction_F555115.fsc_code = f.TerritoryCd 

			INNER JOIN comm.plan_region_map AS m 
			ON m.comm_plan_id = 'CPSGP' AND 
				c.PostalCode LIKE m.postal_code_where_clause_like AND 
				1 = 1 
			INNER JOIN BRS_FSC_Rollup AS sales_key 
			ON sales_key.TerritoryCd = m.TerritoryCd

		WHERE
			(comm.transaction_F555115.WSSHAN_shipto > 0) AND 
			(comm.transaction_F555115.FiscalMonth = @sCurrentFiscalYearmoNum) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End


	if (@bDebug <> 0)
		print '13. update CPS item'

	If (@nErrorCode = 0) 
	Begin
		UPDATE       comm.transaction_F555115
		SET                cps_comm_group_cd = i.comm_group_cps_cd
		FROM            comm.transaction_F555115 t INNER JOIN
								 BRS_Item AS i ON t.WSLITM_item_number = i.Item
		WHERE        
			(i.comm_group_cps_cd <> '') AND 
			(t.cps_comm_plan_id <> '') AND
			(t.FiscalMonth = @sCurrentFiscalYearmoNum) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

	if (@bDebug <> 0)
		print '14. CPS update comm - non-booking -new'

	If (@nErrorCode = 0) 
	Begin
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
			(t.cps_comm_group_cd <> '') AND 
			(t.cps_comm_plan_id <> '') AND
			(g.booking_rt = 0) AND
			(t.FiscalMonth = @sCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

	if (@bDebug <> 0)
		print '15. CPS update comm - booking - new'

	If (@nErrorCode = 0) 
	Begin
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
			(t.cps_comm_group_cd <> '') AND 
			(t.cps_comm_plan_id <> '') AND
			(g.booking_rt <> 0) AND
			(t.FiscalMonth = @sCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

-- EPS
	if (@bDebug <> 0)
		print '16. EPS update plan & terr'

	If (@nErrorCode = 0) 
	Begin
		UPDATE
			comm.transaction_F555115
		SET
			eps_salesperson_key_id = sales_key.comm_salesperson_key_id , 
			eps_comm_plan_id = m.comm_plan_id , 
			eps_code = m.TerritoryCd
		FROM
			comm.transaction_F555115 

			INNER JOIN BRS_Customer AS c 
			ON comm.transaction_F555115.WSSHAN_shipto = c.ShipTo 

			INNER JOIN BRS_FSC_Rollup AS f 
			ON comm.transaction_F555115.fsc_code = f.TerritoryCd 
			INNER JOIN comm.plan_region_map AS m 
			ON m.comm_plan_id = 'EPSGP' AND 
				f.[Branch] = m.[branch_code_where_clause_like] AND 
				1 = 1 
			INNER JOIN BRS_FSC_Rollup AS sales_key 
			ON sales_key.TerritoryCd = m.TerritoryCd

		WHERE
			(comm.transaction_F555115.WSSHAN_shipto > 0) AND 
			(comm.transaction_F555115.FiscalMonth = @sCurrentFiscalYearmoNum) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

	if (@bDebug <> 0)
		print '17. update EPS item'

	If (@nErrorCode = 0) 
	Begin
		UPDATE       comm.transaction_F555115
		SET                eps_comm_group_cd = i.comm_group_eps_cd
		FROM            comm.transaction_F555115 t INNER JOIN
								 BRS_Item AS i ON t.WSLITM_item_number = i.Item
		WHERE        
			(i.comm_group_eps_cd <> '') AND 
			(t.eps_comm_plan_id <> '') AND
			(t.FiscalMonth = @sCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

	if (@bDebug <> 0)
		print '18. EPS update comm - non-booking -new'

	If (@nErrorCode = 0) 
	Begin
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
			(t.eps_comm_group_cd <> '') AND 
			(t.eps_comm_plan_id <> '') AND
			(g.booking_rt = 0) AND
			(t.FiscalMonth = @sCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

	if (@bDebug <> 0)
		print '19. EPS update comm - booking - new'

	If (@nErrorCode = 0) 
	Begin
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
			(t.eps_comm_group_cd <> '') AND 
			(t.eps_comm_plan_id <> '') AND
			(g.booking_rt <> 0) AND
			(t.FiscalMonth = @sCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

--< END NEW

------------------------------------------------------------------------------------------------------------
-- Wrap-up routines.  
------------------------------------------------------------------------------------------------------------


	if (@bDebug <> 0)
		Print 'Set BatchStatus to Processed'	
	
	If (@nErrorCode = 0) 
	Begin
		Update
			[dbo].[BRS_FiscalMonth]
		Set 
			[comm_status_cd] = 20
		Where 
			[FiscalMonth] = @sCurrentFiscalYearmoNum
	
		Set @nErrorCode = @@Error
	End

End



if (@bDebug <> 0)
	Set @nErrorCode = 512

-- Call error message on Error
if (@nErrorCode <> 0)
Begin
	Set @sMessage = 'comm_transaction_commission_calc_proc'
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

GO


-- Debug
-- EXEC	[comm].[commission_calc_proc] @bDebug = 1
--  7m306s @ dev

-- EXEC	[comm].[commission_calc_proc] @bDebug = 0
-- 
