-- pro-repair update, tmc 19 Mar 24


select * from [nes].[cause] where cause_code between '10PR' and 'C99'


UPDATE       nes.cause
SET                owner ='Tech', work_flow = '1.Quote Create'
WHERE        (cause_code BETWEEN '10PR' AND '20PR')
GO

UPDATE       nes.cause
SET                owner ='SC', work_flow = '2.Quote Sign-off'
WHERE        (cause_code BETWEEN '21PR' AND '32PR')
GO

UPDATE       nes.cause
SET                owner ='SC', work_flow = '3.Purchase'
WHERE        (cause_code BETWEEN '40PR' AND '50PR')
GO

UPDATE       nes.cause
SET                owner ='SC', work_flow = '4.Billing'
WHERE        (cause_code BETWEEN '60PR' AND '62PR')
GO

UPDATE       nes.cause
SET                owner ='SC', work_flow = 'OEM'
WHERE        (cause_code BETWEEN '70PR' AND '88PR')
GO

UPDATE       nes.cause
SET                owner ='Tech', work_flow = 'BranchRepair'
WHERE        (cause_code BETWEEN 'C00' AND 'C99')
GO
