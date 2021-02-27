Operation =1
Option =0
Having ="(((Left([comm_plan_id],3))<>\"\") AND ((comm_plan_group_rate.source_cd)<>\"IMP\""
    "))"
Begin InputTables
    Name ="comm_plan_group_rate"
End
Begin OutputColumns
    Alias ="Plan3"
    Expression ="Left([comm_plan_id],3)"
    Expression ="comm_plan_group_rate.source_cd"
    Expression ="comm_plan_group_rate.item_comm_group_cd"
    Expression ="comm_plan_group_rate.disp_comm_group_cd"
    Alias ="MaxOfcomm_rt"
    Expression ="Max(comm_plan_group_rate.comm_rt)"
End
Begin Groups
    Expression ="Left([comm_plan_id],3)"
    GroupLevel =0
    Expression ="comm_plan_group_rate.source_cd"
    GroupLevel =0
    Expression ="comm_plan_group_rate.item_comm_group_cd"
    GroupLevel =0
    Expression ="comm_plan_group_rate.disp_comm_group_cd"
    GroupLevel =0
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
        dbText "Name" ="comm_plan_group_rate.disp_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_plan_group_rate.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_plan_group_rate.item_comm_group_cd"
        dbInteger "ColumnWidth" ="2490"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="MaxOfcomm_rt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Plan3"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1255
    Bottom =921
    Left =-1
    Top =-1
    Right =1231
    Bottom =601
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =88
        Top =30
        Right =570
        Bottom =352
        Top =0
        Name ="comm_plan_group_rate"
        Name =""
    End
End
