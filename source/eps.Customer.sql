
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [eps].[Customer]
AS

/******************************************************************************
**	File: 
**	Name: Customer
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
**	Date: 28 Mar 18
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	31 Mar 18	tmc		added DSO to the list
**    
*******************************************************************************/

-- active cust only
SELECT
	ShipTo			AS Customer_Number, 
	PracticeName	AS Practice_Name, 
	'.'				AS First_Name,
	MailingName		AS Last_Name, 
	RTRIM(AddressLine3 + ' ' + AddressLine4) AS Address_Line1, 
	City, 
	Province		AS State, 
	RTRIM(Country)	AS Country,
	RTRIM(PostalCode)	AS Zip,  
	RTRIM(PhoneNo)	AS Phone_Number,
	'CUSTOMER'		AS Status,
	'S'				AS Bill_Type, 
	RTRIM(f.[FSCName])	AS Field_Level_4_Description,
	RTRIM(Specialty)	AS Specialty_Discription, 
	t.[FSCName]		AS Inside_Sales_Name,
	'.'				AS Inside_Sales_Mgr,
	SalesDivision	AS Sales_Division, 
	BillTo			AS Bill_To, 
	'.'				AS Field_Mgr_Name,
	'.'				AS Alert_Comment,
	PracticeType	AS Practice_Type, 
	BillTo			AS Jde_Bill_To, 
	'.'				AS Eps_Name,
	'0'				AS Credit_Limit,
	'.'				AS Credit_Rep,
	'.'				AS Eps_Mgr_Name,
	'.'				AS Priv_Level,
	'0'				AS Priv_Point,
	RTRIM(SegCd)	AS Special_Market_Segment,
	'.'				AS Special_Market_Segment_Description,
	f.[TerritoryCd]	AS Field_Level_4,
	f.Branch		AS Field_Level_3,
	'.'				AS Field_Level_3_Description

FROM
	BRS_Customer AS c

	INNER JOIN BRS_FSC_Rollup AS f 
	ON c.TerritoryCd = f.TerritoryCd 

	INNER JOIN BRS_FSC_Rollup AS t 
	ON c.TsTerritoryCd = t.TerritoryCd 

WHERE
	(c.ShipTo > 0) AND
	(c.AccountType <> 'D') AND
	(c.SalesDivision = 'AAD') AND 
	(c.Specialty IN('ENDOD', 'ORMS', 'ORTHO', 'PEDO', 'PERIO', 'PROS', 'GENP', 'DSO')) AND
	(f.Branch IN ('LONDN', 'OTTWA', 'TORNT')) AND
	(1=1)
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- SELECT top 10 * FROM eps.Customer 

-- SELECT * FROM eps.Customer 
