
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
	, STUFF(
		(
		SELECT 
			' ' + RTRIM([Q3$PMQ_program_parameter]) AS [text()]
--			'|' + RTRIM([Q3$SNB_sequence_number]) AS [text()]
		FROM 
			[Integration].[F5503_canned_message_file_parameters_Staging] note_line
		WHERE
			ord.[Q3DOCO_salesorder_number] = note_line.[Q3DOCO_salesorder_number] AND
			ord.[Q3INMG_print_message] = note_line.[Q3INMG_print_message]
		Order by 
			[Q3$SNB_sequence_number] ASC
		FOR XML PATH('') 
		), 1, 1, '' 
	) AS OrderMessage_Internal
           
FROM
	[Integration].[F5503_canned_message_file_parameters_Staging] ord
where
--	[Q3DCTO_order_type] = 'CM' AND
--	[Q3INMG_print_message] = 'BOEMSG046 ' AND
	[Q3INMG_print_message] = '9999' AND
--	[Q3DOCO_salesorder_number] = 1179255
	(1=1)
--order by 2 desc

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- SELECT top 10 * FROM Dimension.Salesorder_note
