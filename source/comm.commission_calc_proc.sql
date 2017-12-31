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
	Print 'Check:  Month Loaded and NOT locked'
	Print @sCurrentFiscalYearmoNum
	Print Convert(varchar, @nBatchStatus)
End

If (@nBatchStatus >= 10 and @nBatchStatus < 999)
Begin

	if (@bDebug <> 0)
		Print 'Set:  FSC / ESS code override from BRS_TransactionDW_Ext'

	If (@nErrorCode = 0) 
	Begin

		UPDATE    
			[comm].[transaction_F555115]
		SET              
			[fsc_code]	= 
				CASE 
					WHEN ext.[FSC_code] <> '' 
					THEN ext.[FSC_code] 
					ELSE t.[fsc_code] 
				END,
			[WS$ESS_equipment_specialist_code]	= 
				CASE 
					WHEN ext.[ESS_code] <> '' 
					THEN ext.[ESS_code] 
					ELSE t.[WS$ESS_equipment_specialist_code] 
				END

		FROM         
			[comm].[transaction_F555115] t

			INNER JOIN [dbo].[BRS_TransactionDW_Ext] AS ext 
			ON t.[WSDOCO_salesorder_number] = ext.[SalesOrderNumber]


		WHERE     
			(t.[FiscalMonth] = @sCurrentFiscalYearmoNum) AND 
			(ext.[fsc_code] <> '' OR ext.[ess_code] <> '') AND 
--			(ISNULL(t.[fsc_code], '') <> ext.[fsc_code]) AND
			(1=1)


		Set @nErrorCode = @@Error
	End

	if (@bDebug <> 0)
		Print 'Set:  FSC SalespersonKey and Plan'

	If (@nErrorCode = 0) 
	Begin

		UPDATE    
			[comm].[transaction_F555115]
		SET              
			[fsc_salesperson_key_id]	= s.[comm_salesperson_key_id], 
			[fsc_comm_plan_id]			= sm.[comm_plan_id]
		FROM         
			[comm].[transaction_F555115] t

			INNER JOIN [dbo].[BRS_FSC_Rollup] AS s 
			ON t.[fsc_code] = s.[TerritoryCd] AND
				t.[fsc_code] <> ''

			INNER JOIN [comm].[salesperson_master] AS sm
			ON s.[comm_salesperson_key_id] = sm.[salesperson_key_id]

		WHERE     
			(t.[FiscalMonth] = @sCurrentFiscalYearmoNum) AND 
			(t.source_cd IN ('JDE', 'IMP')) AND
			( 
				(ISNULL(t.[fsc_comm_plan_id], '') <> sm.[comm_plan_id]) OR 
				(ISNULL(t.[fsc_salesperson_key_id], '') <> s.[comm_salesperson_key_id]) 
			)

		Set @nErrorCode = @@Error
	End

	if (@bDebug <> 0)
		Print 'Set:  FSC ItemCommGroup Codes (with special market logic)'

	If (@nErrorCode = 0) 
	Begin

		UPDATE    
			[comm].[transaction_F555115]
		SET              
			fsc_comm_group_cd =	
				CASE 
					WHEN 
						( 
							((c.[comm_status_cd] = 'SMALL') AND (ig.[comm_status_cd] like 'SM%')) OR  
							((c.[comm_status_cd] = 'SMNEQ') AND (ig.[comm_status_cd] = 'SMSND'))
						) 
					THEN 
						-- Use Special Market code
						ig.comm_group_sm_cd 
					ELSE 
						-- Use Regular code
						ig.comm_group_cd 
				END
	
		FROM         

			[comm].[transaction_F555115] t

			INNER JOIN [dbo].[BRS_Customer] AS c 
			ON t.[WSSHAN_shipto] = c.ShipTo AND
				t.[WSSHAN_shipto] > 0

			INNER JOIN [dbo].[BRS_Item] AS i 
			ON t.[WSLITM_item_number] = i.item AND
				t.[WSLITM_item_number] > ''

			INNER JOIN [comm].[group] AS ig 
			ON i.comm_group_cd = ig.comm_group_cd

		WHERE     
			(t.FiscalMonth = @sCurrentFiscalYearmoNum) AND 
			(t.source_cd IN ('JDE', 'IMP')) AND
			(t.fsc_comm_plan_id IS NOT NULL) AND 
			(1=1)

		Set @nErrorCode = @@Error
	End


