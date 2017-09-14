
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[CustomerGroup]
AS

/******************************************************************************
**	File: 
**	Name: CustomerGroup
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
**	10 Jul 17	tmc		updated ABC group
**    
*******************************************************************************/

SELECT
	cgrp.CustGrpKey				AS CustomerGroupKey
	,cgrp.CustGrp				AS CustomerGroup
	,mcroll.MarketClassDesc		AS MarketClassRollup
	,mclass.MarketClassDesc		AS MarketClass
	,spend.Spend_Category		AS Abc_SpendCustomer
	,cgrp.PotentialSpendAmt		AS PotentialSpendAmt
	,spend.Spend_Display
	,spend.Spend_Rank
	,spend.SpendKey
	,spend.Spend_Discount_Rate

FROM
	BRS_CustomerGroup AS cgrp 

	INNER JOIN BRS_CustomerMarketClass AS mclass 
	ON cgrp.MarketClass = mclass.MarketClass 

	INNER JOIN BRS_CustomerMarketClass AS mcroll
	ON mclass.[MarketRollup_L1] = mcroll.MarketClass 


	CROSS JOIN BRS_Customer_Spend_Category AS spend
	where cgrp.PotentialSpendAmt between [Spend_From] and [Spend_To]

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


SELECT top 10 * FROM Dimension.CustomerGroup where CustomerGroupKey = 2637 order by 1
