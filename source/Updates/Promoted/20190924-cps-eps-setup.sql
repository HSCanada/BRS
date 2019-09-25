-- cps and eps setup, tmc, 24 Sep 19

-- postcode / branch mapping table

-- drop table comm.plan_region_map

BEGIN TRANSACTION
GO
CREATE TABLE comm.plan_region_map
	(
	comm_plan_id char(10) NOT NULL,
	postal_code_where_clause_like varchar(30) NOT NULL,
	branch_code_where_clause_like varchar(30) NOT NULL,

	[TerritoryCd] char(5) NOT NULL,

	rule_key int NOT NULL IDENTITY (1, 1),
	note varchar(30) NULL
	)  ON USERDATA
GO
ALTER TABLE comm.plan_region_map ADD CONSTRAINT
	DF_plan_region_map_comm_plan_id DEFAULT '' FOR comm_plan_id
GO
ALTER TABLE comm.plan_region_map ADD CONSTRAINT
	DF_plan_region_map_postal_code_where_clause_like DEFAULT '' FOR postal_code_where_clause_like
GO
ALTER TABLE comm.plan_region_map ADD CONSTRAINT
	DF_plan_region_map_branch_code_where_clause_like DEFAULT '' FOR branch_code_where_clause_like
GO
ALTER TABLE comm.plan_region_map ADD CONSTRAINT
	DF_plan_region_map_territoryCd DEFAULT '' FOR [TerritoryCd]
