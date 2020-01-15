Operation =1
Option =0
Begin InputTables
    Name ="zzzItem"
End
Begin OutputColumns
    Expression ="zzzItem.Item"
    Alias ="group"
    Expression ="zzzItem.Note1"
    Alias ="note"
    Expression ="zzzItem.Note2"
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
        dbText "Name" ="zzzItem.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="group"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="note"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =-340
    Top =37
    Right =1120
    Bottom =957
    Left =-1
    Top =-1
    Right =1436
    Bottom =271
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =24
        Top =12
        Right =168
        Bottom =156
        Top =0
        Name ="zzzItem"
        Name =""
    End
End
