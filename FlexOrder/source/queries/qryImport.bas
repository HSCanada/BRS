Operation =1
Option =0
Where ="(((flex_order_file.flex_code)=\"PG_IMP\"))"
Begin InputTables
    Name ="flex_order_header"
    Name ="flex_order_file"
End
Begin OutputColumns
    Expression ="flex_order_file.order_file_name"
    Expression ="flex_order_header.Supplier"
    Expression ="flex_order_header.ORDERNO"
    Expression ="flex_order_header.DATE"
    Expression ="flex_order_file.flex_code"
    Expression ="flex_order_file.batch_id"
    Expression ="flex_order_file.note"
    Expression ="flex_order_header.ShipTo"
    Expression ="flex_order_header.FIRSTLAST"
End
Begin Joins
    LeftTable ="flex_order_header"
    RightTable ="flex_order_file"
    Expression ="flex_order_header.order_file_key = flex_order_file.order_file_key"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbMemo "OrderBy" ="[Query7].[DATE]"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="SumOfNetSalesAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.NetSalesAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.CalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.SalesOrderNumber"
        dbInteger "ColumnWidth" ="2205"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.CustomerPOText1"
        dbInteger "ColumnWidth" ="2850"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_header.FIRSTLAST"
        dbInteger "ColumnWidth" ="2955"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.Date"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.InvoiceNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_file.flex_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_file.order_file_name"
        dbInteger "ColumnWidth" ="3180"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_file.batch_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_header.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_file.note"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_header.ORDERNO"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_header.order_file_key"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_header.DATE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_header.ShipTo"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1582
    Bottom =918
    Left =-1
    Top =-1
    Right =1296
    Bottom =673
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =80
        Top =85
        Right =477
        Bottom =334
        Top =0
        Name ="flex_order_header"
        Name =""
    End
    Begin
        Left =572
        Top =105
        Right =895
        Bottom =358
        Top =0
        Name ="flex_order_file"
        Name =""
    End
End
