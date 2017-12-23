
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[ItemSupplier]
AS

/******************************************************************************
**	File: 
**	Name: xxx
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
**	Date: 3 Oct 17
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
--	17 Oct 17	tmc		Add class & buygroup to supplier for vendor reporting
**    
*******************************************************************************/

SELECT        
	s.SupplierKey
	,s.Supplier				AS SupplierCode
	,s.supplier_nm			AS SupplierName
	,s.SupplierFamily		AS SupplierFamilyCode
	,sf.buying_group_cd		AS SupplierBuyingGroupCode
	,sf.classificiation_cd	AS SupplierClassificationCode
	,CASE 
		WHEN s.SupplierFamily = ''
		THEN s.supplier_nm
		ELSE sf.supplier_family_nm
	END						AS SupplierFamilyName
	
FROM            
	BRS_ItemSupplier s

	INNER JOIN [dbo].[BRS_ItemSupplierFamily] sf
	ON s.SupplierFamily = sf.SupplierFamily
    

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- SELECT * FROM Dimension.ItemSupplier

-- SELECT count(*) FROM Dimension.ItemSupplier
-- ORG = 5398
