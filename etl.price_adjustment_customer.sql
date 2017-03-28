
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW etl.price_adjustment_customer
AS

/******************************************************************************
**	File: 
**	Name: etl.price_adjustment_detail
**	Desc:  
**
**              
**	Return values:  
**
**	Called by:   
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**
**	Auth: tmc
**	Date: 26 Mar 17
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

--------------------------------------------------------------------------------
-- Customer Map - Class Contract, Marketing programs, Special, Contract
--------------------------------------------------------------------------------

-- Class Contract Map

SELECT        
	PJAN8__billto				AS billto
	,sn.SNAST__adjustment_name	AS adjustment_name
	,'C'						AS price_method
	,''							AS marketing_program
	,PJASN__adjustment_schedule AS adjustment_schedule
FROM            
	etl.F40314_preference_price_adjustment_schedule AS pj

	INNER JOIN etl.F4070_price_adjustment_schedule AS sn
	ON pj.PJASN__adjustment_schedule = sn.SNASN__adjustment_schedule

	INNER JOIN etl.F4071_price_adjustment_name AS atn
	ON sn.SNAST__adjustment_name = atn.ATAST__adjustment_name
WHERE 
	ATPRFR_preference_type= 'IG' AND
	ATPRGR_item_price_group = '' AND
	ATCPGP_customer_price_group	 = '' AND
	ATSDGR_order_detail_group = '' AND
	ATLBT__level_break_type = 1 AND 
	1=1

UNION ALL

-- Marketing program map

SELECT 	
	GSAN8__billto				AS billto
	,'PRPRICE'					AS adjustment_name
	,'P'						AS price_method
	,GSTHGD_thru_grade			AS sales_detail_value_01
	,''							AS adjustment_schedule

  FROM 
	etl.F40308_preference_profile_grade_and_potency

UNION ALL

-- Special Pricing and Contract

SELECT DISTINCT       
	ADAN8__billto				AS billto
	,ADAST__adjustment_name		AS adjustment_name
	,LEFT(ADAST__adjustment_name,1) AS price_method
	,''							AS sales_detail_value_01
	,''							AS adjustment_schedule

FROM            
	etl.F4072_price_adjustment_detail p

	INNER JOIN etl.F4071_price_adjustment_name n
	ON p.ADAST__adjustment_name = n.ATAST__adjustment_name

WHERE
	n.ATPRFR_preference_type IN ('C') AND
	ADAN8__billto > 0 AND
	p.ADBSCD_basis = 5 AND
	(1=1)




GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- exception
-- SELECT * FROM etl.price_adjustment_customer where billto in(2314421,1586614,3042656,2902182,2716885,2669458,2624242,2463856,2247335,2235929,2212280,2197701,1679234,1660468,1589588,1588819,1588112,1587406,1587178,1584471,1584402,1584349,1584192,1583727,1583532,1583417,1583354,1583085,1583078,1583062,1582995,1582732,1582203,1581539,1581318,1581206,1526939,1526923,1526917,2314421) order by 1

-- SELECT distinct billto FROM etl.price_adjustment_customer 