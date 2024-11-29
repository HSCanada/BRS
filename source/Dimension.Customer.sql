
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
--	20 Apr 20	tmc		remove spend logic -- buggy, replace with DAX
--	22 Apr 20	tmc		set unassigned group to "other" for better rollups
--						fix segment name, based on seg not specialty rollup
--	15 Dec 20	tmc		Add new 2021 MarketClass logic
--	17 Mar 21	tmc		Add MarketClassNew to help with Commission mapping
--	09 Jul 21	tmc		Add Wheel data (prior month to current)
--	21 Jul 21	tmc		Add CommMasterCode & ServiceBonus exempt for playbook
--	09 Aug 21	tmc		Add Account Create date for Playbook drop-off filter
--	17 Aug 21	tmc		Roll A25k code into AAA for ISR
--	14 Oct 21	tmc		add freight ind for commission modelling
--	19 Oct 21	tmc		break wheel active into 2 parts for more flex analysis
--	08 Apr 22	tmc		add DSO operatory count and 3 full text adhoc fields
--	10 May 22	tmc		map FieldSales name to commission master for rollup
--	15 Sep 23	tmc		add new segment map
--	04 Jan 24	tmc		add HSBC to model
--	08 Aug 24	tmc		add Commission Branch, and Plan for leaderboards
--	19 Nov 24	tmc		add segment new for modelling
**    
*******************************************************************************/

SELECT
	c.ShipTo
	,c.Billto
	,c.PracticeName + ' | ' + RTRIM(CAST(c.ShipTo as char))	AS Customer

	,CASE 
		WHEN c.CustGrpWrk	<> '' 
		THEN RTRIM(c.CustGrpWrk)
		ELSE 'Other' 
	END													AS CustomerGroup
	,RTRIM(v.VPA) + ' | ' + RTRIM(VPADesc)  			AS SalesPlan
	,RTRIM(v.VPA)  										AS SalesPlanCode
	,CASE
		WHEN ISNULL(padj.[EnrollSource],'') = ''
		THEN RTRIM([VPATypeCd])
		ELSE RTRIM(padj.[EnrollSource])
	END													AS SalesPlanType
	,RTRIM(fsc_master.salesperson_nm)					AS FieldSales
--	,RTRIM(sroll.FSCName)								AS FieldSales
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

/*	
	,RTRIM(spend.Spend_Category)						AS Abc_SpendCustomer
	,cgrp.PotentialSpendAmt								AS Spend_PotentialAmt
	,RTRIM(spend.Spend_Display)							AS Spend_Display
	,spend.Spend_Rank
	,spend.Spend_Discount_Rate
*/
	,RTRIM(div.SalesDivisionDesc)						AS SalesDivision
	,RTRIM(mcroll.MarketClassDesc)						AS MarketClassRollup
	,RTRIM(mclass.MarketClassDesc)						AS MarketClass
	,RTRIM(seg.SegName)	+ ' | ' + RTRIM(seg.SegCd)		AS Segment

	-- break out Primary Dental Schools for 2021
	,RTRIM(seg.SegCd)		AS SegmentCode
	,CASE 
		WHEN seg.SegCd = 'PDS' 
		THEN 'DENSCH'
		ELSE mclass.MarketClass
	END 												AS MarketClass2021Code


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
				ELSE CASE WHEN c.FocusCd in ('','A25K') THEN 'AAA' ELSE RTRIM(c.FocusCd) End
			END
	END AS FocusCd
	,c.FocusCd											AS playbook_focus_code

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

	-- deprecated code
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
	,[Est12MoMerch]
	,RTRIM(c.MarketClass_New)							AS MarketClassNewCode

	-- wheel graft on last month results
	,CASE 
		WHEN wheel_thresh1_sales_ind = 1 AND wheel_thresh2_recent_order_ind = 1 
		THEN 1 
		ELSE 0 
	END													AS wheel_active_ind
	,ISNULL(wheel_thresh1_sales_ind, 0)					AS wheel_thresh1_sales_ind
	,ISNULL(wheel_thresh2_recent_order_ind, 0)			AS wheel_thresh2_recent_order_ind

	,ISNULL([wheel_seg1_merchandise_ind], 0)			AS wheel_seg1_merchandise_ind
	,ISNULL([wheel_seg2_hs_branded_ind], 0)				AS wheel_seg2_hs_branded_ind
	,ISNULL([wheel_seg3_equip_hitech_ind], 0)			AS wheel_seg3_equip_hitech_ind
	,ISNULL([wheel_seg4_digital_restoration_ind], 0)	AS wheel_seg4_digital_restoration_ind
	,ISNULL([wheel_seg5_henry_schein_one_ind], 0)		AS wheel_seg5_henry_schein_one_ind
	,ISNULL([wheel_seg6_equipment_services_ind], 0)		AS wheel_seg6_equipment_services_ind
	,ISNULL([wheel_seg7_business_solutions_ind], 0)		AS wheel_seg7_business_solutions_ind

	,[master_salesperson_cd]							AS CommMasterCode_FSC_Current
	,ISNULL(comm_fsc_bonus_2_ind,0)						AS service_bonus_include_ind
	,c.CreateDate
	,c.adhoc_model_code
	,CASE WHEN c.ApplyFreightInd = 'Y' THEN 1 ELSE 0 END			As ApplyFreightInd
	,CASE WHEN c.ApplySmallOrderChargesInd = 'Y' THEN 1 ELSE 0 END	As ApplySmallOrderChargesInd
	,c.adhoc_model_code2

	,c.adhoc_model_1_text
	,c.adhoc_model_2_text
	,c.adhoc_model_3_text

	,fsc_master.[adhoc_model_1_text] AS CommMasterCode_adhoc_model_1_text
	,fsc_master.[adhoc_model_1_text] AS CommMasterCode_adhoc_model_2_text
	,fsc_master.[adhoc_model_1_text] AS CommMasterCode_adhoc_model_3_text

	,RTRIM(seg_new.[SegCd_map])		AS SegmentCodeNEW
	,eps_roll.FSCName eps_branch

	,RTRIM(fsc_master.comm_plan_id)					AS FieldSalesCommPlan
	,RTRIM(fsc_master_branch.BranchName)			AS FieldSalesBranchName

	,RTRIM(seg_new.SegName)	+ ' | ' + RTRIM(seg_new.SegCd)		AS SegmentNew



