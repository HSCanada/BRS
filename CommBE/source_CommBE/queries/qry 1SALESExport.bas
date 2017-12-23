Operation =1
Option =0
Begin InputTables
    Name ="zzzItemList"
    Name ="comm_salesperson_code_map"
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Expression ="comm_salesperson_code_map.salesperson_cd"
    Expression ="comm_salesperson_master.comm_plan_id"
    Expression ="comm_salesperson_master.salesperson_nm"
    Expression ="comm_salesperson_master.branch_cd"
End
Begin Joins
    LeftTable ="zzzItemList"
    RightTable ="comm_salesperson_code_map"
    Expression ="zzzItemList.item_id = comm_salesperson_code_map.salesperson_cd"
    Flag =1
    LeftTable ="comm_salesperson_code_map"
    RightTable ="comm_salesperson_master"
    Expression ="comm_salesperson_code_map.salesperson_key_id = comm_salesperson_master.salespers"
        "on_key_id"
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
        dbText "Name" ="zzzItemList.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_code_map.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.branch_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-30
    Right =1624
    Bottom =999
    Left =-1
    Top =-1
    Right =1293
    Bottom =668
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =35
        Top =109
        Right =376
        Bottom =331
        Top =0
        Name ="zzzItemList"
        Name =""
    End
    Begin
        Left =477
        Top =143
        Right =802
        Bottom =411
        Top =0
        Name ="comm_salesperson_code_map"
        Name =""
    End
    Begin
        Left =894
        Top =180
        Right =1271
        Bottom =500
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
End
