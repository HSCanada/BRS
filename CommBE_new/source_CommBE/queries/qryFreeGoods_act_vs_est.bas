Operation =1
Option =0
Where ="(((comm_freegoods.FiscalMonth)=202110))"
Begin InputTables
    Name ="comm_freegoods"
End
Begin OutputColumns
    Expression ="comm_freegoods.SourceCode"
    Alias ="ext_cost"
    Expression ="Sum(IIf([SourceCode]=\"ACT\",-[ExtFileCostCadAmt],[ExtFileCostCadAmt]))"
End
Begin Groups
    Expression ="comm_freegoods.SourceCode"
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
        dbText "Name" ="comm_freegoods.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.ExtFileCostCadAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.SourceCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1"
        dbInteger "ColumnWidth" ="1590"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOfExtFileCostCadAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ext_cost"
        dbInteger "ColumnWidth" ="1590"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =20
    Right =1467
    Bottom =593
    Left =-1
    Top =-1
    Right =1443
    Bottom =273
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
End
