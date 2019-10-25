Operation =1
Option =0
Where ="(((comm_plan_group_rate.comm_group_cd)<>'' And (comm_plan_group_rate.comm_group_"
    "cd) Like \"dig*\") AND ((comm_plan_group_rate.comm_plan_id) Like \"ess*\") AND ("
    "(comm_group.source_cd)<>\"BONUS\" And (comm_group.source_cd)<>\"PAYROLL\"))"
Begin InputTables
    Name ="comm_plan_group_rate"
    Name ="comm_group"
End
Begin OutputColumns
    Expression ="comm_plan_group_rate.comm_group_cd"
    Expression ="comm_group.comm_group_desc"
    Expression ="comm_plan_group_rate.comm_plan_id"
    Expression ="comm_plan_group_rate.comm_base_rt"
    Expression ="comm_plan_group_rate.note_txt"
    Expression ="comm_plan_group_rate.active_ind"
    Expression ="comm_plan_group_rate.show_ind"
    Expression ="comm_group.source_cd"
End
Begin Joins
    LeftTable ="comm_plan_group_rate"
    RightTable ="comm_group"
    Expression ="comm_plan_group_rate.comm_group_cd = comm_group.comm_group_cd"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbMemo "OrderBy" ="[t rate set].[comm_group_cd], [t rate set].[active_ind]"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="comm_plan_group_rate.show_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_plan_group_rate.note_txt"
        dbInteger "ColumnWidth" ="1215"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_plan_group_rate.active_ind"
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
    Begin
        dbText "Name" ="comm_plan_group_rate.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_group.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_plan_group_rate.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1541
    Bottom =976
    Left =-1
    Top =-1
    Right =1523
    Bottom =391
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =192
        Bottom =156
        Top =0
        Name ="comm_plan_group_rate"
        Name =""
    End
    Begin
        Left =378
        Top =33
        Right =522
        Bottom =177
        Top =0
        Name ="comm_group"
        Name =""
    End
End
