﻿dbMemo "SQL" ="EXEC comm.adjustment_load_proc @bDebug=0, @bClearStage=1\015\012"
dbMemo "Connect" ="ODBC;DSN=BRSales;Description=cahsionnlsql1;Trusted_Connection=Yes;DATABASE=DEV_B"
    "RSales;Network=DBMSSOCN"
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
