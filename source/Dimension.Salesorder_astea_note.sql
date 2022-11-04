
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[Salesorder_astea_note]
AS

/******************************************************************************
**	File: 
**	Name: [Dimension].[Salesorder_astea_note]
**	Desc:  based on [Dimension].[Salesorder_note]
**			goal is to provide Astea and JDE note header commentary for
**			finacial analysis
**              
**	Return values:  
**
**	Called by:   SSAS
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**  BRS_Config!PriorFiscalMonth
**	comm.transaction_F555115 (table), loaded as part of commission process
**
**	Auth: tmc
**	Date: 13 Sep 22
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

SELECT 
	[SalesOrderNumber]
	,[DocType]
	,FiscalMonth
	,equipment_order
	-- concate notes into one field
	,ISNULL((SELECT
		'| ' + RTRIM(note.ICMMSG_comments) as [text()] 
	FROM
		nes.order_note_D1ICMTPF AS note 
	WHERE
		--(note.SalesOrderNumber_key IS NOT NULL) AND 
		-- header
		(note.ICMTYP2_header_detail = 'H') AND
		-- Equipment Coord and Credit rep notes only 
		(note.ICMTYP1_record_type in ('EC', 'CR')) AND
		(note.ICMORD_ets_order_number = base_orders.equipment_order) AND
		(1=1)
	ORDER BY ICMTYP1_record_type, ICMSEQ_comments_sequence
	FOR XML PATH('') 
	),'.') as note_header_astea
	,ISNULL((SELECT 
			-- reduce page of notes into one line, then concat
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
			[Q3DOCO_salesorder_number] = base_orders.SalesOrderNumber AND
			-- these are the major JDE order notes types
			[Q3INMG_print_message] in ('9999', 'FULL80', '9898') AND
			(1=1)
		Order by 
			[Q3$SNB_sequence_number] ASC
		FOR XML PATH('') 
	),'.') AS note_header_jde
FROM
-- treat grouped report as a single sub-query to implify above joins (left-join implied)
( 
	SELECT
		t.WSDOCO_salesorder_number	AS [SalesOrderNumber]
		,t.WSDCTO_order_type		AS [DocType]
		,MAX(t.FiscalMonth)			AS FiscalMonth
		,MAX(t.WSORD__equipment_order)	AS equipment_order
	FROM 
		comm.transaction_F555115 AS t 
		-- swap to prod (temp)
		--BRSales.comm.transaction_F555115 AS t 
	WHERE 
		-- just have Asea order
		(t.WSORD__equipment_order <> '') AND 
		-- no adustments
		(t.WSDCTO_order_type > 'AA') AND 
		-- Astea order types (Order (A) and Credit (L)
		(t.WS$OSC_order_source_code IN ('A', 'L')) AND
		-- select prior completed monthend
		(t.FiscalMonth = (SELECT PriorFiscalMonth FROM BRS_Config)) AND 
		-- swap to prod (temp)
		--(t.FiscalMonth = (SELECT PriorFiscalMonth FROM BRSales.dbo.BRS_Config)) AND 
		--test
	--	(WSORD__equipment_order = 'T42205') AND
		(1=1)
	GROUP BY
		t.WSDOCO_salesorder_number
		,t.WSDCTO_order_type
) AS base_orders

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT  * from [Dimension].[Salesorder_astea_note]



