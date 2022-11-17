
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW nes.order_open_prorepr_current
AS

/******************************************************************************
**	File: 
**	Name: nes.order_open_prorepr_current
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
**	16 Sep 18	tmc		Added filter so that newest day is shown    
**	22 Oct 18	tmc		Cosmetic chagnes as per Service team
**	23 Oct 18	tmc		Cosmetic chagnes as per Service team
**	30 Oct 18	tmc		Fixed INNER JOIN bug on [order_open_prorepr_standards]
**	16 Nov 18	tmc		Remove Other from hardcode logic
**	12 Dec 18	tmc		Add EST and FSC to pull, fix branch_fsc bug
*******************************************************************************/

SELECT
	RTRIM(t.[branch_code])			AS branch

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

	,RTRIM(age.aging_display)		AS aging
	,RTRIM(ISNULL(std.next_action, '***Undefined***')) AS next_action

	,r.[rma_name]					AS rma

	,RTRIM(t.[order_status_code])	AS st

	,t.[work_order_num]				AS workorder

	,t.[last_update_date]			AS [Last Update]
	,t.[order_received_date]		AS [Order Recv]
	,t.[estimate_complete_date]		AS [Est Compl]
	,t.[approved_date]				AS [Appr/Decl]
	,t.[approved_part_release_date] AS [Appr Part]
	,t.[order_complete_date]		AS [Order Comp]

	,cust.PracticeName + ' | '
	+CAST(t.[shipto] as varchar(7)) AS customer
	,RTRIM(cust.PracticeName)		AS PracticeName
	,t.[shipto]

	,RTRIM(t.[privileges_code])		AS priv
	,RTRIM(t.[model_number])		AS model_number

	,RTRIM(ct.call_type_descr) 		AS call_type
	,RTRIM(t.call_type_code) 		AS call_type_code

	,RTRIM(prob.problem_descr)		AS problem

	,RTRIM(t.[cause_code])	 + ' | '
	+ c.cause_descr					AS cause



	,t.[fact_id]
	
	,c.[work_flow]
	,c.[owner]
	,ISNULL(std.est_value_amt,0)	AS est_value
	,DateDiff("d",[order_received_date],[SalesDate]) AS days_outstanding
	,c.turnaround_time				AS days_outstanding_limit
	,priv.priority_code

	,s.order_status_descr + ' | ' 
	+ RTRIM(t.[order_status_code])	AS order_status

	,CASE 
		WHEN e.Branch <> ''
--		WHEN e.Branch In ('MNTRL','QUEBC','TORNT','VACVR') 
		THEN e.Branch
		ELSE 'OTHER'
	END	as branch_hub
	,f.Branch						AS branch_fsc
	,CAST(t.[SalesDate] as date)	AS sales_date
	,RTRIM(f.FSCName)				AS fsc
	,RTRIM(ec.FSCName)				AS est

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

	CROSS JOIN nes.aging age
WHERE
	(
		[SalesDate] = (SELECT MAX([SalesDate]) FROM nes.order_open_prorepr) AND
		DateDiff("d",[order_received_date],[SalesDate]) BETWEEN age.day_from AND age.day_to
	) OR
	(
		[SalesDate] = '2012-01-01' AND
		age.aging_key = 1
	) AND
	1=1


GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- SELECT top 100 * FROM nes.order_open_prorepr_current order by sales_date desc

/*
SELECT  * FROM nes.order_open_prorepr_current
where 
--bench_tech like '%DO NOT%' AND
user_name In ('51924','41724','41725') AND
(1=1)
*/


