
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[gl_account_group]
AS

/******************************************************************************
**	File: 
**	Name: [Dimension].[gl_account_group]
**	Desc:  
**		
**
**              
**	Return values:  
**
**	Called by:   Finacial Model
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**
**	Auth: tmc
**	Date: 10 Dec 24
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

SELECT 
--	TOP (1000) 

	[gl_account_key]

	,[GMCO___company]
	,[GMAID__account_id]
	,[GMMCU__business_unit]
	,[GMOBJ__object_account]
	,[GMSUB__subsidiary]
	,[GMANS__free_form_3rd_acct_no]
	,[GMDL01_description]
	,[GMLDA__account_level_of_detail]
	,[GMPEC__posting_edit]
	,[GMUSER_user_id]
	,[GMPID__program_id]
	,[GMJOBN_work_station_id]
	,[GMUPMJ_date_updated_JDT]

	,cc.CostCenterKey
	,[HFM_CostCenter]
	,cc.CostCenterDescr
	,cc.CostCenterParent
	,cc.LevelNum
	,cc.Entity	AS EntityCC
	,ent.EntityDescr
	,ent.EntityParent
	,ent.Entity

	,s.[HFM_Account]
	,act.HFM_Account_descr
	,act.GLOBJ_Type

	,[LastUpdated]
	,[HFM_SourceCode]

FROM 
	[hfm].[account_master_F0901] s

	LEFT JOIN [hfm].[cost_center] cc
	ON s.HFM_CostCenter = cc.CostCenter

	LEFT JOIN [hfm].[entity] ent
	ON cc.Entity = ent.Entity

	LEFT JOIN [hfm].[account] act
	ON s.HFM_Account = act.HFM_Account

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


SELECT top 10 * FROM [Dimension].[gl_account_group] order by 12 desc
-- where SalesOrderNumber = 0


