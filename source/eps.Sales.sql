SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [eps].Sales_proc
	@bDebug as smallint = 1
AS

/******************************************************************************
**	File: 
**	Name: Sales
**	Desc: 
**
**              
**	Return values:  @@Error
**
**	Called by:   
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**	@bDebug
**
**	Auth: tmc
**	Date: 28 Mar 18
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	04 Apr 18	tmc		finalize fields for production
--	26 Mar 19	tmc		extend to Quebec Zone & add EPS
**    
*******************************************************************************/

Declare @nWeek	int = 0
-- Declare @StartMonth int = 0

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	if (@bDebug <> 0)
		SET NOCOUNT OFF;

	if (@bDebug <> 0)
		Print 'eps S_TS_Cube_proc - DEBUG MODE.'

	--Get Params
	 
	--Pull Cube based on Params
	SELECT
		@nWeek = d.FiscalWeek
--		@StartMonth = d.FiscalMonth
	FROM
		BRS_Config AS c 

		INNER JOIN BRS_SalesDay AS d 
		ON c.SalesDateLastWeekly = d.SalesDate


	SELECT
		t.shipto								AS Customer_Number
		,(Special_Market_Segment)				AS Special_Market_Segment
		,Special_Market_Segment_Description
		,Practice_Name
		,Field_Level_4
		,(Field_Level_4_Description)			AS Field_Level_4_Description
		,Field_Level_3
		,Sales_Division
		,(Address_Line1)						AS Address_Line1
		,City
		,State
		,(Zip)									AS Zip_5_Digit
		,(Phone_Number)							AS Phone_Number
		,CAST(d.SalesDate as date)				AS Order_Date   
		,[OriginalSalesOrderNumber]				AS Original_Sales_Order_Number
		,[SalesOrderNumber]						AS Sales_Order_Number
		,RTRIM([PromotionCode])					AS Promotion_Code
		,(i.Supplier)							AS Supplier
		,i.Supplier_Description
		,i.[Major_Product_Class]
		,(i.[Major_Product_Class_Description])	AS [Major_Product_Class_Description]
		,i.[Sub_Minor_Prod_Class]
		,(i.[Sub_Minor_Prod_Class_Description])	AS [Sub_Minor_Prod_Class_Description]
		,RTRIM(i.[Item_Number])					AS [Item_Number]
		,i.[Item_Description]
		,CAST(d.SalesDate as date)				AS Sales_Date
		,RTRIM(t.CustomerPOText1)				AS PO_Number
		,t.NetSalesAmt							AS Net_Sales
		,t.[ShippedQty]							AS Net_Quantity
		,t.GPAtCommCostAmt						AS GP_Comm
		,RTRIM(c.EPS_code)						AS Eps_Code


	FROM         
		dbo.BRS_TransactionDW AS t 

		INNER JOIN [eps].[Item] AS i
		on t.item = i.Item_Number

		INNER JOIN [eps].[Customer] as c
-- test
--		LEFT JOIN [eps].[Customer] as c
		on t.Shipto = c.Customer_Number

		INNER JOIN BRS_SalesDay AS d 
		ON d.SalesDate = t.Date 


	WHERE     
		(d.FiscalWeek = @nWeek) AND
		(t.SalesDivision = 'AAD') AND
-- test
--		CAST(d.SalesDate as date) between '2019-01-01' AND '2019-03-22' AND
--		(t.CalMonth Between 201801 and 201803) AND
--		(c.Eps_Code = 'EPQUE') AND

		(1=1)

END

GO

--	Select FiscalMonth, PriorFiscalMonth, FirstFiscalMonth_LY, SalesDateLastWeekly FROM BRS_TS_Config g

-- Debug
-- [eps].Sales_proc

-- Prod
/*

-- ^ delim
-- HSC_SALES_20190412.txt


SET NOCOUNT OFF;
GO
[eps].Sales_proc 0
GO

-- eps_customer.txt

SET NOCOUNT ON;
SELECT * FROM eps.Customer 

GO

-- eps_item.txt

SET NOCOUNT ON;
SELECT * FROM eps.Item

*/

