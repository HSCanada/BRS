Operation =1
Option =0
Begin InputTables
    Name ="fg_redeem_working"
    Name ="zzzItem"
    Name ="Redemptions_tbl_Items"
    Name ="Redemptions_tbl_Main"
End
Begin OutputColumns
    Expression ="fg_redeem_working.order_file_name"
    Expression ="fg_redeem_working.Supplier"
    Expression ="fg_redeem_working.BillTo"
    Expression ="fg_redeem_working.billto_name"
    Expression ="fg_redeem_working.Shipto"
    Expression ="fg_redeem_working.PracticeName"
    Expression ="fg_redeem_working.SalesOrderNumber"
    Expression ="fg_redeem_working.DocType"
    Expression ="fg_redeem_working.LineNumber"
    Expression ="fg_redeem_working.OrderFirstShipDate"
    Expression ="fg_redeem_working.FamilySetLeader"
    Expression ="fg_redeem_working.Item"
    Expression ="fg_redeem_working.ShippedQty"
    Expression ="fg_redeem_working.fg_exempt_cd"
    Expression ="fg_redeem_working.src"
    Alias ="fg_offer_id"
    Expression ="Redemptions_tbl_Items.RecID"
    Alias ="fg_buy"
    Expression ="Redemptions_tbl_Main.Buy"
    Alias ="fg_get"
    Expression ="Redemptions_tbl_Main.Get"
    Expression ="fg_redeem_working.fg_offer_note"
    Expression ="fg_redeem_working.ManufPartNumber"
    Expression ="fg_redeem_working.ItemDescription"
    Expression ="fg_redeem_working.WKUNCS_unit_cost"
    Expression ="fg_redeem_working.WKECST_extended_cost"
    Expression ="fg_redeem_working.PromotionCode"
    Expression ="fg_redeem_working.OrderPromotionCode"
    Expression ="fg_redeem_working.PromotionDescription"
    Expression ="fg_redeem_working.LineTypeOrder"
    Expression ="fg_redeem_working.SalesDivision"
    Expression ="fg_redeem_working.InvoiceNumber"
    Expression ="fg_redeem_working.Label"
    Expression ="fg_redeem_working.Branch"
    Expression ="fg_redeem_working.MajorProductClass"
    Expression ="fg_redeem_working.ExtFileCostCadAmt"
    Expression ="fg_redeem_working.VPA"
    Expression ="fg_redeem_working.ID"
    Expression ="fg_redeem_working.ID_source_ref"
    Expression ="fg_redeem_working.CalMonthRedeem"
    Expression ="fg_redeem_working.CalMonth"
    Expression ="fg_redeem_working.WKCRCD_currency_code"
    Expression ="fg_redeem_working.HIST_Specialty"
    Expression ="fg_redeem_working.MajorProductClassDesc"
    Expression ="fg_redeem_working.OriginalSalesOrderNumber"
    Expression ="fg_redeem_working.status_code_high"
    Expression ="fg_redeem_working.ChargebackContractNumber"
    Expression ="fg_redeem_working.PricingAdjustmentLine"
End
Begin Joins
    LeftTable ="fg_redeem_working"
    RightTable ="zzzItem"
    Expression ="fg_redeem_working.Supplier = zzzItem.Item"
    Flag =1
    LeftTable ="fg_redeem_working"
    RightTable ="Redemptions_tbl_Items"
    Expression ="fg_redeem_working.Item = Redemptions_tbl_Items.ItemNumber"
    Flag =2
    LeftTable ="Redemptions_tbl_Items"
    RightTable ="Redemptions_tbl_Main"
    Expression ="Redemptions_tbl_Items.RecID = Redemptions_tbl_Main.RecID"
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
        dbText "Name" ="fg_redeem_working.SalesOrderNumber"
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
        dbText "Name" ="fg_redeem_working.src"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.fg_exempt_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1740"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="fg_redeem_working.fg_offer_note"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3360"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="fg_redeem_working.Shipto"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.PracticeName"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2940"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="fg_redeem_working.Branch"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.ItemDescription"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.ShippedQty"
        dbLong "AggregateType" ="-1"
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
    End
    Begin
        dbText "Name" ="fg_redeem_working.OrderPromotionCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.OrderFirstShipDate"
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
    End
    Begin
        dbText "Name" ="fg_redeem_working.InvoiceNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.OriginalSalesOrderNumber"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2940"
        dbBoolean "ColumnHidden" ="0"
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
        dbText "Name" ="fg_redeem_working.FamilySetLeader"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.ManufPartNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_get"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_buy"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_offer_id"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1289
    Bottom =918
    Left =-1
    Top =-1
    Right =1273
    Bottom =605
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =-11
        Top =-14
        Right =461
        Bottom =561
        Top =0
        Name ="fg_redeem_working"
        Name =""
    End
    Begin
        Left =572
        Top =19
        Right =716
        Bottom =163
        Top =0
        Name ="zzzItem"
        Name =""
    End
    Begin
        Left =619
        Top =200
        Right =763
        Bottom =344
        Top =0
        Name ="Redemptions_tbl_Items"
        Name =""
    End
    Begin
        Left =911
        Top =238
        Right =1055
        Bottom =382
        Top =0
        Name ="Redemptions_tbl_Main"
        Name =""
    End
End
