-- Dimension sync - Legacy Prod -> BRS
-- run AFTER ETL stage

-- TODO: NEW load test & FG load, 12 Feb 18
-- 

--> START

print '1. group - ADD'
INSERT INTO comm.[group]
(
	comm_group_cd,
	comm_group_desc,
	source_cd,
	active_ind,
	creation_dt,
	note_txt,
	booking_rt,
	show_ind,
	sort_id
)
SELECT
	comm_group_cd,
	comm_group_desc,
	LEFT(source_cd,3),
	active_ind,
	creation_dt,
	note_txt,
	booking_rt,
	show_ind,
	sort_id
FROM            
	CommBE.dbo.comm_group
WHERE comm_group_cd <>'' AND
	NOT EXISTS (SELECT * FROM comm.[group] WHERE comm_group_cd = CommBE.dbo.comm_group.comm_group_cd)
GO

print '2. group - UPATE'
UPDATE       [comm].[group]
SET                
	comm_status_cd =CASE WHEN [SPM_comm_group_cd] like 'SPM%' AND SPM_EQOptOut = 'Y' THEN 'SPMEQU' ELSE CASE WHEN [SPM_comm_group_cd] like 'SPM%' THEN 'SPMSND' ELSE '' END END,
	comm_group_sm_cd = SPM_comm_group_cd,
	note_txt = c.[note_txt]
FROM            CommBE.dbo.[comm_group] c INNER JOIN
                         [comm].[group] ON c.[comm_group_cd] = [comm].[group].[comm_group_cd]
GO

print '3. rate - ADD'
INSERT INTO comm.plan_group_rate
                         (
	comm_plan_id,
	item_comm_group_cd,
	cust_comm_group_cd,
	comm_rt,
	active_ind,
	creation_dt,
	note_txt,
	show_ind
)
SELECT        comm_plan_id,
	comm_group_cd,
	cust_comm_group_cd,
	comm_base_rt,
	active_ind,
	creation_dt,
	note_txt,
	show_ind
FROM            CommBE.dbo.comm_plan_group_rate r

cross join

(SELECT  distinct [comm_status_cd] as cust_comm_group_cd FROM [dbo].[BRS_Customer]) s3


WHERE NOT EXISTS 
(
	Select * from comm.plan_group_rate 
	where comm_plan_id = r.comm_plan_id and 
		comm_group_cd = r.comm_group_cd
)

GO

-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! fix rate update
print '3b. rate - UPDATE'


UPDATE       comm.plan_group_rate
SET                
comm_rt = s.comm_base_rt, 
active_ind = s.active_ind, 
note_txt = s.note_txt, 
show_ind = s.show_ind

FROM            comm.plan_group_rate INNER JOIN
                         CommBE.dbo.comm_plan_group_rate AS s ON comm.plan_group_rate.comm_plan_id = s.comm_plan_id AND 
                         comm.plan_group_rate.item_comm_group_cd = s.comm_group_cd
WHERE        (comm.plan_group_rate.comm_rt <> s.comm_base_rt) OR
                         (comm.plan_group_rate.active_ind <> s.active_ind) OR
                         (comm.plan_group_rate.note_txt <> s.note_txt) OR
                         (comm.plan_group_rate.show_ind <> s.show_ind)


GO

/*
SELECT
	d.[comm_plan_id]
      ,d.[comm_group_cd]

      ,d.[comm_base_rt] 
      ,d.[active_ind]
      ,d.[note_txt]
      ,d.[show_ind]
  FROM 
  [comm].[plan_group_rate] d 

  INNER JOIN  CommBE.dbo.comm_plan_group_rate s
  ON d.[comm_plan_id] = s.[comm_plan_id] AND
   d.[comm_group_cd] = s.[comm_group_cd]
WHERE

      d.[comm_base_rt] <> s.[comm_base_rt] OR
      d.[active_ind] <> s.[active_ind] OR
      d.[note_txt] <> s.[note_txt] OR
      d.[show_ind] <> s.[show_ind] 

--

	comm_group_cd,

	comm_base_rt,
	active_ind,
	note_txt,
	show_ind

FROM           

INNER JOIN comm_plan_id


WHERE NOT EXISTS 
(
	Select * from comm.plan_group_rate 
	where comm_plan_id = r.comm_plan_id and 
		comm_group_cd = r.comm_group_cd
)
*/
GO


-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! fix rate update


print '4. item - UPDATE'
UPDATE       BRS_Item
SET                [comm_group_cd] = c.comm_group_cd,
					[comm_note_txt] = LEFT(c.note_txt,50)

