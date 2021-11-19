Operation =1
Option =0
Begin InputTables
    Name ="Integration_F5554240_fg_redeem_Staging"
    Name ="fg_transaction_F5554240"
    Name ="BRS_TransactionDW"
End
Begin OutputColumns
    Expression ="BRS_TransactionDW.SalesOrderNumber"
    Expression ="BRS_TransactionDW.Item"
    Expression ="fg_transaction_F5554240.order_file_name"
    Expression ="Integration_F5554240_fg_redeem_Staging.order_file_name"
    Expression ="fg_transaction_F5554240.ID_source_ref"
    Expression ="fg_transaction_F5554240.WKUORG_quantity"
    Expression ="Integration_F5554240_fg_redeem_Staging.WKUORG_quantity"
    Expression ="BRS_TransactionDW.ShippedQty"
End
Begin Joins
    LeftTable ="Integration_F5554240_fg_redeem_Staging"
    RightTable ="fg_transaction_F5554240"
    Expression ="Integration_F5554240_fg_redeem_Staging.WKDOCO_salesorder_number = fg_transaction"
        "_F5554240.WKDOCO_salesorder_number"
    Flag =1
    LeftTable ="Integration_F5554240_fg_redeem_Staging"
    RightTable ="fg_transaction_F5554240"
    Expression ="Integration_F5554240_fg_redeem_Staging.WKDCTO_order_type = fg_transaction_F55542"
        "40.WKDCTO_order_type"
    Flag =1
    LeftTable ="Integration_F5554240_fg_redeem_Staging"
    RightTable ="fg_transaction_F5554240"
    Expression ="Integration_F5554240_fg_redeem_Staging.WKLNNO_line_number = fg_transaction_F5554"
        "240.WKLNNO_line_number"
    Flag =1
    LeftTable ="fg_transaction_F5554240"
    RightTable ="BRS_TransactionDW"
    Expression ="fg_transaction_F5554240.ID_source_ref = BRS_TransactionDW.ID"
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
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.order_file_name"
        dbInteger "ColumnWidth" ="5925"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKUORG_quantity"
        dbInteger "ColumnWidth" ="4485"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKUORG_quantity"
        dbInteger "ColumnWidth" ="6105"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.order_file_name"
        dbInteger "ColumnWidth" ="4305"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.ShippedQty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.ID_source_ref"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1649
    Bottom =918
    Left =-1
    Top =-1
    Right =1633
    Bottom =673
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =84
        Top =59
        Right =488
        Bottom =527
        Top =0
        Name ="Integration_F5554240_fg_redeem_Staging"
        Name =""
    End
    Begin
        Left =571
        Top =61
        Right =1111
        Bottom =491
        Top =0
        Name ="fg_transaction_F5554240"
        Name =""
    End
    Begin
        Left =1166
        Top =65
        Right =1419
        Bottom =444
        Top =0
        Name ="BRS_TransactionDW"
        Name =""
    End
End
