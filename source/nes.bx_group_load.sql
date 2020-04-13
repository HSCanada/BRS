
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW nes.bx_group_load
AS

/******************************************************************************
**	File: 
**	Name: nes.bx_group_load
**	Desc: Bitrix new orders to load
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
**	Date: 6 Feb 18
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
** 21 Mar 19	tmc		Add full territory codes for deferred rights & sales 
** 30 Mar 19	tmc		Add design sales for new office identify
** 30 Jul 19	tmc		Add bx_cps_code to description (Dentrix)
** 13 Apr 20	tmc		Add xray except logic 
*******************************************************************************/

SELECT
--	TOP 1
	        
	s.shipto									AS bx_shipto
	,MIN(c.bx_group_id)							AS bx_group_id
	,MIN(c.PracticeName) + ' - '
	+CAST(s.[shipto] as varchar(7))	+ ' - EQP'	AS NAME
	,RTRIM(MIN([AddressLine3])) 
	+' | ' + RTRIM(MIN([AddressLine4]))	
	+' | ' + MIN([City])			
	+' | ' + MIN([Province])		
	+' | ' + MIN([PhoneNo])
	+' | ' + LOWER(RTRIM(MIN(ess.FSCName)))	
	+' | ' + LOWER(RTRIM(MIN(fsc.FSCName)))		
	+' | ' + LOWER(RTRIM(MIN(cps.FSCName)))		AS DESCRIPTION
	,LOWER(MIN(br.BranchName))					AS KEYWORDS

	,MIN(br.Branch)								AS bx_branch_code
	,MIN(br.language_cd)						AS bx_language_code
	,RTRIM(MIN(s.[cps_code]))					AS bx_cps_code
	,RTRIM(MIN(s.[ess_code]))					AS bx_ess_code
	,RTRIM(MIN(s.[dts_code]))					AS bx_dts_code
	,RTRIM(MIN(s.[fsc_code]))					AS bx_fsc_code
	
	,SUM(CASE WHEN mpc.bx_sales_category = 'DIGIMP' THEN net_sales_amount ELSE 0 END)	AS bx_cadcam_sales
	,SUM(CASE WHEN mpc.bx_sales_category = 'HITECH' THEN net_sales_amount ELSE 0 END)	AS bx_hitech_sales
	,SUM(CASE WHEN mpc.bx_sales_category = 'EQUIPM' THEN net_sales_amount ELSE 0 END)	AS bx_large_equip_sales
	,SUM(CASE WHEN mpc.bx_sales_category = 'DENTRX' THEN net_sales_amount ELSE 0 END)	AS bx_dentrix_sales
	,SUM(CASE WHEN s.item = '5772918'	THEN order_qty ELSE 0 END)						AS bx_newreno_qty
	,SUM(CASE WHEN s.item = '5846055'	THEN order_qty ELSE 0 END)						AS bx_xray_qty
	,LOWER(MIN(c.MarketClass))					AS bx_market_class

	,MIN(sales_date)							AS bx_sales_date
	,MIN(install_date)							AS bx_install_date
	,MIN(c.bx_invite_ind)						AS bx_invite_ind


FROM
nes.order_open_equipment_current AS s 

INNER JOIN BRS_Customer AS c 
ON s.shipto = c.ShipTo 

INNER JOIN BRS_FSC_Rollup AS fsc 
ON s.fsc_code = fsc.TerritoryCd 

INNER JOIN BRS_FSC_Rollup AS ess 
ON s.ess_code = ess.TerritoryCd 

INNER JOIN BRS_FSC_Rollup AS cps
ON s.cps_code = cps.TerritoryCd 

INNER JOIN BRS_Branch br
ON fsc.Branch = br.Branch 

INNER JOIN nes.order_status 
ON s.order_status_code = nes.order_status.order_status_code 

INNER JOIN dbo.BRS_Item as i
ON s.item = i.Item

INNER JOIN dbo.BRS_ItemMPC mpc
ON i.MajorProductClass = mpc.MajorProductClass


WHERE
	(br.bx_active_ind = 1) AND 
	(order_status.bx_active_ind = 1)  AND
	(ISNULL(c.[bx_invite_ind],0) < 1) AND
	(1=1)

GROUP BY 
	s.shipto
HAVING 
	(
		-- minimum spend thresh
		SUM(s.net_sales_amount) >= (SELECT [bx_order_thresh] FROM [dbo].[BRS_Config]) OR
		-- except if xray added, 13 Apr 20
		SUM(CASE WHEN s.item = '5846055' THEN order_qty ELSE 0 END) <> 0 OR
		(1<>1)
	) AND
	(1=1)
GO

-- SELECT TOP 10 * FROM nes.bx_group_load

