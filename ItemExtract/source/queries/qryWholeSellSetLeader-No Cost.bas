Operation =1
Option =0
Where ="((([Item Master_1].[Cost Qty Brk1]) Is Null)) OR ((([Item Master_1].[Cost Prc Br"
    "k1]) Is Null))"
Begin InputTables
    Name ="Item Master"
    Name ="Item Master"
    Alias ="Item Master_1"
End
Begin OutputColumns
    Expression ="[Item Master].[Wholesale Set Leader]"
    Expression ="[Item Master_1].[Cost Qty Brk1]"
    Expression ="[Item Master_1].[Cost Prc Brk1]"
    Expression ="[Item Master_1].[Cost Qty Brk1]"
    Expression ="[Item Master_1].[Cost Prc Brk1]"
End
Begin Joins
    LeftTable ="Item Master"
    RightTable ="Item Master_1"
    Expression ="[Item Master].[Wholesale Set Leader] = [Item Master_1].[HSI Item#]"
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
        dbText "Name" ="[Item Master].[Wholesale Set Leader]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master_1].[Cost Qty Brk1]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master_1].[Cost Prc Brk1]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1001"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1002"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =994
    Bottom =630
    Left =-1
    Top =-1
    Right =966
    Bottom =293
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =351
        Bottom =233
        Top =0
        Name ="Item Master"
        Name =""
    End
    Begin
        Left =399
        Top =12
        Right =745
        Bottom =241
        Top =0
        Name ="Item Master_1"
        Name =""
    End
End
