-- D1 Equipment order open ETL
-- 18 May 18, tmc

--- ETL


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
