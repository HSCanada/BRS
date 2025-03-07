
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[CustomerHistory]
AS

/******************************************************************************
**	File: [Dimension].[CustomerHistory]
**	Name: Customer History
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
**	Date: 06 Dec 24
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
--	19 Feb 25	tmc		add FSC MasterName (last fiscal) for FSC cur vs hist 
--  06 Mar 25	tmc		add FSC MasterCode to help with analysis
**    
*******************************************************************************/

SELECT
	ch.cust_hist_key
	,ch.ShipTo
	,ch.[FiscalMonth]

	,ch.[HIST_SalesDivision]
	,ch.[HIST_MarketClass]
	,ch.[HIST_SegCd]
	,ch.[HIST_VPA]
	,ch.HIST_TerritoryCd
	,ISNULL(fsc_master_LME.salesperson_nm, '.') AS FSCName
	,ISNULL(fsc_master_LME.master_salesperson_cd, '.') AS FSCMaster
	,terr.Branch


/*
	,RTRIM(v.VPA) + ' | ' + RTRIM(VPADesc)  			AS SalesPlan
	,RTRIM(v.VPA)  										AS SalesPlanCode
	,RTRIM(b.BranchName)								AS Branch
	,RTRIM(div.SalesDivisionDesc)						AS SalesDivision
	,RTRIM(mclass.MarketClassDesc)						AS MarketClass
	,RTRIM(seg.SegName)	+ ' | ' + RTRIM(seg.SegCd)		AS Segment
	-- break out Primary Dental Schools for 2021
	,RTRIM(seg.SegCd)		AS SegmentCode
*/


FROM
	BRS_Customer AS c 

	-- wheel graft on last month results
	INNER JOIN [dbo].[BRS_CustomerFSC_History] ch
	ON c.ShipTo = ch.Shipto AND
		(EXISTS (SELECT * FROM [Dimension].[Period] dd WHERE ch.FiscalMonth = dd.FiscalMonth)) 

	INNER JOIN BRS_FSC_Rollup AS terr
	ON ch.HIST_TerritoryCd = terr.[TerritoryCd]

	-- pull master code so that the FSC names can be rolled up and compared
	LEFT JOIN [comm].[salesperson_master] fsc_master_LME
	ON terr.comm_salesperson_key_id = fsc_master_LME.salesperson_key_id


/*
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

*/

--	CROSS JOIN BRS_Customer_Spend_Category AS spend


WHERE 
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
/*
 SELECT top 10 * from [Dimension].[CustomerHistory]
 SELECT count (*) from [Dimension].[CustomerHistory]
 -- ORG 2 827 395


 SELECT   cust_hist_key, ShipTo, FiscalMonth, HIST_SalesDivision, HIST_MarketClass, HIST_SegCd, HIST_VPA, HIST_TerritoryCd, FSCName, Branch
FROM     Dimension.CustomerHistory
*/


 SELECT   cust_hist_key, ShipTo, FiscalMonth, HIST_SalesDivision, HIST_MarketClass, HIST_SegCd, HIST_VPA, HIST_TerritoryCd, FSCName, Branch, FSCMaster
FROM     Dimension.CustomerHistory where shipto = 1654380