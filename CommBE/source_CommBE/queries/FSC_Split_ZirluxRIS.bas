Operation =1
Option =0
Where ="(((comm_transaction.salesperson_key_id)<>\"Internal\") AND ((BRS_Item.MinorProdu"
    "ctClass) Between \"318-01-10\" And \"318-01-80\"))"
Begin InputTables
    Name ="comm_configure"
    Name ="comm_transaction"
    Name ="comm_salesperson_master"
    Name ="comm_customer_master"
    Name ="BRS_Item"
    Name ="comm_salesperson_RIS_map"
End
Begin OutputColumns
    Expression ="comm_transaction.fiscal_yearmo_num"
    Expression ="comm_salesperson_RIS_map.RIS_nm"
    Expression ="comm_transaction.salesperson_key_id"
    Alias ="SalespersonInvoiced"
    Expression ="comm_transaction.salesperson_cd"
    Expression ="comm_transaction.transaction_dt"
    Expression ="comm_transaction.shipped_qty"
    Expression ="comm_transaction.transaction_amt"
    Expression ="comm_transaction.gp_ext_amt"
    Expression ="comm_transaction.comm_amt"
    Expression ="comm_transaction.item_comm_group_cd"
    Expression ="comm_transaction.item_id"
    Expression ="comm_transaction.doc_key_id"
    Expression ="comm_transaction.hsi_shipto_id"
    Expression ="comm_transaction.hsi_shipto_nm"
    Expression ="comm_transaction.transaction_txt"
    Expression ="comm_salesperson_master.branch_cd"
    Expression ="comm_customer_master.sales_plan_cd"
    Expression ="BRS_Item.MinorProductClass"
End
Begin Joins
    LeftTable ="comm_transaction"
    RightTable ="comm_salesperson_master"
    Expression ="comm_transaction.salesperson_key_id = comm_salesperson_master.salesperson_key_id"
    Flag =1
    LeftTable ="comm_configure"
    RightTable ="comm_transaction"
    Expression ="comm_configure.current_fiscal_yearmo_num = comm_transaction.fiscal_yearmo_num"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="comm_customer_master"
    Expression ="comm_transaction.hsi_shipto_id = comm_customer_master.hsi_shipto_id"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="BRS_Item"
    Expression ="comm_transaction.item_id = BRS_Item.Item"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="comm_salesperson_RIS_map"
    Expression ="comm_transaction.hsi_shipto_id = comm_salesperson_RIS_map.hsi_shipto_id"
    Flag =1
End
Begin OrderBy
    Expression ="comm_transaction.salesperson_cd"
    Flag =0
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
        dbInteger "ColumnWidth" ="2415"
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
    Begin
        dbText "Name" ="comm_customer_master.sales_plan_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.MinorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_RIS_map.RIS_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.item_id"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1488
    Bottom =991
    Left =-1
    Top =-1
    Right =1456
    Bottom =611
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =467
        Top =14
        Right =611
        Bottom =158
        Top =0
        Name ="comm_configure"
        Name =""
    End
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
    Begin
        Left =533
        Top =377
        Right =677
        Bottom =521
        Top =0
        Name ="comm_customer_master"
        Name =""
    End
    Begin
        Left =804
        Top =108
        Right =1086
        Bottom =488
        Top =0
        Name ="BRS_Item"
        Name =""
    End
    Begin
        Left =674
        Top =48
        Right =918
        Bottom =331
        Top =0
        Name ="comm_salesperson_RIS_map"
        Name =""
    End
End
