
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW ar.aging_billto_F564201
AS

/******************************************************************************
**	File: 
**	Name: Item
**	Desc:  
**		
**
**              
**	Return values:  
**
**	Called by:   SSAS
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**
**	Auth: tmc
**	Date: 25 Oct 24
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

SELECT 
--	TOP (1000) 
	[Account_Number]
      ,[Ship_To]
      ,[ShipTo_Default]

	  ,CASE WHEN Practice_Type = 'LSC' THEN ShipTo_Default ELSE bt.ShipToPrimary END ShipToPrimary
	  ,fsc_master.salesperson_nm
	  ,fsc.Branch
	  ,c.MarketClass_New

      ,[Practice_Type]
      ,[Division_Code]
      ,[Credit_Representative]
	  ,cr.Credit_Rep_nm [Credit_Representative_Name]
      ,[Account_Status]

      ,[Business_Name]
      ,[Customer_Name]
      ,[Open_Amount]
      ,[Future_Amount]
      ,[Gross_Amount]
      ,[Current_Amount]
      ,[Pastdue30]
      ,[Pastdue60]
      ,[Pastdue90]
      ,[Pastdue120]
      ,[CalAgPD91_120]
      ,[CalAgPD121_150]
      ,[CalAgPD151_180]
      ,[CalAgPD181_Over]
      ,[CalAgPD61_74]
      ,[CalAgPD75_90]
      ,[Auto_ACH]
      ,[Phone_Number]
      ,[Credit_Limit]
      ,[Invoice_Type]
      ,[Document_Number]
      ,s.[City]
      ,[Account_Level_Business_Unit]
      ,[Add_Transfer]
      ,[Address_1]
      ,[Address_3]
      ,[Address_4]
      ,[Area_Code]
      ,[Attention]
      ,[Average_Days_Late]
      ,[Bill_To]
      ,[Business_Unit]
      ,[Company_Code]
      ,[Country_Code]
      ,[County]
      ,[Credit_Card_Auto_Pay]
      ,[Credit_Card_Status]
      ,[Credit_Flag_Spread]
      ,[Credit_Manager]
      ,[Customer_Business_Unit]
      ,[Delinquency_Notice]
      ,[Due_Date]
      ,[Dummy]
      ,[Exempt_From_Credit_Hold]
      ,[G_L_Date]
      ,[Hold_Invoices]
      ,[Invoice_Date]
      ,[Invoice_Prior_Year]
      ,[Invoice_This_Year]
      ,[Last_Credit_Review]
      ,[Last_Transaction_Date]
      ,[Late_Charge_Flag]
      ,[Market_Segment]
      ,[Order_Entry]
      ,[Parent_Number]
      ,[Pay_Type]
      ,[Payment_Terms_Customer_Level]
      ,[Payment_Terms_Inv_Level]
      ,[Payment_Type]
      ,[Preferred_Credit_Card]
      ,[Print_Statement]
      ,[Send_Invoice_To]
      ,[Sent_Statement_To]
      ,[SO_Number]
      ,[Start_Date]
      ,[State]
      ,[Statement_Cycle]
      ,[Tax_Expl_Code]
      ,[Tax_ID]
      ,[Temporary_Message]
      ,[Transfer]
      ,[Two_Digit_Zip]
      ,[Zip]
      ,[Last_Pay_Date]
      ,[FSC]
      ,[Territory_AAFS]
  FROM [Integration].[F564201_AgingBillto] s

	-- 	map billto to primary shipto (daily)
	LEFT JOIN [dbo].[BRS_CustomerBT] bt
	ON s.[Account_Number] = bt.BillTo AND 
	bt.BillTo <> bt.ShipToPrimary AND


	(1=1)

	-- pull current FSC (daily)
	LEFT JOIN [dbo].[BRS_Customer] c
	ON c.ShipTo = CASE WHEN Practice_Type = 'LSC' THEN ShipTo_Default ELSE bt.ShipToPrimary END AND
	c.ShipTo <> c.BillTo

	-- maint (daily)
	LEFT JOIN [dbo].[BRS_FSC_Rollup] fsc
	ON c.TerritoryCd = fsc.TerritoryCd

	-- maint (monthly)
	LEFT JOIN [comm].[salesperson_master] fsc_master
	ON fsc.comm_salesperson_key_id = fsc_master.[salesperson_key_id]

	LEFT JOIN [ar].[credit_rep] cr
	ON s.Credit_Representative = cr.Credit_Rep


  where 
	-- test
	--bt.ShipToPrimary is null AND
	--Practice_Type <> 'LSC' AND
	--
	(1=1)





GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- SELECT top 10 * from ar.aging_billto_F564201
