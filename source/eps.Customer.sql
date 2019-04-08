
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
--	17 Jan 19	tmc		add Hygine accout to feed
--	26 Mar 19	tmc		extend to Quebec Zone & add EPS
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
	'.'						AS Field_Level_3_Description,
	RTRIM(b.EPS_code)		AS Eps_Code

FROM
	BRS_Customer AS c

	INNER JOIN BRS_FSC_Rollup AS f 
	ON c.TerritoryCd = f.TerritoryCd 

	INNER JOIN BRS_FSC_Rollup AS t 
	ON c.TsTerritoryCd = t.TerritoryCd 

	INNER JOIN [dbo].[BRS_Branch] AS b
	ON f.Branch = b.Branch

WHERE
	(c.ShipTo > 0) AND
	(c.SalesDivision = 'AAD') AND 
	(c.Specialty IN('ENDOD', 'ORMS', 'ORTHO', 'PEDO', 'PERIO', 'PROS', 'GENP', 'DSO', 'HYGEN')) AND
	(f.Branch IN ('LONDN', 'OTTWA', 'TORNT', 'MNTRL', 'QUEBC')) AND
	(1=1)
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- SELECT top 10 * FROM eps.Customer WHERE Field_Level_3_Description = 'EPQUE'
-- SELECT * FROM eps.Customer where Specialty_Discription = 'HYGEN'

-- eps_customer.txt

/*
SET NOCOUNT ON;
SELECT * FROM eps.Customer 
*/
