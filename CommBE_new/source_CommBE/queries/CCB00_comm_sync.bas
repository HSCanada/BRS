﻿dbMemo "SQL" ="EXEC comm.comm_sync_proc @bDebug=0"
dbMemo "Connect" ="ODBC;DSN=DEV_BRSales;Description=cahsionnlsql1;Trusted_Connection=Yes;DATABASE=D"
    "EV_BRSales"
dbBoolean "ReturnsRecords" ="0"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbText "Description" ="bla bla blaensure operational business rules and commission groups are in sync"
dbBoolean "LogMessages" ="0"
Begin
    Begin
        dbText "Name" ="Expr1"
        dbLong "AggregateType" ="-1"
    End
End
