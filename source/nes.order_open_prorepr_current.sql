
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
**	Date: 20 Jun 19
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
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
	,RTRIM(std.next_action)			AS next_action

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

	,RTRIM(t.[privileges_code])		AS priv
	,RTRIM(t.[model_number])		AS model_number

	,RTRIM(ct.call_type_descr) 		AS call_type

	,RTRIM(prob.problem_descr)		AS problem

	,RTRIM(t.[cause_code])	 + ' | '
	+ c.cause_descr					AS cause



	,t.[fact_id]
	
	,c.[work_flow]
	,c.[owner]
	,std.est_value_amt				AS est_value
	,DateDiff("d",[order_received_date],[SalesDate]) AS days_outstanding
	,c.turnaround_time				AS days_outstanding_limit
	,priv.priority_code

	,s.order_status_descr + ' | ' 
	+ RTRIM(t.[order_status_code])			AS order_status

	,CASE 
		WHEN e.Branch In ('MNTRL','QUEBC','TORNT','VACVR') 
		THEN e.Branch
		ELSE 'CORP'
	END	as branch_hub
	,e.Branch						AS branch_fsc
	,CAST(t.[SalesDate] as date)	AS sales_date

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

	INNER JOIN [nes].[order_open_prorepr_standards] std
	ON (t.cause_code = std.cause_code) AND
		(t.problem_code = std.problem_code) AND
		(t.call_type_code = std.call_type_code) AND
		(t.order_status_code = std.order_status_code) AND
		(t.rma_code = std.rma_code)

	CROSS JOIN nes.aging age
WHERE
	DateDiff("d",[order_received_date],[SalesDate]) BETWEEN age.day_from AND age.day_to

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT * FROM nes.order_open_prorepr_current
