Operation =1
Option =0
Where ="(((comm_transaction.fiscal_yearmo_num) Between \"201001\" And \"201012\") AND (("
    "comm_transaction.ess_salesperson_key_id)<>\"\") AND ((comm_transaction.source_cd"
    ")<>\"PAYROLL\") AND ((comm_transaction.ess_comm_group_cd) Not In ('ITMEQ0','ITMS"
    "ER','ITMPAR','ITMSND','ITMCAM')))"
Begin InputTables
    Name ="comm_transaction"
    Name ="comm_salesperson_master"
    Name ="comm_salesperson_master"
    Alias ="comm_salesperson_master_1"
End
Begin OutputColumns
    Alias ="ESS"
    Expression ="comm_salesperson_master_1.salesperson_nm"
    Expression ="comm_salesperson_master.salesperson_nm"
    Alias ="sales_2010"
    Expression ="Sum(comm_transaction.transaction_amt)"
End
Begin Joins
    LeftTable ="comm_transaction"
    RightTable ="comm_salesperson_master"
    Expression ="comm_transaction.salesperson_key_id = comm_salesperson_master.salesperson_key_id"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="comm_salesperson_master_1"
    Expression ="comm_transaction.ess_salesperson_key_id = comm_salesperson_master_1.salesperson_"
        "key_id"
    Flag =1
End
Begin Groups
    Expression ="comm_salesperson_master_1.salesperson_nm"
    GroupLevel =0
    Expression ="comm_salesperson_master.salesperson_nm"
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
        dbText "Name" ="comm_salesperson_master.salesperson_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ESS"
        dbInteger "ColumnWidth" ="3165"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="sales_2010"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =16
    Right =1557
    Bottom =980
    Left =-1
    Top =-1
    Right =1534
    Bottom =598
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =48
        Top =12
        Right =341
        Bottom =419
        Top =0
        Name ="comm_transaction"
        Name =""
    End
    Begin
        Left =493
        Top =-5
        Right =892
        Bottom =321
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
    Begin
        Left =570
        Top =383
        Right =714
        Bottom =527
        Top =0
        Name ="comm_salesperson_master_1"
        Name =""
    End
End
