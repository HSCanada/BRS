Operation =1
Option =0
Where ="(((comm_item_master.comm_group_cd)<>\"ITMEQ0\") AND ((BRS_Item.MajorProductClass"
    ")>=\"a\"))"
Begin InputTables
    Name ="comm_item_master"
    Name ="BRS_Item"
End
Begin OutputColumns
    Expression ="BRS_Item.Item"
    Expression ="comm_item_master.item_master_desc"
    Expression ="BRS_Item.CurrentFileCost"
    Expression ="BRS_Item.CurrentCorporatePrice"
    Expression ="comm_item_master.comm_group_cd"
    Expression ="comm_item_master.note_txt"
    Expression ="BRS_Item.MajorProductClass"
    Expression ="BRS_Item.Est12MoSales"
End
Begin Joins
    LeftTable ="comm_item_master"
    RightTable ="BRS_Item"
    Expression ="comm_item_master.item_id = BRS_Item.Item"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbMemo "OrderBy" ="[t fin codes].[MajorProductClass]"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="BRS_Item.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.MajorProductClass"
        dbInteger "ColumnWidth" ="2145"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.comm_group_cd"
        dbInteger "ColumnWidth" ="1950"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.item_master_desc"
        dbInteger "ColumnWidth" ="3030"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.CurrentCorporatePrice"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.CurrentFileCost"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.note_txt"
        dbInteger "ColumnWidth" ="3495"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Est12MoSales"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1563
    Bottom =991
    Left =-1
    Top =-1
    Right =1531
    Bottom =668
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =326
        Bottom =223
        Top =0
        Name ="comm_item_master"
        Name =""
    End
    Begin
        Left =436
        Top =23
        Right =781
        Bottom =386
        Top =0
        Name ="BRS_Item"
        Name =""
    End
End