-- Fix Parts, 4 Feb 15, tmc
	if (@bDebug <> 0)
		Print 'Override:  FSC ItemCommGroup for Parts on EQ Orders'

	If (@nErrorCode = 0) 
	Begin

		Update
			[comm].[transaction_F555115]
		Set 
			-- override Parts on EQ orders.  Pelton is Focus 1 and the rest Focus 3., 04 Feb 15, tmc.
			[fsc_comm_group_cd] =	CASE 
										WHEN t.[WSSRP6_manufacturer] IN ('PELTON' ) 
										Then 'ITMFO1' 
										Else 'ITMFO3' 
									End
		From 
			[comm].[transaction_F555115] s,
			(
			SELECT     
				tt.[ID], 
				tt.[fsc_comm_group_cd], 
				tt.[WSSRP6_manufacturer]

			FROM         
				[comm].[transaction_F555115] tt 
			Where
				(tt.[FiscalMonth] = @sCurrentFiscalYearmoNum) AND 
				(tt.source_cd IN ('JDE')) AND 
				(tt.[fsc_comm_plan_id] IS NOT NULL) AND 

				tt.[WS$OSC_order_source_code] IN ('A','L') And		-- Astea  EQ and Service
				tt.[WS$ESS_equipment_specialist_code] <>'' And		-- Exclude Service (No ESS code)
				tt.[fsc_comm_group_cd] = 'ITMPAR' And				-- ONLY effect Parts 
				1=1
			) t
		Where 
			(s.[FiscalMonth] = @sCurrentFiscalYearmoNum ) AND
			(s.[ID] = t.[ID]) AND
			(1=1)


		Set @nErrorCode = @@Error
	End

	-- Add Booking rate, 24 Feb 16
	if (@bDebug <> 0)
		Print 'Override:  FSC Booking Rate GP'

	If (@nErrorCode = 0) 
	Begin
		UPDATE    
			[comm].[transaction_F555115]
		SET              
			[gp_ext_org_amt] = gp_ext_amt,
			gp_ext_amt = t.transaction_amt * (g.booking_rt / 100.0)
		FROM         
			[comm].[transaction_F555115] as t
			
			INNER JOIN [comm].[group] AS g 
			ON t.[fsc_comm_group_cd] = g.[comm_group_cd]

		WHERE     
			(t.[FiscalMonth] = @sCurrentFiscalYearmoNum) AND 
			(t.source_cd IN ('JDE', 'IMP')) AND 
			(t.[fsc_comm_plan_id] IS NOT NULL) AND 

			(g.[booking_rt] > 0)  AND 
			-- only run once so as not to clobber orginal GP
			(t.[gp_ext_org_amt] IS NULL)
	End

		
	if (@bDebug <> 0)
		Print 'Set:  FSC ItemCommGroup Rates'


	If (@nErrorCode = 0) 
	Begin

		UPDATE    
			[comm].[transaction_F555115]
		SET              
			[fsc_comm_rt] = r.comm_base_rt,
			[fsc_comm_amt] = t.gp_ext_amt * (r.comm_base_rt / 100.0) 

		FROM         
			[comm].[transaction_F555115] t INNER JOIN

			[comm].[plan_group_rate] AS r 
			ON t.[fsc_comm_plan_id] = r.comm_plan_id AND 
				t.[fsc_comm_group_cd] = r.comm_group_cd

		WHERE     
			(t.[FiscalMonth] = @sCurrentFiscalYearmoNum) AND 
			(t.source_cd IN ('JDE', 'IMP')) AND 
			(t.[fsc_comm_plan_id] IS NOT NULL) AND 
			(1 = 1)

		Set @nErrorCode = @@Error
	End


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


