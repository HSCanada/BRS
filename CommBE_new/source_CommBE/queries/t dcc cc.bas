Operation =1
Option =0
Begin InputTables
    Name ="zzzItem"
    Name ="BRS_ItemMarketAdjustFix_dcc"
End
Begin OutputColumns
    Expression ="BRS_ItemMarketAdjustFix_dcc.Item"
    Expression ="BRS_ItemMarketAdjustFix_dcc.CurrentDccPrice"
    Expression ="BRS_ItemMarketAdjustFix_dcc.CurrentFileCost"
    Expression ="BRS_ItemMarketAdjustFix_dcc.UnitChargeback"
    Expression ="BRS_ItemMarketAdjustFix_dcc.FreightAdjPct"
    Expression ="BRS_ItemMarketAdjustFix_dcc.new_corprorate_adj"
    Expression ="BRS_ItemMarketAdjustFix_dcc.new_divisional_adj"
End
Begin Joins
    LeftTable ="zzzItem"
    RightTable ="BRS_ItemMarketAdjustFix_dcc"
    Expression ="zzzItem.Item = BRS_ItemMarketAdjustFix_dcc.Item"
    Flag =1
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
        dbText "Name" ="Pricing_item_price_dcc.UnitChargeback"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Pricing_item_price_dcc.CurrentPrice"
        dbInteger "ColumnWidth" ="1590"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Pricing_item_price_dcc.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemMarketAdjustFix_dcc.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemMarketAdjustFix_dcc.new_divisional_adj"
        dbInteger "ColumnWidth" ="2220"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemMarketAdjustFix_dcc.new_corprorate_adj"
        dbInteger "ColumnWidth" ="2295"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemMarketAdjustFix_dcc.FreightAdjPct"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemMarketAdjustFix_dcc.CurrentFileCost"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemMarketAdjustFix_dcc.CurrentDccPrice"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemMarketAdjustFix_dcc.UnitChargeback"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1051
    Bottom =573
    Left =-1
    Top =-1
    Right =1027
    Bottom =271
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =29
        Top =30
        Right =173
        Bottom =174
        Top =0
        Name ="zzzItem"
        Name =""
    End
    Begin
        Left =244
        Top =47
        Right =501
        Bottom =272
        Top =0
        Name ="BRS_ItemMarketAdjustFix_dcc"
        Name =""
    End
End
