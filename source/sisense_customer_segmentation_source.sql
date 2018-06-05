
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER VIEW [sisense].[customer_segmentation_source]
AS

/******************************************************************************
**	File: 
**	Name: sisense_customer_segmentation_source
**	Desc: provide customer segmentation source for dashboard.  
**
**              
**	Return values:  @@Error
**
**	Called by:   
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**
**	Auth: tmc
**	Date: 21 Jul 17
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

SELECT        
	c.ShipTo
	,c.Specialty AS specialty_code
	,s.SpecialtyNm AS specialty_name
	,c.SegCd AS segment_code
	,s.SegName AS segment_name
	,c.MarketClass AS market_class_code
	,m.MarketClassDesc AS market_class_name

FROM            
	dbo.BRS_Customer AS c 

	INNER JOIN dbo.BRS_CustomerSpecialty AS s 
	ON c.Specialty = s.Specialty 

	INNER JOIN dbo.BRS_CustomerMarketClass AS m 
	ON c.MarketClass = m.MarketClass 
--		AND s.MarketClass = m.MarketClass
WHERE        
	(c.ShipTo > 0) AND 
	(c.SegCd <> 'ZZ-EXCLUDE')

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT top 10 * FROM sisense.customer_segmentation_source 

-- SELECT top 10 * FROM sisense.customer_segmentation_source where ShipTo = 3035775

-- SELECT distinct market_class_code FROM sisense.customer_segmentation_source 






