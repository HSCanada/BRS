Operation =1
Option =0
Begin InputTables
    Name ="zzzItem"
    Name ="BRS_Item"
End
Begin OutputColumns
    Expression ="zzzItem.Item"
    Expression ="BRS_Item.Item"
    Expression ="BRS_Item.comm_group_cd"
    Expression ="BRS_Item.comm_note_txt"
End
Begin Joins
    LeftTable ="zzzItem"
    RightTable ="BRS_Item"
    Expression ="zzzItem.Item = BRS_Item.Item"
    Flag =2
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbMemo "OrderBy" ="[BRS_Item].[Item]"
Begin
    Begin
        dbText "Name" ="BRS_Item.comm_note_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzItem.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Item"
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
    Bottom =600
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =81
        Top =58
        Right =225
        Bottom =202
        Top =0
        Name ="zzzItem"
        Name =""
    End
    Begin
        Left =293
        Top =61
        Right =675
        Bottom =349
        Top =0
        Name ="BRS_Item"
        Name =""
    End
End
