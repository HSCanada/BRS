Operation =1
Option =0
Begin InputTables
    Name ="Item Master Export"
End
Begin OutputColumns
    Expression ="[Item Master Export].[HSI Item#]"
    Expression ="[Item Master Export].[Item Description]"
    Expression ="[Item Master Export].[Retail Set Leader]"
    Expression ="[Item Master Export].[Cost Prc Brk1]"
    Expression ="[Item Master Export].[Sell Prc Brk1]"
    Expression ="[Item Master Export].[Avail Code]"
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
        dbText "Name" ="[Item Master Export].[HSI Item#]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master Export].[Item Description]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master Export].[Cost Qty Brk1]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master Export].[Cost Prc Brk1]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master Export].[Sell Prc Brk1]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master Export].[Avail Code]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master Export].[Retail Set Leader]"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =853
    Bottom =591
    Left =-1
    Top =-1
    Right =828
    Bottom =278
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =192
        Bottom =156
        Top =0
        Name ="Item Master Export"
        Name =""
    End
End
