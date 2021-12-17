Operation =1
Option =0
Begin InputTables
    Name ="t model rate fsc"
    Name ="t model rate fsc"
    Alias ="t model rate fsc_1"
End
Begin OutputColumns
    Expression ="[t model rate fsc].item_comm_group_cd"
    Expression ="[t model rate fsc_1].item_comm_group_cd"
    Expression ="[t model rate fsc].comm_rt"
    Expression ="[t model rate fsc_1].comm_rt"
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
    Bottom =618
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =46
        Top =56
        Right =190
        Bottom =200
        Top =0
        Name ="t model rate fsc"
        Name =""
    End
    Begin
        Left =270
        Top =75
        Right =414
        Bottom =219
        Top =0
        Name ="t model rate fsc_1"
        Name =""
    End
End
