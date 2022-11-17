Operation =1
Option =0
Begin InputTables
    Name ="zzzShipto"
End
Begin OutputColumns
    Alias ="order"
    Expression ="zzzShipto.ST"
    Expression ="zzzShipto.Note"
    Alias ="calmonth"
    Expression ="zzzShipto.Note2"
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
        dbText "Name" ="zzzShipto.Note"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="7575"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="calmonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="order"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1526
    Bottom =918
    Left =-1
    Top =-1
    Right =1510
    Bottom =557
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =165
        Top =73
        Right =309
        Bottom =217
        Top =0
        Name ="zzzShipto"
        Name =""
    End
End
