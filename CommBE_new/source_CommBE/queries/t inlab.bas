Operation =1
Option =0
Where ="(((BRS_Item.ItemDescription) Not Like \"*inlab*\") AND ((BRS_Item.comm_group_cd)"
    "=\"DIGLAB\")) OR (((BRS_Item.ItemDescription) Like \"*inlab*\") AND ((BRS_Item.c"
    "omm_group_cd)<>\"DIGLAB\"))"
Begin InputTables
    Name ="BRS_Item"
End
Begin OutputColumns
    Expression ="BRS_Item.Item"
    Expression ="BRS_Item.ItemDescription"
    Expression ="BRS_Item.Supplier"
    Expression ="BRS_Item.SubMajorProdClass"
    Expression ="BRS_Item.comm_group_cd"
    Expression ="BRS_Item.comm_note_txt"
    Expression ="BRS_Item.Est12MoSales"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbMemo "OrderBy" ="[Query2].[Est12MoSales] DESC, [Query2].[SubMajorProdClass], [Query2].[ItemDescri"
    "ption]"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="BRS_Item.comm_note_txt"
        dbInteger "ColumnWidth" ="2925"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.SubMajorProdClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.ItemDescription"
        dbInteger "ColumnWidth" ="3300"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Item"
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
    Right =1533
    Bottom =937
    Left =-1
    Top =-1
    Right =1509
    Bottom =617
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =76
        Top =48
        Right =513
        Bottom =349
        Top =0
        Name ="BRS_Item"
        Name =""
    End
End
