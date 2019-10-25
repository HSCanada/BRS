Operation =1
Option =0
Where ="(((BRS_Item.SalesCategory)=\"SMEQU\") AND ((comm_item_master.comm_group_cd)=\"IT"
    "MFO1\" Or (comm_item_master.comm_group_cd)=\"ITMPAR\"))"
Begin InputTables
    Name ="comm_item_master"
    Name ="BRS_Item"
End
Begin OutputColumns
    Expression ="BRS_Item.Item"
    Expression ="BRS_Item.ItemDescription"
    Expression ="BRS_Item.Supplier"
    Expression ="BRS_Item.MajorProductClass"
    Expression ="BRS_Item.SalesCategory"
    Expression ="comm_item_master.comm_group_cd"
    Expression ="comm_item_master.note_txt"
    Expression ="BRS_Item.Est12MoSales"
End
Begin Joins
    LeftTable ="BRS_Item"
    RightTable ="comm_item_master"
    Expression ="BRS_Item.Item = comm_item_master.item_id"
    Flag =1
End
Begin OrderBy
    Expression ="BRS_Item.Est12MoSales"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="0"
dbByte "RecordsetType" ="2"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="BRS_Item.SalesCategory"
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
        dbText "Name" ="comm_item_master.note_txt"
        dbInteger "ColumnWidth" ="4140"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Est12MoSales"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.MajorProductClass"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-30
    Right =871
    Bottom =825
    Left =-1
    Top =-1
    Right =847
    Bottom =498
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =348
        Top =75
        Right =806
        Bottom =417
        Top =0
        Name ="comm_item_master"
        Name =""
    End
    Begin
        Left =65
        Top =43
        Right =295
        Bottom =381
        Top =0
        Name ="BRS_Item"
        Name =""
    End
End
