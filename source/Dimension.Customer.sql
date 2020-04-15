
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
--	20 Mar 18	tmc		add goals and spend
--	28 Sep 18	tmc		add data to support Business Review model
--	17 Oct 18	tmc		cosmetic change on VPA
--	19 Oct 18	tmc		add Privileges code
--	23 Oct 18	tmc		reactiveate ISR
--	13 Nov 18	tmc		replace focus with focusCode
--	15 Nov 18	tmc		add Credit Limit
--  07 Dec 18	tmc		add Business Review items
--	16 Jan 18	tmc		add coupa start date for SM project
--	27 Feb 20	tmc		add additional flags for Private Label analysis
--	24 Mar 20	tmc		add sm focus flag
--	15 Apr 20	tmc		fix spend range bug using category to specify
**    
*******************************************************************************/

SELECT
	c.ShipTo
	,c.Billto
	,c.PracticeName + ' | ' + RTRIM(CAST(c.ShipTo as char))	AS Customer

	,CASE 
		WHEN c.CustGrpWrk	<> '' 
		THEN RTRIM(c.CustGrpWrk)
		ELSE 'BT_' + RTRIM(CAST(c.Billto as char))
	END													AS CustomerGroup
	,RTRIM(v.VPA) + ' | ' + RTRIM(VPADesc)  			AS SalesPlan
	,RTRIM(v.VPA)  										AS SalesPlanCode
	,CASE
		WHEN ISNULL(padj.[EnrollSource],'') = ''
		THEN RTRIM([VPATypeCd])
		ELSE RTRIM(padj.[EnrollSource])
	END													AS SalesPlanType
	,RTRIM(sroll.FSCName)								AS FieldSales
	,RTRIM(b.BranchName)								AS Branch
	,RTRIM(fsa.FSA)										AS FSA
	,RTRIM(fsa.City)									AS City
	,RTRIM(fsa.Region)									AS Region
	,RTRIM(fsa.Province)								AS Province
	,RTRIM(fsa.Country)									AS Country
	,RTRIM(Geo_Category)								AS Abc_GeoCustomer
	,RTRIM(c.PhoneNo)									AS PhoneNumber

	,RTRIM(ISNULL(padj.[SNAST__adjustment_name],''))			AS Adjustment
	,RTRIM(ISNULL(padj.[PJEFTJ_effective_date],'1980-01-01'))	AS AdjEffectiveDate
	,RTRIM(ISNULL(padj.[PJEXDJ_expired_date],'1980-01-01'))		AS AdjExpiredDate
	,RTRIM(ISNULL(padj.[PJUSER_user_id],''))					AS AdjUserId
	,RTRIM(ISNULL(padj.[EnrollSource],''))						AS AdjEnrollSource
	,RTRIM(ISNULL(padj.[PriceMethod],''))						AS AdjPriceMethod
	
	,RTRIM(spend.Spend_Category)						AS Abc_SpendCustomer
	,cgrp.PotentialSpendAmt								AS Spend_PotentialAmt
	,RTRIM(spend.Spend_Display)							AS Spend_Display
	,spend.Spend_Rank
	,spend.Spend_Discount_Rate

	,RTRIM(div.SalesDivisionDesc)						AS SalesDivision
	,RTRIM(mcroll.MarketClassDesc)						AS MarketClassRollup
	,RTRIM(mclass.MarketClassDesc)						AS MarketClass
	,RTRIM(s.SegName)									AS Segment
	,s.SpecialtyNm + ' | ' + RTRIM(s.Specialty)			AS Specialty
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
	,CAST(c.DateAccountOpened AS date)					AS DateAccountOpened

	,RTRIM(div.SalesDivision)							AS SalesDivisionCode
	,RTRIM(b.Branch)									AS BranchCode
	,RTRIM(mclass.MarketClass)							AS MarketClassCode

	,RTRIM(c.[comm_status_cd])							AS CommStatusCode
	,RTRIM(c.[comm_note_txt])							AS CommStatusNote

---
	,RTRIM(terr.TerritoryCd)							AS FscTerritoryCd
	,RTRIM(terr.FSCStatusCode)							AS FscStatusCode

	,RTRIM(isr.TerritoryCd)								AS IsrTerritoryCd
	,RTRIM(isr.FSCName)									AS IsrName
	,RTRIM(isr.FSCStatusCode)							AS IsrStatusCode

	-- Closed -> Special Market -> Focus -> Default
	,CASE WHEN c.AccountType ='D' 
		THEN 'CLS'
		ELSE
			CASE WHEN mcroll.MarketRollup_L1 like 'SP%'
				THEN 'SPC'
				ELSE CASE WHEN c.FocusCd = '' THEN 'AAA' ELSE RTRIM(c.FocusCd) End
			END
	END AS FocusCd


	,[DSO_ParentShipTo]
	,[PrivilegesCode]


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

	,c.isr_target_amt			AS TargetAmount
	,c.potential_spend_amt		As PotentialSpendAmount
	,bt.CreditLimit
	,(bt.ReviewTrackingInd | v.ReviewTrackingInd) AS ReviewTrackingInd

	,terr_ess.FSCName			AS ESTName
	,priv.pma_ind
	,coupa_start_date			AS CoupaStartDate
	,v.FocusCd					AS SalesplanFocusCode

	,CASE 
		WHEN s.PrivateLabelScopeInd = 1 AND 
			mclass.PrivateLabelScopeInd = 1 AND 
			c.SalesDivision = 'AAD'
		THEN
			'Include_Cust'
		ELSE
			'Exclude_Cust'
	END							AS PrivateLabelScope_Cust
	,c.sm_focus_code			AS SmFocusCode


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

	INNER JOIN BRS_FSC_Rollup AS terr_ess
	ON c.est_code = terr_ess.[TerritoryCd]

	INNER JOIN [nes].[privileges] AS priv
	ON c.PrivilegesCode = priv.privileges_code


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
	(spend.Spend_Category = 'S') AND
--	test
--	c.Billto = 1527764 AND
	(1=1)


GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

print 'integrity checks (s/b 0):'

print '1. missing customer?'
SELECT * from BRS_Customer where not exists (SELECT * FROM Dimension.Customer where  ShipTo = BRS_Customer.[ShipTo])

print '2. dup check?'
SELECT        ShipTo, COUNT(*) AS Expr1 FROM  Dimension.Customer GROUP BY ShipTo HAVING (COUNT(*) > 1)


/*
SELECT        BillTo, COUNT(*) AS Expr1
FROM            Pricing.price_adjustment_enroll
GROUP BY BillTo
HAVING        (COUNT(*) > 1)
*/

