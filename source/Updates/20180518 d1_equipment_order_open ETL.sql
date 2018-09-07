-- D1 Equipment order open ETL
-- 18 May 18, tmc

--- ETL

-- Upload order_open_prorepr

-- order
INSERT INTO [nes].[order]
([work_order_num], [note])
SELECT 
DISTINCT [work_order_num], ''
FROM [Integration].[open_order_prorepr] s
WHERE NOT EXISTS(
  SELECT * FROM [nes].[order] o where o.work_order_num = s.work_order_num
)
GO

-- user
INSERT INTO [nes].[user_login]
SELECT 
DISTINCT [d1_user_id], '', '', ''
FROM [Integration].[open_order_prorepr] s
WHERE NOT EXISTS(
  SELECT * FROM [nes].user_login u where u.user_id = s.d1_user_id
)
GO

-- EST
INSERT INTO [dbo].[BRS_FSC_Rollup]
([TerritoryCd], [Branch])
SELECT 
DISTINCT [est_num], ''
FROM [Integration].[open_order_prorepr] s
WHERE NOT EXISTS(
  SELECT * FROM [dbo].[BRS_FSC_Rollup] f where f.TerritoryCd = s.est_num
)
GO

-- add these codes TODO
SELECT distinct [cause_code] from Integration.open_order_prorepr s
where not exists (
select * from [nes].[cause] c where s.[cause_code] = c.[cause_code]
)


-- TRUNCATE TABLE nes.order_open_prorepr

INSERT INTO 
	nes.order_open_prorepr 
	(
		work_order_num
		,branch_code
		,rma_code
		,order_status_code
		,order_received_date
		,estimate_complete_date
		,approved_date
		,order_complete_date
		,shipto
		,privileges_code
		,model_number
		,est_code
		,call_type_code
		,problem_code
		,cause_code
		,user_id
		,approved_part_release_date
		,SalesDate
		,last_update_date
	)
SELECT
	s.work_order_num
	,UPPER(s.d1_branch)				AS d1_branch
	,UPPER(CASE 
		WHEN s.[rma_code] <> '' 
		THEN s.[rma_code] 
		ELSE 'NO' 
	END)							AS rma_code
	,UPPER(s.order_status)			AS order_status
	,s.order_received_date
	,s.estimate_complete_date
	,s.approved_date
	,s.order_complete_date
	,s.shipto
	,s.priv_code
	,s.model_number
	,s.est_num
	,UPPER(s.call_type_code)		AS call_type_code
	,UPPER(s.problem_code)			AS problem_code
	,UPPER(s.cause_code)			AS cause_code
	,s.d1_user_id
	,s.approved_part_release_date
	,BRS_Config.SalesDate
	,COALESCE ( 
		s.order_complete_date, 
		s.approved_part_release_date,
		s.approved_date, 
		s.estimate_complete_date, 
		s.order_received_date
	)
FROM
	Integration.open_order_prorepr AS s 
CROSS JOIN 
	BRS_Config


/*
-- Add Priv priorty, Manual

1. Priv with PMA
2. Priv only
3. rest
*/

/*
-- Add Aging bucket for table time (
5
10
15
30
60
90
)


-- build summary idea

-- oRG cause, total

branch split by EST Branch (see Tony list)

***

resp (Cord, EST, Cust)
  Cause (with buckets)


****

-- fix missing users list dups -> Tony
*/

---

-- 
INSERT INTO [nes].[branch]
(branch_code, branch_name)
SELECT        
distinct (i.branch_code), '' descr
FROM            
Integration.inventory_valuation_whvalrpt AS i
where  
NOT exists (select * from [nes].[branch] where i.branch_code = nes.branch.branch_code)

--truncate table nes.inventory_valuation_whvalrpt

INSERT INTO
	nes.inventory_valuation_whvalrpt
	(
		SalesDate,
		item,
		branch_code,
		tag_number,
		tag_date,
		available_qty,
		allocation_qty,
		reserved_qty,
		total_qty,
		tag_or_avg_cost,
		tag_cost_ind,
		available_extended_value,
		reserved_extended_value,
		reservation_quantity_list,
		total_extended_value,
		bin_code
)
SELECT        
	BRS_Config.SalesDate,
	item,
	branch_code,
	tag_number,
	CASE 
		WHEN tag_number<>'' 
		THEN CAST (LEFT(tag_number,6) AS DATE)
		ELSE NULL
	END	AS tag_date,
	available_qty,
	allocation_qty,
	reserved_qty,
	total_qty,
	tag_or_avg_cost,
	tag_cost_ind,
	available_extended_value,
	reserved_extended_value,
	reservation_quantity_list,
	total_extended_value,
	UPPER(bin_code) AS bin_code
FROM            
	Integration.inventory_valuation_whvalrpt AS inventory_valuation_whvalrpt_1
CROSS JOIN 
	BRS_Config
GO

---


INSERT INTO nes.order_open_prorepr_standards
                         (cause_code, problem_code, call_type_code, order_status_code, rma_code)
SELECT DISTINCT cause_code, problem_code, call_type_code, order_status_code, rma_code
FROM            nes.order_open_prorepr s
WHERE NOT EXISTS (
SELECT * FROM nes.order_open_prorepr_standards d WHERE 
(s.cause_code = d.cause_code) AND
(s.problem_code = d.problem_code) AND
(s.call_type_code = d.call_type_code) AND
(s.order_status_code = d.order_status_code) AND
(s.rma_code = d.rma_code)
)

UPDATE       nes.order_open_prorepr_standards
SET                next_action = LEFT(fix_message,30)
FROM            nes.cause INNER JOIN
                         nes.order_open_prorepr_standards ON nes.cause.cause_code = nes.order_open_prorepr_standards.cause_code

UPDATE       nes.order_open_prorepr_standards
SET                est_value_amt = 300
