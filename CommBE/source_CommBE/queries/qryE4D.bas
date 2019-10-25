Operation =1
Option =0
Where ="(((comm_transaction.fiscal_yearmo_num)>=\"201601\"))"
Begin InputTables
    Name ="comm_transaction"
    Name ="comm_bonus_item"
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Expression ="comm_transaction.fiscal_yearmo_num"
    Expression ="comm_salesperson_master.branch_cd"
    Expression ="comm_salesperson_master.salesperson_nm"
    Expression ="comm_salesperson_master.employee_num"
    Expression ="comm_salesperson_master.comm_plan_id"
    Expression ="comm_transaction.source_cd"
    Expression ="comm_transaction.doc_id"
    Expression ="comm_transaction.doc_type_cd"
    Expression ="comm_transaction.item_id"
    Expression ="comm_transaction.transaction_txt"
    Expression ="comm_transaction.transaction_amt"
    Expression ="comm_transaction.gp_ext_amt"
    Expression ="comm_transaction.shipped_qty"
End
Begin Joins
    LeftTable ="comm_transaction"
    RightTable ="comm_bonus_item"
    Expression ="comm_transaction.item_id = comm_bonus_item.IMITEM"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="comm_salesperson_master"
    Expression ="comm_transaction.salesperson_key_id = comm_salesperson_master.salesperson_key_id"
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
        dbText "Name" ="comm_transaction.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.branch_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_txt"
        dbInteger "ColumnWidth" ="2895"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.shipped_qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.employee_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.doc_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.doc_type_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1604
    Bottom =991
    Left =-1
    Top =-1
    Right =1572
    Bottom =668
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =655
        Bottom =411
        Top =0
        Name ="comm_transaction"
        Name =""
    End
    Begin
        Left =851
        Top =369
        Right =995
        Bottom =513
        Top =0
        Name ="comm_bonus_item"
        Name =""
    End
    Begin
        Left =859
        Top =4
        Right =1317
        Bottom =406
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
End
