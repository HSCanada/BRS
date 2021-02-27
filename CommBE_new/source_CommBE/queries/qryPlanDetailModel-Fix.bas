Operation =1
Option =0
Where ="(((Left([comm_plan_id],3))=zzzDetailupdate!plan3) And ((comm_plan_group_rate.sho"
    "w_ind)=False) And ((zzzDetailupdate.show)=\"yes\"))"
Begin InputTables
    Name ="comm_plan_group_rate"
    Name ="zzzDetailupdate"
End
Begin OutputColumns
    Alias ="Plan3"
    Expression ="Left([comm_plan_id],3)"
    Expression ="comm_plan_group_rate.source_cd"
    Expression ="comm_plan_group_rate.item_comm_group_cd"
    Expression ="comm_plan_group_rate.disp_comm_group_cd"
    Expression ="comm_plan_group_rate.comm_rt"
    Expression ="comm_plan_group_rate.show_ind"
    Expression ="zzzDetailupdate.show"
    Expression ="comm_plan_group_rate.note_txt"
End
Begin Joins
    LeftTable ="comm_plan_group_rate"
    RightTable ="zzzDetailupdate"
    Expression ="comm_plan_group_rate.item_comm_group_cd = zzzDetailupdate.item_comm_group_cd"
    Flag =1
    LeftTable ="comm_plan_group_rate"
    RightTable ="zzzDetailupdate"
    Expression ="comm_plan_group_rate.source_cd = zzzDetailupdate.source_cd"
    Flag =1
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
    Begin
        dbText "Name" ="comm_plan_group_rate.show_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_plan_group_rate.comm_rt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzDetailupdate.Plan3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzDetailupdate.show"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_plan_group_rate.note_txt"
        dbInteger "ColumnWidth" ="4500"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =1280
    Bottom =946
    Left =-1
    Top =-1
    Right =1256
    Bottom =487
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =88
        Top =30
        Right =570
        Bottom =352
        Top =0
        Name ="comm_plan_group_rate"
        Name =""
    End
    Begin
        Left =702
        Top =39
        Right =985
        Bottom =249
        Top =0
        Name ="zzzDetailupdate"
        Name =""
    End
End
