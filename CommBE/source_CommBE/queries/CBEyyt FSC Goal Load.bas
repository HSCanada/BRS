Operation =1
Option =0
Where ="(((comm_salesperson_master.comm_plan_id) Like \"FSC*\" And (comm_salesperson_mas"
    "ter.comm_plan_id)<>\"FSCDP00\"))"
Begin InputTables
    Name ="comm_salesperson_master"
    Name ="comm_salesperson_territory_map"
End
Begin OutputColumns
    Expression ="comm_salesperson_territory_map.branch_nm"
    Expression ="comm_salesperson_master.employee_num"
    Expression ="comm_salesperson_master.hsi_salesperson_cd"
    Expression ="comm_salesperson_master.salesperson_key_id"
    Expression ="comm_salesperson_master.salesperson_nm"
    Expression ="comm_salesperson_master.territory_start_dt"
    Expression ="comm_salesperson_master.comm_plan_id"
    Expression ="comm_salesperson_master.note_txt"
End
Begin Joins
    LeftTable ="comm_salesperson_master"
    RightTable ="comm_salesperson_territory_map"
    Expression ="comm_salesperson_master.salesperson_territory_cd = comm_salesperson_territory_ma"
        "p.salesperson_territory_cd"
    Flag =1
End
Begin OrderBy
    Expression ="comm_salesperson_territory_map.branch_nm"
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
        dbText "Name" ="comm_salesperson_master.salesperson_nm"
        dbInteger "ColumnWidth" ="3225"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_territory_map.branch_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.employee_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.hsi_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.territory_start_dt"
        dbInteger "ColumnWidth" ="2010"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.note_txt"
        dbInteger "ColumnWidth" ="5550"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1592
    Bottom =1009
    Left =-1
    Top =-1
    Right =1569
    Bottom =294
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =38
        Top =6
        Right =431
        Bottom =358
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
    Begin
        Left =453
        Top =6
        Right =829
        Bottom =285
        Top =0
        Name ="comm_salesperson_territory_map"
        Name =""
    End
End
