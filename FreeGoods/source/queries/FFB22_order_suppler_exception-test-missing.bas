Operation =1
Option =0
Where ="(((BRS_TransactionDW.SalesOrderNumber) Is Null))"
Begin InputTables
    Name ="BRS_TransactionDW"
    Name ="zzzShipto"
End
Begin OutputColumns
    Alias ="order"
    Expression ="zzzShipto.ST"
    Expression ="zzzShipto.Note"
    Expression ="zzzShipto.Note2"
    Expression ="BRS_TransactionDW.SalesOrderNumber"
End
Begin Joins
    LeftTable ="zzzShipto"
    RightTable ="BRS_TransactionDW"
    Expression ="zzzShipto.ST = BRS_TransactionDW.SalesOrderNumber"
    Flag =2
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
        dbText "Name" ="BRS_TransactionDW.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzShipto.Note"
        dbInteger "ColumnWidth" ="8085"
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
    Bottom =588
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =362
        Top =102
        Right =857
        Bottom =478
        Top =0
        Name ="BRS_TransactionDW"
        Name =""
    End
    Begin
        Left =53
        Top =114
        Right =267
        Bottom =332
        Top =0
        Name ="zzzShipto"
        Name =""
    End
End
