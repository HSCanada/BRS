
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
--	20 Sep 17	tmc		Fixed Market setment join bug resulting in missing rows
--	07 Dec 17	tmc		add Commission info
--	22 Feb 18	tmc		add ISR info

**    
*******************************************************************************/

SELECT
	c.ShipTo
	,c.Billto
	,c.PracticeName + ' | ' + CAST(c.ShipTo as char)	AS Customer

	,CASE 
		WHEN c.CustGrpWrk	<> '' 
		THEN c.CustGrpWrk
		ELSE 'BT_' + CAST(c.Billto as char) 
	END													AS CustomerGroup
	,VPADesc + ' | ' + RTRIM(v.VPA)  					AS SalesPlan
	,RTRIM(v.VPA)  										AS SalesPlanCode
	,CASE
		WHEN ISNULL(padj.[EnrollSource],'') = ''
		THEN [VPATypeCd]
		ELSE padj.[EnrollSource]
	END													AS SalesPlanType
	,sroll.FSCName										AS FieldSales
	,b.BranchName										AS Branch
	,fsa.FSA
	,fsa.City
	,fsa.Region
	,fsa.Province
	,fsa.Country
	,Geo_Category										AS Abc_GeoCustomer
	,c.PhoneNo											AS PhoneNumber

	,ISNULL(padj.[SNAST__adjustment_name],'')			AS Adjustment
	,ISNULL(padj.[PJEFTJ_effective_date],'1980-01-01')	AS AdjEffectiveDate
	,ISNULL(padj.[PJEXDJ_expired_date],'1980-01-01')	AS AdjExpiredDate
	,ISNULL(padj.[PJUSER_user_id],'')					AS AdjUserId
	,ISNULL(padj.[EnrollSource],'')						AS AdjEnrollSource
	,ISNULL(padj.[PriceMethod],'')						AS AdjPriceMethod
	
	,spend.Spend_Category								AS Abc_SpendCustomer
	,cgrp.PotentialSpendAmt								AS Spend_PotentialAmt
	,spend.Spend_Display		
	,spend.Spend_Rank
	,spend.Spend_Discount_Rate

	,div.SalesDivisionDesc								AS SalesDivision
	,mcroll.MarketClassDesc								AS MarketClassRollup
	,mclass.MarketClassDesc								AS MarketClass
	,s.SegName											AS Segment
	,s.SpecialtyNm + ' | ' + s.Specialty				AS Specialty
	,iif(c.AccountType='D',
		'Closed',
		'Active'
	)													AS CustomerStatus
	,iif(c.DSO_ParentShipTo > 0, 
		c.DSO_ParentShipTo, 
		c.ShipTo)										AS DCC_TrackingShipTo
	,iif(c.DSO_TrackingCd = 'DSO',
		'Post',
		'Prior'
	)													AS DCC_TrackingCode
	,iif(c.FocusCd='',
		'Non-Focus',
		'Focus'
	)													As Focus
	,CAST(c.DateAccountOpened AS date)					AS DateAccountOpened

	,(div.SalesDivision)								AS SalesDivisionCode
	,(b.Branch)											AS BranchCode
	,mclass.MarketClass									AS MarketClassCode

	,c.[comm_status_cd]									AS CommStatusCode
	,c.[comm_note_txt]									AS CommStatusNote

---
	,terr.TerritoryCd		AS FscTerritoryCd
	,terr.FSCStatusCode		AS FscStatusCode

	,isr.TerritoryCd		AS IsrTerritoryCd
	,isr.FSCName			AS IsrName
	,isr.FSCStatusCode		AS IsrStatusCode

	,ISNULL(isr_emp.[EmployeeKey], 1) AS IsrEmployeeKey
	,ISNULL(isr_emp.LoginId, '') AS IsrLoginId

