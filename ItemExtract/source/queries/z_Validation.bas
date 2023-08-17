Operation =1
Option =0
Where ="((([Item Master].[HSI Item#])=\"5832431\"))"
Begin InputTables
    Name ="Item Master"
    Name ="Item Master Export"
End
Begin OutputColumns
    Expression ="[Item Master].[HSI Item#]"
    Alias ="master"
    Expression ="[Item Master].[Cost Prc Brk1]"
    Alias ="export"
    Expression ="[Item Master Export].[Cost Prc Brk1]"
End
Begin Joins
    LeftTable ="Item Master"
    RightTable ="Item Master Export"
    Expression ="[Item Master].[HSI Item#] = [Item Master Export].[HSI Item#]"
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
Begin
    Begin
        dbText "Name" ="[Item Master].[HSI Item#]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.HSI Item#"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="export"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="master"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1473
    Bottom =790
    Left =-1
    Top =-1
    Right =1449
    Bottom =280
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =60
        Top =15
        Right =240
        Bottom =195
        Top =0
        Name ="Item Master"
        Name =""
    End
    Begin
        Left =323
        Top =43
        Right =503
        Bottom =223
        Top =0
        Name ="Item Master Export"
        Name =""
    End
End
