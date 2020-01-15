Operation =1
Option =0
Where ="(((BRS_Item.comm_group_cd)<>[Note1]))"
Begin InputTables
    Name ="zzzItem"
    Name ="BRS_Item"
End
Begin OutputColumns
    Expression ="zzzItem.Item"
    Alias ="group"
    Expression ="zzzItem.Note1"
    Alias ="note"
    Expression ="zzzItem.Note2"
    Expression ="BRS_Item.comm_group_cd"
    Expression ="BRS_Item.comm_note_txt"
End
Begin Joins
    LeftTable ="zzzItem"
    RightTable ="BRS_Item"
    Expression ="zzzItem.Item = BRS_Item.Item"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbBoolean "FailOnError" ="0"
Begin
    Begin
        dbText "Name" ="zzzItem.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="group"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="note"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.comm_note_txt"
        dbInteger "ColumnWidth" ="1890"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.comm_group_cd"
        dbInteger "ColumnWidth" ="1950"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =-375
    Top =49
    Right =1085
    Bottom =969
    Left =-1
    Top =-1
    Right =1436
    Bottom =237
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =24
        Top =12
        Right =168
        Bottom =156
        Top =0
        Name ="zzzItem"
        Name =""
    End
    Begin
        Left =272
        Top =10
        Right =545
        Bottom =238
        Top =0
        Name ="BRS_Item"
        Name =""
    End
End
