Operation =1
Option =0
Where ="(((BRS_Item.comm_group_cd)=\"\"))"
Begin InputTables
    Name ="BRS_Item"
End
Begin OutputColumns
    Expression ="BRS_Item.Item"
    Expression ="BRS_Item.ItemDescription"
    Expression ="BRS_Item.SalesCategory"
    Expression ="BRS_Item.comm_group_cd"
    Expression ="BRS_Item.comm_note_txt"
    Expression ="BRS_Item.AddedDt"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbMemo "OrderBy" ="[Query1].[SalesCategory]"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="BRS_Item.comm_note_txt"
        dbInteger "ColumnWidth" ="4365"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.comm_group_cd"
        dbInteger "ColumnWidth" ="1890"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.SalesCategory"
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
        dbText "Name" ="BRS_Item.AddedDt"
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
        Left =68
        Top =46
        Right =242
        Bottom =229
        Top =0
        Name ="BRS_Item"
        Name =""
    End
End
