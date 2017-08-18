
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
-- 18 Aug 17	tmc		Added Family seto for Supplier Tabular project
**    
*******************************************************************************/

SELECT        
	s.SupplierKey,
	s.supplier_nm			AS Supplier,
	s.Supplier_Category		AS Abc_SupplierItem,
	sf.supplier_family_nm	AS SupplierFamily,
	sf.buying_group_cd		AS BuyingGroup,
	sf.classificiation_cd	AS VendorClassification,
	s.Supplier				AS SupplierCode
FROM            
	BRS_ItemSupplier AS s 

	INNER JOIN BRS_ItemSupplierFamily AS sf 
	ON s.SupplierFamily = sf.SupplierFamily
						 
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- SELECT top 10 * FROM Dimension.Supplier order by 1
