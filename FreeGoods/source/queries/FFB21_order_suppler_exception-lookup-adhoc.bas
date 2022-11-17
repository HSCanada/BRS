Operation =1
Option =0
Where ="(((BRS_TransactionDW.SalesOrderNumber)=[order]))"
Begin InputTables
    Name ="BRS_TransactionDW"
    Name ="BRS_Item"
End
Begin OutputColumns
    Expression ="BRS_TransactionDW.SalesOrderNumber"
    Expression ="BRS_TransactionDW.InvoiceNumber"
    Expression ="BRS_TransactionDW.DocType"
    Expression ="BRS_TransactionDW.LineNumber"
    Expression ="BRS_TransactionDW.CalMonth"
    Expression ="BRS_TransactionDW.Shipto"
    Expression ="BRS_Item.Supplier"
    Expression ="BRS_TransactionDW.ShippedQty"
    Expression ="BRS_TransactionDW.NetSalesAmt"
    Expression ="BRS_Item.ItemDescription"
End
Begin Joins
    LeftTable ="BRS_TransactionDW"
    RightTable ="BRS_Item"
    Expression ="BRS_TransactionDW.Item = BRS_Item.Item"
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
        dbText "Name" ="BRS_TransactionDW.Shipto"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.CalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.LineNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.DocType"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.ItemDescription"
        dbInteger "ColumnWidth" ="3135"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.ShippedQty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.NetSalesAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.InvoiceNumber"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1381
    Bottom =918
    Left =-1
    Top =-1
    Right =1365
    Bottom =284
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =99
        Top =91
        Right =594
        Bottom =467
        Top =0
        Name ="BRS_TransactionDW"
        Name =""
    End
    Begin
        Left =768
        Top =97
        Right =1035
        Bottom =455
        Top =0
        Name ="BRS_Item"
        Name =""
    End
End