/*
-- SM Opt-out full fcode
		SELECT     
			t.fiscal_yearmo_num, 
			t.source_cd,         
			t.salesperson_cd,
			t.salesperson_key_id, 
			t.comm_plan_id,
			t.hsi_shipto_id,

			c.SPM_StatusCd AS CustSMStatus,
			c.SPM_EQOptOut AS CustEQOpt,

			g.SPM_EQOptOut AS GroupSPM_EQOptOut,
			g.comm_group_cd,
			g.SPM_comm_group_cd AS GroupSPM_comm_group_cd,
			t.item_comm_group_cd AS item_comm_group_cd_CURR,

			CASE 
				WHEN 
					( (c.SPM_StatusCd = 'Y') And ( (c.SPM_EQOptOut <> 'Y') OR  ( (c.SPM_EQOptOut = 'Y') AND (g.SPM_EQOptOut<>'Y') ))) 
				THEN 
					-- Use Special Market code
					g.SPM_comm_group_cd 
				ELSE 
					-- Use Regular code
					g.comm_group_cd 
			END AS item_comm_group_cd_NEW

		FROM         
			comm_transaction t

			INNER JOIN comm_plan p
			ON t.comm_plan_id = p.comm_plan_id

			INNER JOIN comm_customer_master c
			ON t.hsi_shipto_id = c.hsi_shipto_id

			INNER JOIN comm_item_master i
			ON t.item_id = i.item_id

				INNER JOIN comm_group g
				ON i.comm_group_cd = g.comm_group_cd

		WHERE     
			(t.fiscal_yearmo_num = '201601') AND 
			(t.source_cd = 'JDE') AND
			(t.comm_plan_id LIKE 'FSC%') AND 

		--	(c.SPM_StatusCd = 'Y' ) AND
		--	(c.SPM_EQOptOut = 'Y' ) AND
		--	(g.SPM_EQOptOut <> 'Y' ) AND

			(1=1)
*/


/*
-- reset
UPDATE       comm.transaction_F555115
SET
fsc_salesperson_key_id = NULL,
fsc_comm_plan_id =NULL,
fsc_comm_group_cd =NULL,
fsc_comm_rt =NULL,
ess_salesperson_key_id =NULL,
fsc_comm_amt =0,
ess_comm_plan_id =NULL,
ess_comm_group_cd =NULL,
ess_comm_rt =NULL,
ess_comm_amt =0,
cps_salesperson_key_id =NULL,
cps_comm_plan_id =NULL,
cps_comm_group_cd =NULL,
cps_comm_rt =NULL,
cps_comm_amt =0
WHERE 
FiscalMonth = 201711
*/

-- Debug (1min)
-- Exec comm.commission_calc_proc

-- Prod
-- Exec comm.commission_calc_proc 0

/*
-- test o/r
-- so 10836230, fsc WZ1G4, ess = ESS76
SELECT        WSDOCO_salesorder_number, FiscalMonth, fsc_code, WS$ESS_equipment_specialist_code
FROM            comm.transaction_F555115
WHERE        (WSDOCO_salesorder_number = '10836230')
*/

/*
SELECT 
TOP 10
t.[fsc_comm_plan_id], t.[fsc_comm_group_cd], [fsc_comm_rt], [fsc_comm_amt] 

FROM         
	[comm].[transaction_F555115] t 
	
	INNER JOIN [comm].[plan_group_rate] AS r 
	ON t.[fsc_comm_plan_id] = r.comm_plan_id AND 
		t.[fsc_comm_group_cd] = r.comm_group_cd

WHERE     
	(t.[FiscalMonth] = 201711) AND 
	(t.source_cd IN ('JDE', 'IMP')) AND 
	(t.[fsc_comm_plan_id] IS NOT NULL) AND 
	(1 = 1)
*/