dbMemo "SQL" ="UPDATE [0-QrySel-SetLeaders-Wholesales] INNER JOIN [Item Master] ON [0-QrySel-Se"
    "tLeaders-Wholesales].[Wholesale Set Leader]=[Item Master].[HSI Item#] SET [Item "
    "Master].[Exception Message] = [Item Master]![Exception Message] & \"NOCOST \"\015"
    "\012WHERE ((([Item Master].[Cost Prc Brk1]) Is Null));\015\012"
dbMemo "Connect" =""
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
Begin
    Begin
        dbText "Name" ="[Item Master].Major"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[HSI Item#]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Avail Code]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Item Description]"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2985"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="[Item Master].[Exception Message]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Cost Prc Brk1]"
        dbLong "AggregateType" ="-1"
    End
End
