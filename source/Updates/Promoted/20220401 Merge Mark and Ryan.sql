
-- Merge Mark and Ryan, 1 Apr 22


-- FSC
update BRS_FSC_Rollup
set 
FSCRollup = 'WZ1RL', comm_salesperson_key_id = 'RYAN.LUCAS'
WHERE        (comm_salesperson_key_id IN ('Mvanderh' ) )

SELECT        TOP (10) TerritoryCd, FSCName, Branch, FSCRollup, comm_salesperson_key_id, group_type
FROM            BRS_FSC_Rollup
WHERE        (comm_salesperson_key_id IN ('Mvanderh', 'RYAN.LUCAS')) 


-- History
update BRS_CustomerFSC_History
set  HIST_fsc_salesperson_key_id = 'RYAN.LUCAS'
WHERE        
(FiscalMonth >= 202101) and
(HIST_fsc_salesperson_key_id IN ('Mvanderh', 'RYAN.LUCAS')) 

-- FG

update [comm].[freegoods]
set fsc_salesperson_key_id ='RYAN.LUCAS'
WHERE
(FiscalMonth >= 202101) and
(fsc_salesperson_key_id IN ('Mvanderh')) 

select top 10 * from [comm].[freegoods]
WHERE        (fsc_salesperson_key_id IN ('Mvanderh', 'RYAN.LUCAS')) 

--Trans

update [comm].[transaction_F555115]
set fsc_salesperson_key_id = 'RYAN.LUCAS'
WHERE        
(FiscalMonth >= 202101) and
(fsc_salesperson_key_id IN ('Mvanderh')) 

select top 10 * from [comm].[transaction_F555115]
WHERE        
(FiscalMonth >= 202101) and
(fsc_salesperson_key_id IN ('Mvanderh', 'RYAN.LUCAS')) 

Exec comm.transaction_commission_calc_proc @bDebug=0
--5m
