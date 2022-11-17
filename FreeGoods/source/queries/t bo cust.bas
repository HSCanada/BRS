Operation =1
Option =0
Begin InputTables
    Name ="zzzShipto"
    Name ="BRS_Customer"
End
Begin OutputColumns
    Expression ="zzzShipto.ST"
    Alias ="Expr1"
    Expression ="[ShipTo] & \" | \" & [PracticeName]"
End
Begin Joins
    LeftTable ="zzzShipto"
    RightTable ="BRS_Customer"
    Expression ="zzzShipto.ST = BRS_Customer.ShipTo"
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
        dbText "Name" ="Expr1"
        dbInteger "ColumnWidth" ="5430"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzShipto.ST"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1541
    Bottom =918
    Left =-1
    Top =-1
    Right =1255
    Bottom =673
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =68
        Top =33
        Right =212
        Bottom =177
        Top =0
        Name ="zzzShipto"
        Name =""
    End
    Begin
        Left =295
        Top =69
        Right =439
        Bottom =213
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
End
