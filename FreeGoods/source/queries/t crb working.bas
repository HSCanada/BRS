Operation =1
Option =0
Where ="(((fg_transaction_F5554240.WKDCTO_order_type)=\"cm\") AND ((fg_transaction_F5554"
    "240.fg_exempt_cd)=\"XXXDOC\") AND ((fg_transaction_F5554240.CalMonthRedeem)=2021"
    "09))"
Begin InputTables
    Name ="fg_transaction_F5554240"
    Name ="BRS_TransactionDW"
End
Begin OutputColumns
    Expression ="fg_transaction_F5554240.WKDOCO_salesorder_number"
    Expression ="fg_transaction_F5554240.WKDCTO_order_type"
    Expression ="fg_transaction_F5554240.WKLNNO_line_number"
    Expression ="fg_transaction_F5554240.WKLNTY_line_type"
    Expression ="fg_transaction_F5554240.fg_exempt_cd"
    Expression ="fg_transaction_F5554240.CalMonthRedeem"
    Expression ="fg_transaction_F5554240.OriginalSalesOrderNumber"
    Expression ="fg_transaction_F5554240.OriginalOrderDocumentType"
    Expression ="fg_transaction_F5554240.OriginalOrderLineNumber"
    Expression ="BRS_TransactionDW.CalMonth"
End
Begin Joins
    LeftTable ="fg_transaction_F5554240"
    RightTable ="BRS_TransactionDW"
    Expression ="fg_transaction_F5554240.OriginalSalesOrderNumber = BRS_TransactionDW.SalesOrderN"
        "umber"
    Flag =1
    LeftTable ="fg_transaction_F5554240"
    RightTable ="BRS_TransactionDW"
    Expression ="fg_transaction_F5554240.OriginalOrderDocumentType = BRS_TransactionDW.DocType"
    Flag =1
    LeftTable ="fg_transaction_F5554240"
    RightTable ="BRS_TransactionDW"
    Expression ="fg_transaction_F5554240.OriginalOrderLineNumber = BRS_TransactionDW.LineNumber"
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
dbMemo "OrderBy" ="[t crb working].[CalMonth]"
Begin
    Begin
        dbText "Name" ="fg_transaction_F5554240.CalMonthRedeem"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.fg_exempt_cd"
        dbInteger "ColumnWidth" ="1740"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKLNNO_line_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKDCTO_order_type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKDOCO_salesorder_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKLNTY_line_type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.OriginalSalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.OriginalOrderDocumentType"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.OriginalOrderLineNumber"
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
    Right =1216
    Bottom =918
    Left =-1
    Top =-1
    Right =1200
    Bottom =656
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =90
        Top =129
        Right =693
        Bottom =549
        Top =0
        Name ="fg_transaction_F5554240"
        Name =""
    End
    Begin
        Left =779
        Top =170
        Right =1036
        Bottom =606
        Top =0
        Name ="BRS_TransactionDW"
        Name =""
    End
End
