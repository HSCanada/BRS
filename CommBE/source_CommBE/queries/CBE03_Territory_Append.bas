Operation =3
Name ="comm_salesperson_code_map"
Option =0
Where ="(((comm_salesperson_code_map.salesperson_cd) Is Null))"
Begin InputTables
    Name ="comm_salesperson_code_map_stage"
    Name ="comm_salesperson_code_map"
End
Begin OutputColumns
    Name ="salesperson_cd"
    Expression ="comm_salesperson_code_map_stage.salesperson_cd"
    Name ="salesperson_nm"
    Expression ="comm_salesperson_code_map_stage.salesperson_nm"
    Name ="salesperson_id"
    Expression ="comm_salesperson_code_map_stage.salesperson_id"
    Name ="branch_cd"
    Expression ="comm_salesperson_code_map_stage.branch_cd"
    Alias ="salesperson_key_id"
    Name ="salesperson_key_id"
    Expression ="\"\""
    Alias ="comm_plan_id"
    Name ="comm_plan_id"
    Expression ="\"\""
End
Begin Joins
    LeftTable ="comm_salesperson_code_map_stage"
    RightTable ="comm_salesperson_code_map"
    Expression ="comm_salesperson_code_map_stage.salesperson_cd = comm_salesperson_code_map.sales"
        "person_cd"
    Flag =2
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
        dbText "Name" ="comm_customer_master.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.hsi_billto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.customer_nm"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3525"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_customer_master.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_hsi_stage.hsi_billto_id"
        dbInteger "ColumnWidth" ="4350"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_hsi_stage.ship_mailing_nm"
        dbInteger "ColumnWidth" ="4395"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_hsi_stage.hsi_territory_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_code_map_stage.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_code_map.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_code_map_stage.branch_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_code_map.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_code_map.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1539
    Bottom =1004
    Left =-1
    Top =-1
    Right =1516
    Bottom =566
    Left =0
    Top =0
    ColumnsShown =651
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
