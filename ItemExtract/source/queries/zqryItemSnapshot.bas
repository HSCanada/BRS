Operation =2
Name ="ItemPrice20120905"
Option =0
Begin InputTables
    Name ="Item Master Export"
End
Begin OutputColumns
    Expression ="[Item Master Export].[HSI Item#]"
    Expression ="[Item Master Export].[Retail Set Leader]"
    Expression ="[Item Master Export].[Sell Qty Brk1]"
    Expression ="[Item Master Export].[Sell Prc Brk1]"
    Expression ="[Item Master Export].[Sell Qty Brk2]"
    Expression ="[Item Master Export].[Sell Prc Brk2]"
    Expression ="[Item Master Export].[Sell Qty Brk3]"
    Expression ="[Item Master Export].[Sell Prc Brk3]"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbByte "Orientation" ="0"
Begin
    Begin
        dbText "Name" ="[Item Master Export].[HSI Item#]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master Export].[Sell Prc Brk3]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master Export].[Sell Qty Brk1]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master Export].[Sell Prc Brk1]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master Export].[Sell Qty Brk2]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master Export].[Sell Prc Brk2]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master Export].[Sell Qty Brk3]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master Export].[Retail Set Leader]"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =108
    Top =15
    Right =1672
    Bottom =984
    Left =-1
    Top =-1
    Right =1541
    Bottom =603
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =266
        Bottom =655
        Top =0
        Name ="Item Master Export"
        Name =""
    End
End
