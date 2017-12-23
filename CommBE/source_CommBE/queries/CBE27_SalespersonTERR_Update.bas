Operation =1
Option =0
Where ="(((comm_salesperson_code_map.comm_plan_id)<>[comm_salesperson_master]![comm_plan"
    "_id]))"
Begin InputTables
    Name ="comm_salesperson_master"
    Name ="comm_salesperson_code_map"
End
Begin OutputColumns
    Expression ="comm_salesperson_master.salesperson_key_id"
    Expression ="comm_salesperson_code_map.salesperson_cd"
    Alias ="SRC_salesperson"
    Expression ="comm_salesperson_master.salesperson_nm"
    Alias ="DST_salesperson"
    Expression ="comm_salesperson_code_map.salesperson_nm"
    Alias ="SRC_comm_plan_id"
    Expression ="comm_salesperson_master.comm_plan_id"
    Alias ="DST_comm_plan_id"
    Expression ="comm_salesperson_code_map.comm_plan_id"
End
Begin Joins
    LeftTable ="comm_salesperson_master"
    RightTable ="comm_salesperson_code_map"
    Expression ="comm_salesperson_master.salesperson_key_id = comm_salesperson_code_map.salespers"
        "on_key_id"
    Flag =1
End
Begin OrderBy
    Expression ="comm_salesperson_master.salesperson_key_id"
    Flag =0
    Expression ="comm_salesperson_code_map.salesperson_cd"
    Flag =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbText "Description" ="Syncronize Commission Plans from FSC to AccPac code"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="comm_salesperson_code_map.salesperson_cd"
        dbInteger "ColumnWidth" ="1545"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_key_id"
        dbInteger "ColumnWidth" ="2505"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SRC_comm_plan_id"
        dbInteger "ColumnWidth" ="3900"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="DST_comm_plan_id"
        dbInteger "ColumnWidth" ="4200"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SRC_salesperson"
        dbInteger "ColumnWidth" ="4875"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="DST_salesperson"
        dbInteger "ColumnWidth" ="5220"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-4
    Top =-23
    Right =1515
    Bottom =1008
    Left =-1
    Top =-1
    Right =1496
    Bottom =396
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =38
        Top =6
        Right =285
        Bottom =218
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
    Begin
        Left =493
        Top =6
        Right =719
        Bottom =188
        Top =0
        Name ="comm_salesperson_code_map"
        Name =""
    End
End
