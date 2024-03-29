

--------------------------------------------------------------------------------
-- DROP TABLE Integration.D1ICMTPF_order_note_Stage
--------------------------------------------------------------------------------

SELECT 
	top 5000 
	"ICMOWO" AS ICMOWO_work_order_number 
	, "ICMORD" AS ICMORD_ets_order_number
	, "ICMTYP2" AS ICMTYP2_header_detail
	, "ICMLNE" AS ICMLNE_detail_line_sequence
	, "ICMSEQ" AS ICMSEQ_comments_sequence
	, "ICMMSG" AS ICMMSG_comments
	, "ICMBCH" AS ICMBCH_batch_number
	, "ICMTYP1" AS ICMTYP1_record_type

INTO Integration.D1ICMTPF_order_note_Stage

FROM 
    OPENQUERY (ASYS_PROD, '

	SELECT ICMOWO, ICMORD, ICMTYP2, ICMLNE, ICMSEQ, ICMMSG,ICMBCH,ICMTYP1

	FROM
		ARCPCORDTA.D1ICMTPF
	WHERE ICMORD >= ''S00000''
--    ORDER BY
--        <insert custom code here>
')

-- 7237043 @ 33m
/*
SELECT 
*
-- INTO Integration.ARCPDTA71_F060116_<instert_friendly_name_here>

FROM 
    OPENQUERY (ASYS_PROD, '

	SELECT count(*)

	FROM
		ARCPCORDTA.D1ICMTPF
--	WHERE ICMORD = ''S80647''
--    ORDER BY
--        <insert custom code here>
')
*/

-- drop TABLE nes.order_note_D1ICMTPF 
CREATE TABLE nes.order_note_D1ICMTPF (
	[ICMOWO_work_order_number] [char](10) NOT NULL
	,[ICMORD_ets_order_number] [char](6) NOT NULL
	,[ICMTYP2_header_detail] [char](1) NOT NULL
	,[ICMLNE_detail_line_sequence] int NOT NULL
	,[ICMSEQ_comments_sequence] int NOT NULL
	,[ICMMSG_comments] [varchar](75) NOT NULL
	,[ICMBCH_batch_number] int NOT NULL
	,[ICMTYP1_record_type] [char](2) NOT NULL
	,ID int NOT NULL Identity(1,1) 
) ON [USERDATA]
GO

BEGIN TRANSACTION
GO
ALTER TABLE nes.order_note_D1ICMTPF ADD CONSTRAINT
	order_note_D1ICMTPF_c_pk PRIMARY KEY CLUSTERED 
	(
	ICMOWO_work_order_number,
	ICMORD_ets_order_number,
	ICMTYP2_header_detail,
	ICMLNE_detail_line_sequence,
	ICMSEQ_comments_sequence,
	ICMBCH_batch_number,
	ICMTYP1_record_type
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE nes.order_note_D1ICMTPF ADD CONSTRAINT
	FK_order_note_D1ICMTPF_order FOREIGN KEY
	(
	ICMOWO_work_order_number
	) REFERENCES nes.[order]
	(
	work_order_num
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.order_note_D1ICMTPF SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--> New, 12 Sep 22
-- fix salesorder ext key 
BEGIN TRANSACTION
GO
DROP INDEX BRS_TransactionDW_Ext_idx_02 ON dbo.BRS_TransactionDW_Ext
GO
CREATE UNIQUE NONCLUSTERED INDEX BRS_TransactionDW_Ext_idx_02 ON dbo.BRS_TransactionDW_Ext
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
GO

-- link D1 note to order
BEGIN TRANSACTION
GO
ALTER TABLE nes.order_note_D1ICMTPF ADD
	SalesOrderNumber_key int NULL
GO
ALTER TABLE nes.order_note_D1ICMTPF ADD CONSTRAINT
	FK_order_note_D1ICMTPF_BRS_TransactionDW_Ext FOREIGN KEY
	(
	SalesOrderNumber_key
	) REFERENCES dbo.BRS_TransactionDW_Ext
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.order_note_D1ICMTPF SET (LOCK_ESCALATION = TABLE)
GO
COMMIT




-- XXX
-- add wo forRI
INSERT INTO [nes].[order]([work_order_num], note)
select distinct ICMOWO_work_order_number, '' from Integration.D1ICMTPF_order_note_Stage where not exists (select * from [nes].[order] where ICMOWO_work_order_number = [work_order_num])

-- XXX

-- find bad data.  think WO WQ02190041
SELECT min([ICMOWO_work_order_number]), count (*) from Integration.D1ICMTPF_order_note_Stage group by 
	[ICMOWO_work_order_number]
	,[ICMORD_ets_order_number]
	,[ICMTYP2_header_detail] 
	,[ICMLNE_detail_line_sequence]
	,[ICMSEQ_comments_sequence]
	,[ICMBCH_batch_number]
	,[ICMTYP1_record_type]
having count(*) > 1


--truncate table nes.order_note_D1ICMTPF
INSERT INTO nes.order_note_D1ICMTPF
(ICMOWO_work_order_number, ICMORD_ets_order_number, ICMTYP2_header_detail, ICMLNE_detail_line_sequence, ICMSEQ_comments_sequence, ICMMSG_comments, ICMBCH_batch_number, 
                         ICMTYP1_record_type)
SELECT        ICMOWO_work_order_number, ICMORD_ets_order_number, ICMTYP2_header_detail, ICMLNE_detail_line_sequence, ICMSEQ_comments_sequence, ICMMSG_comments, ICMBCH_batch_number, 
                         ICMTYP1_record_type
FROM            Integration.D1ICMTPF_order_note_Stage s
WHERE ICMOWO_work_order_number <>'WQ02190041'



-- create view?  may just query raw table to map note to token

-- test

/*
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [ICMOWO_work_order_number]
      ,[ICMORD_ets_order_number]
      ,[ICMTYP2_header_detail]
      ,[ICMSEQ_comments_sequence]
      ,[ICMMSG_comments]
      ,[ICMTYP1_record_type]
      ,[ID]
  FROM [DEV_BRSales].[nes].[order_note_D1ICMTPF] 
  where [ICMTYP2_header_detail] = 'H' and
  [ICMORD_ets_order_number] > 'R' 
  order by 2 desc

  SELECT 
      [ICMTYP1_record_type]
	  ,count(*)
  FROM [DEV_BRSales].[nes].[order_note_D1ICMTPF] 
  where [ICMTYP2_header_detail] = 'H' and
  [ICMORD_ets_order_number] > 'R' 
  group by 
  [ICMTYP1_record_type]
*/

--

-- update note xref, run for each fiscal month (for speed)
/*
UPDATE       nes.order_note_D1ICMTPF
SET                SalesOrderNumber_key = temp.MinOfID
FROM            (SELECT        t.WSORD__equipment_order, MIN(ext.ID) AS MinOfID
                          FROM            comm.transaction_F555115 AS t INNER JOIN
                                                    BRS_TransactionDW_Ext AS ext ON t.WSDCTO_order_type = ext.DocType AND t.WSDOCO_salesorder_number = ext.SalesOrderNumber
                          WHERE        (t.FiscalMonth = 202208) AND (t.WSORD__equipment_order <> '') AND (t.WSDCTO_order_type > 'AA') AND (t.WS$OSC_order_source_code IN ('A', 'L'))
                          GROUP BY t.WSORD__equipment_order) AS temp INNER JOIN
                         nes.order_note_D1ICMTPF ON temp.WSORD__equipment_order = nes.order_note_D1ICMTPF.ICMORD_ets_order_number
WHERE        (nes.order_note_D1ICMTPF.SalesOrderNumber_key IS NULL)
GO
*/
/*
select * from (SELECT        t.WSORD__equipment_order, MIN(ext.ID) AS MinOfID
FROM            comm.transaction_F555115 AS t INNER JOIN
                         BRS_TransactionDW_Ext AS ext ON t.WSDCTO_order_type = ext.DocType AND t.WSDOCO_salesorder_number = ext.SalesOrderNumber
WHERE        (t.FiscalMonth = 202201) AND (t.WSORD__equipment_order <> '') AND (t.WSDCTO_order_type > 'AA') AND (t.WS$OSC_order_source_code IN ('A', 'L'))
GROUP BY t.WSORD__equipment_order) temp
*/
/*
UPDATE       nes.order_note_D1ICMTPF
SET                ICMMSG_comments = s.ICMMSG_comments
FROM            Integration.D1ICMTPF_order_note_Stage AS s INNER JOIN
                         nes.order_note_D1ICMTPF ON s.ICMOWO_work_order_number = nes.order_note_D1ICMTPF.ICMOWO_work_order_number AND s.ICMORD_ets_order_number = nes.order_note_D1ICMTPF.ICMORD_ets_order_number AND 
                         s.ICMTYP2_header_detail = nes.order_note_D1ICMTPF.ICMTYP2_header_detail AND s.ICMLNE_detail_line_sequence = nes.order_note_D1ICMTPF.ICMLNE_detail_line_sequence AND 
                         s.ICMSEQ_comments_sequence = nes.order_note_D1ICMTPF.ICMSEQ_comments_sequence AND s.ICMBCH_batch_number = nes.order_note_D1ICMTPF.ICMBCH_batch_number AND 
                         s.ICMTYP1_record_type = nes.order_note_D1ICMTPF.ICMTYP1_record_type
WHERE        (nes.order_note_D1ICMTPF.ICMMSG_comments <> s.ICMMSG_comments)
*/

/*
1. run this script
2. run backorder script
3. backorder ETL
4. note ETL
5. update /run 
	a) BRS_BE_Dimension_load_proc
	b) pricing.order_note_post_proc
	c) fg.order_update_proc
	d) Dimension.Salesorder_astea_note

*/

/*
prod
connection_string=Data Source=CAHSIONNLSQL1;Initial Catalog=BRSales;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;
Param_srcsql_F5503=SELECT "Q3KCOO" AS Q3KCOO_order_number_document_company, 	"Q3DCTO" AS Q3DCTO_order_type, 	"Q3DOCO" AS Q3DOCO_salesorder_number, 	"Q3LNID" AS Q3LNID_line_number, 	"Q3$APC" AS Q3$APC_application_code, 	"Q3$PMQ" AS Q3$PMQ_program_parameter, 	"Q3LNGP" AS Q3LNGP_language, 	"Q3INMG" AS Q3INMG_print_message, 	"Q3$SNB" AS Q3$SNB_sequence_number, 	"QCTRDJ" AS QCTRDJ_order_date, 	HASHBYTES('SHA1', "Q3$PMQ") AS chksum FROM      OPENQUERY (ESYS_PROD, ' 	SELECT 		Q3KCOO, 		Q3DCTO, 		Q3DOCO, 		CAST((Q3LNID)/1000.0 AS DEC(15,3)) AS Q3LNID, 		Q3$APC, 		Q3$PMQ, 		Q3LNGP, 		Q3INMG, 		CAST((Q3$SNB)/100.0 AS DEC(15,2)) AS Q3$SNB, 		DATE(DIGITS(DEC(QCTRDJ+ 1900000,7,0))) AS QCTRDJ  	FROM 		ARCPDTA71.F5503 n, ARCPDTA71.F5501 h     WHERE 		Q3KCOO = QCKCOO AND 		Q3DCTO = QCDCTO AND 		Q3DOCO = QCDOCO AND  		Q3KCOO = ''02000'' AND 		(QCTRDJ between 122000 and 122365)     ORDER BY         QCTRDJ ')

qa
connection_string=Data Source=CAHSIONNLSQL1;Initial Catalog=DEV_BRSales;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;
Param_srcsql_F5503=SELECT    top 5  "Q3KCOO" AS Q3KCOO_order_number_document_company, 	"Q3DCTO" AS Q3DCTO_order_type, 	"Q3DOCO" AS Q3DOCO_salesorder_number, 	"Q3LNID" AS Q3LNID_line_number, 	"Q3$APC" AS Q3$APC_application_code, 	"Q3$PMQ" AS Q3$PMQ_program_parameter, 	"Q3LNGP" AS Q3LNGP_language, 	"Q3INMG" AS Q3INMG_print_message, 	"Q3$SNB" AS Q3$SNB_sequence_number, 	"QCTRDJ" AS QCTRDJ_order_date, 	HASHBYTES('SHA1', "Q3$PMQ") AS chksum FROM      OPENQUERY (ESYS_PROD, ' 	SELECT 		Q3KCOO, 		Q3DCTO, 		Q3DOCO, 		CAST((Q3LNID)/1000.0 AS DEC(15,3)) AS Q3LNID, 		Q3$APC, 		Q3$PMQ, 		Q3LNGP, 		Q3INMG, 		CAST((Q3$SNB)/100.0 AS DEC(15,2)) AS Q3$SNB, 		DATE(DIGITS(DEC(QCTRDJ+ 1900000,7,0))) AS QCTRDJ  	FROM 		ARCPDTA71.F5503 n, ARCPDTA71.F5501 h     WHERE 		Q3KCOO = QCKCOO AND 		Q3DCTO = QCDCTO AND 		Q3DOCO = QCDOCO AND  		Q3KCOO = ''02000'' AND 		(QCTRDJ >= 122000)     ORDER BY         QCTRDJ ')
Param_srcsql_D1ICMTPF=SELECT    top 5    ICMOWO AS ICMOWO_work_order_number, ICMORD AS ICMORD_ets_order_number, ICMTYP2 AS ICMTYP2_header_detail, ICMLNE AS ICMLNE_detail_line_sequence, ICMSEQ AS ICMSEQ_comments_sequence,                           ICMMSG AS ICMMSG_comments, ICMBCH AS ICMBCH_batch_number, ICMTYP1 AS ICMTYP1_record_type FROM            OPENQUERY(ASYS_PROD, '  	SELECT ICMOWO, ICMORD, ICMTYP2, ICMLNE, ICMSEQ, ICMMSG,ICMBCH,ICMTYP1  	FROM 		ARCPCORDTA.D1ICMTPF 	WHERE ICMORD >= ''S00000'' --    ORDER BY --        <insert custom code here> ')
*/




