Operation =1
Option =0
Where ="(((BRS_Item.SalesCategory) In (\"MERCH\",\"SMEQU\")) AND ((BRS_Item.comm_group_c"
    "d)=\"ITMPVT\") AND ((BRS_Item.Label)=\"P\") AND ((zzzItem.Item) Is Null))"
Begin InputTables
    Name ="BRS_Item"
    Name ="zzzItem"
End
Begin OutputColumns
    Expression ="BRS_Item.Item"
    Expression ="BRS_Item.ItemDescription"
    Expression ="BRS_Item.Supplier"
    Expression ="BRS_Item.SalesCategory"
    Expression ="BRS_Item.comm_group_cd"
    Expression ="BRS_Item.Est12MoSales"
    Expression ="BRS_Item.Label"
    Expression ="BRS_Item.comm_group_eps_cd"
    Expression ="zzzItem.Item"
End
Begin Joins
    LeftTable ="BRS_Item"
    RightTable ="zzzItem"
    Expression ="BRS_Item.SubMajorProdClass = zzzItem.Item"
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
        dbText "Name" ="BRS_Item.ItemDescription"
        dbInteger "ColumnWidth" ="3090"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.comm_group_cd"
        dbInteger "ColumnWidth" ="1950"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.comm_group_eps_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2385"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="BRS_Item.Label"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.SalesCategory"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Est12MoSales"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzItem.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Supplier"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =1428
    Bottom =651
    Left =-1
    Top =-1
    Right =1404
    Bottom =323
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =40
        Top =28
        Right =321
        Bottom =324
        Top =0
        Name ="BRS_Item"
        Name =""
    End
    Begin
        Left =430
        Top =31
        Right =636
        Bottom =265
        Top =0
        Name ="zzzItem"
        Name =""
    End
End
