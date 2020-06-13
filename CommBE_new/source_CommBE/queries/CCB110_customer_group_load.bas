Operation =1
Option =0
Begin InputTables
    Name ="zzzShipto"
End
Begin OutputColumns
    Expression ="zzzShipto.ST"
    Expression ="zzzShipto.Note"
    Expression ="zzzShipto.Note2"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbBoolean "FailOnError" ="0"
Begin
    Begin
        dbText "Name" ="zzzShipto.Note"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzShipto.ST"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzShipto.Note2"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-30
    Right =1217
    Bottom =825
    Left =-1
    Top =-1
    Right =1193
    Bottom =237
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =84
        Top =34
        Right =228
        Bottom =178
        Top =0
        Name ="zzzShipto"
        Name =""
    End
End
