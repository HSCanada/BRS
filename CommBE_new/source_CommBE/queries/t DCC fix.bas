Operation =1
Option =0
Begin InputTables
    Name ="zzzItem"
    Name ="BRS_ItemMarketAdjustModel"
    Name ="Pricing_item_price_dcc"
    Name ="BRS_ItemMarketAdjustFix_dcc"
    Name ="BRS_Item"
    Name ="BRS_ItemMPC"
End
Begin OutputColumns
    Expression ="zzzItem.Item"
    Expression ="BRS_Item.ItemDescription"
    Expression ="BRS_ItemMarketAdjustModel.Supplier"
    Expression ="BRS_ItemMPC.MajorProductClassDesc"
    Expression ="BRS_ItemMarketAdjustModel.CurrentFileCost"
    Expression ="BRS_ItemMarketAdjustModel.CurrentCorporatePrice"
    Expression ="BRS_ItemMarketAdjustModel.FreightAdjPct"
    Expression ="BRS_ItemMarketAdjustModel.CorporateMarketAdjustmentPct"
    Expression ="BRS_ItemMarketAdjustModel.new_market_adj"
    Expression ="zzzItem.Note1"
    Expression ="Pricing_item_price_dcc.CurrentPrice"
    Expression ="Pricing_item_price_dcc.UnitChargeback"
    Expression ="Pricing_item_price_dcc.note_txt"
    Expression ="BRS_ItemMarketAdjustFix_dcc.new_corprorate_adj"
    Expression ="BRS_ItemMarketAdjustFix_dcc.new_divisional_adj"
End
Begin Joins
    LeftTable ="zzzItem"
    RightTable ="BRS_ItemMarketAdjustModel"
    Expression ="zzzItem.Item = BRS_ItemMarketAdjustModel.Item"
    Flag =2
    LeftTable ="zzzItem"
    RightTable ="Pricing_item_price_dcc"
    Expression ="zzzItem.Item = Pricing_item_price_dcc.Item"
    Flag =2
    LeftTable ="zzzItem"
    RightTable ="BRS_ItemMarketAdjustFix_dcc"
    Expression ="zzzItem.Item = BRS_ItemMarketAdjustFix_dcc.Item"
    Flag =2
    LeftTable ="zzzItem"
    RightTable ="BRS_Item"
    Expression ="zzzItem.Item = BRS_Item.Item"
    Flag =1
    LeftTable ="BRS_Item"
    RightTable ="BRS_ItemMPC"
    Expression ="BRS_Item.MajorProductClass = BRS_ItemMPC.MajorProductClass"
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
        dbText "Name" ="BRS_ItemMarketAdjustModel.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzItem.Note1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzItem.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemMarketAdjustModel.SalesCategory"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemMarketAdjustModel.CurrentFileCost"
        dbInteger "ColumnWidth" ="1875"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemMarketAdjustModel.CurrentCorporatePrice"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemMarketAdjustModel.new_market_adj"
        dbInteger "ColumnWidth" ="1980"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemMarketAdjustFix_dcc.new_corprorate_adj"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemMarketAdjustFix_dcc.new_divisional_adj"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2220"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="BRS_ItemMarketAdjustFix_dcc.new_divisional_adj_import"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2955"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="BRS_ItemMarketAdjustModel.Label"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzItem.Note2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Pricing_item_price_dcc.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzItem.Note5"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.MajorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzItem.Note4"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzItem.Note3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Pricing_item_price_dcc.CurrentPrice"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Pricing_item_price_dcc.UnitChargeback"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Pricing_item_price_dcc.note_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemMarketAdjustModel.StockingType"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemMarketAdjustFix_dcc.Est12MoSales"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemMarketAdjustModel.FreightAdjPct"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.ItemDescription"
        dbInteger "ColumnWidth" ="3135"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemMarketAdjustModel.CorporateMarketAdjustmentPct"
        dbInteger "ColumnWidth" ="1770"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemMPC.MajorProductClassDesc"
        dbInteger "ColumnWidth" ="3060"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =1460
    Bottom =581
    Left =-1
    Top =-1
    Right =1158
    Bottom =308
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =58
        Top =20
        Right =202
        Bottom =164
        Top =0
        Name ="zzzItem"
        Name =""
    End
    Begin
        Left =682
        Top =35
        Right =976
        Bottom =251
        Top =0
        Name ="BRS_ItemMarketAdjustModel"
        Name =""
    End
    Begin
        Left =198
        Top =173
        Right =342
        Bottom =317
        Top =0
        Name ="Pricing_item_price_dcc"
        Name =""
    End
    Begin
        Left =774
        Top =88
        Right =1063
        Bottom =270
        Top =0
        Name ="BRS_ItemMarketAdjustFix_dcc"
        Name =""
    End
    Begin
        Left =287
        Top =2
        Right =431
        Bottom =146
        Top =0
        Name ="BRS_Item"
        Name =""
    End
    Begin
        Left =488
        Top =102
        Right =632
        Bottom =246
        Top =0
        Name ="BRS_ItemMPC"
        Name =""
    End
End