FROM            CommBE.dbo.comm_item_master AS c INNER JOIN
                         BRS_Item ON c.[item_id] = item
GO

print '5. map customer'

UPDATE       BRS_Customer
SET                
comm_status_cd =CASE WHEN (SPM_StatusCd+SPM_EQOptOut) = 'YY' THEN 'SPMSND' ELSE CASE WHEN SPM_StatusCd = 'Y' THEN 'SPMALL' ELSE '' END END,

comm_note_txt = c.SPM_ReasonTxt
FROM            CommBE.dbo.comm_customer_master c INNER JOIN
                         BRS_Customer ON c.hsi_shipto_id = BRS_Customer.ShipTo
GO

print '6. Branch update'
UPDATE       BRS_Branch
SET                ZoneName = [zone_cd]
FROM            CommBE.dbo.comm_branch c INNER JOIN
                         BRS_Branch ON c.branch_cd = BRS_Branch.Branch
GO

/*
-- TBD -- AFTER 2018 bonus legacy setup, 12 Feb 18
-- 7. pull from dev for prod, dentrix and bonus
UPDATE       BRS_Item
SET             comm_group_cps_cd = s.comm_group_cps_cd,
				custom_comm_group1_cd = s.custom_comm_group1_cd	

FROM            BRS_Item INNER JOIN
                         DEV_BRSales.dbo.BRS_Item s ON BRS_Item.Item = s.Item
*/

print '8. FSC - ADD'
INSERT INTO [dbo].[BRS_FSC_Rollup]
([TerritoryCd], [group_type], Branch)
SELECT 
	GD$TER_territory_code,  [GD$GTY_group_type], ISNULL(b.Branch, '') as branch
FROM 
	Integration.F5553_territory_Staging s
	LEFT JOIN [dbo].[BRS_Branch] b
	ON b.Branch = s.[GD$L02_level_code_02]
WHERE 
	s.GD$TER_territory_code <>'' AND
	NOT EXISTS 
	(
		SELECT * FROM [dbo].[BRS_FSC_Rollup] WHERE [TerritoryCd] = s.GD$TER_territory_code
	)
GO

print '9. set branch for new terr'
UPDATE       BRS_FSC_Rollup
SET                Branch = b.Branch
FROM            Integration.F5553_territory_Staging AS s LEFT OUTER JOIN
                         BRS_Branch AS b ON b.Branch = s.GD$L02_level_code_02 INNER JOIN
                         BRS_FSC_Rollup ON s.GD$TER_territory_code = BRS_FSC_Rollup.TerritoryCd
WHERE        (s.GD$TER_territory_code <> '') AND (b.Branch<> '') AND (BRS_FSC_Rollup.Branch = '')
GO

print '10. update new fsc ownership (for dups)'
UPDATE       BRS_FSC_Rollup
SET                order_taken_by = s.WRTKBY_order_taken_by
FROM            Integration.F55510_customer_territory_Staging s INNER JOIN
                         BRS_FSC_Rollup ON s.WR$TER_territory_code = BRS_FSC_Rollup.TerritoryCd
WHERE
	order_taken_by <> s.WRTKBY_order_taken_by
GO

/*
-- not comfortable with this fix.  ensure bad NOT over good.  tmc, 1 Nov 18
print '11. ID dup terr'
UPDATE       BRS_FSC_Rollup
SET                FSCRollup = s.TerritoryCd
FROM            BRS_FSC_Rollup AS s INNER JOIN
                         BRS_FSC_Rollup ON s.order_taken_by = BRS_FSC_Rollup.order_taken_by AND s.TerritoryCd <> BRS_FSC_Rollup.FSCRollup
WHERE 
	s.order_taken_by NOT IN (' ', 'OPEN') AND
	s.FSCRollup <> '' AND
	s.FSCRollup <> BRS_FSC_Rollup.FSCRollup AND
	1=1
GO
*/

print '12. update names here...'
UPDATE       BRS_FSC_Rollup
SET                FSCName = s.GEDSC1_description 
FROM            Integration.F5554_territory_name_Staging AS s INNER JOIN
                         BRS_FSC_Rollup ON s.GE$L01_level_code_01 = BRS_FSC_Rollup.TerritoryCd AND s.GEDSC1_description <> BRS_FSC_Rollup.FSCName
WHERE        (s.GE$GTY_group_type <> 'DDTS')
GO

print '13. set terr BR'
UPDATE       BRS_FSC_Rollup
SET                Branch = c.branch_cd
FROM            CommBE.dbo.comm_salesperson_code_map AS c INNER JOIN
                         BRS_FSC_Rollup ON c.salesperson_cd = BRS_FSC_Rollup.TerritoryCd AND c.branch_cd <> BRS_FSC_Rollup.Branch AND BRS_FSC_Rollup.Branch = ''
