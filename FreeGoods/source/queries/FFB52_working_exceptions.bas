Operation =1
Option =0
Begin InputTables
    Name ="fg_exempt_code"
End
Begin OutputColumns
    Expression ="fg_exempt_code.fg_exempt_cd"
    Expression ="fg_exempt_code.fg_exempt_desc"
    Expression ="fg_exempt_code.note_txt"
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
        dbText "Name" ="fg_exempt_code.note_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_exempt_code.fg_exempt_desc"
        dbInteger "ColumnWidth" ="4260"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_exempt_code.fg_exempt_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1587
    Bottom =798
    Left =-1
    Top =-1
    Right =1571
    Bottom =639
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =91
        Top =117
        Right =452
        Bottom =467
        Top =0
        Name ="fg_exempt_code"
        Name =""
    End
End
