-- adjustment backend, tmc, 27 Jun 20

/*
SELECT DISTINCT WSDSC1_description AS adj_comment_org, UPPER(WSVR01_reference) AS adj_source_org, source_cd
INTO              comm.adjustment
FROM            comm.transaction_F555115
WHERE        (source_cd <> 'JDE')
ORDER BY adj_comment_org, adj_source_org

-- truncate table [comm].[adjustment]

SELECT distinct  
      [WSDSC1_description] adj_comment_org
      ,upper([WSVR01_reference]) adj_source_org
	  ,source_cd
  FROM [DEV_BRSales].[comm].[transaction_F555115] where source_cd <> 'JDE'
  order by 1,2

*/

-- drop table [comm].[adjustment]

CREATE TABLE [comm].[adjustment](
	[adj_comment_org] [varchar](30) NOT NULL,
	[adj_source_org] [varchar](25) NOT NULL,
	[source_cd] [char](3) NOT NULL,
	[adj_key] int NOT NULL IDENTITY(1,1),
	[adj_source] [char](6) NOT NULL DEFAULT(''),
	[adj_type] [varchar](30) NOT NULL DEFAULT(''),
	[adj_note] [varchar](50) NULL
) ON [USERDATA]
GO

BEGIN TRANSACTION
GO
ALTER TABLE comm.adjustment ADD CONSTRAINT
	comm_adjustment_c_pk PRIMARY KEY CLUSTERED 
	(
	adj_comment_org,
	adj_source_org
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
CREATE UNIQUE NONCLUSTERED INDEX comm_adjustment_u_idx_01 ON comm.adjustment
	(
	adj_key
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE comm.adjustment ADD CONSTRAINT
	FK_adjustment_source FOREIGN KEY
	(
	source_cd
	) REFERENCES comm.source
	(
	source_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.adjustment SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- add undefined

INSERT INTO [comm].[adjustment]
           ([adj_comment_org]
           ,[adj_source_org]
           ,[source_cd]
           ,[adj_source]
           ,[adj_type]
           ,[adj_note])
     VALUES
           (''
           ,''
           ,''
           ,''
           ,''
           ,'undefined')
GO

