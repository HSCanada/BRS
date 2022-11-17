Operation =1
Option =0
Where ="(((fg_redeem_working.SalesOrderNumber)=15345802) AND ((fg_redeem_working.Item)>\""
    "0\"))"
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
    Expression ="fg_redeem_working.EnteredBy"
    Expression ="fg_redeem_working.Shipto"
    Expression ="fg_redeem_working.Item"
    Expression ="fg_redeem_working.LineNumber"
End
Begin Joins
    LeftTable ="fg_deal"
    RightTable ="fg_deal_item"
    Expression ="fg_deal.deal_id = fg_deal_item.deal_id"
    Flag =3
    LeftTable ="fg_redeem_working"
    RightTable ="fg_deal_item"
    Expression ="fg_redeem_working.Item = fg_deal_item.item"
    Flag =2
    LeftTable ="fg_redeem_working"
    RightTable ="fg_deal_item"
    Expression ="fg_redeem_working.CalMonthRedeem = fg_deal_item.CalMonthRedeem"
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
dbMemo "OrderBy" ="[FFB30_working_review_adhoc].[Supplier]"
Begin
    Begin
        dbText "Name" ="fg_redeem_working.Supplier"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1200"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Customer"
        dbInteger "ColumnWidth" ="2970"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Order"
        dbInteger "ColumnWidth" ="1020"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Date"
        dbInteger "ColumnWidth" ="1200"
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
        dbText "Name" ="FS"
        dbInteger "ColumnWidth" ="1050"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item"
        dbInteger "ColumnWidth" ="4110"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="buyget"
        dbInteger "ColumnWidth" ="1065"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Qty"
        dbInteger "ColumnWidth" ="750"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="claim?"
        dbInteger "ColumnWidth" ="1020"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_note"
        dbInteger "ColumnWidth" ="3060"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="deal_buy"
        dbInteger "ColumnWidth" ="2940"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="deal_get"
        dbInteger "ColumnWidth" ="2835"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="deal_txt"
        dbInteger "ColumnWidth" ="3360"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.CreditMinorReasonCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.PromotionCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.CalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.VPA"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.ChargebackContractNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.WKUNCS_unit_cost"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_deal.deal_id"
        dbInteger "ColumnWidth" ="1110"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.fg_exempt_cd"
        dbInteger "ColumnWidth" ="1740"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.status_code_high"
        dbInteger "ColumnWidth" ="2040"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.PromotionDescription"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3420"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="fg_redeem_working.Branch"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.ID_source_ref"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.CreditTypeCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.order_file_name"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2850"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="fg_redeem_working.Label"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.billto_name"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.BillTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.ExtFileCostCadAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.DocType"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.LineNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.ManufPartNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.WKECST_extended_cost"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.OrderPromotionCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.LineTypeOrder"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.SalesDivision"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.InvoiceNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.MajorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.CalMonthRedeem"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.WKCRCD_currency_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.HIST_Specialty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.MajorProductClassDesc"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2955"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="fg_redeem_working.PricingAdjustmentLine"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.EnteredBy"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.Shipto"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1024"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1364
    Bottom =690
    Left =-1
    Top =-1
    Right =1348
    Bottom =211
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =318
        Bottom =412
        Top =0
        Name ="fg_redeem_working"
        Name =""
    End
    Begin
        Left =829
        Top =78
        Right =973
        Bottom =222
        Top =0
        Name ="fg_deal"
        Name =""
    End
    Begin
        Left =592
        Top =113
        Right =736
        Bottom =257
        Top =0
        Name ="fg_deal_item"
        Name =""
    End
End
