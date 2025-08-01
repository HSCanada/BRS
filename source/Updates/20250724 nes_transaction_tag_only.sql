-- nes_transaction_tag_only, tmc, 24 July 25

-- drop table [Integration].[nes_transaction_tag_only]

CREATE TABLE [Integration].[nes_transaction_tag_only](

	[d1_branch] [char](10) NULL,
	[item] [char](10) NULL,
	[tag_number] [varchar](20) NULL,
	[item_description] [varchar](40) NULL,
	[sales_date] [date] NULL,
	[d1_user] [char](10) NULL,
	[work_order_num] [char](10) NULL,

	[total_extended_value] money NULL,

	[id_key] [int] IDENTITY(1,1) NOT NULL,

	[tag_date] [date] NULL,

 CONSTRAINT [nes_transaction_tag_only_pk] PRIMARY KEY NONCLUSTERED 
(
	[id_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [USERDATA]
) ON [USERDATA]
GO


select top 10 * from [Integration].[nes_transaction_tag_only]


truncate table Integration.nes_transaction_tag_only

INSERT INTO Integration.nes_transaction_tag_only
             (d1_branch, item, tag_number, item_description, sales_date, d1_user, work_order_num, total_extended_value, [tag_date])
SELECT   
-- TOP (1000) 
d1_branch, item, tag_number, ItemDescription, SalesDate, d1_user, work_order_num, extended_cost_amount, Convert(date,SUBSTRING(tag_number, 1,6),12 ) as tag_date
FROM     Integration.nes_transaction_tag_only2


select top 10 *, Convert(date,SUBSTRING(tag_number, 1,6),12 ) as tag_date from [Integration].[nes_transaction_tag_only]

select * from [Integration].[nes_transaction_tag_only] where  NOT exists (SELECT * FROM [nes].[order_install_date_estimate] we WHERE  we.[work_order_num] = work_order_num)

SELECT [work_order_num], min([equipment_order]) min_eq, max([equipment_order]) max_eq FROM [nes].[order_install_date_estimate]
GROUP BY [work_order_num]
having min([equipment_order]) <> max([equipment_order])

-- XXXXXXXXXX

SELECT * FROM [nes].[order_install_date_estimate] we WHERE  we.[work_order_num] = 'WX01100475' 'WX04250522'

-- make view (see Josh V, link to commission feed)

SELECT   we.[ets_num], 'TAG' AS source_cd, t.sales_date AS data_capture_date, t.work_order_num, 0 as salesorder_num, 0 as shipto, '.' as ess_code, t.tag_date, day_.FiscalMonth AS fisc, t.total_extended_value
FROM     
	Integration.nes_transaction_tag_only AS t 

	LEFT OUTER JOIN [nes].[order] AS we 
	ON t.work_order_num = we.work_order_num 

	LEFT JOIN BRS_SalesDay AS day_ 
	ON t.sales_date = day_.SalesDate
WHERE 
	(we.work_order_num is  null) AND
	(total_extended_value > 0.01) AND
	(1=1)
 order by sales_date desc
-- order by total_extended_value desc


-- = 'WX04250522'



--ORG 98 434

SELECT distinct  [ICMOWO_work_order_number]
      ,[ICMORD_ets_order_number]
  FROM [BRSales].[nes].[order_note_D1ICMTPF] where ICMOWO_work_order_number <>''


-- add workorder / order RI

BEGIN TRANSACTION
GO
ALTER TABLE nes.[order] ADD
	ets_num char(6) NULL
GO
ALTER TABLE nes.[order] ADD CONSTRAINT
	FK_order_order_ets FOREIGN KEY
	(
	ets_num
	) REFERENCES nes.order_ets
	(
	ets_num
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.[order] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- populate the xref  frmo the estimates, notes, and excel...

SELECT   TOP (10) nes.[order].work_order_num, nes.[order].note, nes.[order].ets_num, nes.order_install_date_estimate.equipment_order
FROM     nes.[order] INNER JOIN
             nes.order_install_date_estimate ON nes.[order].work_order_num = nes.order_install_date_estimate.work_order_num
where ets_num is null


-- populate

UPDATE  
-- TOP (100) 
nes.[order]
SET        ets_num = s.equipment_order, note = 'tc20250729 inst' 
FROM     nes.[order] s2 INNER JOIN
             nes.order_install_date_estimate s ON s2.work_order_num = s.work_order_num
where ets_num is null


SELECT   TOP (10) nes.[order].work_order_num, nes.[order].note, nes.[order].ets_num, nes.order_note_D1ICMTPF.ICMORD_ets_order_number
FROM     nes.[order] INNER JOIN
             nes.order_note_D1ICMTPF ON nes.[order].work_order_num = nes.order_note_D1ICMTPF.ICMOWO_work_order_number
where nes.order_note_D1ICMTPF.ICMOWO_work_order_number <> '' and ets_num is  null 
GO

select distinct ICMORD_ets_order_number from nes.order_note_D1ICMTPF where not exists (select * from [nes].[order_ets] where ets_num = ICMORD_ets_order_number)

INSERT INTO nes.order_ets
             (ets_num, note)
SELECT DISTINCT ICMORD_ets_order_number, '.'
FROM     nes.order_note_D1ICMTPF
WHERE   (NOT EXISTS
                 (SELECT   ets_num, note, ets_key, eq_forecast_est_astea_key, eq_forecast_act_comm_key
                 FROM     nes.order_ets AS order_ets_1
                 WHERE   (ets_num = nes.order_note_D1ICMTPF.ICMORD_ets_order_number)))


UPDATE  
-- TOP (10) 
nes.[order]
SET        ets_num = nes.order_note_D1ICMTPF.ICMORD_ets_order_number , note = N'tc20250729 note'
FROM     nes.[order] INNER JOIN
             nes.order_note_D1ICMTPF ON nes.[order].work_order_num = nes.order_note_D1ICMTPF.ICMOWO_work_order_number
WHERE   (nes.order_note_D1ICMTPF.ICMOWO_work_order_number <> '') AND (nes.[order].ets_num IS NULL)



SELECT TOP (1000) [ICMOWO_work_order_number]
      ,[ICMORD_ets_order_number], *

  FROM [nes].[order_note_D1ICMTPF]
where [ICMOWO_work_order_number] <> ''




--
-- drop TABLE [dbo].[zzzGroup]

CREATE TABLE [dbo].[zzzGroup](
	[group1] [varchar](100) NOT NULL,
	[group2] [varchar](100) NOT NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
) ON [USERDATA]
GO



-- truncate table zzzGroup

INSERT INTO zzzGroup
([group1], [group2])
SELECT 
--  top 10 
  IHOWO, IHORD
-- top 1000 * 
from OPENQUERY (ASYS_PROD, '	
	SELECT
		IHOWO, IHORD
--		*
 	FROM
		ARCPCORDTA.D1INVHPF
 
--	 WHERE 
--	IHOWO = ''WH04020032''
--	order by FGUPMJ desc
')


SELECT 
--  top 10 
--  IHOWO, IHORD
 top 1000 * 
from OPENQUERY (ASYS_PROD, '	
	SELECT
--		IHOWO, IHORD
		*
 	FROM
		ARCPCORDTA.D1INVHPF
 
	 WHERE 
	IHOWO in (''WK09070199'', ''WK04260302'', ''WL03280260'', ''WW07220604'')
	order by 1,2
')



select [group1], min([group2]), max([group2])  from  zzzGroup group by group1
having min([group2]) <> max([group2])




SELECT   zzzGroup.group1, MIN(zzzGroup.group2) AS Expr1, MAX(zzzGroup.group2) AS Expr2, nes.[order].ets_num, count(*)
FROM     zzzGroup INNER JOIN
             nes.[order] ON zzzGroup.group1 = nes.[order].work_order_num
where group2 <> ''
GROUP BY zzzGroup.group1, nes.[order].ets_num
HAVING   (MIN(zzzGroup.group2) <> MAX(zzzGroup.group2))
order by 5 desc


SELECT   zzzGroup.group2, MIN(zzzGroup.group1) AS Expr1, MAX(zzzGroup.group1) AS Expr2
FROM     zzzGroup 
where group2 <> ''
GROUP BY zzzGroup.group2
HAVING   (MIN(zzzGroup.group2) = MAX(zzzGroup.group2))


select * from zzzGroup where group1 in ('WK09070199', 'WK04260302', 'WL03280260')
