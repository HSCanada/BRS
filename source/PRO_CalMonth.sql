
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[PRO_CalMonth]
AS

/******************************************************************************
**	File: 
**	Name: PRO_CalMonth
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
	m.CalMonth, 
	m.MonthSeq, 
	c.PRO_CalMonthLastSeq - m.MonthSeq + 1 AS MonthIndex
FROM         

	BRS_CalMonth AS m 
	CROSS JOIN PRO_Config AS c

WHERE     
	(m.MonthSeq BETWEEN c.PRO_CalMonthFirstSeq AND c.PRO_CalMonthLastSeq)
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT * FROM PRO_CalMonth
