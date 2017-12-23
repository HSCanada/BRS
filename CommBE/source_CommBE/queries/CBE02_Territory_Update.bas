Operation =1
Option =0
Where ="(((comm_salesperson_code_map.salesperson_id)<>[comm_salesperson_code_map_stage]!"
    "[salesperson_id])) OR (((comm_salesperson_code_map.salesperson_cd) Not In (\"CZ2"
    "PO\",\"AZAZZ\",\"CORP\")) AND ((comm_salesperson_code_map.branch_cd)<>[comm_sale"
    "sperson_code_map_stage]![branch_cd])) OR (((comm_salesperson_code_map.salesperso"
    "n_nm)<>[comm_salesperson_code_map_stage]![salesperson_nm]))"
Begin InputTables
    Name ="comm_salesperson_code_map_stage"
    Name ="comm_salesperson_code_map"
End
Begin OutputColumns
    Expression ="comm_salesperson_code_map.salesperson_cd"
    Expression ="comm_salesperson_code_map_stage.salesperson_nm"
    Alias ="NEW_salesperson_id"
    Expression ="comm_salesperson_code_map_stage.salesperson_id"
    Expression ="comm_salesperson_code_map.salesperson_id"
    Alias ="NEW_branch_cd"
    Expression ="comm_salesperson_code_map_stage.branch_cd"
    Expression ="comm_salesperson_code_map.branch_cd"
    Alias ="NEW_salesperson_nm"
    Expression ="comm_salesperson_code_map_stage.salesperson_nm"
    Expression ="comm_salesperson_code_map.salesperson_nm"
End
Begin Joins
    LeftTable ="comm_salesperson_code_map_stage"
    RightTable ="comm_salesperson_code_map"
    Expression ="comm_salesperson_code_map_stage.salesperson_cd = comm_salesperson_code_map.sales"
        "person_cd"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbBoolean "FailOnError" ="0"
Begin
    Begin
        dbText "Name" ="comm_salesperson_code_map.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_code_map.salesperson_nm"
        dbInteger "ColumnWidth" ="5220"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_code_map.salesperson_id"
        dbInteger "ColumnWidth" ="5070"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_code_map.branch_cd"
        dbInteger "ColumnWidth" ="4620"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="NEW_salesperson_id"
        dbInteger "ColumnWidth" ="5730"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="NEW_branch_cd"
        dbInteger "ColumnWidth" ="5280"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="NEW_salesperson_nm"
        dbInteger "ColumnWidth" ="5880"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_code_map_stage.salesperson_nm"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="5880"
        dbBoolean "ColumnHidden" ="0"
    End
End
Begin
    State =2
    Left =-8
    Top =-30
    Right =1589
    Bottom =999
    Left =-1
    Top =-1
    Right =1531
    Bottom =243
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =55
        Top =90
        Right =256
        Bottom =300
        Top =0
        Name ="comm_salesperson_code_map_stage"
        Name =""
    End
    Begin
        Left =388
        Top =53
        Right =733
        Bottom =317
        Top =0
        Name ="comm_salesperson_code_map"
        Name =""
    End
End