-----------------------------------------
--			|	TS		|	No
-----------------------------------------
--	FSC		|	Shared	|	Field
-----------------------------------------
--	House	|	Tele	|	Unassasigned
-----------------------------------------

	,CASE WHEN terr.FSCStatusCode LIKE 'F%' 
		THEN 
			CASE WHEN isr.FSCStatusCode LIKE 'T%' 
				THEN 'Shared FSCs & TS'  
				ELSE 'Field Only' 
			END 
		ELSE 
			CASE WHEN isr.FSCStatusCode LIKE 'T%' 
				THEN 'Telesales Only'  
				ELSE 'Unassigned' 
			END 
	END AS SalesChannel

	-- Closed -> Special Market -> Focus -> Default
	,CASE WHEN c.AccountType ='D' 
		THEN 'CLS'
		ELSE
			CASE WHEN mcroll.MarketRollup_L1 like 'SP%'
				THEN 'SPC'
				ELSE CASE WHEN c.FocusCd = '' THEN 'AAA' ELSE c.FocusCd End
			END
	END AS FocusCd



FROM
	BRS_Customer AS c 

	INNER JOIN BRS_CustomerSpecialty AS s 
	ON c.Specialty = s.Specialty 

	INNER JOIN BRS_SalesDivision AS div 
	ON c.SalesDivision = div.SalesDivision 

	INNER JOIN BRS_CustomerMarketClass AS mclass 
	ON c.MarketClass = mclass.MarketClass 

	INNER JOIN BRS_CustomerGroup AS cgrp
	ON c.CustGrpWrk = cgrp.CustGrp
	
	INNER JOIN BRS_CustomerMarketClass AS mcroll
	ON mclass.[MarketRollup_L3] = mcroll.MarketClass 

	INNER JOIN BRS_CustomerVPA as v
	ON c.[VPA] = v.[VPA]


	INNER JOIN BRS_FSC_Rollup AS terr
	ON c.TerritoryCd = terr.[TerritoryCd]

	INNER JOIN BRS_FSC_Rollup AS isr
	ON c.TsTerritoryCd = isr.TerritoryCd

	LEFT JOIN [dbo].[BRS_Employee] isr_emp
	ON isr.[FSCRollup] = isr_emp.[IsrRollupCd]

	INNER JOIN BRS_Branch AS b 
	ON terr.Branch = b.Branch

	INNER JOIN BRS_FSC_Rollup sroll
	ON terr.FSCRollup = sroll.TerritoryCd


	INNER JOIN BRS_Customer_FSA AS fsa 
	ON c.FSA = fsa.FSA 

	INNER JOIN [dbo].[BRS_CustomerBT] as bt
	ON c.BillTo = bt.BillTo

	-- de-dup enroll (due to contract + special price enroll)
	LEFT JOIN 
	(
		SELECT 
			*
		FROM            
			[Pricing].[price_adjustment_enroll] AS s
		WHERE EXISTS 
		(
			SELECT MIN(s2.ID) AS id_unique 
			FROM [Pricing].[price_adjustment_enroll] s2
			GROUP BY s2.BillTo
			HAVING s.[ID] = MIN(s2.ID)
		)
	)  padj
	ON c.BillTo = padj.BillTo

	CROSS JOIN BRS_Customer_Spend_Category AS spend


WHERE 
 	(cgrp.PotentialSpendAmt BETWEEN [Spend_From] and [Spend_To]) AND
--	test
--	c.Billto = 1527764 AND
	(1=1)


GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- SELECT top 10 * FROM Dimension.Customer where  billto = 2613256 order by 1

-- integrity check
-- SELECT * from BRS_Customer where not exists (SELECT * FROM Dimension.Customer where  ShipTo = BRS_Customer.[ShipTo])

-- dup check
/*
SELECT        BillTo, COUNT(*) AS Expr1
FROM            Pricing.price_adjustment_enroll
GROUP BY BillTo
HAVING        (COUNT(*) > 1)
*/

-- Select top 10 * from [Dimension].[Customer]
-- Select count(*) from [Dimension].[Customer]