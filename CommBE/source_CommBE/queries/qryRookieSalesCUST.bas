Operation =1
Option =0
Where ="(((comm_transaction.source_cd)=\"JDE\") AND ((comm_transaction.salesperson_key_i"
    "d)<>\"INTERNAL\") AND ((comm_transaction.fiscal_yearmo_num) Between \"201201\" A"
    "nd \"201409\"))"
Begin InputTables
    Name ="comm_salesperson_master"
    Name ="comm_salesperson_code_map"
    Name ="comm_transaction"
    Name ="comm_customer_master"
    Name ="comm_rookie_track"
End
Begin OutputColumns
    Expression ="comm_salesperson_master.employee_num"
    Alias ="salesperson_nm"
    Expression ="First(comm_salesperson_master.salesperson_nm)"
    Expression ="comm_transaction.fiscal_yearmo_num"
    Expression ="comm_transaction.item_comm_group_cd"
    Alias ="transaction_amt"
    Expression ="Sum(comm_transaction.transaction_amt)"
    Alias ="gp_ext_amt"
    Expression ="Sum(comm_transaction.gp_ext_amt)"
End
Begin Joins
    LeftTable ="comm_salesperson_master"
    RightTable ="comm_salesperson_code_map"
    Expression ="comm_salesperson_master.salesperson_key_id = comm_salesperson_code_map.salespers"
        "on_key_id"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="comm_customer_master"
    Expression ="comm_transaction.hsi_shipto_id = comm_customer_master.hsi_shipto_id"
    Flag =1
    LeftTable ="comm_salesperson_code_map"
    RightTable ="comm_customer_master"
    Expression ="comm_salesperson_code_map.salesperson_cd = comm_customer_master.salesperson_cd"
    Flag =1
    LeftTable ="comm_salesperson_code_map"
    RightTable ="comm_rookie_track"
    Expression ="comm_salesperson_code_map.salesperson_key_id = comm_rookie_track.salesperson_key"
        "_id"
    Flag =1
End
Begin Groups
    Expression ="comm_salesperson_master.employee_num"
    GroupLevel =0
    Expression ="comm_transaction.fiscal_yearmo_num"
    GroupLevel =0
    Expression ="comm_transaction.item_comm_group_cd"
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
        dbText "Name" ="comm_transaction.item_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.employee_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="salesperson_nm"
        dbInteger "ColumnWidth" ="2730"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="gp_ext_amt"
        dbInteger "ColumnWidth" ="2265"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="transaction_amt"
        dbInteger "ColumnWidth" ="2700"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =23
    Top =14
    Right =1522
    Bottom =978
    Left =-1
    Top =-1
    Right =1467
    Bottom =444
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =406
        Top =31
        Right =1006
        Bottom =557
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
    Begin
        Left =256
        Top =137
        Right =508
        Bottom =281
        Top =0
        Name ="comm_salesperson_code_map"
        Name =""
    End
    Begin
        Left =1187
        Top =30
        Right =1485
        Bottom =426
        Top =0
        Name ="comm_transaction"
        Name =""
    End
    Begin
        Left =53
        Top =15
        Right =197
        Bottom =159
        Top =0
        Name ="comm_customer_master"
        Name =""
    End
    Begin
        Left =53
        Top =204
        Right =197
        Bottom =348
        Top =0
        Name ="comm_rookie_track"
        Name =""
    End
End
