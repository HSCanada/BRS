Operation =4
Option =0
Where ="(((comm_freegoods.FiscalMonth)=202104) AND ((comm_freegoods.SourceCode)=\"EST\")"
    " AND ((comm_freegoods_1.SourceCode)=\"ACT\"))"
Begin InputTables
    Name ="comm_freegoods"
    Name ="comm_freegoods"
    Alias ="comm_freegoods_1"
End
Begin OutputColumns
    Name ="comm_freegoods.ID_redeem_xref"
    Expression ="[comm_freegoods_1]![ID]"
End
Begin Joins
    LeftTable ="comm_freegoods"
    RightTable ="comm_freegoods_1"
    Expression ="comm_freegoods.FiscalMonth = comm_freegoods_1.FiscalMonth"
    Flag =1
    LeftTable ="comm_freegoods"
    RightTable ="comm_freegoods_1"
    Expression ="comm_freegoods.SalesOrderNumber = comm_freegoods_1.SalesOrderNumber"
    Flag =1
    LeftTable ="comm_freegoods"
    RightTable ="comm_freegoods_1"
    Expression ="comm_freegoods.ShipTo = comm_freegoods_1.ShipTo"
    Flag =1
    LeftTable ="comm_freegoods"
    RightTable ="comm_freegoods_1"
    Expression ="comm_freegoods.Item = comm_freegoods_1.Item"
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
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
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
        dbText "Name" ="comm_freegoods_1.SourceCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.SourceCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods_1.ID_redeem_xref"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.ID_redeem_xref"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.ExtFileCostCadAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods_1.ExtFileCostCadAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.ID"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =1721
    Bottom =946
    Left =-1
    Top =-1
    Right =1697
    Bottom =584
    Left =0
    Top =0
    ColumnsShown =579
    Begin
        Left =126
        Top =60
        Right =328
        Bottom =397
        Top =0
        Name ="comm_freegoods"
        Name =""
    End
    Begin
        Left =456
        Top =83
        Right =827
        Bottom =383
        Top =0
        Name ="comm_freegoods_1"
        Name =""
    End
End
