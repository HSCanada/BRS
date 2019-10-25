Operation =2
Name ="zzzSO"
Option =0
Where ="(((BRS_TransactionDW.CalMonth)>=201901) AND ((BRS_TransactionDW.OrderSourceCode)"
    " In (\"A\",\"L\")))"
Begin InputTables
    Name ="BRS_TransactionDW"
End
Begin OutputColumns
    Expression ="BRS_TransactionDW.SalesOrderNumber"
    Alias ="MinOfOrderTakenBy"
    Expression ="Min(BRS_TransactionDW.OrderTakenBy)"
    Alias ="MaxOfOrderTakenBy"
    Expression ="Max(BRS_TransactionDW.OrderTakenBy)"
End
Begin Groups
    Expression ="BRS_TransactionDW.SalesOrderNumber"
    GroupLevel =0
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
Begin
    Begin
        dbText "Name" ="BRS_TransactionDW.CalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.OrderSourceCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="MaxOfOrderTakenBy"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="MinOfOrderTakenBy"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.OrderTakenBy"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.DocType"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1445
    Bottom =817
    Left =-1
    Top =-1
    Right =1421
    Bottom =481
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =78
        Top =36
        Right =469
        Bottom =420
        Top =0
        Name ="BRS_TransactionDW"
        Name =""
    End
End
