Operation =4
Option =0
Begin InputTables
    Name ="STAGE_comm_plan_group_rate-update"
    Name ="comm_plan_group_rate"
End
Begin OutputColumns
    Name ="comm_plan_group_rate.comm_rt"
    Expression ="[comm_rt_NEW]"
    Name ="comm_plan_group_rate.note_txt"
    Expression ="[note_txt_NEW]"
End
Begin Joins
    LeftTable ="STAGE_comm_plan_group_rate-update"
    RightTable ="comm_plan_group_rate"
    Expression ="[STAGE_comm_plan_group_rate-update].calc_key = comm_plan_group_rate.calc_key"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
dbByte "Orientation" ="0"
Begin
    Begin
        dbText "Name" ="[STAGE_comm_plan_group_rate-update].calc_key"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[STAGE_comm_plan_group_rate-update].disp_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[STAGE_comm_plan_group_rate-update].source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[STAGE_comm_plan_group_rate-update].cust_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[STAGE_comm_plan_group_rate-update].item_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[STAGE_comm_plan_group_rate-update].comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_plan_group_rate_DEV.note_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_plan_group_rate_DEV.comm_rt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[STAGE_comm_plan_group_rate-update].comm_rt_NEW"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[STAGE_comm_plan_group_rate-update].note_txt_NEW"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_plan_group_rate.comm_rt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_plan_group_rate.note_txt"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1568
    Bottom =938
    Left =-1
    Top =-1
    Right =1544
    Bottom =584
    Left =0
    Top =0
    ColumnsShown =579
    Begin
        Left =63
        Top =53
        Right =274
        Bottom =253
        Top =0
        Name ="STAGE_comm_plan_group_rate-update"
        Name =""
    End
    Begin
        Left =653
        Top =29
        Right =797
        Bottom =173
        Top =0
        Name ="comm_plan_group_rate"
        Name =""
    End
End
