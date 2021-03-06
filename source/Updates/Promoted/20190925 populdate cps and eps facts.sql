-- populdate cps and eps facts.sql, tmc, 25 Sep 19

/****** Script for SelectTopNRows command from SSMS  ******/

SELECT        t.FiscalMonth, t.cps_salesperson_key_id, t.cps_comm_plan_id, t.cps_comm_group_cd, t.cps_comm_rt, t.cps_comm_amt, t.cps_code, t.eps_code, 
                         t.eps_salesperson_key_id, t.eps_comm_plan_id, t.eps_comm_group_cd, i.comm_group_eps_cd, i.comm_group_cps_cd
FROM            comm.transaction_F555115 AS t INNER JOIN
                         BRS_Item AS i ON t.WSLITM_item_number = i.Item

-- update cps

SELECT        t.FiscalMonth, t.cps_comm_group_cd, i.comm_group_cps_cd
FROM            comm.transaction_F555115 AS t INNER JOIN
                         BRS_Item AS i ON t.WSLITM_item_number = i.Item
WHERE        (i.comm_group_cps_cd <> '') AND (t.FiscalMonth = 201801)


-- update CPS item
UPDATE       comm.transaction_F555115
SET                cps_comm_group_cd = i.comm_group_cps_cd
FROM            comm.transaction_F555115 INNER JOIN
                         BRS_Item AS i ON comm.transaction_F555115.WSLITM_item_number = i.Item
WHERE        
(i.comm_group_cps_cd <> '') AND 
(comm.transaction_F555115.FiscalMonth between 201801 and 201908 )

-- update EPS item
UPDATE       comm.transaction_F555115
SET                eps_comm_group_cd = i.comm_group_eps_cd
FROM            comm.transaction_F555115 INNER JOIN
                         BRS_Item AS i ON comm.transaction_F555115.WSLITM_item_number = i.Item
WHERE        
(i.comm_group_eps_cd <> '') AND 
(comm.transaction_F555115.FiscalMonth between 201801 and 201908 )


-- update CPS terr, key
BEGIN TRANSACTION
GO
CREATE NONCLUSTERED INDEX transaction_F555115_idx_13 ON comm.transaction_F555115
	(
	fsc_code
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


SELECT
	t.FiscalMonth,
	t.WSSHAN_shipto,
	t.WSAC10_division_code,
	t.cps_salesperson_key_id,
	t.cps_comm_plan_id,
	t.cps_code,

	t.fsc_code,
	f.Branch,
	c.PostalCode,
	m.[TerritoryCd],
	m.[comm_plan_id],
	sales_key.comm_salesperson_key_id

FROM
	comm.transaction_F555115 AS t 
	
	INNER JOIN BRS_Customer AS c 
	ON t.WSSHAN_shipto = c.ShipTo 
	
	INNER JOIN BRS_FSC_Rollup AS f 
	ON t.fsc_code = f.TerritoryCd

	INNER JOIN [comm].[plan_region_map] m
	ON m.[comm_plan_id] = 'CPSGP' AND
		c.PostalCode Like m.[postal_code_where_clause_like] AND
--		f.Branch LIKE [branch_code_where_clause_like] AND
		(1 = 1)

	INNER JOIN [dbo].[BRS_FSC_Rollup] sales_key
	ON sales_key.TerritoryCd = m.TerritoryCd

WHERE
	(t.WSSHAN_shipto > 0) AND
	(t.FiscalMonth between 201801 and 201801 ) AND
	(1=1)
ORDER BY 
	c.PostalCode

--
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
	(comm.transaction_F555115.FiscalMonth BETWEEN 201801 AND 201908) AND 
	(1 = 1)

--

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
	(comm.transaction_F555115.FiscalMonth BETWEEN 201801 AND 201908) AND 
	(1 = 1)

