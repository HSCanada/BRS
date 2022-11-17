Operation =1
Option =0
Where ="(((fg_deal_item.CalMonthRedeem)=202211) AND ((CDate([SalesDate])) Between CDate("
    "[EffDate]) And CDate([Expired])) AND ((fg_deal.active_ind)=True))"
Begin InputTables
    Name ="fg_deal"
    Name ="BRS_Config"
    Name ="fg_deal_item"
    Name ="fg_chargeback"
    Name ="BRS_Item"
End
Begin OutputColumns
    Expression ="fg_deal_item.item"
    Alias ="FSI"
    Expression ="\"I\""
    Alias ="promo_limit_qty"
    Expression ="10"
    Expression ="fg_deal.buy_qty"
    Alias ="promo_eff_date"
    Expression ="Now()+1"
    Alias ="promo_end_date"
    Expression ="CDate([Expired])"
    Alias ="fg_item"
    Expression ="[fg_deal_item]![item]"
    Alias ="fg_item2"
    Expression ="[fg_deal_item]![item]"
    Expression ="fg_deal.get_qty"
    Alias ="fg_price"
    Expression ="0"
    Expression ="fg_chargeback.cb_contract_num"
    Alias ="fg_default"
    Expression ="IIf([fg_deal_item]![item]=IIf([deal_type_cd]=\"AA\",[fg_deal_item]![item],[fg_ge"
        "t_item_default]),\"XX\",\"\")"
    Alias ="prov_field"
    Expression ="\".\""
    Expression ="fg_deal_item.CalMonthRedeem"
    Expression ="fg_deal.deal_id"
    Expression ="fg_deal.SalesDivision"
    Expression ="fg_deal.Supplier"
    Expression ="BRS_Item.FamilySetLeader"
    Expression ="fg_deal.deal_type_cd"
    Expression ="fg_deal_item.deal_source_cd"
    Expression ="fg_deal.EffDate"
    Expression ="fg_deal.Expired"
    Expression ="fg_deal.BuyOrg"
    Expression ="fg_deal.GetOrg"
    Expression ="fg_deal.deal_txt"
    Expression ="fg_deal.NoteOrg"
End
Begin Joins
    LeftTable ="fg_deal"
    RightTable ="fg_deal_item"
    Expression ="fg_deal.deal_id = fg_deal_item.deal_id"
    Flag =1
    LeftTable ="fg_deal"
    RightTable ="fg_chargeback"
    Expression ="fg_deal.Supplier = fg_chargeback.fg_supplier"
    Flag =1
    LeftTable ="fg_deal_item"
    RightTable ="BRS_Item"
    Expression ="fg_deal_item.item = BRS_Item.Item"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="2"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="fg_deal.buy_qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_deal.deal_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FSI"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="promo_limit_qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="promo_eff_date"
        dbText "Format" ="Short Date"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="promo_end_date"
        dbText "Format" ="Short Date"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_deal_item.item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_chargeback.cb_contract_num"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2010"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="fg_deal.deal_txt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1965"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="fg_deal_item.CalMonthRedeem"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2100"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="fg_deal.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_deal.BuyOrg"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="5025"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="fg_deal.Expired"
        dbText "Format" ="Short Date"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_deal.GetOrg"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="8145"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="fg_deal.EffDate"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_deal.get_qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_deal.[EffDate]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_deal.deal_type_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_price"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_default"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_deal.SalesDivision"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_deal.NoteOrg"
        dbInteger "ColumnWidth" ="1995"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_deal.fg_get_item_default"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2445"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="zzzItem.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr2"
        dbText "Format" ="Short Date"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1001"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr3"
        dbText "Format" ="Short Date"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Config.SalesDate"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_deal.active_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1010"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.FamilySetLeader"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1017"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_deal_item.deal_source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1016"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="prov_field"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_item2"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1555
    Bottom =918
    Left =-1
    Top =-1
    Right =1020
    Bottom =327
    Left =96
    Top =0
    ColumnsShown =539
    Begin
        Left =183
        Top =25
        Right =506
        Bottom =565
        Top =0
        Name ="fg_deal"
        Name =""
    End
    Begin
        Left =646
        Top =197
        Right =790
        Bottom =341
        Top =0
        Name ="BRS_Config"
        Name =""
    End
    Begin
        Left =594
        Top =38
        Right =738
        Bottom =182
        Top =0
        Name ="fg_deal_item"
        Name =""
    End
    Begin
        Left =877
        Top =43
        Right =1096
        Bottom =187
        Top =0
        Name ="fg_chargeback"
        Name =""
    End
    Begin
        Left =876
        Top =290
        Right =1020
        Bottom =434
        Top =0
        Name ="BRS_Item"
        Name =""
    End
End
