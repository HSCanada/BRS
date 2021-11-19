Operation =1
Option =0
Where ="(((comm_freegoods.SourceCode)=\"ACT\"))"
Having ="(((comm_freegoods.FiscalMonth)=202108))"
Begin InputTables
    Name ="comm_freegoods"
End
Begin OutputColumns
    Expression ="comm_freegoods.FiscalMonth"
    Expression ="comm_freegoods.SalesOrderNumber"
    Expression ="comm_freegoods.Item"
    Alias ="SumOfExtFileCostCadAmt"
    Expression ="Sum(comm_freegoods.ExtFileCostCadAmt)"
End
Begin Groups
    Expression ="comm_freegoods.FiscalMonth"
    GroupLevel =0
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
        dbText "Name" ="comm_freegoods.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.ShipTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.SourceCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOfExtFileCostCadAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.ExtFileCostCadAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOfSourceCode"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1573
    Bottom =918
    Left =-1
    Top =-1
    Right =1287
    Bottom =673
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =78
        Top =63
        Right =313
        Bottom =383
        Top =0
        Name ="comm_freegoods"
        Name =""
    End
End
