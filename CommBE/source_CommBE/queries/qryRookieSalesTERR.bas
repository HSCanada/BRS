Operation =1
Option =0
Where ="(((comm_transaction.fiscal_yearmo_num) Between \"201410\" And \"201410\") AND (("
    "comm_transaction.source_cd)=\"JDE\"))"
Begin InputTables
    Name ="comm_transaction"
    Name ="comm_salesperson_master"
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
    LeftTable ="comm_transaction"
    RightTable ="comm_salesperson_master"
    Expression ="comm_transaction.salesperson_key_id = comm_salesperson_master.salesperson_key_id"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="comm_rookie_track"
    Expression ="comm_transaction.salesperson_key_id = comm_rookie_track.salesperson_key_id"
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
    Left =0
    Top =40
    Right =1499
    Bottom =1004
    Left =-1
    Top =-1
    Right =1467
    Bottom =269
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =226
        Top =10
        Right =524
        Bottom =406
        Top =0
        Name ="comm_transaction"
        Name =""
    End
    Begin
        Left =706
        Top =1
        Right =1306
        Bottom =527
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
    Begin
        Left =19
        Top =63
        Right =163
        Bottom =207
        Top =0
        Name ="comm_rookie_track"
        Name =""
    End
End
