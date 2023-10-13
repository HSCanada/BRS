Operation =1
Option =0
Where ="(((BRS_TransactionDW_Ext_1.fg_CalMonthRedeem)=202308) AND ((BRS_TransactionDW_Ex"
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
    Alias ="fg_exempt_note_src"
    Expression ="BRS_TransactionDW_Ext_1.fg_exempt_note"
    Alias ="fg_offer_note_dst"
    Expression ="fg_transaction_F5554240.fg_offer_note"
    Alias ="fg_exempt_cd_src"
    Expression ="BRS_TransactionDW_Ext_1.fg_exempt_cd"
    Alias ="fg_exempt_cd_dst"
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
dbMemo "OrderBy" ="[FFB26_order_suppler_exception_data-set-manual].[fg_exempt_cd_dst], [FFB26_order"
    "_suppler_exception_data-set-manual].[WK$SPC_supplier_code], [FFB26_order_suppler"
    "_exception_data-set-manual].[fg_exempt_note_src]"
Begin
    Begin
        dbText "Name" ="BRS_TransactionDW_Ext_1.fg_CalMonthRedeem"
        dbInteger "ColumnWidth" ="2385"
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
        dbText "Name" ="fg_exempt_cd_src"
        dbInteger "ColumnWidth" ="3165"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_exempt_cd_dst"
        dbInteger "ColumnWidth" ="2130"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_exempt_note_src"
        dbInteger "ColumnWidth" ="4740"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_offer_note_dst"
        dbInteger "ColumnWidth" ="2445"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1587
    Bottom =918
    Left =-1
    Top =-1
    Right =1034
    Bottom =142
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
        Left =59
        Top =37
        Right =313
        Bottom =364
        Top =0
        Name ="fg_transaction_F5554240"
        Name =""
    End
End
