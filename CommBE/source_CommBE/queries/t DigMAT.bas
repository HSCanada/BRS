Operation =1
Option =0
Where ="(((comm_transaction.fiscal_yearmo_num) Between \"201501\" And \"201512\") AND (("
    "comm_item_master.comm_group_cd)=\"DIGMAT\") AND ((comm_salesperson_master.branch"
    "_cd)=\"TORNT\"))"
Begin InputTables
    Name ="comm_transaction"
    Name ="comm_item_master"
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Expression ="comm_transaction.item_id"
    Alias ="FirstOfitem_master_desc"
    Expression ="First(comm_item_master.item_master_desc)"
    Alias ="SumOfshipped_qty"
    Expression ="Sum(comm_transaction.shipped_qty)"
    Alias ="SumOfgp_ext_amt"
    Expression ="Sum(comm_transaction.gp_ext_amt)"
    Alias ="SumOftransaction_amt"
    Expression ="Sum(comm_transaction.transaction_amt)"
End
Begin Joins
    LeftTable ="comm_transaction"
    RightTable ="comm_item_master"
    Expression ="comm_transaction.item_id = comm_item_master.item_id"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="comm_salesperson_master"
    Expression ="comm_transaction.salesperson_key_id = comm_salesperson_master.salesperson_key_id"
    Flag =1
End
Begin Groups
    Expression ="comm_transaction.item_id"
    GroupLevel =0
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
        dbText "Name" ="FirstOfitem_master_desc"
        dbInteger "ColumnWidth" ="2910"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOftransaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOfshipped_qty"
        dbLong "AggregateType" ="-1"
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
    Right =1511
    Bottom =991
    Left =-1
    Top =-1
    Right =1479
    Bottom =668
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =506
        Top =64
        Right =748
        Bottom =413
        Top =0
        Name ="comm_transaction"
        Name =""
    End
    Begin
        Left =913
        Top =111
        Right =1278
        Bottom =458
        Top =0
        Name ="comm_item_master"
        Name =""
    End
    Begin
        Left =30
        Top =76
        Right =322
        Bottom =406
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
End
