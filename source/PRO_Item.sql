
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[PRO_Item]
AS

/******************************************************************************
**	File: 
**	Name: PRO_Item
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

	i.Item, 
	i.FamilySetLeader, 
	i.ItemDescription, 
	i.Supplier, 
	i.MajorProductClass, 
	i.SalesCategory, 
	i.Label, 
	i.ItemStatus, 
	i.StockingType, 
	i.ItemCreationDate, 
	i.CurrentFileCost, 
	i.CurrentCorporatePrice, 
	DATEDIFF(m, i.ItemCreationDate, c.PRO_CalMonthLastDt) AS ItemCreationMonths, 
	ISNULL(mpc.CategoryManager, N'""') AS CategorySpecialist

FROM         

	dbo.BRS_Item AS i 

	LEFT OUTER JOIN dbo.BRS_ItemMPC mpc
	ON i.MajorProductClass = mpc.MajorProductClass 

	CROSS JOIN dbo.PRO_Config c

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT * FROM PRO_Item
