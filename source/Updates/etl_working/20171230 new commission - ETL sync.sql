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
where ZoneName <> [zone_cd]
GO

-- does FSC terr work?  6 Feb 20
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


