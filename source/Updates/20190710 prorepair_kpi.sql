
BEGIN TRANSACTION
GO
ALTER TABLE nes.problem ADD
	problem_rollup char(5) NOT NULL CONSTRAINT DF_problem_problem_rollup DEFAULT ''
GO
ALTER TABLE nes.problem ADD CONSTRAINT
	FK_problem_problem FOREIGN KEY
	(
	problem_rollup
	) REFERENCES nes.problem
	(
	problem_code
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.problem SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


--

INSERT INTO [nes].[problem]
([problem_code], [problem_descr])
VALUES ('ZZZ', 'Other')
go

UPDATE [nes].[problem]
SET problem_rollup = 'PH'
WHERE [problem_code] IN ('PH', 'PLH')
GO

UPDATE [nes].[problem]
SET problem_rollup = 'PS'
WHERE [problem_code] IN ('PS')
go

UPDATE [nes].[problem]
SET problem_rollup = 'PSE'
WHERE [problem_code] <> '' AND [problem_code] NOT IN ('PH', 'PLH', 'PS')


