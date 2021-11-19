Operation =1
Option =0
Where ="(((BRS_TransactionDW.SalesOrderNumber)=14501643) AND ((BRS_TransactionDW.Shipped"
    "Qty)<>0) AND ((BRS_TransactionDW.NetSalesAmt)=0))"
Begin InputTables
    Name ="BRS_TransactionDW"
End
Begin OutputColumns
    Expression ="BRS_TransactionDW.SalesOrderNumber"
    Expression ="BRS_TransactionDW.DocType"
    Expression ="BRS_TransactionDW.Item"
    Expression ="BRS_TransactionDW.LineNumber"
    Expression ="BRS_TransactionDW.ShippedQty"
    Expression ="BRS_TransactionDW.NetSalesAmt"
    Expression ="BRS_TransactionDW.ID"
    Expression ="BRS_TransactionDW.Date"
End
Begin OrderBy
    Expression ="BRS_TransactionDW.SalesOrderNumber"
    Flag =0
    Expression ="BRS_TransactionDW.Item"
    Flag =0
    Expression ="BRS_TransactionDW.ID"
    Flag =0
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
        dbText "Name" ="BRS_TransactionDW.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.LineNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.NetSalesAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.ShippedQty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.DocType"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.Date"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1303
    Bottom =918
    Left =-1
    Top =-1
    Right =1287
    Bottom =486
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =59
        Top =42
        Right =516
        Bottom =385
        Top =0
        Name ="BRS_TransactionDW"
        Name =""
    End
End