GO
ALTER TABLE comm.plan_region_map ADD CONSTRAINT
	plan_region_map_c_pk PRIMARY KEY CLUSTERED 
	(
	comm_plan_id,
	postal_code_where_clause_like,
	branch_code_where_clause_like
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE comm.plan_region_map SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- add relationships

BEGIN TRANSACTION
GO
ALTER TABLE comm.plan_region_map ADD CONSTRAINT
	FK_plan_region_map_plan FOREIGN KEY
	(
	comm_plan_id
	) REFERENCES comm.[plan]
	(
	comm_plan_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.plan_region_map ADD CONSTRAINT
	FK_plan_region_map_territoryCd FOREIGN KEY
	(
	[TerritoryCd]
	) REFERENCES [dbo].[BRS_FSC_Rollup]
	(
	[TerritoryCd]
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.plan_region_map SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- setup master

-- EPS --
INSERT INTO [comm].[salesperson_master]
           ([employee_num]
           ,[master_salesperson_cd]
           ,[salesperson_key_id]
           ,[salesperson_nm]
           ,[comm_plan_id]
           ,[territory_start_dt]
           ,[note_txt]
           ,[flag_ind]
           ,[CostCenter]
           ,[tracker_ind])
     VALUES
           (4396
           ,'EPONT'
           ,'Chris.Nicolson.EPS'
           ,'Chris Nicolson'
           ,'EPSGP'
           ,'1 jan 1980'
           ,''
           ,0
           ,''
           ,0)
GO

INSERT INTO [comm].[salesperson_master]
           ([employee_num]
           ,[master_salesperson_cd]
           ,[salesperson_key_id]
           ,[salesperson_nm]
           ,[comm_plan_id]
           ,[territory_start_dt]
           ,[note_txt]
           ,[flag_ind]
           ,[CostCenter]
           ,[tracker_ind])
     VALUES
           (4472
           ,'EPQUE'
           ,'Marilyne.Petryka.EPS'
           ,'Marilyne Petryka'
           ,'EPSGP'
           ,'1 jan 1980'
           ,''
           ,0
           ,''
           ,0)
GO

-- CPS

-- plan
INSERT INTO [comm].[plan]
           ([comm_plan_id]
           ,[comm_plan_nm]
           ,[note_txt]
           ,[active_ind]
		   )
     VALUES
           ('CPSGP'
           ,'Core Practice Specialist'
           ,''
           ,0
		   )
GO


-- CPS --
INSERT INTO [comm].[salesperson_master]
           ([employee_num]
           ,[master_salesperson_cd]
           ,[salesperson_key_id]
           ,[salesperson_nm]
           ,[comm_plan_id]
           ,[territory_start_dt]
           ,[note_txt]
           ,[flag_ind]
           ,[CostCenter]
           ,[tracker_ind])
     VALUES
           (3101
           ,'PMT10'
           ,'Alison.Hamilton.cps'
           ,'ALISON HAMILTON'
           ,'CPSGP'
           ,'1 jan 1980'
           ,''
           ,0
           ,''
           ,0)
GO

INSERT INTO [comm].[salesperson_master]
           ([employee_num]
           ,[master_salesperson_cd]
           ,[salesperson_key_id]
           ,[salesperson_nm]
           ,[comm_plan_id]
           ,[territory_start_dt]
           ,[note_txt]
           ,[flag_ind]
           ,[CostCenter]
           ,[tracker_ind])
     VALUES
           (2172
           ,'PMT27'
           ,'Maralee.Miller.cps'
           ,'MARALEE MILLER'
           ,'CPSGP'
           ,'1 jan 1980'
           ,''
           ,0
           ,''
           ,0)
GO


INSERT INTO [comm].[salesperson_master]
           ([employee_num]
           ,[master_salesperson_cd]
           ,[salesperson_key_id]
           ,[salesperson_nm]
           ,[comm_plan_id]
           ,[territory_start_dt]
           ,[note_txt]
           ,[flag_ind]
           ,[CostCenter]
           ,[tracker_ind])
     VALUES
           (2129
           ,'PMT21'
           ,'Lynn.Simpson.cps'
           ,'LYNN SIMPSON'
           ,'CPSGP'
           ,'1 jan 1980'
           ,''
           ,0
           ,''
           ,0)
GO

-- truncate table [comm].[plan_region_map]

-- add CPS region
INSERT INTO [comm].[plan_region_map]
           ([comm_plan_id]
           ,[postal_code_where_clause_like]
           ,[branch_code_where_clause_like]
           ,[TerritoryCd]
           ,[note])
     VALUES
           ('CPSGP'
           ,'K%'
           ,'%'
           ,'PMT10'
           ,'Alison.Hamilton.cps'),
           ('CPSGP'
           ,'L%'
           ,'%'
           ,'PMT10'
           ,'Alison.Hamilton.cps'),
           ('CPSGP'
           ,'M%'
           ,'%'
           ,'PMT10'
           ,'Alison.Hamilton.cps'),
           ('CPSGP'
           ,'N%'
           ,'%'
           ,'PMT10'
           ,'Alison.Hamilton.cps'),
           ('CPSGP'
           ,'P%'
           ,'%'
           ,'PMT10'
           ,'Alison.Hamilton.cps'),
           ('CPSGP'
           ,'V%'
           ,'%'
           ,'PMT27'
           ,'Maralee.Miller.cps'),
           ('CPSGP'
           ,'Y%'
           ,'%'
           ,'PMT27'
           ,'Maralee.Miller.cps'),
           ('CPSGP'
           ,'R%'
           ,'%'
           ,'PMT21'
           ,'Lynn.Simpson.cps'),

           ('CPSGP'
           ,'S%'
           ,'%'
           ,'PMT21'
           ,'Lynn.Simpson.cps'),
           ('CPSGP'
           ,'T%'
           ,'%'
           ,'PMT21'
           ,'Lynn.Simpson.cps'),
           ('CPSGP'
           ,'X%'
           ,'%'
           ,'PMT21'
           ,'Lynn.Simpson.cps')
GO


-- add EPS region
INSERT INTO [comm].[plan_region_map]
           ([comm_plan_id]
           ,[postal_code_where_clause_like]
           ,[branch_code_where_clause_like]
           ,[TerritoryCd]
           ,[note])
     VALUES
           ('EPSGP'
           ,'%'
           ,'LONDN'
           ,'EPONT'
           ,'Chris.Nicolson.EPS'),
           ('EPSGP'
           ,'%'
           ,'OTTWA'
           ,'EPONT'
           ,'Chris.Nicolson.EPS'),
           ('EPSGP'
           ,'%'
           ,'TORNT'
           ,'EPONT'
           ,'Chris.Nicolson.EPS'),

           ('EPSGP'
           ,'%'
           ,'MNTRL'
           ,'EPQUE'
           ,'Marilyne.Petryka.EPS'),

           ('EPSGP'
           ,'%'
           ,'QUEBC'
           ,'EPQUE'
           ,'Marilyne.Petryka.EPS')
GO

-- add EPS category to group


INSERT INTO [comm].[group]
           ([comm_group_cd]
           ,[comm_group_desc]
           ,[booking_rt]
		   )
     VALUES
           ('EPSBAI'
           ,'BAINTE'
           ,1
		   ),

           ('EPSCAO'
           ,'CAO_LASER'
           ,1
		   ),

           ('EPSCHA'
           ,'CHANNELS'
           ,1
		   ),

           ('EPSEDG'
           ,'EDGE_ENDO'
           ,1
		   ),

           ('EPSMIL'
           ,'MILESTONE'
           ,1
		   ),

           ('EPSORT'
           ,'ORTHO_TECHNOLOGIES'
           ,1
		   ),

           ('EPSOST'
           ,'OSSTELL'
           ,1
		   )
		   
GO

--add eps item code to item
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Item ADD
	comm_group_eps_cd char(6) NOT NULL CONSTRAINT DF_BRS_Item_comm_group_eps_cd DEFAULT ''
GO
ALTER TABLE dbo.BRS_Item ADD CONSTRAINT
	FK_BRS_Item_group5 FOREIGN KEY
	(
	comm_group_eps_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Item SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


BEGIN TRANSACTION
GO
ALTER TABLE comm.transaction_F555115 ADD
	cps_code char(5) NULL,
	eps_code char(5) NULL,
	eps_salesperson_key_id varchar(30) NULL
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


BEGIN TRANSACTION
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_FSC_Rollup6 FOREIGN KEY
	(
	cps_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_FSC_Rollup7 FOREIGN KEY
	(
	eps_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_salesperson_master3 FOREIGN KEY
	(
	eps_salesperson_key_id
	) REFERENCES comm.salesperson_master
	(
	salesperson_key_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--

BEGIN TRANSACTION
GO
ALTER TABLE comm.transaction_F555115 ADD
	eps_comm_plan_id char(10) NULL,
	eps_comm_group_cd char(6) NULL
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_plan3 FOREIGN KEY
	(
	eps_comm_plan_id
	) REFERENCES comm.[plan]
	(
	comm_plan_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_group3 FOREIGN KEY
	(
	eps_comm_group_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
CREATE NONCLUSTERED INDEX transaction_F555115_idx_10 ON comm.transaction_F555115
	(
	eps_salesperson_key_id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
CREATE NONCLUSTERED INDEX transaction_F555115_idx_11 ON comm.transaction_F555115
	(
	eps_comm_group_cd
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
CREATE NONCLUSTERED INDEX transaction_F555115_idx_12 ON comm.transaction_F555115
	(
	cps_comm_group_cd
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--

--add map to terr

UPDATE [dbo].[BRS_FSC_Rollup]
SET comm_salesperson_key_id = 'Chris.Nicolson.EPS'
WHERE TerritoryCd = 'EPONT'
go

UPDATE [dbo].[BRS_FSC_Rollup]
SET comm_salesperson_key_id = 'Marilyne.Petryka.EPS'
WHERE TerritoryCd = 'EPQUE'
go

UPDATE [dbo].[BRS_FSC_Rollup]
SET comm_salesperson_key_id = 'Alison.Hamilton.cps'
WHERE TerritoryCd = 'PMT10'
go

UPDATE [dbo].[BRS_FSC_Rollup]
SET comm_salesperson_key_id = 'Lynn.Simpson.cps'
WHERE TerritoryCd = 'PMT21'
go

UPDATE [dbo].[BRS_FSC_Rollup]
SET comm_salesperson_key_id = 'Maralee.Miller.cps'
WHERE TerritoryCd = 'PMT27'
go



-- TODO update comm & group in sales based on map


