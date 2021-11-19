Operation =1
Option =0
Begin InputTables
    Name ="fg_redeem_actual_commission"
End
Begin OutputColumns
    Expression ="fg_redeem_actual_commission.SalesOrderNumber"
    Expression ="fg_redeem_actual_commission.DocType"
    Expression ="fg_redeem_actual_commission.LineNumber"
    Expression ="fg_redeem_actual_commission.CalMonthRedeem"
    Expression ="fg_redeem_actual_commission.CalMonth"
    Expression ="fg_redeem_actual_commission.fg_exempt_cd"
    Expression ="fg_redeem_actual_commission.src"
    Expression ="fg_redeem_actual_commission.fg_offer_id"
    Expression ="fg_redeem_actual_commission.fg_offer_note"
    Expression ="fg_redeem_actual_commission.Shipto"
    Expression ="fg_redeem_actual_commission.PracticeName"
    Expression ="fg_redeem_actual_commission.Branch"
    Expression ="fg_redeem_actual_commission.Item"
    Expression ="fg_redeem_actual_commission.ItemDescription"
    Expression ="fg_redeem_actual_commission.ShippedQty"
    Expression ="fg_redeem_actual_commission.WKECST_extended_cost"
    Expression ="fg_redeem_actual_commission.ExtFileCostCadAmt"
    Expression ="fg_redeem_actual_commission.WKUNCS_unit_cost"
    Expression ="fg_redeem_actual_commission.WKCRCD_currency_code"
    Expression ="fg_redeem_actual_commission.PromotionCode"
    Expression ="fg_redeem_actual_commission.PromotionDescription"
    Expression ="fg_redeem_actual_commission.OrderPromotionCode"
    Expression ="fg_redeem_actual_commission.OrderFirstShipDate"
    Expression ="fg_redeem_actual_commission.VPA"
    Expression ="fg_redeem_actual_commission.HIST_Specialty"
    Expression ="fg_redeem_actual_commission.LineTypeOrder"
    Expression ="fg_redeem_actual_commission.SalesDivision"
    Expression ="fg_redeem_actual_commission.MajorProductClass"
    Expression ="fg_redeem_actual_commission.MajorProductClassDesc"
    Expression ="fg_redeem_actual_commission.Label"
    Expression ="fg_redeem_actual_commission.Supplier"
    Expression ="fg_redeem_actual_commission.InvoiceNumber"
    Expression ="fg_redeem_actual_commission.OriginalSalesOrderNumber"
    Expression ="fg_redeem_actual_commission.BillTo"
    Expression ="fg_redeem_actual_commission.billto_name"
    Expression ="fg_redeem_actual_commission.ID"
    Expression ="fg_redeem_actual_commission.ID_source_ref"
    Expression ="fg_redeem_actual_commission.status_code_high"
    Expression ="fg_redeem_actual_commission.ChargebackContractNumber"
    Expression ="fg_redeem_actual_commission.PricingAdjustmentLine"
    Expression ="fg_redeem_actual_commission.order_file_name"
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
        dbText "Name" ="fg_redeem_actual_commission.ItemDescription"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.fg_exempt_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.ShippedQty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.src"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.WKECST_extended_cost"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.fg_offer_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.WKUNCS_unit_cost"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.fg_offer_note"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.WKCRCD_currency_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.Shipto"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.DocType"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.PromotionCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.PracticeName"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.LineNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.PromotionDescription"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.Branch"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.CalMonthRedeem"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.OrderPromotionCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.CalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.OrderFirstShipDate"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.VPA"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.HIST_Specialty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.LineTypeOrder"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.SalesDivision"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.MajorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.MajorProductClassDesc"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.Label"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.InvoiceNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.OriginalSalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.BillTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.billto_name"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.ID_source_ref"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.status_code_high"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.ChargebackContractNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.PricingAdjustmentLine"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.order_file_name"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_actual_commission.ExtFileCostCadAmt"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1649
    Bottom =918
    Left =-1
    Top =-1
    Right =1633
    Bottom =537
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =284
        Top =64
        Right =578
        Bottom =409
        Top =0
        Name ="fg_redeem_actual_commission"
        Name =""
    End
End
