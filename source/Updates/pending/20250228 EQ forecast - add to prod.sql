-- EQ forecast, tmc, 28 Feb 25


-- add SQL index to comm EQ order for speed
-- 5m

BEGIN TRANSACTION
GO
CREATE NONCLUSTERED INDEX transaction_F555115_idx_17 ON comm.transaction_F555115
	(
	WSORD__equipment_order
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- add unique key to open order table (for linking)
BEGIN TRANSACTION
GO
CREATE UNIQUE NONCLUSTERED INDEX open_order_opordrpt_u_idx_01 ON nes.open_order_opordrpt
	(
	fact_id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE nes.open_order_opordrpt SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- add Astea and commission IDs to ETS table
BEGIN TRANSACTION
GO
ALTER TABLE nes.order_ets ADD
	eq_forecast_est_astea_key int NULL,
	eq_forecast_act_comm_key int NULL
GO
ALTER TABLE nes.order_ets SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- 3min
BEGIN TRANSACTION
GO
CREATE UNIQUE NONCLUSTERED INDEX transaction_F555115_u_idx_18 ON comm.transaction_F555115
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
CREATE NONCLUSTERED INDEX transaction_F555115_idx_19 ON comm.transaction_F555115
	(
	ess_code
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- Move this to production!

-- populate keys from Astea and Comm

-- 1. add any missing orders from Commission)
-- 2. add Comm xref
-- 3. add Astea xref

SELECT TOP (1000) *
  FROM [nes].[order_ets]


--> Astea:  set new eq_forecast_est_astea_key from the Astea order pipline.   may be re-run
UPDATE  nes.order_ets
SET        [eq_forecast_est_astea_key] = eqord.eq_fact_id
FROM     nes.order_ets INNER JOIN
(
	SELECT   ets_num, min(fact_id) eq_fact_id
	FROM     nes.open_order_opordrpt
	WHERE  
		-- pick first install date in workorder status
		(order_status = 'WO') 
	GROUP BY 
		ets_num
) eqord
ON nes.order_ets.ets_num = eqord.ets_num AND
[eq_forecast_est_astea_key] is null
GO
-- ORD 61966


-- [nes].[open_order_opordrpt]
/*
SELECT   ets_num, min(fact_id) fact_id
FROM     nes.open_order_opordrpt
WHERE   
	(order_status = 'WO') AND 
	exists (Select * from [nes].[order_ets] o where [ets_num] = o.[ets_num] and o.eq_forecast_est_astea_key is null)
GROUP BY 
	ets_num
*/
/*
-- [nes].[open_order_opordrpt]
SELECT   top 200 SalesDate, ets_num, line_number, install_date
FROM     nes.open_order_opordrpt
WHERE   
(order_status = 'WO') AND 
(salesdate >= '2025-01-01') and
-- (ets_num = 'X63139') AND 
(1 = 1)
ORDER BY 
ets_num
--fact_id
*/

-- comm

-- Comm:  add missing EQ orders from commission source
INSERT INTO [nes].[order_ets] 
([ets_num], note)
SELECT   distinct WSORD__equipment_order, 'src=Comm' as note
FROM     comm.transaction_F555115
WHERE   
	-- Astea JDE only lines with non-empty Order#
	source_cd = 'JDE' AND
	(WSDCTO_order_type = 'SL') AND
	(WSORD__equipment_order>'') AND
	(WS$OSC_order_source_code = 'A') AND
	not exists (Select * from [nes].[order_ets] where [ets_num] = WSORD__equipment_order)
GROup by 
	WSORD__equipment_order


-- Comm:  set new eq_forecast_act_comm_key from the commission trans.   may be re-run
UPDATE  nes.order_ets
SET        eq_forecast_act_comm_key = comm.comm_fact_id
FROM     nes.order_ets INNER JOIN
(
	SELECT   WSORD__equipment_order, min(ID) comm_fact_id
	FROM     comm.transaction_F555115
	WHERE   
	source_cd = 'JDE' AND
	(WSDCTO_order_type = 'SL') AND
	(WSORD__equipment_order>'') AND
	-- astea
	(WS$OSC_order_source_code = 'A') and
	exists (Select * from [nes].[order_ets] o where o.[ets_num] = WSORD__equipment_order AND o.[eq_forecast_act_comm_key] is null)
	GROup by 
	WSORD__equipment_order
) comm
ON nes.order_ets.ets_num = comm.WSORD__equipment_order

--< PROD

-- 508 783
/*
SELECT   WSORD__equipment_order, min(ID) fact_id
FROM     comm.transaction_F555115
WHERE   
	source_cd = 'JDE' AND
	(WSDCTO_order_type = 'SL') AND
	(WSORD__equipment_order>'') AND
	-- astea
	(WS$OSC_order_source_code = 'A') and
	exists (Select * from [nes].[order_ets] o where o.[ets_num] = WSORD__equipment_order AND o.[eq_forecast_act_comm_key] is null)
GROup by 
	WSORD__equipment_order

-- and not exists match (TODO)
*/

/*
SELECT   top 1000 WSORD__equipment_order, WSDCTO_order_type, WSDOCO_salesorder_number, FiscalMonth,source_cd, WS$OSC_order_source_code, WSTKBY_order_taken_by
FROM     comm.transaction_F555115
WHERE   
	source_cd = 'JDE' AND
	(WSDCTO_order_type = 'SL') AND
	(WSORD__equipment_order>'') AND
	-- astea
	(WS$OSC_order_source_code = 'A') and

	-- test
--	(WSORD__equipment_order = 'X63139') and
	([FiscalMonth] >= 202401) and
	(WSTKBY_order_taken_by like 'CCS%') AND
	(1=1)
ORDER BY 1, 4
*/

-- test est vs act keys

-- test bill without order
Select * from nes.order_ets where [eq_forecast_est_astea_key] is null and [eq_forecast_act_comm_key] is not null and note <> 'src=Comm' order by 1 desc
select * from [nes].[open_order_opordrpt] where [ets_num] in('X70542', 'X70135', 'X69989', 'X69549', 'X69344', 'X68545', 'X68439', 'X68350')

-- test order with no bill
Select * from nes.order_ets where [eq_forecast_est_astea_key] is not null and [eq_forecast_act_comm_key] is null and note <> 'src=Comm' order by 1 asc
select * from [nes].[open_order_opordrpt] where [ets_num] in(
'X38062'
,'X38083'
,'X38101'
,'X38372'
,'X38464'
,'X38471'
,'X38482'
,'X38492'
,'X39129'
,'X39429'
,'X39504'
,'X39680'
)


Select * from nes.order_ets where [eq_forecast_est_astea_key] is not null and [eq_forecast_act_comm_key] is not null 

select * from [comm].[transaction_F555115] where fiscalmonth = 202401 [WSORD__equipment_order]= 'X63139'

sp_who2