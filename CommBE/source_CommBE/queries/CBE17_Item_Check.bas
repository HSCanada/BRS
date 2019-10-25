Operation =1
Option =0
Where ="(((comm_item_master.item_id) Is Null))"
Begin InputTables
    Name ="comm_transaction_hsi_stage"
    Name ="comm_item_master"
    Name ="BRS_Item"
End
Begin OutputColumns
    Expression ="comm_transaction_hsi_stage.key_id"
    Expression ="comm_transaction_hsi_stage.WKLITM"
    Expression ="BRS_Item.ItemDescription"
    Expression ="BRS_Item.Supplier"
    Expression ="comm_transaction_hsi_stage.[WK$SLC]"
    Expression ="BRS_Item.SubMajorProdClass"
    Expression ="comm_item_master.item_id"
End
Begin Joins
    LeftTable ="comm_transaction_hsi_stage"
    RightTable ="comm_item_master"
    Expression ="comm_transaction_hsi_stage.WKLITM = comm_item_master.item_id"
    Flag =2
    LeftTable ="comm_transaction_hsi_stage"
    RightTable ="BRS_Item"
    Expression ="comm_transaction_hsi_stage.WKLITM = BRS_Item.Item"
    Flag =2
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbMemo "OrderBy" ="[CBE17_Item_Check].[WK$SLC]"
Begin
    Begin
        dbText "Name" ="comm_transaction_hsi_stage.WKLITM"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.item_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3405"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction_hsi_stage.key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_hsi_stage.[WK$SLC]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.ItemDescription"
        dbInteger "ColumnWidth" ="3180"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.SubMajorProdClass"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =-362
    Top =332
    Right =1175
    Bottom =1289
    Left =-1
    Top =-1
    Right =1505
    Bottom =548
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =47
        Top =20
        Right =323
        Bottom =292
        Top =0
        Name ="comm_transaction_hsi_stage"
        Name =""
    End
    Begin
        Left =453
        Top =30
        Right =681
        Bottom =212
        Top =0
        Name ="comm_item_master"
        Name =""
    End
    Begin
        Left =418
        Top =303
        Right =726
        Bottom =583
        Top =0
        Name ="BRS_Item"
        Name =""
    End
End
