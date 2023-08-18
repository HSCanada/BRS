Operation =4
Option =0
Where ="((([Item Master].[Sell Prc Brk1]) Is Null) AND (([Item Master].Major) Not In (\""
    "925\",\"908\",\"100\",\"904\")))"
Begin InputTables
    Name ="0-QrySel-SetLeaders-Wholesales"
    Name ="Item Master"
End
Begin OutputColumns
    Name ="[Item Master].[Exception Message]"
    Expression ="[Item Master]![Exception Message] & \"NOPRICE \""
End
Begin Joins
    LeftTable ="0-QrySel-SetLeaders-Wholesales"
    RightTable ="Item Master"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Wholesale Set Leader] = [Item Master].[HSI Ite"
        "m#]"
    Flag =1
End
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
dbText "Description" ="tc"
Begin
    Begin
        dbText "Name" ="[Item Master].Major"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Major Product Class].Description"
        dbInteger "ColumnWidth" ="3030"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Avail Code]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[HSI Item#]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Item Description]"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3480"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="[Major Product Class].FreeGoodInd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Sell Prc Brk1]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Exception Message]"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =1122
    Bottom =946
    Left =-1
    Top =-1
    Right =1098
    Bottom =444
    Left =0
    Top =0
    ColumnsShown =579
    Begin
        Left =16
        Top =55
        Right =225
        Bottom =199
        Top =0
        Name ="0-QrySel-SetLeaders-Wholesales"
        Name =""
    End
    Begin
        Left =351
        Top =14
        Right =675
        Bottom =570
        Top =0
        Name ="Item Master"
        Name =""
    End
End
