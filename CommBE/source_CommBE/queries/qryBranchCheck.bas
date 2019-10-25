Operation =1
Option =0
Where ="(((comm_transaction.fiscal_yearmo_num) Between \"201201\" And \"201212\") And (("
    "comm_transaction.source_cd)=\"JDE\") And ((comm_salesperson_code_map_1.branch_cd"
    ")<>comm_salesperson_code_map!branch_cd))"
Begin InputTables
    Name ="comm_customer_master"
    Name ="comm_salesperson_code_map"
    Name ="comm_transaction"
    Name ="comm_salesperson_code_map"
    Alias ="comm_salesperson_code_map_1"
End
Begin OutputColumns
    Expression ="comm_customer_master.hsi_shipto_id"
    Alias ="Org_Branch"
    Expression ="comm_salesperson_code_map_1.branch_cd"
    Alias ="New_Branch"
    Expression ="comm_salesperson_code_map.branch_cd"
    Expression ="comm_salesperson_code_map.salesperson_nm"
    Alias ="SumOftransaction_amt"
    Expression ="Sum(comm_transaction.transaction_amt)"
End
Begin Joins
    LeftTable ="comm_customer_master"
    RightTable ="comm_salesperson_code_map"
    Expression ="comm_customer_master.salesperson_cd = comm_salesperson_code_map.salesperson_cd"
    Flag =1
    LeftTable ="comm_customer_master"
    RightTable ="comm_transaction"
    Expression ="comm_customer_master.hsi_shipto_id = comm_transaction.hsi_shipto_id"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="comm_salesperson_code_map_1"
    Expression ="comm_transaction.salesperson_cd = comm_salesperson_code_map_1.salesperson_cd"
    Flag =1
End
Begin Groups
    Expression ="comm_customer_master.hsi_shipto_id"
    GroupLevel =0
    Expression ="comm_salesperson_code_map_1.branch_cd"
    GroupLevel =0
    Expression ="comm_salesperson_code_map.branch_cd"
    GroupLevel =0
    Expression ="comm_salesperson_code_map.salesperson_nm"
    GroupLevel =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="0"
dbByte "RecordsetType" ="2"
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
        dbText "Name" ="Org_Branch"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="New_Branch"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOftransaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_code_map.salesperson_nm"
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
    Bottom =678
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =437
        Top =61
        Right =723
        Bottom =475
        Top =0
        Name ="comm_customer_master"
        Name =""
    End
    Begin
        Left =811
        Top =63
        Right =1188
        Bottom =340
        Top =0
        Name ="comm_salesperson_code_map"
        Name =""
    End
    Begin
        Left =128
        Top =182
        Right =272
        Bottom =326
        Top =0
        Name ="comm_transaction"
        Name =""
    End
    Begin
        Left =906
        Top =402
        Right =1050
        Bottom =546
        Top =0
        Name ="comm_salesperson_code_map_1"
        Name =""
    End
End
