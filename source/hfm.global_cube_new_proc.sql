SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [hfm].global_cube_new_proc 
	@FiscalMonth int

AS

/******************************************************************************
**	File: 
**	Name: BRS_global_cube_new_proc
**	Desc: Pull Global Vendor Cube data, based on BRS_global_cube_new_proc
**
**              
**	Return values:  @@Error
**
**	Called by:   
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**	
**
**	Auth: tmc
**	Date: 06 Oct 21
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	29 Jun 22	tmc		add Free Goods est code
*******************************************************************************/

Declare @sVersion	varchar(10)		= 'WRKNG'
Declare @sCurrency	varchar(3)		= 'LOC'
Declare @sAnalysis	varchar(10)		= 'NoAnalysis'

BEGIN
	SET NOCOUNT ON;

	-- Sales 1 of 3
	SELECT   
--		top 10  

		ENTITY_sales			AS ENTITY 
		,ACCOUNT_sales			AS ACCOUNT
		,PRODUCT
		,BRAND_EQUITY
		,BRAND_LINE
		,CUSTOMER
		,@sCurrency				AS CURRENCY
		,ANALYSIS
		,SUPPLIER
		,CUSTOMER_SPECIALTY		
		,REPORTING_SOURCE		
		,PERIOD
		,@sVersion				AS VERSION
		,SUM(t.sales)			AS AMOUNT

	FROM         
		[hfm].global_cube AS t 

	WHERE
		(PERIOD = @FiscalMonth) AND
--		test
		-- temp flag (1 of 3, sales)
		(AdjCode <> 'XXXFGE') AND
--		t.SalesOrderNumber = 1109883 AND
		(1=1)

	GROUP BY 
		PERIOD
		,ENTITY_sales
		,ACCOUNT_sales
		,PRODUCT
		,SUPPLIER
		,BRAND_EQUITY
		,BRAND_LINE
		,ANALYSIS
		,CUSTOMER_SPECIALTY
		,CUSTOMER
		,REPORTING_SOURCE

	HAVING
		(SUM(t.sales) <>0)

	UNION ALL

	-- Cost 2 of 3
	SELECT     
--		top 10

		ENTITY_cost				AS ENTITY 
		,ACCOUNT_cost			AS ACCOUNT
		,PRODUCT
		,BRAND_EQUITY
		,BRAND_LINE
		,CUSTOMER
		,@sCurrency				AS CURRENCY
		,ANALYSIS
		,SUPPLIER
		,CUSTOMER_SPECIALTY		
		,REPORTING_SOURCE		
		,PERIOD
		,@sVersion				AS VERSION
		,SUM(t.ext_cost)		AS ValueAmt

	FROM         
		[hfm].global_cube AS t 


	WHERE
		(ReportingClass <> 'NSA') AND
		(PERIOD = @FiscalMonth) AND
		-- temp flag (2 of 3, ext_cost)
		(AdjCode <> 'XXXFGE') AND
		(1=1)

	GROUP BY 
		PERIOD
		,ENTITY_cost
		,ACCOUNT_cost
		,PRODUCT
		,SUPPLIER
		,BRAND_EQUITY
		,BRAND_LINE
		,ANALYSIS
		,CUSTOMER_SPECIALTY
		,CUSTOMER
		,REPORTING_SOURCE

	HAVING 
		SUM(t.ext_cost)<>0

	UNION ALL

	-- Chargeback 3 of 3
	SELECT     
--		top 10 

		ENTITY_cb				AS ENTITY 
		,ACCOUNT_cb				AS ACCOUNT
		,PRODUCT
		,BRAND_EQUITY
		,BRAND_LINE
		,CUSTOMER
		,@sCurrency				AS CURRENCY
		,ANALYSIS
		,SUPPLIER
		,CUSTOMER_SPECIALTY		
		,REPORTING_SOURCE		
		,PERIOD
		,@sVersion				AS VERSION
		,SUM(t.ext_chargeback)	AS ValueAmt

	FROM         
		[hfm].global_cube AS t 

	WHERE
		(t.ext_chargeback is NOT NULL) AND
		(ReportingClass <> 'NSA') AND
		(PERIOD = @FiscalMonth) AND

--		test
--		t.SalesOrderNumber = 1109883 AND
		-- temp flag (3 of 3, cb), DO NOT ADJ, TC
		--(AdjCode = 'XXXFGE') AND


		(1=1)

	GROUP BY 
		PERIOD
		,ENTITY_cb
		,ACCOUNT_cb
		,PRODUCT
		,SUPPLIER
		,BRAND_EQUITY
		,BRAND_LINE
		,ANALYSIS
		,CUSTOMER_SPECIALTY
		,CUSTOMER
		,REPORTING_SOURCE

	HAVING
		(SUM(t.ext_chargeback)<> 0)

END


GO


-- see ETL for current update script docs - S:\BR\zDev\BRS\source\Updates\etl_working 20171217 global vendor - ETL details.sql

--a_CAN_Sep-21_RA.csv
-- [hfm].global_cube_new_proc 202112
-- 48 368 rows @ 3s

-- FG 28 124

-- 46 452 rows @ 6s
-- 