GO

print '14. set FSC name'
UPDATE       BRS_FSC_Rollup
SET                [FSCName] = c.[salesperson_nm]
FROM            CommBE.dbo.comm_salesperson_code_map AS c INNER JOIN
                         BRS_FSC_Rollup ON c.salesperson_cd = BRS_FSC_Rollup.TerritoryCd AND c.[salesperson_nm] <> [FSCName] AND c.[salesperson_nm] <> ''
GO

print '15. set salesperson_key_id'
UPDATE       BRS_FSC_Rollup
SET                comm_salesperson_key_id = c.salesperson_key_id
FROM            CommBE.dbo.comm_salesperson_code_map AS c INNER JOIN
                         BRS_FSC_Rollup ON c.salesperson_cd = BRS_FSC_Rollup.TerritoryCd
WHERE EXISTS (SELECT * FROM comm.salesperson_master WHERE [salesperson_key_id] = c.salesperson_key_id)

GO

print '16. add new salemaster code (should always be 0 adds)'
INSERT INTO [dbo].[BRS_FSC_Rollup] ([TerritoryCd],[Branch])
SELECT        distinct master_salesperson_cd,
''
FROM            CommBE.dbo.comm_salesperson_master 
WHERE employee_num > 0 AND salesperson_key_id <> '' AND master_salesperson_cd <> '' and
	not exists(select * from [dbo].[BRS_FSC_Rollup] where master_salesperson_cd = [TerritoryCd])
GO

print '17b. Add new Salesperson to HR'
INSERT INTO [comm].[hr_employee]
(
	[employee_num]
	,[CostCenter]
	,[last_name]
	,[first_name]
	,[job_title]
	,[location]
	,[status_code]
)
SELECT        
	employee_num
	,''
	,''
	,''
	,''
	,''
	,''

FROM            CommBE.dbo.comm_salesperson_master 
WHERE 
	employee_num > 0 AND 
	salesperson_key_id <> '' AND 
	master_salesperson_cd <> '' AND
	NOT EXISTS
	(
		SELECT * FROM [comm].[hr_employee]
		WHERE [comm].[hr_employee].employee_num = CommBE.dbo.comm_salesperson_master.employee_num
	)
GO


print '17. Add new Salesperson'
INSERT INTO comm.salesperson_master
(
	salesperson_key_id,
	salesperson_nm,
	comm_plan_id,
	creation_dt,
	note_txt,
	master_salesperson_cd,
	flag_ind,
	territory_start_dt,
	employee_num
)
SELECT        
	salesperson_key_id,
	salesperson_nm,
	comm_plan_id,
	creation_dt,
	note_txt,
	master_salesperson_cd,
	select_ind,
	ISNULL(territory_start_dt,
	'1980-01-01'),
	employee_num
FROM            CommBE.dbo.comm_salesperson_master 
WHERE 
	employee_num > 0 AND 
	salesperson_key_id <> '' AND 
	master_salesperson_cd <> '' AND
	NOT EXISTS
	(
		SELECT * FROM comm.salesperson_master 
		WHERE comm.salesperson_master.salesperson_key_id = CommBE.dbo.comm_salesperson_master.salesperson_key_id
	)
GO

print '18. Update Salesperson'
UPDATE comm.salesperson_master
SET
	salesperson_nm = s.salesperson_nm,
	comm_plan_id = s.comm_plan_id,
	creation_dt = s.creation_dt,
	note_txt = s.note_txt,
	master_salesperson_cd = s.master_salesperson_cd,
	flag_ind = s.select_ind,
	territory_start_dt = ISNULL(s.territory_start_dt,'1980-01-01'),
	employee_num = s.employee_num

FROM  
	comm.salesperson_master d
	INNER JOIN CommBE.dbo.comm_salesperson_master s
	ON d.salesperson_key_id = s.salesperson_key_id AND
		s.salesperson_key_id <> ''

WHERE 
	d.salesperson_nm <> s.salesperson_nm OR
	d.comm_plan_id <> s.comm_plan_id OR
	d.creation_dt <> s.creation_dt OR
	d.note_txt <> s.note_txt OR
	d.master_salesperson_cd  <> s.master_salesperson_cd OR
	d.flag_ind <> s.select_ind OR
	d.territory_start_dt <> ISNULL(s.territory_start_dt,'1980-01-01') OR
	d.employee_num <> s.employee_num 

GO


--> STOP


