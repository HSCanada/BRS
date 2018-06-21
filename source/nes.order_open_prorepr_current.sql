
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
	UPPER(RTRIM(t.[branch_code]))	AS branch_d1

	,RTRIM(CASE 
		WHEN u.user_name <> '' 
		THEN u.user_name 
		ELSE u.[user_id] 
	END)							AS user_name

	,priv.priority_code

	,RTRIM(age.aging_display)		AS days_outstanding_aging
	,DateDiff("d",[order_received_date],[SalesDate]) AS days_outstanding
	,c.turnaround_time				AS days_outstanding_limit
	,c.fix_message					AS next_step

	,t.[work_order_num]
	,CASE 
		WHEN t.[rma_code] <> '' 
		THEN t.[rma_code] 
		ELSE 'NO' 
	END								AS rma_code

	,c.cause_descr + ' | '
	+ UPPER(RTRIM(t.[cause_code]))	AS cause


	,e.FSCName 	+ ' | '
	+t.[est_code]					AS tech_name

	,cust.PracticeName + ' | '
	+CAST(t.[shipto] as varchar(7)) 	AS customer

	,RTRIM(t.[model_number])		AS model_number


	,s.order_status_descr + ' | ' 
	+ RTRIM(t.[order_status_code])			AS order_status

	,ct.call_type_descr + ' | '
	+UPPER(RTRIM(t.[call_type_code]))	AS call_type

	,RTRIM(prob.problem_descr) + ' | '
	+UPPER(RTRIM(t.[problem_code]))	AS problem

	,t.[fact_id]

	,t.[last_update_date]
	,t.[order_received_date]
	,t.[estimate_complete_date]
	,t.[approved_date]
	,t.[approved_part_release_date]
	,t.[order_complete_date]


	,CASE 
		WHEN e.Branch In ('MNTRL','QUEBC','TORNT','VACVR') 
		THEN e.Branch
		ELSE 'CORP'
	END	as branch_hub
	,e.Branch						AS branch
	,RTRIM(t.[privileges_code])		AS privileges_code

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

	CROSS JOIN nes.aging age
WHERE
	DateDiff("d",[order_received_date],[SalesDate]) BETWEEN age.day_from AND age.day_to

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- SELECT * FROM nes.order_open_prorepr_current
