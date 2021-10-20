Operation =1
Option =0
Where ="(((comm_group.comm_group_desc) Like \"*free*\"))"
Begin InputTables
    Name ="comm_group"
End
Begin OutputColumns
    Expression ="comm_group.comm_group_cd"
    Expression ="comm_group.comm_group_desc"
    Expression ="comm_group.active_ind"
    Expression ="comm_group.show_ind"
    Expression ="comm_group.note_txt"
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
        dbText "Name" ="comm_group.note_txt"
        dbInteger "ColumnWidth" ="1815"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_group.active_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_group.show_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_group.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_group.comm_group_desc"
        dbInteger "ColumnWidth" ="3255"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1516
    Bottom =918
    Left =-1
    Top =-1
    Right =1500
    Bottom =656
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =45
        Top =48
        Right =390
        Bottom =436
        Top =0
        Name ="comm_group"
        Name =""
    End
End
