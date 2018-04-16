
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
**	04 Apr 18	tmc		finalize fields for production
**	13 Apr 18	tmc		removed inactive filter to allow growth measure DCC
**    
*******************************************************************************/

-- active cust only
SELECT
	ShipTo					AS Customer_Number, 
	PracticeName			AS Practice_Name, 
	'.'						AS First_Name,
	MailingName				AS Last_Name, 
	RTRIM(AddressLine3 + ' ' + AddressLine4) AS Address_Line1, 
	City, 
	Province				AS State, 
	RTRIM(Country)			AS Country,
	RTRIM(PostalCode)		AS Zip,  
	RTRIM(PhoneNo)			AS Phone_Number,
	RTRIM(c.AccountType)	AS Status,
	'S'						AS Bill_Type, 
	RTRIM(f.[FSCName])		AS Field_Level_4_Description,
	RTRIM(Specialty)		AS Specialty_Discription, 
	t.[FSCName]				AS Inside_Sales_Name,
	SalesDivision			AS Sales_Division, 
	BillTo					AS Bill_To, 
	'.'						AS Alert_Comment,
	PracticeType			AS Practice_Type, 
	BillTo					AS Jde_Bill_To, 
	'0'						AS Credit_Limit,
	'0'						AS Priv_Point,
	RTRIM(SegCd)			AS Special_Market_Segment,
	'.'						AS Special_Market_Segment_Description,
	RTRIM(f.[TerritoryCd])	AS Field_Level_4,
	f.Branch				AS Field_Level_3,
	'.'						AS Field_Level_3_Description

FROM
	BRS_Customer AS c

	INNER JOIN BRS_FSC_Rollup AS f 
	ON c.TerritoryCd = f.TerritoryCd 

	INNER JOIN BRS_FSC_Rollup AS t 
	ON c.TsTerritoryCd = t.TerritoryCd 

WHERE
	(c.ShipTo > 0) AND
	(c.SalesDivision = 'AAD') AND 
	(c.Specialty IN('ENDOD', 'ORMS', 'ORTHO', 'PEDO', 'PERIO', 'PROS', 'GENP', 'DSO')) AND
	(f.Branch IN ('LONDN', 'OTTWA', 'TORNT')) AND
	(1=1)
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- SELECT top 10 * FROM eps.Customer where customer_number = 1669334
/*
SET NOCOUNT ON;
SELECT * FROM eps.Customer 
*/
