-- Dimension sync - Legacy Prod -> BRS
-- run AFTER ETL stage

-- TODO: NEW load test & FG load, 12 Feb 18
-- 
/*
0. update DEV Dim & Fact - Done
1. synch Prod Dim to Dev - Done
2. Scrub prod fact - Done
3. load Prod fact to Dev -Done
4. calc Dev fact Legacy - Done
*/

------------------------------------------------------------------------------------------------------
-- sync Prod to NEW
------------------------------------------------------------------------------------------------------

print '1. comm.group - Update'
UPDATE
	comm.[group]
SET
	comm_group_desc = s.comm_group_desc, 
	source_cd = LEFT(s.source_cd,3), 
	active_ind = s.active_ind, 
	note_txt = ISNULL(s.note_txt,''), 
	booking_rt = s.booking_rt, 
	show_ind = s.show_ind, 
	sort_id = s.sort_id	
--SELECT d.*
FROM
	CommBE.dbo.comm_group AS s 
	INNER JOIN comm.[group] d ON s.comm_group_cd = d.comm_group_cd
WHERE
	(s.comm_group_cd <> '') AND
	(
		s.comm_group_desc <> d.comm_group_desc OR
		LEFT(s.source_cd,3) <> d.source_cd OR
		s.active_ind <> d.active_ind OR
		ISNULL(s.note_txt,'') <> ISNULL(d.note_txt,'') OR
		s.booking_rt <> d.booking_rt OR
		s.show_ind <> d.show_ind OR
		s.sort_id <> d.sort_id
	)
GO

print '2. comm.group - Add'
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
	ISNULL(note_txt,''),
	booking_rt,
	show_ind,
	sort_id
FROM            
	CommBE.dbo.comm_group s
WHERE comm_group_cd <>'' AND
	NOT EXISTS (SELECT * FROM comm.[group] WHERE comm_group_cd = s.comm_group_cd)
GO

-- add handled by Dimension synch
print '3. BRS_Item - Update'
UPDATE
	BRS_Item
SET
	[comm_group_cd] = s.comm_group_cd,
	[comm_note_txt] = LEFT(s.note_txt,50)
FROM
	CommBE.dbo.comm_item_master AS s 
	INNER JOIN BRS_Item d
	ON s.[item_id] = d.item
WHERE
	d.[comm_group_cd] <> s.comm_group_cd OR
	d.[comm_note_txt] <> LEFT(s.note_txt,50)
GO

-- add handled by Dimension synch
print '4. BRS_Customer - Update'
UPDATE
	BRS_Customer
SET                
	comm_status_cd = CASE 
						WHEN (s.SPM_StatusCd+s.SPM_EQOptOut) = 'YY' 
						THEN 'SPMSND' 
						ELSE 
							CASE 
								WHEN SPM_StatusCd = 'Y' 
								THEN 'SPMALL' 
								ELSE '' 
							END 
						END,
	comm_note_txt = ISNULL(s.SPM_ReasonTxt,'')
--SELECT s.*
FROM
	CommBE.dbo.comm_customer_master s 
	INNER JOIN BRS_Customer d
	ON s.hsi_shipto_id = d.ShipTo AND
	(
	d.comm_status_cd <> CASE 
						WHEN (s.SPM_StatusCd+s.SPM_EQOptOut) = 'YY' 
						THEN 'SPMSND' 
						ELSE 
							CASE 
								WHEN SPM_StatusCd = 'Y' 
								THEN 'SPMALL' 
								ELSE '' 
							END 
						END OR
	ISNULL(d.comm_note_txt,'') <> ISNULL(s.SPM_ReasonTxt,'')
	)
GO

print '5. BRS_Branch - Update'
UPDATE
	BRS_Branch
SET
	ZoneName = [zone_cd]
FROM
	CommBE.dbo.comm_branch s 
	INNER JOIN BRS_Branch d 
	ON s.branch_cd = d.Branch
where ZoneName <> [zone_cd]
GO

/*
-- does FSC terr work?  6 Feb 20
print '5. FSC - ADD'
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
*/

-- add handled by Dimension synch
print '6. BRS_FSC_Rollup - Update'
UPDATE
	BRS_FSC_Rollup
SET
	comm_salesperson_key_id = s.salesperson_key_id
