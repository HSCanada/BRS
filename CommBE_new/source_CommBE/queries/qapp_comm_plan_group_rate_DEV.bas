Operation =3
Name ="comm_plan_group_rate_DEV"
Option =0
Begin InputTables
    Name ="STAGE_comm_plan_group_rate-add"
End
Begin OutputColumns
    Name ="comm_plan_id"
    Expression ="[STAGE_comm_plan_group_rate-add].comm_plan_id"
    Name ="item_comm_group_cd"
    Expression ="[STAGE_comm_plan_group_rate-add].item_comm_group_cd"
    Name ="cust_comm_group_cd"
    Expression ="[STAGE_comm_plan_group_rate-add].cust_comm_group_cd"
    Name ="source_cd"
    Expression ="[STAGE_comm_plan_group_rate-add].source_cd"
    Name ="disp_comm_group_cd"
    Expression ="[STAGE_comm_plan_group_rate-add].disp_comm_group_cd"
    Name ="comm_rt"
    Expression ="[STAGE_comm_plan_group_rate-add].comm_rt"
    Name ="active_ind"
    Expression ="[STAGE_comm_plan_group_rate-add].active_ind"
    Name ="note_txt"
    Expression ="[STAGE_comm_plan_group_rate-add].note_txt"
    Name ="show_ind"
    Expression ="[STAGE_comm_plan_group_rate-add].show_ind"
    Name ="fg_comm_group_cd"
    Expression ="[STAGE_comm_plan_group_rate-add].fg_comm_group_cd"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbByte "Orientation" ="0"
Begin
    Begin
        dbText "Name" ="[STAGE_comm_plan_group_rate-add].comm_rt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[STAGE_comm_plan_group_rate-add].fg_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[STAGE_comm_plan_group_rate-add].disp_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[STAGE_comm_plan_group_rate-add].source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[STAGE_comm_plan_group_rate-add].comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[STAGE_comm_plan_group_rate-add].cust_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[STAGE_comm_plan_group_rate-add].item_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[STAGE_comm_plan_group_rate-add].active_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[STAGE_comm_plan_group_rate-add].note_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[STAGE_comm_plan_group_rate-add].show_ind"
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
    Bottom =618
    Left =0
    Top =0
    ColumnsShown =651
    Begin
        Left =19
        Top =32
        Right =479
        Bottom =458
        Top =0
        Name ="STAGE_comm_plan_group_rate-add"
        Name =""
    End
End
