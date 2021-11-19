dbMemo "SQL" ="SELECT \015\012--\011top 10\015\012\011m.CalMonth\015\012\011,l.SalesDate\015\012"
    "\011,l.Item\015\012\011,l.Supplier\015\012\011,l.Currency\015\012\011,l.Supplier"
    "Cost\015\012\015\012\011,l.PriceKey\015\012\015\012FROM         \015\012\011[dbo"
    "].[BRS_ItemBaseHistoryDay] AS l \015\012\015\012\011INNER JOIN [dbo].[BRS_CalMon"
    "th] as m\015\012\011ON l.FiscalMonth = m.CalMonth AND\015\012\011\011l.SalesDate"
    " = '2021-08-27' AND\015\012--\011\011l.SalesDate = m.BCI_BenchmarkDay AND\015\012"
    "\011\011(1=1)\015\012WHERE\015\012\011m.CalMonth = 202108\015\012order by 2 asc\015"
    "\012\015\012\015\012"
dbMemo "Connect" ="ODBC;DSN=DEV_BRSales;Description=cahsionnlsql1;Trusted_Connection=Yes;DATABASE=D"
    "EV_BRSales;Network=DBMSSOCN"
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "LogMessages" ="0"
dbByte "Orientation" ="0"
Begin
    Begin
        dbText "Name" ="1.SalesDate"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="1.CalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="1.Currency"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="1.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="1.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="1.PriceKey"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="1.SupplierCost"
        dbLong "AggregateType" ="-1"
    End
End
