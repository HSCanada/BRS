Operation =1
Option =0
Where ="(((BRS_Item.Label)=\"P\"))"
Begin InputTables
    Name ="BRS_Item"
End
Begin OutputColumns
    Expression ="BRS_Item.Item"
    Expression ="BRS_Item.Label"
    Expression ="BRS_Item.ItemCreationDate"
    Expression ="BRS_Item.MajorProductClass"
    Expression ="BRS_Item.FreightAdjPct"
    Expression ="BRS_Item.CorporateMarketAdjustmentPct"
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
        dbText "Name" ="BRS_Item.Label"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.MajorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.FreightAdjPct"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.CorporateMarketAdjustmentPct"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.ItemCreationDate"
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
        Right =425
        Bottom =397
        Top =0
        Name ="BRS_Item"
        Name =""
    End
End
