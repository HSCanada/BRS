Operation =1
Option =0
Begin InputTables
    Name ="zzzCustList"
    Name ="comm_customer_master"
    Name ="comm_salesperson_code_map"
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Expression ="comm_customer_master.hsi_shipto_id"
    Expression ="comm_customer_master.customer_nm"
    Expression ="comm_customer_master.salesperson_cd"
    Expression ="comm_salesperson_master.salesperson_nm"
    Expression ="comm_salesperson_master.employee_num"
    Expression ="comm_salesperson_code_map.branch_cd"
End
Begin Joins
    LeftTable ="zzzCustList"
    RightTable ="comm_customer_master"
    Expression ="zzzCustList.hsi_customer_id = comm_customer_master.hsi_shipto_id"
    Flag =1
    LeftTable ="comm_customer_master"
    RightTable ="comm_salesperson_code_map"
    Expression ="comm_customer_master.salesperson_cd = comm_salesperson_code_map.salesperson_cd"
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
        dbText "Name" ="comm_customer_master.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.customer_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.employee_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_code_map.branch_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1514
    Bottom =991
    Left =-1
    Top =-1
    Right =1482
    Bottom =634
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =192
        Bottom =156
        Top =0
        Name ="zzzCustList"
        Name =""
    End
    Begin
        Left =278
        Top =29
        Right =620
        Bottom =294
        Top =0
        Name ="comm_customer_master"
        Name =""
    End
    Begin
        Left =668
        Top =12
        Right =812
        Bottom =156
        Top =0
        Name ="comm_salesperson_code_map"
        Name =""
    End
    Begin
        Left =860
        Top =12
        Right =1004
        Bottom =156
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
End
