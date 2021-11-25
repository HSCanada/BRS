Operation =1
Option =0
Where ="(((BRS_TransactionDW_Ext_1.SalesOrderNumber)=14644187) AND ((BRS_TransactionDW_E"
    "xt_1.DocType)<>\"AA\"))"
Begin InputTables
    Name ="BRS_TransactionDW_Ext"
    Alias ="BRS_TransactionDW_Ext_1"
End
Begin OutputColumns
    Expression ="BRS_TransactionDW_Ext_1.SalesOrderNumber"
    Expression ="BRS_TransactionDW_Ext_1.DocType"
    Expression ="BRS_TransactionDW_Ext_1.fg_CalMonthRedeem"
    Expression ="BRS_TransactionDW_Ext_1.fg_exempt_cd"
    Expression ="BRS_TransactionDW_Ext_1.fg_exempt_note"
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
        dbText "Name" ="BRS_TransactionDW_Ext.DocType"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW_Ext.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW_Ext.freegoods_exempt_note"
        dbInteger "ColumnWidth" ="2730"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW_Ext.freegoods_exempt_cd"
        dbInteger "ColumnWidth" ="2505"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW_Ext_1.freegoods_exempt_note"
        dbInteger "ColumnWidth" ="2730"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW_Ext_1.freegoods_exempt_cd"
        dbInteger "ColumnWidth" ="2505"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW_Ext_1.DocType"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW_Ext_1.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW_Ext_1.fg_CalMonthRedeem"
        dbInteger "ColumnWidth" ="2385"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW_Ext_1.fg_exempt_cd"
        dbInteger "ColumnWidth" ="1740"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW_Ext_1.fg_exempt_note"
        dbInteger "ColumnWidth" ="1965"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.CalMonth"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1564
    Bottom =918
    Left =-1
    Top =-1
    Right =1548
    Bottom =673
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =238
        Top =108
        Right =584
        Bottom =526
        Top =0
        Name ="BRS_TransactionDW_Ext_1"
        Name =""
    End
End
