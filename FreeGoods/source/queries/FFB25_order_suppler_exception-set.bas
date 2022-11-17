Operation =4
Option =0
Where ="(((BRS_TransactionDW_Ext_1.DocType)<>\"AA\"))"
Begin InputTables
    Name ="BRS_TransactionDW_Ext"
    Alias ="BRS_TransactionDW_Ext_1"
    Name ="zzzShipto"
End
Begin OutputColumns
    Name ="BRS_TransactionDW_Ext_1.fg_CalMonthRedeem"
    Expression ="Left([zzzShipto]![Note2],50)"
    Name ="BRS_TransactionDW_Ext_1.fg_exempt_cd"
    Expression ="\"FGDEAL\""
    Name ="BRS_TransactionDW_Ext_1.fg_exempt_note"
    Expression ="Left([zzzShipto]![Note],50)"
End
Begin Joins
    LeftTable ="zzzShipto"
    RightTable ="BRS_TransactionDW_Ext_1"
    Expression ="zzzShipto.ST = BRS_TransactionDW_Ext_1.SalesOrderNumber"
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
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
Begin
    Begin
        dbText "Name" ="BRS_TransactionDW_Ext_1.DocType"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW_Ext_1.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2205"
        dbBoolean "ColumnHidden" ="0"
    End
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
        dbInteger "ColumnWidth" ="4950"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Note"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzShipto.Note"
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
    Bottom =409
    Left =0
    Top =0
    ColumnsShown =579
    Begin
        Left =361
        Top =57
        Right =707
        Bottom =475
        Top =0
        Name ="BRS_TransactionDW_Ext_1"
        Name =""
    End
    Begin
        Left =82
        Top =60
        Right =257
        Bottom =375
        Top =0
        Name ="zzzShipto"
        Name =""
    End
End
