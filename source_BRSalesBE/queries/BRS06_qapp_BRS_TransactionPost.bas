dbMemo "SQL" ="Exec BRS_BE_Transaction_post_proc 0"
dbMemo "Connect" ="ODBC;DSN=BRSales;Description=BRSales;Trusted_Connection=Yes;DATABASE=BRSales"
dbBoolean "ReturnsRecords" ="0"
dbInteger "ODBCTimeout" ="0"
dbBoolean "LogMessages" ="0"
dbByte "Orientation" ="0"
Begin
    Begin
        dbText "Name" ="1.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="1.SalesOrderNumberKEY"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="1.DocType"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="1.LineNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="1.Shipto"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="1.TerritoryCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="1.TerritoryORG"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="1.Cust-ShipTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="1.FSC-TerritoryCd"
        dbLong "AggregateType" ="-1"
    End
End
