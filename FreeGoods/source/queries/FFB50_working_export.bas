Operation =1
Option =0
Where ="(((fg_redeem_working.Item)>\"0\") AND ((fg_redeem_working.show_ind)=1))"
Begin InputTables
    Name ="fg_redeem_working"
    Name ="fg_deal"
    Name ="fg_deal_item"
End
Begin OutputColumns
    Expression ="fg_redeem_working.Supplier"
    Alias ="Customer"
    Expression ="[Shipto] & \" | \" & Left([PracticeName],20)"
    Alias ="Order"
    Expression ="fg_redeem_working.SalesOrderNumber"
    Alias ="Date"
    Expression ="fg_redeem_working.OrderFirstShipDate"
    Alias ="OrdDeal"
    Expression ="fg_redeem_working.OriginalSalesOrderNumber"
    Alias ="FS"
    Expression ="fg_redeem_working.FamilySetLeader"
    Alias ="Item"
    Expression ="Trim([fg_redeem_working]![Item]) & \" | \" & [ItemDescription]"
    Alias ="buyget"
    Expression ="fg_redeem_working.src"
    Alias ="Qty"
    Expression ="fg_redeem_working.ShippedQty"
    Alias ="claim?"
    Expression ="IIf([src]=\"GET\",IIf([fg_redeem_ind],\"Y\",\"no\"),\".\")"
    Expression ="fg_deal.deal_id"
    Expression ="fg_redeem_working.fg_exempt_cd"
    Alias ="fg_note"
    Expression ="fg_redeem_working.fg_offer_note"
    Alias ="deal_buy"
    Expression ="Left([BuyOrg],30)"
    Alias ="deal_get"
    Expression ="Left([GetOrg],30)"
    Alias ="deal_txt"
    Expression ="IIf([fg_deal]![deal_id],Left([fg_deal]![deal_txt],30) & IIf([auto_add_ind],\" (A"
        "A)\",\" (MM)\"),\".\")"
    Expression ="fg_redeem_working.PromotionDescription"
    Expression ="fg_redeem_working.Branch"
    Expression ="fg_redeem_working.ID"
    Expression ="fg_redeem_working.ID_source_ref"
    Expression ="fg_redeem_working.order_file_name"
    Expression ="fg_redeem_working.billto_name"
    Expression ="fg_redeem_working.BillTo"
    Expression ="fg_redeem_working.DocType"
    Expression ="fg_redeem_working.LineNumber"
    Expression ="fg_redeem_working.ManufPartNumber"
    Expression ="fg_redeem_working.WKUNCS_unit_cost"
    Expression ="fg_redeem_working.WKECST_extended_cost"
    Expression ="fg_redeem_working.PromotionCode"
    Expression ="fg_redeem_working.OrderPromotionCode"
    Expression ="fg_redeem_working.LineTypeOrder"
    Expression ="fg_redeem_working.SalesDivision"
    Expression ="fg_redeem_working.InvoiceNumber"
    Expression ="fg_redeem_working.Label"
    Expression ="fg_redeem_working.MajorProductClass"
    Expression ="fg_redeem_working.ExtFileCostCadAmt"
    Expression ="fg_redeem_working.VPA"
    Expression ="fg_redeem_working.CalMonthRedeem"
    Expression ="fg_redeem_working.CalMonth"
    Expression ="fg_redeem_working.WKCRCD_currency_code"
    Expression ="fg_redeem_working.HIST_Specialty"
    Expression ="fg_redeem_working.MajorProductClassDesc"
    Expression ="fg_redeem_working.status_code_high"
    Expression ="fg_redeem_working.ChargebackContractNumber"
    Expression ="fg_redeem_working.PricingAdjustmentLine"
    Expression ="fg_redeem_working.CreditMinorReasonCode"
    Expression ="fg_redeem_working.CreditTypeCode"
    Alias ="Item_code"
    Expression ="fg_redeem_working.Item"
End
Begin Joins
    LeftTable ="fg_deal"
    RightTable ="fg_deal_item"
    Expression ="fg_deal.deal_id = fg_deal_item.deal_id"
    Flag =3
    LeftTable ="fg_redeem_working"
    RightTable ="fg_deal_item"
    Expression ="fg_redeem_working.CalMonthRedeem = fg_deal_item.CalMonthRedeem"
    Flag =2
    LeftTable ="fg_redeem_working"
    RightTable ="fg_deal_item"
    Expression ="fg_redeem_working.Item = fg_deal_item.item"
    Flag =2
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="0"
dbByte "RecordsetType" ="2"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="fg_redeem_working.SalesDivision"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.order_file_name"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.DocType"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.CalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.CalMonthRedeem"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.LineNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.Branch"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1050"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="fg_redeem_working.WKECST_extended_cost"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.WKUNCS_unit_cost"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.WKCRCD_currency_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.MajorProductClassDesc"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.PromotionCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.PromotionDescription"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3585"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="fg_redeem_working.OrderPromotionCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.VPA"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.BillTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.HIST_Specialty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.LineTypeOrder"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.MajorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.Label"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.Supplier"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1200"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="fg_redeem_working.InvoiceNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.billto_name"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2550"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="fg_redeem_working.ID_source_ref"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.status_code_high"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.ChargebackContractNumber"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3030"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="fg_redeem_working.PricingAdjustmentLine"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.ExtFileCostCadAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.ManufPartNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Order"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1020"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Date"
        dbText "Format" ="Short Date"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FS"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Qty"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="750"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="fg_note"
        dbInteger "ColumnWidth" ="2385"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Customer"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3270"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Item"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="4095"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="deal_get"
        dbInteger "ColumnWidth" ="2850"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="deal_txt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3615"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="deal_buy"
        dbInteger "ColumnWidth" ="3465"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_deal.deal_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1110"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="fg_redeem_working.fg_exempt_cd"
        dbInteger "ColumnWidth" ="1740"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.CreditTypeCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.CreditMinorReasonCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="buyget"
        dbInteger "ColumnWidth" ="960"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OrdDeal"
        dbInteger "ColumnWidth" ="1185"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_deal.[deal_id]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="claim?"
        dbInteger "ColumnWidth" ="1530"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item_code"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1466
    Bottom =918
    Left =-1
    Top =-1
    Right =1450
    Bottom =342
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =166
        Top =-3
        Right =638
        Bottom =661
        Top =0
        Name ="fg_redeem_working"
        Name =""
    End
    Begin
        Left =958
        Top =36
        Right =1249
        Bottom =432
        Top =0
        Name ="fg_deal"
        Name =""
    End
    Begin
        Left =763
        Top =105
        Right =907
        Bottom =249
        Top =0
        Name ="fg_deal_item"
        Name =""
    End
End
