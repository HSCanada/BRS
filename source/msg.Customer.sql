
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [msg].[Customer]
AS

/******************************************************************************
**	File: 
**	Name: Customer
**	Desc:  based on dimension.customer
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
**	Date: 28 Jul 21
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

SELECT
	c.ShipTo											AS CUST_NUMBER
	,RTRIM(c.PracticeName)								AS PRACTICENAME
	,c.CustGrpWrk										AS Parent_Account
	,RTRIM(c.PhoneNo)									AS PhoneNumber
	,c.AddressLine3
	,c.AddressLine4
	,c.City
	,c.Province
	,c.PostalCode
	,iif(c.AccountType='D',
		'Closed',
		'Active'
	)													AS Account_Status
	,SpecialtyNm										AS Specialty
	,'Shipt To'											AS Type
	,b.ZoneName											AS Account_Owner_Region_Name
	,RTRIM(b.BranchName)								AS FIELD_LEVEL3

	,RTRIM(div.SalesDivisionDesc)						AS SALESDIVISION
	,'.'												AS MARKET_SEGMENT
	,c.PracticeType										AS Practice_Type

	,RTRIM(fsc_master.salesperson_nm)					AS FIELD_LEVEL4
	,'.'												AS Owner_Manager
	,RTRIM(terr.TerritoryCd)							AS FIELD_LEVEL4_CODE
	,'CA'												AS Shipping_Country

	,RTRIM(b.Branch)									AS FIELD_LEVEL3_CODE
--

	,RTRIM(div.SalesDivision)							AS SALES_DIVISION_ID

	,RTRIM(mclass.MarketClassDesc)						AS MarketClass
	,RTRIM(mclass.MarketClass)							AS MARKET_CLASS

	,CAST(c.DateAccountOpened AS date)					AS DateAccountOpened

---
	,RTRIM(isr.TerritoryCd)								AS IsrTerritoryCd
	,RTRIM(isr.FSCName)									AS IsrName

	,[master_salesperson_cd]							AS CommMasterCode_FSC_Current


FROM
	BRS_Customer AS c 

	INNER JOIN BRS_FSC_Rollup AS terr
	ON c.TerritoryCd = terr.[TerritoryCd]

	INNER JOIN BRS_Branch AS b 
	ON terr.Branch = b.Branch

	INNER JOIN BRS_SalesDivision AS div 
	ON c.SalesDivision = div.SalesDivision 

	INNER JOIN BRS_CustomerMarketClass AS mclass 
	ON c.MarketClass = mclass.MarketClass 

	INNER JOIN [comm].[salesperson_master] fsc_master
	ON terr.comm_salesperson_key_id = fsc_master.salesperson_key_id
	
	INNER JOIN BRS_FSC_Rollup AS isr
	ON c.TsTerritoryCd = isr.TerritoryCd

	INNER JOIN BRS_CustomerSpecialty AS s 
	ON c.Specialty = s.Specialty 

WHERE 
	(c.SalesDivision in ('AAD', 'AAL', 'AAV')) AND
	(c.ShipTo > 0) AND
	(1=1)


GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- test details
-- SELECT  top 10 * FROM msg.Customer 
-- SELECT * FROM msg.Customer order by FIELD_LEVEL4, FIELD_LEVEL4_code

-- export
-- camsg_Customer_20210806.txt
-- SELECT * FROM msg.Customer

