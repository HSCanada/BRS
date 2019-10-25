Operation =1
Option =0
Where ="(((comm_transaction.fiscal_yearmo_num)>=\"201001\") AND ((comm_transaction.sourc"
    "e_cd)<>\"PAYROLL\") AND ((comm_transaction.comm_plan_id) Like \"FSC*\"))"
Begin InputTables
    Name ="comm_transaction"
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Expression ="comm_transaction.fiscal_yearmo_num"
    Expression ="comm_transaction.item_comm_group_cd"
    Expression ="comm_transaction.source_cd"
    Expression ="comm_salesperson_master.employee_num"
    Alias ="SumOftransaction_amt"
    Expression ="Sum(comm_transaction.transaction_amt)"
    Alias ="SumOfgp_ext_amt"
    Expression ="Sum(comm_transaction.gp_ext_amt)"
End
Begin Joins
    LeftTable ="comm_transaction"
    RightTable ="comm_salesperson_master"
    Expression ="comm_transaction.salesperson_key_id = comm_salesperson_master.salesperson_key_id"
    Flag =1
End
Begin Groups
    Expression ="comm_transaction.fiscal_yearmo_num"
    GroupLevel =0
    Expression ="comm_transaction.item_comm_group_cd"
    GroupLevel =0
    Expression ="comm_transaction.source_cd"
    GroupLevel =0
    Expression ="comm_salesperson_master.employee_num"
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
        dbText "Name" ="SumOftransaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.source_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2370"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="SumOfgp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1557
    Bottom =1004
    Left =-1
    Top =-1
    Right =1534
    Bottom =662
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
End
