
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW fg.redeem_working_notes
AS

/******************************************************************************
**	File: 
**	Name: fg.redeem_working_notes
**	Desc: show order notes
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
**	Date: 23 Nov 21
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

--
SELECT
	[SalesOrderNumber]
	,[DocType]
	,conf.PriorFiscalMonth as [CalMonthRedeem]
	,[OrderDate]
	,[OrderMessage_Internal] as order_header
FROM
	[Dimension].[Salesorder_note] t

	CROSS JOIN [dbo].[BRS_Config] conf

WHERE
	-- include full order
	EXISTS 
	(
		SELECT * 
		FROM 
			fg.transaction_F5554240 s
			INNER JOIN [fg].[exempt_code] ex
			ON s.fg_exempt_cd = ex.fg_exempt_cd
		WHERE 
			(CalMonthRedeem = (SELECT [PriorFiscalMonth] FROM [dbo].[BRS_Config])) AND
			(t.[SalesOrderNumber] = s.WKDOCO_salesorder_number ) AND
			(ex.show_ind = 1) AND
			-- test
			-- (s.WKDOCO_salesorder_number = 14502711) AND
			(1=1)
	) AND
	(1=1)



GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


SELECT TOP 100 * FROM fg.redeem_working_notes where doctype like 'S%'
--SELECT * FROM fg.redeem_working_notes WHERE SalesOrderNumber = 14502711
