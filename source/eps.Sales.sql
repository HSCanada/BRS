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
**    
*******************************************************************************/

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SET NOCOUNT ON

	if (@bDebug <> 0)
		SET NOCOUNT OFF;

	if (@bDebug <> 0)
		Print 'eps S_TS_Cube_proc - DEBUG MODE.'

	--Get Params
	 
	--Pull Cube based on Params

	SELECT
		Customer_Number
		,(Special_Market_Segment)			AS Special_Market_Segment
		,Special_Market_Segment_Description
		,Practice_Name
		,Field_Level_4
		,(Field_Level_4_Description)		AS Field_Level_4_Description
		,Eps_Name
		,Field_Level_3
		,Field_Level_3_Description
		,Sales_Division
		,(Address_Line1)		AS Address_Line1
		,City
		,State
		,(Zip)					AS Zip_5_Digit
		,(Phone_Number)		AS Phone_Number
		,CAST(d.SalesDate as date)	AS Order_Date   
		,[OriginalSalesOrderNumber]	AS Original_Sales_Order_Number
		,[SalesOrderNumber]			AS Sales_Order_Number
		,RTRIM([PromotionCode])		AS Promotion_Code
		,'.'						AS Classification
		,(i.Supplier)			AS Supplier
		,i.Supplier_Description
		,i.[Major_Product_Class]
		,(i.[Major_Product_Class_Description])		AS [Major_Product_Class_Description]
		,i.[Sub_Minor_Prod_Class]
		,(i.[Sub_Minor_Prod_Class_Description])	AS [Sub_Minor_Prod_Class_Description]
		,RTRIM(i.[Item_Number])							AS [Item_Number]
		,i.[Item_Description]
		,CAST(d.SalesDate as date) AS Sales_Date
		,t.NetSalesAmt			AS Net_Sales
		,t.[ShippedQty]			AS Net_Quantity

	FROM         
		dbo.BRS_TransactionDW AS t 

		INNER JOIN [eps].[Item] AS i
		on t.item = i.Item_Number

		INNER JOIN [eps].[Customer] as c
		on t.Shipto = c.Customer_Number

		INNER JOIN BRS_SalesDay AS d 
		ON d.SalesDate = t.Date 


	WHERE     
		(t.CalMonth = 201803) AND
		(1=1)

END

GO

--	Select FiscalMonth, PriorFiscalMonth, FirstFiscalMonth_LY, SalesDateLastWeekly FROM BRS_TS_Config g

-- Debug
-- [eps].Sales_proc

-- Prod
-- [eps].Sales_proc 0