FROM
	CommBE.dbo.comm_salesperson_code_map AS s 
	INNER JOIN BRS_FSC_Rollup d 
	ON s.salesperson_cd = d.TerritoryCd AND 
		s.salesperson_key_id <> 'INTERNAL' AND
		s.salesperson_key_id <> ISNULL(d.comm_salesperson_key_id,'') AND
		-- do not overwrite with blanks.  Fixes CPS codes
		-- bad data should be overridden with dummy code, not blank
		s.salesperson_key_id <> '' AND
		(1=1)

-- Update not needed
print '7. hr_employee - Add (stub)'
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
FROM
	CommBE.dbo.comm_salesperson_master s
WHERE 
	employee_num > 0 AND 
	salesperson_key_id <> '' AND 
	master_salesperson_cd <> '' AND
	NOT EXISTS
	(
		SELECT * FROM [comm].[hr_employee]
		WHERE [comm].[hr_employee].employee_num = s.employee_num
	)
GO

print '8. comm.plan - Add'
INSERT INTO [comm].[plan]
(
[comm_plan_id]
,[comm_plan_nm]
)
SELECT 
	comm_plan_id
	,[comm_plan_nm]
FROM 
	CommBE.[dbo].[comm_plan] s
WHERE NOT EXISTS (
	SELECT * FROM [comm].[plan] d 
	WHERE s.comm_plan_id = d.[comm_plan_id]
)


print '9. salesperson_master - Update'
UPDATE comm.salesperson_master
SET
	salesperson_nm = s.salesperson_nm,
	comm_plan_id = s.comm_plan_id,
	creation_dt = s.creation_dt,
	note_txt = s.note_txt,
	master_salesperson_cd = s.master_salesperson_cd,
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
	d.territory_start_dt <> ISNULL(s.territory_start_dt,'1980-01-01') OR
	d.employee_num <> s.employee_num 
GO


