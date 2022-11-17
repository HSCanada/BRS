Operation =1
Option =0
Where ="(((BRS_TransactionDW_Ext.DocType)<>\"AA\") AND ((BRS_TransactionDW_Ext.fg_CalMon"
    "thRedeem)<>\"\"))"
Begin InputTables
    Name ="zzzShipto"
    Name ="BRS_TransactionDW_Ext"
End
Begin OutputColumns
    Alias ="order"
    Expression ="zzzShipto.ST"
    Expression ="zzzShipto.Note"
    Expression ="zzzShipto.Note2"
    Expression ="BRS_TransactionDW_Ext.DocType"
    Expression ="BRS_TransactionDW_Ext.fg_CalMonthRedeem"
    Expression ="BRS_TransactionDW_Ext.fg_exempt_cd"
    Expression ="BRS_TransactionDW_Ext.fg_exempt_note"
End
Begin Joins
    LeftTable ="zzzShipto"
    RightTable ="BRS_TransactionDW_Ext"
    Expression ="zzzShipto.ST = BRS_TransactionDW_Ext.SalesOrderNumber"
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
        dbText "Name" ="zzzShipto.Note"
        dbInteger "ColumnWidth" ="5790"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzShipto.Note2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="order"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW_Ext.fg_exempt_note"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW_Ext.fg_exempt_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW_Ext.fg_CalMonthRedeem"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW_Ext.DocType"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1526
    Bottom =918
    Left =-1
    Top =-1
    Right =1510
    Bottom =571
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =53
        Top =114
        Right =267
        Bottom =332
        Top =0
        Name ="zzzShipto"
        Name =""
    End
    Begin
        Left =401
        Top =139
        Right =712
        Bottom =452
        Top =0
        Name ="BRS_TransactionDW_Ext"
        Name =""
    End
End
