--- Order comments, redux, tmc, 16 Jan 20

/*

File Name       Description                        
F5503      Canned Message File Parameters          
F4201      Sales Order Header File                 

From Field  File ID  Relation   To Field   File ID  
Q3DCTO        F01       EQ     SHDCTO        F02    
Q3DOCO        F01       EQ     SHDOCO        F02    
Q3KCOO        F01       EQ     SHKCOO        F02    

  Seq                                   W P Col Sup Edt Prt Num   Output   
No.       Description            Size L W Sp  Hdg Cde Dec Scl    Field   
   10 Order Number . . . . . .      8 N A *DF  N   Z   0   0  Q3DOCO     
   20 Order Type . . . . . . .      2 N A *DF  N              Q3DCTO     
   30 Line Number. . . . . . .      6 N A *DF  N   4   3   0  Q3LNID     
   40 Sequence Number. . . . .      6 N A *DF  N       2   0  Q3$SNB     
   50 Program Parameter . . . .   601 N A *DF  N              Q3$PMQ     
   60 Address Number . . . . .      8 N A *DF  N   Z   0   0  SHAN8      
   70 Ship To. . . . . . . . .      8 N A *DF  N   Z   0   0  SHSHAN     
   80 Order Date . . . . . . .      8 N A *DF  N   W   0   0  SHTRDJ     
   90 Actual Ship. . . . . . .      8 N A *DF  N   W   0   0  SHADDJ     
                                                                          
*/

--TRUNCATE TABLE Integration.F5503_canned_message_file_parameters_Staging

--------------------------------------------------------------------------------
-- DROP TABLE Integration.F5503_canned_message_file_parameters_Staging
--------------------------------------------------------------------------------

SELECT 
    Top 5
    "Q3KCOO" AS Q3KCOO_order_number_document_company,
	"Q3DCTO" AS Q3DCTO_order_type,
	"Q3DOCO" AS Q3DOCO_salesorder_number,
	"Q3LNID" AS Q3LNID_line_number,
	"Q3$APC" AS Q3$APC_application_code,
	"Q3$PMQ" AS Q3$PMQ_program_parameter,
	"Q3LNGP" AS Q3LNGP_language,
	"Q3INMG" AS Q3INMG_print_message,
	"Q3$SNB" AS Q3$SNB_sequence_number,
	"QCTRDJ" AS QCTRDJ_order_date,
	HASHBYTES('SHA1', "Q3$PMQ") AS chksum

--INTO Integration.F5503_canned_message_file_parameters_Staging

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		Q3KCOO,
		Q3DCTO,
		Q3DOCO,
		CAST((Q3LNID)/1000.0 AS DEC(15,3)) AS Q3LNID,
		Q3$APC,
		Q3$PMQ,
		Q3LNGP,
		Q3INMG,
		CAST((Q3$SNB)/100.0 AS DEC(15,2)) AS Q3$SNB,

		DATE(DIGITS(DEC(QCTRDJ+ 1900000,7,0))) AS QCTRDJ

	FROM
		ARCPDTA71.F5503 n, ARCPDTA71.F5501 h
    WHERE
		Q3KCOO = QCKCOO AND
		Q3DCTO = QCDCTO AND
		Q3DOCO = QCDOCO AND

		Q3KCOO = ''02000'' AND
		(QCTRDJ >= 120000) AND
--		(QCTRDJ between 119000 AND 119365) AND
--		QCTRDJ >= 120001 AND
		1=1

    ORDER BY
        QCTRDJ
')

--

CREATE TABLE [Integration].[F5503_canned_message_file_parameters_Staging](
	[Q3KCOO_order_number_document_company] [char](5) NOT NULL,
	[Q3DCTO_order_type] [char](2) NOT NULL,
	[Q3DOCO_salesorder_number] [numeric](8, 0) NOT NULL,
	[Q3LNID_line_number] [numeric](15, 3) NOT NULL,
	[Q3$APC_application_code] [char](1) NOT NULL,
	[Q3$PMQ_program_parameter] [char](601) NOT NULL,
	[Q3LNGP_language] [char](2) NOT NULL,
	[Q3INMG_print_message] [char](10) NOT NULL,
	[Q3$SNB_sequence_number] [numeric](15, 2) NOT NULL,
	[QCTRDJ_order_date] [date] NOT NULL,
	[chksum] [varbinary](8000) NULL,
	[id] [int] IDENTITY(1,1) NOT NULL
) ON [USERDATA]
GO

