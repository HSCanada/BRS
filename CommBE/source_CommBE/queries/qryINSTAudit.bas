Operation =1
Option =0
Where ="(((comm_customer_master.sales_plan_cd) Like \"denc*\"))"
Begin InputTables
    Name ="comm_customer_master"
    Name ="comm_salesperson_code_map"
End
Begin OutputColumns
    Expression ="comm_customer_master.hsi_shipto_id"
    Expression ="comm_customer_master.comm_group_cd"
    Expression ="comm_customer_master.note_txt"
    Expression ="comm_customer_master.sales_plan_cd"
    Expression ="comm_salesperson_code_map.salesperson_nm"
End
Begin Joins
    LeftTable ="comm_customer_master"
    RightTable ="comm_salesperson_code_map"
    Expression ="comm_customer_master.salesperson_cd = comm_salesperson_code_map.salesperson_cd"
    Flag =2
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
        dbText "Name" ="zzzCustList.hsi_customer_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzCustList.note_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.comm_group_cd"
        dbInteger "ColumnWidth" ="2085"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.note_txt"
        dbInteger "ColumnWidth" ="5295"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_code_map.salesperson_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.sales_plan_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1462
    Bottom =962
    Left =-1
    Top =-1
    Right =1424
    Bottom =662
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =240
        Top =12
        Right =554
        Bottom =420
        Top =0
        Name ="comm_customer_master"
        Name =""
    End
    Begin
        Left =709
        Top =64
        Right =853
        Bottom =208
        Top =0
        Name ="comm_salesperson_code_map"
        Name =""
    End
End
