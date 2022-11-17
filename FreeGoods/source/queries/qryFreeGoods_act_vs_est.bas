Operation =1
Option =0
Where ="(((comm_freegoods.FiscalMonth)=202110))"
Begin InputTables
    Name ="comm_freegoods"
    Name ="fg_transaction_F5554240"
End
Begin OutputColumns
    Expression ="comm_freegoods.SalesOrderNumber"
    Expression ="comm_freegoods.Item"
    Alias ="ext_cost"
    Expression ="Sum(IIf([SourceCode]=\"ACT\",-[comm_freegoods]![ExtFileCostCadAmt],[comm_freegoo"
        "ds]![ExtFileCostCadAmt]))"
End
Begin Joins
    LeftTable ="comm_freegoods"
    RightTable ="fg_transaction_F5554240"
    Expression ="comm_freegoods.ID_source_ref = fg_transaction_F5554240.ID_source_ref"
    Flag =2
End
Begin Groups
    Expression ="comm_freegoods.SalesOrderNumber"
    GroupLevel =0
    Expression ="comm_freegoods.Item"
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
Begin
    Begin
        dbText "Name" ="ext_cost"
        dbInteger "ColumnWidth" ="1590"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.SourceCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.ID_source_ref"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1541
    Bottom =918
    Left =-1
    Top =-1
    Right =1525
    Bottom =361
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =63
        Top =15
        Right =334
        Bottom =223
        Top =0
        Name ="comm_freegoods"
        Name =""
    End
    Begin
        Left =429
        Top =29
        Right =688
        Bottom =240
        Top =0
        Name ="fg_transaction_F5554240"
        Name =""
    End
End
