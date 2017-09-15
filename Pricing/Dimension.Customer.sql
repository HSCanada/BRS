
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[Customer]
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
**	Date: 14 Jun 17
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	14 Sep 17	tmc		Simplified model
**    
*******************************************************************************/

SELECT
	c.ShipTo
	,c.Billto
	,c.PracticeName + ' | ' + CAST(c.ShipTo as char)	AS Customer
	,c2.PracticeName + ' | ' + CAST(c2.BillTo as char)	AS CustomerBillto

	,VPADesc + ' | ' + RTRIM(v.VPA)  	AS SalesPlan
	,RTRIM(v.VPA)  	AS SalesPlanCode
	,VPATypeCd	AS SalesPlanType

	,sroll.FSCName		AS FieldSales
	,b.BranchName		AS Branch

	,fsa.FSA
	,fsa.City
	,fsa.Region
	,fsa.Province
	,fsa.Country
	,Geo_Category	AS Abc_GeoCustomer

	,ISNULL(padj.[SNAST__adjustment_name],'')			AS Adjustment
	,ISNULL(padj.[PJEFTJ_effective_date],'1980-01-01')	AS AdjEffectiveDate
	,ISNULL(padj.[PJEXDJ_expired_date],'1980-01-01')	AS AdjExpiredDate
	,ISNULL(padj.[PJUSER_user_id],'')					AS AdjUserId
	,ISNULL(padj.[EnrollSource],'')						AS AdjEnrollSource
	,ISNULL(padj.[PriceMethod],'')						AS AdjPriceMethod
	
	,spend.Spend_Category		AS Abc_SpendCustomer
	,cgrp.PotentialSpendAmt		AS Spend_PotentialAmt
	,spend.Spend_Display		
	,spend.Spend_Rank
	,spend.Spend_Discount_Rate

	,div.SalesDivisionDesc	AS SalesDivision
	,mcroll.MarketClassDesc	AS MarketClassRollup
	,mclass.MarketClassDesc	AS MarketClass
	,s.SegName				AS Segment
	,s.SpecialtyNm			AS Specialty
	,iif(c.AccountType='D',
		'Closed',
		'Active'
	)						AS Status
	,iif(c.DSO_ParentShipTo > 0, 
		c.DSO_ParentShipTo, 
		c.ShipTo)			AS DCC_TrackingShipTo
	,iif(c.DSO_TrackingCd = 'DSO',
		'Post',
		'Prior'
	)						AS DCC_TrackingCode
	,iif(c.FocusCd='',
		'Non-Focus',
		'Focus'
	)						As Focus
	,c.DateAccountOpened


FROM
	BRS_Customer AS c 

	INNER JOIN BRS_CustomerSpecialty AS s 
	ON c.Specialty = s.Specialty 

	INNER JOIN BRS_SalesDivision AS div 
	ON c.SalesDivision = div.SalesDivision 

	INNER JOIN BRS_CustomerMarketClass AS mclass 
	ON c.MarketClass = mclass.MarketClass 
		AND s.MarketClass = mclass.MarketClass 

	INNER JOIN BRS_CustomerGroup AS cgrp
	ON c.CustGrpWrk = cgrp.CustGrp
	
	INNER JOIN BRS_CustomerMarketClass AS mcroll
	ON mclass.[MarketRollup_L1] = mcroll.MarketClass 

	INNER JOIN BRS_CustomerVPA as v
	ON c.[VPA] = v.[VPA]

	INNER JOIN BRS_FSC_Rollup AS terr
	ON c.TerritoryCd = terr.[TerritoryCd]

	INNER JOIN BRS_Branch AS b 
	ON terr.Branch = b.Branch

	INNER JOIN BRS_FSC_Rollup sroll
	ON terr.FSCRollup = sroll.TerritoryCd

	INNER JOIN BRS_Customer_FSA AS fsa 
	ON c.FSA = fsa.FSA 

	INNER JOIN [dbo].[BRS_CustomerBT] as bt
	ON c.BillTo = bt.BillTo

	INNER JOIN [dbo].[BRS_Customer] as c2
	on bt.ShipToPrimary = c2.ShipTo

	LEFT JOIN [Pricing].[price_adjustment_enroll] AS padj
	ON c.BillTo = padj.BillTo

	CROSS JOIN BRS_Customer_Spend_Category AS spend
WHERE 
	cgrp.PotentialSpendAmt between [Spend_From] and [Spend_To]


GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- SELECT top 10 * FROM Dimension.Customer where  billto = 2613256 order by 1

