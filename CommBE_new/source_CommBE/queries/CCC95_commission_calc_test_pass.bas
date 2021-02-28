dbMemo "SQL" ="Exec comm.transaction_commission_calc_proc @bDebug=1\015\012"
dbMemo "Connect" ="ODBC;DSN=DEV_BRSales;Description=cahsionnlsql1;Trusted_Connection=Yes;DATABASE=D"
    "EV_BRSales;Network=DBMSSOCN"
dbBoolean "ReturnsRecords" ="0"
dbInteger "ODBCTimeout" ="500"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbBoolean "LogMessages" ="-1"
Begin
    Begin
        dbText "Name" ="Expr1"
        dbLong "AggregateType" ="-1"
    End
End
