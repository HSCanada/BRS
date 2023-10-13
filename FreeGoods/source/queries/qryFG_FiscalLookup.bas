Operation =1
Option =0
Begin InputTables
    Name ="zzzShipto"
    Name ="fg_transaction_F5554240"
    Name ="BRS_TransactionDW"
    Name ="BRS_SalesDay"
End
Begin OutputColumns
    Expression ="zzzShipto.ST"
    Expression ="fg_transaction_F5554240.ID_source_ref"
    Expression ="BRS_TransactionDW.Date"
    Expression ="BRS_SalesDay.FiscalMonth"
End
Begin Joins
    LeftTable ="zzzShipto"
    RightTable ="fg_transaction_F5554240"
    Expression ="zzzShipto.ST = fg_transaction_F5554240.ID"
    Flag =1
    LeftTable ="BRS_TransactionDW"
    RightTable ="fg_transaction_F5554240"
    Expression ="BRS_TransactionDW.ID = fg_transaction_F5554240.ID_source_ref"
    Flag =1
    LeftTable ="BRS_TransactionDW"
    RightTable ="BRS_SalesDay"
    Expression ="BRS_TransactionDW.Date = BRS_SalesDay.SalesDate"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="0"
dbByte "RecordsetType" ="2"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbMemo "OrderBy" ="[qryFG_FiscalLookup].[FiscalMonth]"
Begin
    Begin
        dbText "Name" ="zzzShipto.ST"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.ID_source_ref"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_SalesDay.FiscalMonth"
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
    Right =1587
    Bottom =918
    Left =-1
    Top =-1
    Right =1571
    Bottom =322
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =56
        Top =32
        Right =200
        Bottom =176
        Top =0
        Name ="zzzShipto"
        Name =""
    End
    Begin
        Left =238
        Top =15
        Right =544
        Bottom =277
        Top =0
        Name ="fg_transaction_F5554240"
        Name =""
    End
    Begin
        Left =585
        Top =34
        Right =845
        Bottom =387
        Top =0
        Name ="BRS_TransactionDW"
        Name =""
    End
    Begin
        Left =950
        Top =52
        Right =1094
        Bottom =196
        Top =0
        Name ="BRS_SalesDay"
        Name =""
    End
End
