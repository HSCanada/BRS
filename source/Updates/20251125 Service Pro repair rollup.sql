-- Service Pro repair rollup, tmc, 25 Nov 25

SELECT TOp 10
*
FROM [Offline].[dbo].[OL_ServiceData]
where [TCPDT] >= 202510

select distinct [TCPDT] from [Offline].[dbo].[OL_ServiceData]


SELECT distinct  
	ID
	,[Record Type]
	,[Invoice #]
     ,[workorder #]

	,[JDE order number]
	,[JDE order line #]

      ,[Call type]
      ,[TCPDT]
  FROM [Offline].[dbo].[OL_ServiceData] where [TCPDT] >= 202510

-- add workorder and calltype to trans

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Transaction ADD
	nes_work_order_num char(10) NULL,
	nes_call_type_code char(5) NULL
GO
ALTER TABLE dbo.BRS_Transaction ADD CONSTRAINT
	FK_BRS_Transaction_order FOREIGN KEY
	(
	nes_work_order_num
	) REFERENCES nes.[order]
	(
	work_order_num
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Transaction ADD CONSTRAINT
	FK_BRS_Transaction_call_type FOREIGN KEY
	(
	nes_call_type_code
	) REFERENCES nes.call_type
	(
	call_type_code
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Transaction SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


--

BEGIN TRANSACTION
GO
ALTER TABLE nes.call_type ADD
	pro_repair_ind bit NOT NULL CONSTRAINT DF_call_type_pro_repair_ind DEFAULT 0
GO
ALTER TABLE nes.call_type SET (LOCK_ESCALATION = TABLE)
COMMIT



select * from nes.call_type
where call_type_code
in('PRCR'
 ,'PRIW' 
 ,'PRNC' 
 ,'PROC' 
 ,'PROO' 
 ,'PROW' 
 ,'PRPM' 
 ,'PRSH')

UPDATE  nes.call_type
SET        pro_repair_ind = 1
WHERE   (call_type_code IN ('PRCR', 'PRIW', 'PRNC', 'PROC', 'PROO', 'PROW', 'PRPM', 'PRSH'))

select * from nes.call_type
where call_type_code like 'PR%'