print '10. salesperson_master - Add'
INSERT INTO comm.salesperson_master
(
	salesperson_key_id,
	salesperson_nm,
	comm_plan_id,
	creation_dt,
	note_txt,
	master_salesperson_cd,
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
	ISNULL(territory_start_dt, '1980-01-01'),
	employee_num
FROM
	CommBE.dbo.comm_salesperson_master s
WHERE 
	employee_num > 0 AND 
	salesperson_key_id <> '' AND 
	master_salesperson_cd <> '' AND
	NOT EXISTS
	(
		SELECT * FROM comm.salesperson_master 
		WHERE comm.salesperson_master.salesperson_key_id = s.salesperson_key_id
	)
GO

-- TBD display set, then rate update
print '11. plan_group_rate - Add'
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
GO

-- use this to fix FSC territory Prod vs NEW until go live
print '12. Allign FSC Territory with Commission - HISTORY'
UPDATE
	BRS_CustomerFSC_History
SET
	HIST_TerritoryCd = s.salesperson_cd_MIN,
	HIST_fsc_salesperson_key_id = salesperson_key_id_MIN,
	HIST_fsc_comm_plan_id = comm_plan_id_MIN
-- SELECT *  
FROM
	BRS_CustomerFSC_History d
	INNER JOIN 
	(
		SELECT
			CAST(fiscal_yearmo_num AS int) AS FiscalMonth
			,hsi_shipto_id
			,MIN(salesperson_cd) AS salesperson_cd_MIN
			,MIN(salesperson_key_id) AS salesperson_key_id_MIN
			,MIN(comm_plan_id) AS comm_plan_id_MIN
		FROM
			CommBE.dbo.comm_transaction
		WHERE
			(source_cd = 'JDE') AND 
			(fiscal_yearmo_num >= '201901') AND 
			(salesperson_cd<>'') AND
			(salesperson_key_id<>'Internal') AND
			(1 = 1)
		GROUP BY 
			fiscal_yearmo_num, 
			hsi_shipto_id
		HAVING
			-- ensure no ambiguous results
			MIN(salesperson_cd) = MAX(salesperson_cd) AND
		--	MIN(salesperson_key_id) <> MAX(salesperson_key_id) AND
		--	MIN(comm_plan_id) <> MAX(comm_plan_id) AND
			(1=1)
	) AS s 
	ON d.FiscalMonth = s.FiscalMonth AND 
		d.Shipto = s.hsi_shipto_id AND 
		-- comment below to force all updates
		d.HIST_TerritoryCd <> s.salesperson_cd_MIN AND 
		(1 = 1)
GO

print '13. EPS update plan & terr - HISTORY'
UPDATE
	BRS_CustomerFSC_History
SET
	HIST_eps_code = [master_salesperson_cd],
	HIST_eps_salesperson_key_id = comm_salesperson_key_id, 
	HIST_eps_comm_plan_id = comm_plan_id
FROM
	BRS_CustomerFSC_History d
	INNER JOIN 
	(
		SELECT 
			-- top 10 
			Customer_Number, master_salesperson_cd, comm_salesperson_key_id, comm_plan_id
		FROM  
			[eps].[Customer] AS c 

			INNER JOIN BRS_FSC_Rollup AS sales_key 
			ON sales_key.TerritoryCd = c.Eps_Code

			INNER JOIN [comm].[salesperson_master] m
			ON m.[salesperson_key_id] = sales_key.comm_salesperson_key_id
		WHERE
			(Customer_Number > 0)
	) AS s
	ON d.Shipto = s.Customer_Number AND 
		d.FiscalMonth >= 201901 AND
		-- comment below to force all updates
		HIST_eps_code <> [master_salesperson_cd] AND
		(1 = 1)

print '14. CPS update plan & terr'
UPDATE
	BRS_CustomerFSC_History
SET
	HIST_cps_code = master_salesperson_cd
	,HIST_cps_salesperson_key_id = comm_salesperson_key_id
	,HIST_cps_comm_plan_id = comm_plan_id
FROM
	BRS_CustomerFSC_History d
	INNER JOIN 
	(
		SELECT 
			 -- top 10 
			shipto, master_salesperson_cd, comm_salesperson_key_id, m.comm_plan_id
		FROM  
			BRS_Customer AS c

			INNER JOIN comm.plan_region_map AS map
			ON map.comm_plan_id = 'CPSGP' AND 
				c.PostalCode LIKE map.postal_code_where_clause_like AND 
				1 = 1 

			INNER JOIN BRS_FSC_Rollup AS sales_key 
			ON sales_key.TerritoryCd = map.TerritoryCd

			INNER JOIN [comm].[salesperson_master] m
			ON m.[salesperson_key_id] = sales_key.comm_salesperson_key_id
		WHERE
			-- must be valid customer, as postal code driven based on Current address
			(shipto > 0) AND 
			(Postalcode <>'') AND
			(1 = 1)
	) AS s
	ON d.Shipto = s.ShipTo AND 
		d.FiscalMonth >= 201901 AND
		-- comment below to force all updates
		-- HIST_cps_code <> master_salesperson_cd AND
		(1 = 1)

print '15. Allign Item Commission FSC / ESS - HISTORY'
UPDATE
	[BRS_ItemHistory]
SET
	[HIST_comm_group_cd] = item_comm_group_cd
-- SELECT *  
FROM
	[BRS_ItemHistory] d
	INNER JOIN 
	(
		SELECT
			-- top 10
			CAST(fiscal_yearmo_num AS int) AS FiscalMonth
			,item_id
			-- merge fsc and ess item codes
			,COALESCE(
				NULLIF(MAX(item_comm_group_cd),''), 
				NULLIF(MAX(ess_comm_group_cd),'')
			) AS item_comm_group_cd
		FROM
			CommBE.dbo.comm_transaction
		WHERE
			(source_cd = 'JDE') AND 
			(fiscal_yearmo_num >= '201901') AND 
			(item_id<>'') AND
			(salesperson_key_id='Internal') AND
			(1 = 1)
		GROUP BY 
			fiscal_yearmo_num, 
			item_id
	) AS s 
	ON d.FiscalMonth = s.FiscalMonth AND 
		d.Item = s.item_id AND 
		s.item_comm_group_cd <>'' AND
		-- comment below to force all updates
		d.[HIST_comm_group_cd] <> s.item_comm_group_cd AND 
		(1 = 1)
GO

print '16. Allign Item Commission CSP / EPS - HISTORY'
UPDATE
	BRS_ItemHistory
SET
	HIST_comm_group_cps_cd = s.comm_group_cps_cd, 
	HIST_comm_group_eps_cd = s.comm_group_eps_cd
FROM
	BRS_Item s

	INNER JOIN BRS_ItemHistory d ON 
	s.Item = d.Item AND
	d.FiscalMonth >=201901
GO

/*
-- TBD. check HIST comm for cust / item set (s/b setup in Friday archive with Monday correction)
a) synchronize eps_item to BRS_Item!eps_item
b) synch BRS_Item to item history, current month, DONE
c) sycch BRS_Cust to cust history, current month, DONE

*/
