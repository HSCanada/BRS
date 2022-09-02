

--------------------------------------------------------------------------------
-- DROP TABLE Integration.D1ICMTPF_order_note_Stage
--------------------------------------------------------------------------------

SELECT 
--	top 5000 
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
--	WHERE ICMORD = ''S80647''
--    ORDER BY
--        <insert custom code here>
')

-- 7237043 @ 33m

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

-- add wo forRI
INSERT INTO [nes].[order]([work_order_num], note)
select distinct ICMOWO_work_order_number, '' from Integration.D1ICMTPF_order_note_Stage where not exists (select * from [nes].[order] where ICMOWO_work_order_number = [work_order_num])

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