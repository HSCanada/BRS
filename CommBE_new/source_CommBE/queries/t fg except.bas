Operation =1
Option =0
Where ="(((comm_freegoods.FiscalMonth)=202107))"
Begin InputTables
    Name ="zzzItem"
    Name ="comm_freegoods"
    Name ="BRS_Item"
    Name ="BRS_ItemMPC"
End
Begin OutputColumns
    Expression ="comm_freegoods.FiscalMonth"
    Expression ="comm_freegoods.SalesOrderNumber"
    Expression ="comm_freegoods.original_line_number"
    Expression ="comm_freegoods.SourceCode"
    Expression ="comm_freegoods.ShipTo"
    Expression ="comm_freegoods.PracticeName"
    Expression ="comm_freegoods.Item"
    Expression ="comm_freegoods.ItemDescription"
    Expression ="BRS_Item.MajorProductClass"
    Expression ="BRS_ItemMPC.MajorProductClassDesc"
    Expression ="comm_freegoods.Supplier"
    Expression ="comm_freegoods.ExtFileCostCadAmt"
    Expression ="comm_freegoods.ID"
End
Begin Joins
    LeftTable ="zzzItem"
    RightTable ="comm_freegoods"
    Expression ="zzzItem.Item = comm_freegoods.Item"
    Flag =1
    LeftTable ="comm_freegoods"
    RightTable ="BRS_Item"
    Expression ="comm_freegoods.Item = BRS_Item.Item"
    Flag =1
    LeftTable ="BRS_Item"
    RightTable ="BRS_ItemMPC"
    Expression ="BRS_Item.MajorProductClass = BRS_ItemMPC.MajorProductClass"
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
        dbText "Name" ="comm_freegoods.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.PracticeName"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.ShipTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.SourceCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.original_line_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.ExtFileCostCadAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.ItemDescription"
        dbInteger "ColumnWidth" ="3120"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzItem.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.MajorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemMPC.MajorProductClassDesc"
        dbInteger "ColumnWidth" ="3060"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1560
    Bottom =938
    Left =-1
    Top =-1
    Right =1536
    Bottom =618
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =82
        Top =57
        Right =226
        Bottom =201
        Top =0
        Name ="zzzItem"
        Name =""
    End
    Begin
        Left =374
        Top =93
        Right =792
        Bottom =538
        Top =0
        Name ="comm_freegoods"
        Name =""
    End
    Begin
        Left =979
        Top =96
        Right =1123
        Bottom =537
        Top =0
        Name ="BRS_Item"
        Name =""
    End
    Begin
        Left =1181
        Top =173
        Right =1325
        Bottom =317
        Top =0
        Name ="BRS_ItemMPC"
        Name =""
    End
End
