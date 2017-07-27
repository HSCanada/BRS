
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[Supplier]
AS

/******************************************************************************
**	File: 
**	Name: Supplier
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
	SupplierKey,
	supplier_nm AS Supplier,
	Supplier_Category AS Abc_SupplierItem
FROM
	dbo.BRS_ItemSupplier

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


SELECT top 10 * FROM Dimension.Supplier order by 1
