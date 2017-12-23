Operation =1
Option =0
Where ="(((comm_transaction.fiscal_yearmo_num) Between \"201201\" And \"201212\") AND (("
    "comm_transaction.source_cd)=\"jde\") AND ((comm_transaction.sales_category_cd)=\""
    "MERCH\") AND ((comm_salesperson_code_map.branch_cd)=\"MNTRL\"))"
Begin InputTables
    Name ="comm_transaction"
    Name ="comm_salesperson_code_map"
End
Begin OutputColumns
    Expression ="comm_transaction.fiscal_yearmo_num"
    Expression ="comm_transaction.hsi_shipto_id"
    Alias ="FirstOfsalesperson_key_id"
    Expression ="First(comm_transaction.salesperson_key_id)"
    Alias ="Merch_amt"
    Expression ="Sum(comm_transaction.transaction_amt)"
End
Begin Joins
    LeftTable ="comm_transaction"
    RightTable ="comm_salesperson_code_map"
    Expression ="comm_transaction.salesperson_cd = comm_salesperson_code_map.salesperson_cd"
    Flag =1
End
Begin Groups
    Expression ="comm_transaction.fiscal_yearmo_num"
    GroupLevel =0
    Expression ="comm_transaction.hsi_shipto_id"
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
        dbText "Name" ="comm_transaction.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Merch_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfsalesperson_key_id"
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
        Left =48
        Top =12
        Right =477
        Bottom =397
        Top =0
        Name ="comm_transaction"
        Name =""
    End
    Begin
        Left =542
        Top =102
        Right =907
        Bottom =437
        Top =0
        Name ="comm_salesperson_code_map"
        Name =""
    End
End
