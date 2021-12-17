Operation =1
Option =0
Begin InputTables
    Name ="t model rate ess"
    Name ="t model rate ess"
    Alias ="t model rate ess_1"
End
Begin OutputColumns
    Expression ="[t model rate ess].item_comm_group_cd"
    Expression ="[t model rate ess_1].item_comm_group_cd"
    Expression ="[t model rate ess].comm_rt"
    Expression ="[t model rate ess_1].comm_rt"
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
        dbText "Name" ="[t model rate fsc_1].comm_rt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[t model rate fsc_1].item_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[t model rate fsc].comm_rt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[t model rate fsc].item_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[t model rate ess_1].comm_rt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[t model rate ess].comm_rt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[t model rate ess_1].item_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[t model rate ess].item_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1560
    Bottom =938
    Left =-1
    Top =-1
    Right =1536
    Bottom =584
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =65
        Top =101
        Right =209
        Bottom =245
        Top =0
        Name ="t model rate ess"
        Name =""
    End
    Begin
        Left =307
        Top =121
        Right =451
        Bottom =265
        Top =0
        Name ="t model rate ess_1"
        Name =""
    End
End
