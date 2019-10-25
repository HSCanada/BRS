Operation =1
Option =0
Where ="(((comm_transaction.fiscal_yearmo_num)>=\"201201\") AND ((comm_transaction.sales"
    "person_key_id)<>\"Internal\") AND ((comm_transaction.item_comm_group_cd) Not In "
    "(\"ITMSER\",\"ITMPAR\",\"ITMEQ0\")) AND ((comm_transaction.hsi_shipto_id) In (16"
    "69571,1679900)))"
Begin InputTables
    Name ="comm_transaction"
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Expression ="comm_transaction.fiscal_yearmo_num"
    Expression ="comm_transaction.salesperson_key_id"
    Alias ="SalespersonInvoiced"
    Expression ="comm_transaction.salesperson_cd"
    Expression ="comm_transaction.transaction_dt"
    Expression ="comm_transaction.shipped_qty"
    Expression ="comm_transaction.transaction_amt"
    Expression ="comm_transaction.gp_ext_amt"
    Expression ="comm_transaction.comm_amt"
    Expression ="comm_transaction.item_comm_group_cd"
    Expression ="comm_transaction.IMITEM"
    Expression ="comm_transaction.doc_key_id"
    Expression ="comm_transaction.hsi_shipto_id"
    Expression ="comm_transaction.hsi_shipto_nm"
    Expression ="comm_transaction.transaction_txt"
    Expression ="comm_salesperson_master.branch_cd"
End
Begin Joins
    LeftTable ="comm_transaction"
    RightTable ="comm_salesperson_master"
    Expression ="comm_transaction.salesperson_key_id = comm_salesperson_master.salesperson_key_id"
    Flag =1
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
        dbText "Name" ="comm_transaction.salesperson_key_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2970"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_dt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1800"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.item_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.IMITEM"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.doc_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_txt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3675"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.hsi_shipto_nm"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2925"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.shipped_qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.branch_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.comm_amt"
        dbInteger "ColumnWidth" ="1545"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SalespersonInvoiced"
        dbInteger "ColumnWidth" ="2445"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-4
    Top =-23
    Right =1556
    Bottom =1013
    Left =-1
    Top =-1
    Right =1537
    Bottom =679
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =38
        Top =6
        Right =336
        Bottom =633
        Top =0
        Name ="comm_transaction"
        Name =""
    End
    Begin
        Left =473
        Top =148
        Right =735
        Bottom =292
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
End
