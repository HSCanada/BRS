
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW nes.order_note
AS

/******************************************************************************
**	File: 
**	Name: nes.order_note
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
**	Date: 26 Nov 21
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

-- this needs work.  figure out header vs line vs duplicate workorder / missing and doctype

SELECT
	distinct (ord.[Q3DOCO_salesorder_number])	AS [SalesOrderNumber]
	,ord.[Q3DCTO_order_type]					AS [DocType]
	,convert(date, ord.QCTRDJ_order_date, 103)		AS OrderDate
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
			nes.order_note_D1ICMTPF note_line
		WHERE
			ord.[ICMOWO_work_order_number]  = note_line.[ICMOWO_work_order_number]  AND
			ord.[Q3INMG_print_message] = note_line.[Q3INMG_print_message]
		Order by 
			[ICMSEQ_comments_sequence] ASC
		FOR XML PATH('') 
	) AS OrderMessage_Internal
           
FROM
	nes.order_note_D1ICMTPF ord
where
	-- 9898 is external note
	[ICMTYP2_header_detail] = 'H') AND
--	[Q3INMG_print_message] in ('9898') AND
	(1=1)

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT distinct [Q3INMG_print_message] FROM [Pricing].[order_header_note_F5503] 
-- SELECT top 1000 * FROM Dimension.Salesorder_note where DocType like 'S%' order by 3 desc 


