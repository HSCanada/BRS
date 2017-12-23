Operation =1
Option =0
Begin InputTables
    Name ="comm_plan_group_rate"
    Name ="comm_group"
End
Begin OutputColumns
    Expression ="comm_plan_group_rate.comm_plan_id"
    Expression ="comm_plan_group_rate.comm_group_cd"
    Expression ="comm_group.comm_group_desc"
    Expression ="comm_plan_group_rate.comm_base_rt"
End
Begin Joins
    LeftTable ="comm_plan_group_rate"
    RightTable ="comm_group"
    Expression ="comm_plan_group_rate.comm_group_cd = comm_group.comm_group_cd"
    Flag =1
End
Begin OrderBy
    Expression ="comm_plan_group_rate.comm_plan_id"
    Flag =0
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
        dbText "Name" ="comm_plan_group_rate.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_plan_group_rate.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_plan_group_rate.comm_base_rt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_group.comm_group_desc"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1493
    Bottom =1004
    Left =-1
    Top =-1
    Right =1470
    Bottom =694
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =662
        Top =94
        Right =1063
        Bottom =408
        Top =0
        Name ="comm_plan_group_rate"
        Name =""
    End
    Begin
        Left =1123
        Top =118
        Right =1467
        Bottom =443
        Top =0
        Name ="comm_group"
        Name =""
    End
End
