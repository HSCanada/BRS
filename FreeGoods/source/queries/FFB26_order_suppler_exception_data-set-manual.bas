Operation =1
Option =0
Where ="(((BRS_TransactionDW_Ext_1.fg_CalMonthRedeem)=202210) AND ((BRS_TransactionDW_Ex"
    "t_1.DocType)<>\"AA\"))"
Begin InputTables
    Name ="BRS_TransactionDW_Ext"
    Alias ="BRS_TransactionDW_Ext_1"
    Name ="fg_transaction_F5554240"
End
Begin OutputColumns
    Expression ="BRS_TransactionDW_Ext_1.fg_CalMonthRedeem"
    Expression ="fg_transaction_F5554240.WKDOCO_salesorder_number"
    Expression ="fg_transaction_F5554240.[WK$SPC_supplier_code]"
    Expression ="BRS_TransactionDW_Ext_1.fg_exempt_note"
    Expression ="fg_transaction_F5554240.fg_offer_note"
    Expression ="BRS_TransactionDW_Ext_1.fg_exempt_cd"
    Expression ="fg_transaction_F5554240.fg_exempt_cd"
End
Begin Joins
    LeftTable ="fg_transaction_F5554240"
    RightTable ="BRS_TransactionDW_Ext_1"
    Expression ="fg_transaction_F5554240.WKDOCO_salesorder_number = BRS_TransactionDW_Ext_1.Sales"
        "OrderNumber"
    Flag =1
    LeftTable ="fg_transaction_F5554240"
    RightTable ="BRS_TransactionDW_Ext_1"
    Expression ="fg_transaction_F5554240.WKDCTO_order_type = BRS_TransactionDW_Ext_1.DocType"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
dbMemo "OrderBy" ="[FFB26_order_suppler_exception_data-set-manual].[WKDOCO_salesorder_number]"
dbMemo "Filter" ="([fg_transaction_F5554240].[fg_exempt_cd]=\"FGDEAL\")"
Begin
    Begin
        dbText "Name" ="BRS_TransactionDW_Ext_1.fg_CalMonthRedeem"
        dbInteger "ColumnWidth" ="2385"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW_Ext_1.fg_exempt_cd"
        dbInteger "ColumnWidth" ="2670"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW_Ext_1.fg_exempt_note"
        dbInteger "ColumnWidth" ="5880"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.fg_exempt_cd"
        dbInteger "ColumnWidth" ="4065"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.fg_offer_note"
        dbInteger "ColumnWidth" ="5160"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.[WK$SPC_supplier_code]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKDOCO_salesorder_number"
        dbInteger "ColumnWidth" ="3210"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW_Ext_1.SalesOrderNumber"
        dbInteger "ColumnWidth" ="2205"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW_Ext_1.DocType"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzShipto.Note"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Note"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1537
    Bottom =918
    Left =-1
    Top =-1
    Right =1703
    Bottom =401
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =413
        Top =52
        Right =759
        Bottom =470
        Top =0
        Name ="BRS_TransactionDW_Ext_1"
        Name =""
    End
    Begin
        Left =98
        Top =108
        Right =352
        Bottom =435
        Top =0
        Name ="fg_transaction_F5554240"
        Name =""
    End
End