--

--------------------------------------------------------------------------------
-- DROP TABLE Integration.F5527_price_adjustment_history_Staging
--------------------------------------------------------------------------------

SELECT 
--    Top 500 
    "QPCO" AS QPCO___company,
	"QPAC08" AS QPAC08_market_segment,
	"QPITM" AS QPITM__item_number_short,
	"QPUOM4" AS QPUOM4_pricing_uom,
	"QPOVPR" AS QPOVPR_override_price,
	"QP$RSC" AS QP$RSC_reason_code,
	"QP$CTR" AS QP$CTR_competitor,
	"QP$TO" AS QP$TO__total_number_of_orders,
	"QP$AID" AS QP$AID_authorized_id,
	"QPUSER" AS QPUSER_user_id,
	"QPPID" AS QPPID__program_id,
	"QPUPMJ" AS QPUPMJ_date_updated,
	"QPTDAY" AS QPTDAY_time_of_day,
	"QPJOBN" AS QPJOBN_work_station_id 

INTO Integration.F5527_price_adjustment_history_Staging

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		QPCO,
		QPAC08,
		QPITM,
		QPUOM4,
		CAST((QPOVPR)/100.0 AS DEC(15,2)) AS QPOVPR,
		QP$RSC,
		QP$CTR,
		QP$TO,
		QP$AID,
		QPUSER,
		QPPID,
		CASE WHEN QPUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(QPUPMJ+ 1900000,7,0))) ELSE NULL END AS QPUPMJ,
		QPTDAY,
		QPJOBN

	FROM
		ARCPDTA71.F5527
    WHERE
		QPUPMJ between 109000 AND 119365
    ORDER BY
        QPITM
')

--------------------------------------------------------------------------------

ALTER TABLE Integration.F5527_price_adjustment_history_Staging
ADD id int identity(1,1)


---

--------------------------------------------------------------------------------
-- DROP TABLE Integration.F5503_canned_message_file_parameters_Staging
--------------------------------------------------------------------------------

SELECT 
    "Q3KCOO" AS Q3KCOO_order_number_document_company,
	"Q3DCTO" AS Q3DCTO_order_type,
	"Q3DOCO" AS Q3DOCO_salesorder_number,
	"Q3LNID" AS Q3LNID_line_number,
	"Q3$APC" AS Q3$APC_application_code,
	"Q3$PMQ" AS Q3$PMQ_program_parameter,
	"Q3LNGP" AS Q3LNGP_language,
	"Q3INMG" AS Q3INMG_print_message,
	"Q3$SNB" AS Q3$SNB_sequence_number,
	"QCTRDJ" AS QCTRDJ_order_date,
	HASHBYTES('SHA1', "Q3$PMQ") AS chksum
FROM 
    OPENQUERY (ESYS_PROD, '
	SELECT
		Q3KCOO,
		Q3DCTO,
		Q3DOCO,
		CAST((Q3LNID)/1000.0 AS DEC(15,3)) AS Q3LNID,
		Q3$APC,
		Q3$PMQ,
		Q3LNGP,
		Q3INMG,
		CAST((Q3$SNB)/100.0 AS DEC(15,2)) AS Q3$SNB,
		DATE(DIGITS(DEC(QCTRDJ+ 1900000,7,0))) AS QCTRDJ

	FROM
		ARCPDTA71.F5503 n, ARCPDTA71.F5501 h
    WHERE
		Q3KCOO = QCKCOO AND
		Q3DCTO = QCDCTO AND
		Q3DOCO = QCDOCO AND

		Q3KCOO = ''02000'' AND
		(QCTRDJ >= 120000)
    ORDER BY
        QCTRDJ
')


--

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
