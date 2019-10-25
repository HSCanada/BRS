Operation =1
Option =0
Where ="(((comm_transaction.item_id) Not In (\"1074153\",\"1076903\",\"1070511\")) AND ("
    "(comm_transaction.source_cd)=\"JDE\") AND ((comm_transaction.salesperson_key_id)"
    "<>\"Internal\"))"
Begin InputTables
    Name ="comm_transaction"
    Name ="comm_salesperson_master"
    Name ="eps_Item"
    Name ="BRS_Customer"
    Name ="comm_configure"
End
Begin OutputColumns
    Expression ="comm_transaction.fiscal_yearmo_num"
    Expression ="comm_transaction.hsi_shipto_div_cd"
    Expression ="BRS_Customer.MarketClass"
    Expression ="BRS_Customer.SegCd"
    Expression ="BRS_Customer.Specialty"
    Expression ="comm_salesperson_master.branch_cd"
    Expression ="eps_Item.Supplier"
    Expression ="eps_Item.Supplier_Description"
    Expression ="comm_transaction.salesperson_cd"
    Expression ="comm_transaction.item_id"
    Expression ="comm_transaction.transaction_txt"
    Expression ="comm_transaction.item_comm_group_cd"
    Expression ="comm_transaction.shipped_qty"
    Expression ="comm_transaction.transaction_amt"
    Expression ="comm_transaction.gp_ext_amt"
    Expression ="comm_transaction.transaction_dt"
    Expression ="comm_transaction.hsi_shipto_id"
    Expression ="comm_transaction.hsi_shipto_nm"
    Expression ="comm_transaction.doc_key_id"
    Expression ="comm_transaction.line_id"
    Expression ="comm_transaction.source_cd"
    Expression ="comm_transaction.reference_order_txt"
End
Begin Joins
    LeftTable ="comm_transaction"
    RightTable ="comm_salesperson_master"
    Expression ="comm_transaction.salesperson_key_id = comm_salesperson_master.salesperson_key_id"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="eps_Item"
    Expression ="comm_transaction.item_id = eps_Item.Item_Number"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="BRS_Customer"
    Expression ="comm_transaction.hsi_shipto_id = BRS_Customer.ShipTo"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="comm_configure"
    Expression ="comm_transaction.fiscal_yearmo_num = comm_configure.current_fiscal_yearmo_num"
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
        dbText "Name" ="comm_transaction.transaction_dt"
        dbLong "AggregateType" ="-1"
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
        dbText "Name" ="comm_transaction.line_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.[item_id]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.hsi_shipto_div_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.branch_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="eps_Item.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="eps_Item.Supplier_Description"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.MarketClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.SegCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.Specialty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.reference_order_txt"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1508
    Bottom =857
    Left =-1
    Top =-1
    Right =1484
    Bottom =365
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =38
        Top =6
        Right =336
        Bottom =360
        Top =0
        Name ="comm_transaction"
        Name =""
    End
    Begin
        Left =713
        Top =118
        Right =1214
        Bottom =407
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
    Begin
        Left =466
        Top =403
        Right =725
        Bottom =696
        Top =0
        Name ="eps_Item"
        Name =""
    End
    Begin
        Left =397
        Top =17
        Right =790
        Bottom =362
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
    Begin
        Left =327
        Top =438
        Right =471
        Bottom =582
        Top =0
        Name ="comm_configure"
        Name =""
    End
End
