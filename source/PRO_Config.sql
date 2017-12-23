
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[PRO_Config]
AS

/******************************************************************************
**	File: 
**	Name: PRO_Config
**	Desc: 
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
**	Date: 16 Feb 16
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/


SELECT     

	c.id, 
	c.PriorCalMonth AS PRO_CalMonthLast, 
	m.MonthSeq AS PRO_CalMonthLastSeq, 
	m.MonthSeq - c.PRO_HistoryMonths + 1 AS PRO_CalMonthFirstSeq, 
	c.PRO_HistoryMonths, m.BeginDt AS PRO_CalMonthLastDt, 
	CASE PRO_PROMO.SALESDIVISION WHEN 'AAD' THEN PRO_DentalFactor WHEN 'AAL' THEN PRO_ZahnFactor WHEN 'AAM' THEN PRO_MedicalFactor ELSE 0 END AS PRO_SeasonalAdjustFactor, 
	dbo.PRO_Promo.SalesDivision AS PRO_SalesDivision, 
	c.PRO_PromoCode

FROM         

	dbo.BRS_Config AS c 

	INNER JOIN dbo.BRS_CalMonth AS m 
	ON c.PriorCalMonth = m.CalMonth 

	INNER JOIN dbo.PRO_Promo 
	ON c.PRO_PromoCode = dbo.PRO_Promo.PromoCode

GO


SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT * FROM PRO_Config
