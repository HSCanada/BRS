
INSERT INTO [dbo].[BRS_CustomerSpecialty]
           ([Specialty]
           ,[SpecialtyNm]
           )
     VALUES
           ('CAMP'
           ,'.'
           ),
           ('CLIN'
           ,'.'
           )
GO
--


INSERT INTO [comm].[plan]
           ([comm_plan_id]
           ,[comm_plan_nm]
)
     VALUES
           ('ISRGP02'
           ,'ISR plan 2'),
           ('ISRGP03'
           ,'ISR plan 3'
			)
GO


BEGIN TRANSACTION
GO
ALTER TABLE comm.transaction_F555115 ADD
	isr_salesperson_key_id varchar(30) NULL,
	isr_comm_plan_id char(10) NULL,
	isr_comm_rt float(53) NULL,
	isr_comm_amt money NOT NULL CONSTRAINT DF_transaction_F555115_isr_comm_amt DEFAULT ((0)),
	isr_code char(5) NULL,
	isr_calc_key int NULL
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_salesperson_master4 FOREIGN KEY
	(
	isr_salesperson_key_id
	) REFERENCES comm.salesperson_master
	(
	salesperson_key_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_plan4 FOREIGN KEY
	(
	isr_comm_plan_id
	) REFERENCES comm.[plan]
	(
	comm_plan_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_FSC_Rollup11 FOREIGN KEY
	(
	isr_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_plan_group_rate4 FOREIGN KEY
	(
	isr_calc_key
	) REFERENCES comm.plan_group_rate
	(
	calc_key
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_CustomerFSC_History ADD
	HIST_isr_salesperson_key_id varchar(30) NOT NULL CONSTRAINT DF_BRS_CustomerFSC_History_HIST_isr_salesperson_key_id DEFAULT (''),
	HIST_isr_comm_plan_id char(10) NOT NULL CONSTRAINT DF_BRS_CustomerFSC_History_HIST_isr_comm_plan_id DEFAULT ('')
GO
ALTER TABLE dbo.BRS_CustomerFSC_History SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_CustomerFSC_History ADD CONSTRAINT
	FK_BRS_CustomerFSC_History_salesperson_master FOREIGN KEY
	(
	HIST_isr_salesperson_key_id
	) REFERENCES comm.salesperson_master
	(
	salesperson_key_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_CustomerFSC_History ADD CONSTRAINT
	FK_BRS_CustomerFSC_History_plan FOREIGN KEY
	(
	HIST_isr_comm_plan_id
	) REFERENCES comm.[plan]
	(
	comm_plan_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_CustomerFSC_History SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

