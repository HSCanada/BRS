
INSERT INTO [nes].[bx_role](
	[role_cd],
	[role_descr])
     VALUES
		   ('branchmgr',''),
		   ('project',''),
		   ('digital','')

GO

/*
role_key	role_cd	role_descr	bx_active_ind
1	                              		0
2	design                        		1
3	coord                         		1
4	install                       		1
5	service                       		1
6	operations                    		1
7	finance                       		1
8	salesmgr                      		1
15	branchmgr                     		0
16	project                       		0
17	digital                       		0

*/



INSERT INTO nes.bx_role_branch
                         (Branch, role_key, unique_id)
SELECT        BRS_Branch.Branch, nes.bx_role.role_key, 1 AS unique_id
FROM            BRS_Branch CROSS JOIN
                         nes.bx_role
WHERE        (nes.bx_role.role_key > 8)
ORDER BY BRS_Branch.Branch
go


UPDATE nes.bx_role_branch
SET bx_active_ind = 1
where Branch = 'OTTWA'
go

--< 

--> add to prod, 4 Jul 19

-- add employee support tables, 4 Jul 19

-- drop table [comm].[hr_employee]

CREATE TABLE [comm].[hr_employee](
	[employee_num] [int] NOT NULL,
	[CostCenter] [nvarchar](30) NOT NULL,
	[last_name] [nvarchar](30) NOT NULL,
	[first_name] [nvarchar](30) NOT NULL,
	[job_title] [nvarchar](100) NOT NULL,
	[location] [nvarchar](30) NOT NULL,
	[status_code] [char](3) NOT NULL,
 CONSTRAINT [hr_employee_c_pk] PRIMARY KEY CLUSTERED 
(
	[employee_num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

ALTER TABLE [comm].[hr_employee] ADD  CONSTRAINT [DF_hr_employee_CostCenter]  DEFAULT ('') FOR [CostCenter]
GO


BEGIN TRANSACTION
GO
ALTER TABLE comm.hr_employee ADD CONSTRAINT
	FK_hr_employee_cost_center FOREIGN KEY
	(
	CostCenter
	) REFERENCES hfm.cost_center
	(
	CostCenter
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.hr_employee SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


insert into [comm].[hr_employee]
([employee_num], [last_name], [first_name], [job_title], [location], [status_code])
select distinct [employee_num], '', '', '', '', '' 
from [comm].[salesperson_master]
go

BEGIN TRANSACTION
GO
ALTER TABLE comm.salesperson_master ADD CONSTRAINT
	FK_salesperson_master_hr_employee FOREIGN KEY
	(
	employee_num
	) REFERENCES comm.hr_employee
	(
	employee_num
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.salesperson_master SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Employee ADD
	employee_num int NULL
GO
ALTER TABLE dbo.BRS_Employee ADD CONSTRAINT
	FK_BRS_Employee_hr_employee FOREIGN KEY
	(
	employee_num
	) REFERENCES comm.hr_employee
	(
	employee_num
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Employee SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

ALTER TABLE dbo.BRS_Employee ADD
	office nvarchar(30) NULL
GO

--< add to prod, 4 Jul 19

