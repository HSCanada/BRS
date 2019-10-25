Operation =1
Option =0
Where ="(((comm_group.sort_id)>0) AND ((comm_group.show_ind)=True))"
Begin InputTables
    Name ="comm_group"
End
Begin OutputColumns
    Expression ="comm_group.comm_group_cd"
    Expression ="comm_group.comm_group_desc"
    Expression ="comm_group.sort_id"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="2"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="comm_group.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_group.comm_group_desc"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_group.sort_id"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1520
    Bottom =797
    Left =-1
    Top =-1
    Right =1504
    Bottom =380
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =125
        Top =62
        Right =558
        Bottom =271
        Top =0
        Name ="comm_group"
        Name =""
    End
End
