
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[Salesorder_note]
AS

/******************************************************************************
**	File: 
**	Name: DocType
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
**	Date: 14 Feb 20
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

SELECT
	distinct (ord.[Q3DOCO_salesorder_number])	AS [SalesOrderNumber]
	,ord.[Q3DCTO_order_type]					AS [DocType]
	,ord.QCTRDJ_order_date						AS OrderDate
	,(
		SELECT 
			RTRIM(      LTRIM(SUBSTRING([Q3$PMQ_program_parameter],    1+1, 60))) + 
			RTRIM(' ' + LTRIM(SUBSTRING([Q3$PMQ_program_parameter],   61+1, 60))) +
			RTRIM(' ' + LTRIM(SUBSTRING([Q3$PMQ_program_parameter],  121+1, 60))) +
			RTRIM(' ' + LTRIM(SUBSTRING([Q3$PMQ_program_parameter],  181+1, 60))) +
			RTRIM(' ' + LTRIM(SUBSTRING([Q3$PMQ_program_parameter],  241+1, 60))) +
			RTRIM(' ' + LTRIM(SUBSTRING([Q3$PMQ_program_parameter],  301+1, 60))) +
			RTRIM(' ' + LTRIM(SUBSTRING([Q3$PMQ_program_parameter],  361+1, 60))) +
			RTRIM(' ' + LTRIM(SUBSTRING([Q3$PMQ_program_parameter],  421+1, 60))) +
			RTRIM(' ' + LTRIM(SUBSTRING([Q3$PMQ_program_parameter],  481+1, 60))) AS [text()]
		FROM 
			[Pricing].[order_header_note_F5503] note_line
		WHERE
			ord.[Q3DOCO_salesorder_number] = note_line.[Q3DOCO_salesorder_number] AND
			ord.[Q3INMG_print_message] = note_line.[Q3INMG_print_message]
		Order by 
			[Q3$SNB_sequence_number] ASC
		FOR XML PATH('') 
	) AS OrderMessage_Internal
           
FROM
	[Pricing].[order_header_note_F5503] ord
where
	-- 9898 is external note
	[Q3INMG_print_message] in ('9999', 'FULL80') AND
	(1=1)

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- SELECT top 1000 * FROM Dimension.Salesorder_note where   SalesOrderNumber= 12997658

--  where [Q3DOCO_salesorder_number] = 1181905 or 1178540