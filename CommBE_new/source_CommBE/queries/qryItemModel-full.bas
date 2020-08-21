Operation =1
Option =0
Where ="(((BRS_Item.Item)<>\"\") AND ((BRS_Item.comm_group_cd)<>\"\"))"
Begin InputTables
    Name ="BRS_Item"
End
Begin OutputColumns
    Expression ="BRS_Item.ItemKey"
    Expression ="BRS_Item.Item"
    Expression ="BRS_Item.ItemDescription"
    Expression ="BRS_Item.Supplier"
    Expression ="BRS_Item.ItemStatus"
    Expression ="BRS_Item.Label"
    Expression ="BRS_Item.StockingType"
    Expression ="BRS_Item.SalesCategory"
    Expression ="BRS_Item.MajorProductClass"
    Expression ="BRS_Item.SubMajorProdClass"
    Expression ="BRS_Item.MinorProductClass"
    Expression ="BRS_Item.Est12MoSales"
    Expression ="BRS_Item.comm_group_cd"
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
        dbText "Name" ="BRS_Item.StockingType"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Label"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.ItemStatus"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.ItemDescription"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.SubMajorProdClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.MajorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.SalesCategory"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.MinorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.ItemKey"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Est12MoSales"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1412
    Bottom =937
    Left =-1
    Top =-1
    Right =1388
    Bottom =617
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =72
        Right =488
        Bottom =443
        Top =0
        Name ="BRS_Item"
        Name =""
    End
End
