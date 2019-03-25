
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
*******************************************************************************/

SELECT        
	s.shipto									AS bx_shipto
	,0											AS bx_group_id
	,RTRIM(MIN(s.[cps_code]))					AS bx_cps_code
	,RTRIM(MIN(s.[ess_code]))					AS bx_ess_code
	,RTRIM(MIN(s.[dts_code]))					AS bx_dts_code
	,RTRIM(MIN(s.[fsc_code]))					AS bx_fsc_code
	
	,SUM(CASE WHEN mpc.bx_sales_category = 'DIGIMP' THEN net_sales_amount ELSE 0 END)	AS cadcam_sales
	,SUM(CASE WHEN mpc.bx_sales_category = 'HITECH' THEN net_sales_amount ELSE 0 END)	AS hitech_sales
	,SUM(CASE WHEN mpc.bx_sales_category = 'EQUIPM' THEN net_sales_amount ELSE 0 END)	AS large_equip_sales
	,SUM(CASE WHEN mpc.bx_sales_category = 'DENTRIX' THEN net_sales_amount ELSE 0 END)	AS dentrix_sales


	,MIN(c.PracticeName) + ' - '
	+CAST(s.[shipto] as varchar(7)) +' - TBD'	AS NAME

	,RTRIM(MIN([AddressLine3])) 
	+' | ' + RTRIM(MIN([AddressLine4]))	
	+' | ' + MIN([City])			
	+' | ' + MIN([Province])		
	+' | ' + MIN([PhoneNo])
	+' | ' + LOWER(RTRIM(MIN(ess.FSCName)))	
	+' | ' + LOWER(RTRIM(MIN(fsc.FSCName)))		AS DESCRIPTION

	,'N'										AS VISIBLE	
	,'N'										AS OPENED
	,LOWER(MIN(br.BranchName))					AS KEYWORDS
	,'K'										AS INITIATE_PERMS
	,'Y'										AS PROJECT 
	,MIN(sales_date)							AS PROJECT_DATE_START 
	,MIN(install_date)							AS PROJECT_DATE_FINISH 


FROM
nes.order_open_equipment_current AS s 

INNER JOIN BRS_Customer AS c 
ON s.shipto = c.ShipTo 

INNER JOIN BRS_FSC_Rollup AS fsc 
ON s.fsc_code = fsc.TerritoryCd 

INNER JOIN BRS_FSC_Rollup AS ess 
ON s.ess_code = ess.TerritoryCd 

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
	(c.bx_group_id IS NULL)

GROUP BY 
	s.shipto
HAVING 
	SUM(s.net_sales_amount) >= (SELECT [bx_order_thresh] FROM [dbo].[BRS_Config])


GO


SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

--
SELECT TOP 10 * FROM nes.bx_group_load


/*
SELECT   ProductNumber, Category =  
      CASE ProductLine  
         WHEN 'R' THEN 'Road'  
         WHEN 'M' THEN 'Mountain'  
         WHEN 'T' THEN 'Touring'  
         WHEN 'S' THEN 'Other sale items'  
         ELSE 'Not for sale'  
      END,  
   Name  
FROM Production.Product  

*/
