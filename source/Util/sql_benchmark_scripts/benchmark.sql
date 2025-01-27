-- Create TestTable for INSERT test
CREATE TABLE TestTable (col1 int, col2 int, col3 varchar(20), col4 varchar(20));
GO

-- change to sqlcmd mode
truncate table TestTable
GO
BULK INSERT dbo.TestTable FROM '\\cahsionnld3092a.ca.hsi.local\scripts\TestTable10.dat' WITH (DATAFILETYPE='native')
GO
truncate table TestTable
GO
BULK INSERT dbo.TestTable FROM 'C:\scripts\TestTable100.dat' WITH (DATAFILETYPE='native')
GO
truncate table TestTable
GO
BULK INSERT dbo.TestTable FROM 'C:\scripts\TestTable1000.dat' WITH (DATAFILETYPE='native')
GO

truncate table TestTable
GO
:r ".\scripts\TestTableIndividual10.sql"
GO
truncate table TestTable
GO
:r ".\scripts\TestTableIndividual100.sql"
GO
truncate table TestTable
GO
:r ".\scripts\TestTableIndividual1000.sql"
GO

truncate table TestTable
GO
:r ".\scripts\TestTableMultiple10.sql"
GO
truncate table TestTable
GO
:r ".\scripts\TestTableMultiple100.sql"
GO
truncate table TestTable
GO
:r ".\scripts\TestTableMultiple1000.sql"
GO