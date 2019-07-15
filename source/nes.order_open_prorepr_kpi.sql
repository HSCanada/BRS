
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW nes.order_open_prorepr_kpi
AS

/******************************************************************************
**	File: 
**	Name: nes.order_open_prorepr_kpi
**	Desc:  
**		
**
**              
**	Return values:  
**
**	Called by:   Excel power query
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**
**	Auth: tmc
**	Date: 20 Jun 18
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
*******************************************************************************/

SELECT
	CASE 
		WHEN e.Branch <> ''
		THEN e.Branch
		ELSE 'OTHER'
	END	as branch_hub
	,RTRIM(t.[branch_code])			AS branch

	,cust.PracticeName + ' | '
	+CAST(t.[shipto] as varchar(7)) AS customer

	,RTRIM(CASE 
		WHEN u.user_name <> '' 
		THEN u.user_name 
		ELSE u.[user_id] 
	END)							AS user_name

	,RTRIM(CASE 
		WHEN e.FSCName <> '' 
		THEN e.FSCName 
		ELSE t.[est_code] 
	END)							AS bench_tech

	,RTRIM(f.FSCName)				AS fsc
	,RTRIM(ec.FSCName)				AS est

	,t.[work_order_num]				AS workorder

	,CAST(t.[SalesDate] as date)	AS sales_date
	,t.[last_update_date]			
	,t.[order_received_date]		
	,t.[estimate_complete_date]		
	,t.[approved_date]				
	,t.[approved_part_release_date] 
	,t.[order_complete_date]		

	,t.[fact_id]


	,RTRIM(prob.problem_rollup)		AS problem_rollup

	,RTRIM(prob.problem_descr) + ' | '	
	+RTRIM(prob.problem_code)		AS problem
	,s.order_status_descr + ' | ' 
	+ RTRIM(t.[order_status_code])	AS order_status

	,CASE WHEN [order_complete_date] IS NULL THEN 'PENDING' ELSE 'COMPLETE' END AS status

	,ISNULL(std.est_value_amt,0)	AS est_value
	,DateDiff("d",[order_received_date],[order_complete_date]) AS days_to_complete
	,DateDiff("d",[order_received_date],[SalesDate]) AS days_pending



FROM 
	nes.order_open_prorepr t

	INNER JOIN nes.cause c
	ON t.cause_code = c.cause_code 

	INNER JOIN nes.order_status s
	ON t.order_status_code = s.order_status_code

	INNER JOIN nes.user_login u
	ON t.user_id = u.user_id

	INNER JOIN BRS_Customer cust
	ON t.shipto = cust.ShipTo

	INNER JOIN BRS_FSC_Rollup f
	ON cust.TerritoryCd = f.TerritoryCd

	INNER JOIN BRS_FSC_Rollup AS e 
	ON t.est_code = e.TerritoryCd

	INNER JOIN BRS_FSC_Rollup AS ec 
	ON cust.est_code = ec.TerritoryCd

	INNER JOIN nes.branch b
	ON t.branch_code = b.branch_code

	INNER JOIN nes.privileges priv
	ON t.privileges_code = priv.privileges_code 

	INNER JOIN nes.call_type ct
	ON t.call_type_code = ct.call_type_code

	INNER JOIN nes.problem prob
	ON t.problem_code = prob.problem_code

	INNER JOIN nes.rma r
	ON t.rma_code = r.rma_code

	LEFT JOIN [nes].[order_open_prorepr_standards] std
	ON (t.cause_code = std.cause_code) AND
		(t.problem_code = std.problem_code) AND
		(t.call_type_code = std.call_type_code) AND
		(t.order_status_code = std.order_status_code) AND
		(t.rma_code = std.rma_code)



WHERE
	[SalesDate] = (SELECT MAX([SalesDate]) FROM nes.order_open_prorepr)  

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


SELECT * FROM nes.order_open_prorepr_kpi where branch_hub <> 'QUEBC'



--SELECT count(*) FROM nes.order_open_prorepr_kpi
-- ORG 1516
-- Fix 1890




