-- goal to pre new comm backend for scorecord reporting


-- IN PROD BEGIN ----->

BEGIN TRANSACTION
GO
ALTER TABLE comm.[group] ADD
	comm_group_scorecard_cd char(6) NOT NULL CONSTRAINT DF_group_comm_group_scorecard_cd DEFAULT ''
GO
ALTER TABLE comm.[group] ADD CONSTRAINT
	FK_group_group2 FOREIGN KEY
	(
	comm_group_scorecard_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.[group] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- set "cerec" group

UPDATE comm.[group]
SET comm_group_scorecard_cd = 'DIGIMP'
WHERE
comm_group_cd in ('DIGIMP', 'DIGCCS', 'DIGOTH', 'DIGCIM', 'DIGCCC', 'DIGLAB') 
GO

-- addd DO NOT USE code
INSERT INTO comm.[group]
                         (comm_group_cd, [comm_group_desc])
VALUES        ('ZZZZZZ', 'zzzExclude')
GO

-- addd ok -- inlucde 
INSERT INTO comm.[group]
                         (comm_group_cd, [comm_group_desc])
VALUES        ('SCRCRD', 'Scorecard Include - other')
GO


UPDATE comm.[group]
SET comm_group_scorecard_cd = 'ZZZZZZ'
WHERE
comm_group_cd NOT in ('DIGIMP', 'DIGMAT', 'FRESEQ', 'FRESND', 'ITMCAM', 'ITMCPU', 'ITMEQ0', 'ITMFO1', 'ITMFO2', 'ITMFO3', 'ITMFRT', 'ITMISC', 'ITMPAR', 'ITMSER', 'ITMSND', 'ITMSOF', 'ITMTEE', 'REBSND', 'REBTEE', 'SFFFIN', 'SPMFGE', 'SPMFGS', 'SPMFO1', 'SPMFO2', 'SPMFO3', 'SPMREB', 'SPMSND'  ) AND
comm_group_scorecard_cd = ''
GO

UPDATE comm.[group]
SET comm_group_scorecard_cd = 'SCRCRD'
WHERE
comm_group_scorecard_cd = ''
GO

SELECT [employee_num]
      ,[tracker_ind]
  FROM [comm].[salesperson_master] WHERE tracker_ind = 1


-- run  source/Dimension.CommissionGroup.sql

-- IN PROD END ---<