FROM
	BRS_Customer AS c 

	INNER JOIN BRS_CustomerSpecialty AS s 
	ON c.Specialty = s.Specialty 

	INNER JOIN [dbo].[BRS_CustomerSegment] AS seg
	ON c.[SegCd] = seg.[SegCd]

	INNER JOIN [dbo].[BRS_CustomerSegment] AS seg_new
	ON c.[SegCd_New] = seg_new.[SegCd]

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

	INNER JOIN [comm].[salesperson_master] fsc_master
	ON terr.comm_salesperson_key_id = fsc_master.salesperson_key_id

	INNER JOIN BRS_FSC_Rollup fsc_master_terr
	ON fsc_master.master_salesperson_cd = fsc_master_terr.TerritoryCd

	INNER JOIN BRS_Branch AS fsc_master_branch
	ON fsc_master_terr.Branch = fsc_master_branch.Branch
	
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

	--
	INNER JOIN BRS_FSC_Rollup eps_roll
	ON b.EPS_code = eps_roll.TerritoryCd

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

	-- wheel graft on last month results
	LEFT JOIN 
	(
		SELECT [Shipto]
		  --,[wheel_active_ind]
		  ,wheel_thresh1_sales_ind
		  ,wheel_thresh2_recent_order_ind

		  ,[wheel_seg1_merchandise_ind]
		  ,[wheel_seg2_hs_branded_ind]
		  ,[wheel_seg3_equip_hitech_ind]
		  ,[wheel_seg4_digital_restoration_ind]
		  ,[wheel_seg5_henry_schein_one_ind]
		  ,[wheel_seg6_equipment_services_ind]
		  ,[wheel_seg7_business_solutions_ind]
	  FROM [dbo].[BRS_CustomerFSC_History]
	  WHERE FiscalMonth = (SELECT [PriorFiscalMonth] FROM [dbo].[BRS_Config])
	) cwheel
	ON c.ShipTo = cwheel.Shipto


--	CROSS JOIN BRS_Customer_Spend_Category AS spend


WHERE 
-- 	(cgrp.PotentialSpendAmt BETWEEN [Spend_From] and [Spend_To]) AND
--	(spend.Spend_Category = 'S') AND
--	test
--	c.Billto = 1527764 AND
	(1=1)


GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/*
print 'integrity checks (s/b 0):'

print '1. missing customer?'
SELECT * from BRS_Customer where not exists (SELECT * FROM Dimension.Customer where  ShipTo = BRS_Customer.[ShipTo])

print '2. dup check?'
SELECT        ShipTo, COUNT(*) AS Expr1 FROM  Dimension.Customer GROUP BY ShipTo HAVING (COUNT(*) > 1)

SELECT * from Dimension.Customer where wheel_service_include_ind is null

SELECT * from Dimension.Customer where CommMasterCode_Current is null 
*/

-- test details
-- SELECT  top 10 * FROM Dimension.Customer where [wheel_active_ind] = 0 and wheel_thresh1_sales_ind = 1

-- SELECT  count(*) FROM Dimension.Customer
-- ORG= 134509

-- test
-- SELECT  distinct FocusCd FROM Dimension.Customer

-- SELECT  * FROM Dimension.Customer where ShipTo = 1667465
 --SELECT  * FROM Dimension.Customer where FscTerritoryCd = 'CZ1LG'
