
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[BRS_TS_Customer]
AS

/******************************************************************************
**	File: 
**	Name: BRS_TS_Customer
**	Desc:  
**
**              
**	Return values: 
**
**	Called by:   
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**
**	Auth: tmc
**	Date: 11 Oct 16
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
--  8 Nov 16	tmc		Standardised Channel, Branch, and Focus fields
-- 16 Nov 16	tmc		replace Sales Division code with description
-- 17 Nov 16	tmc	    Updated Sales Channel wording based on feedback
-- 03 Jan 18	tmc		sunset BRS_TS_Rollup
-- 31 Aug 21	tmc		Roll A25k code into AAA for ISR

**    
*******************************************************************************/

SELECT     
	c.ShipTo, 
	c.BillTo, 
	c.DSO_ParentShipTo, 
	c.PracticeName, 
	CASE 
		WHEN c.AccountType = 'D' 
		THEN 'D' 
		ELSE 'A' 
	END					AS AccountType, 
	d.SalesDivisionDesc AS SalesDivision, 
	c.VPA, 
	CASE 
		WHEN c.CustGrpWrk = '' 
		THEN 'Other' 
		ELSE c.CustGrpWrk 
	END					AS CustomerGroup, 
	c.MarketClass, 
	c.SegCd, 
	c.Specialty, 
	CONVERT(INT, LEFT(CONVERT(varchar, 
		(c.DateAccountOpened), 112), 6)) AS DateAccountOpenedFiscalMonth, 

	b.BranchName		AS Branch,

	f.TerritoryCd		AS FscTerritoryCd, 
	f.FSCName			AS FscName, 
	f.FSCStatusCode		AS FscStatusCode,
	-- sunset
	''					AS FscShareType,

	t.TerritoryCd		AS TsTerritoryCd, 
	t.FSCName			AS TsName, 
	t.FSCStatusCode		AS TsStatusCode,

-----------------------------------------
--			|	TS		|	No
-----------------------------------------
--	FSC		|	Shared	|	Field
-----------------------------------------
--	House	|	Tele	|	Unassasigned
-----------------------------------------

	CASE WHEN f.FSCStatusCode LIKE 'F%' 
		THEN 
			CASE WHEN t.FSCStatusCode LIKE 'T%' 
				THEN 'Shared FSCs & TS'  
				ELSE 'Field Only' 
			END 
		ELSE 
			CASE WHEN t.FSCStatusCode LIKE 'T%' 
				THEN 'Telesales Only'  
				ELSE 'Unassigned' 
			END 
	END AS SalesChannel,

	-- Closed -> Special Market -> Focus -> Default
	CASE WHEN c.AccountType ='D' 
		THEN 'CLS'
			
		ELSE
			CASE WHEN MarketRollup_L1 like 'SP%'
				THEN 'SPC'
				ELSE CASE WHEN c.FocusCd in ('','A25K') THEN 'AAA' ELSE RTRIM(c.FocusCd) End
--				ELSE CASE WHEN c.FocusCd = '' THEN 'AAA' ELSE c.FocusCd End
			END
	END AS FocusCd


FROM         

	BRS_Customer AS c 

	INNER JOIN BRS_FSC_Rollup AS f 
	ON c.TerritoryCd = f.TerritoryCd

	INNER JOIN BRS_FSC_Rollup AS t
	ON c.TsTerritoryCd = t.TerritoryCd

	INNER JOIN BRS_Branch AS b 
	ON f.Branch = b.Branch

	INNER JOIN BRS_CustomerMarketClass AS m
	ON c.MarketClass = m.MarketClass

	INNER JOIN BRS_SalesDivision AS d
	ON c.SalesDivision = d.SalesDivision
	
WHERE     
	(1=1)

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT top 10 * FROM BRS_TS_Customer 

-- SELECT distinct TsName FROM BRS_TS_Customer 
-- SELECT distinct FocusCd FROM BRS_TS_Customer 


-- SELECT * FROM BRS_TS_Customer WHERE VPA = 'DENCORP'

-- SELECT * FROM BRS_TS_Customer WHERE MarketRollup_L1 like 'SP%' and FocusCd <>''

-- SELECT * FROM BRS_TS_Customer WHERE AccountType ='D' and FocusCd <>''

