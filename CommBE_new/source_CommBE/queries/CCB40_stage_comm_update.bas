﻿dbMemo "SQL" ="EXEC comm.comm_stage_update_proc @bDebug=0"
dbMemo "Connect" ="ODBC;DSN=DEV_BRSales;Description=cahsionnlsql1;UID=TCrowley;Trusted_Connection=Y"
    "es;DATABASE=DEV_BRSales;Network=DBMSSOCN"
dbBoolean "ReturnsRecords" ="0"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbBoolean "LogMessages" ="0"
Begin
    Begin
        dbText "Name" ="Expr1"
        dbLong "AggregateType" ="-1"
    End
End
