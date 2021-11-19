Operation =1
Option =0
Where ="(((fg_redeem_working.SalesOrderNumber)=14459975))"
Begin InputTables
    Name ="fg_redeem_working"
End
Begin OutputColumns
    Expression ="fg_redeem_working.SalesOrderNumber"
    Expression ="fg_redeem_working.DocType"
    Expression ="fg_redeem_working.LineNumber"
    Expression ="fg_redeem_working.CalMonthRedeem"
    Expression ="fg_redeem_working.CalMonth"
    Expression ="fg_redeem_working.fg_exempt_cd"
    Expression ="fg_redeem_working.src"
    Expression ="fg_redeem_working.fg_offer_id"
    Expression ="fg_redeem_working.fg_offer_note"
    Expression ="fg_redeem_working.Shipto"
    Expression ="fg_redeem_working.PracticeName"
    Expression ="fg_redeem_working.Branch"
    Expression ="fg_redeem_working.Item"
    Expression ="fg_redeem_working.ItemDescription"
    Expression ="fg_redeem_working.ShippedQty"
    Expression ="fg_redeem_working.WKECST_extended_cost"
    Expression ="fg_redeem_working.WKUNCS_unit_cost"
    Expression ="fg_redeem_working.WKCRCD_currency_code"
    Expression ="fg_redeem_working.PromotionCode"
    Expression ="fg_redeem_working.PromotionDescription"
    Expression ="fg_redeem_working.OrderPromotionCode"
    Expression ="fg_redeem_working.OrderFirstShipDate"
    Expression ="fg_redeem_working.VPA"
    Expression ="fg_redeem_working.HIST_Specialty"
    Expression ="fg_redeem_working.LineTypeOrder"
    Expression ="fg_redeem_working.SalesDivision"
    Expression ="fg_redeem_working.MajorProductClass"
    Expression ="fg_redeem_working.MajorProductClassDesc"
    Expression ="fg_redeem_working.Label"
    Expression ="fg_redeem_working.Supplier"
    Expression ="fg_redeem_working.InvoiceNumber"
    Expression ="fg_redeem_working.OriginalSalesOrderNumber"
    Expression ="fg_redeem_working.BillTo"
    Expression ="fg_redeem_working.billto_name"
    Expression ="fg_redeem_working.ID"
    Expression ="fg_redeem_working.ID_source_ref"
    Expression ="fg_redeem_working.status_code_high"
    Expression ="fg_redeem_working.ChargebackContractNumber"
    Expression ="fg_redeem_working.PricingAdjustmentLine"
    Expression ="fg_redeem_working.order_file_name"
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
        dbText "Name" ="fg_redeem_working.billto_name"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.Branch"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.PracticeName"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.order_file_name"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.VPA"
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
        dbText "Name" ="fg_redeem_working.DocType"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.fg_exempt_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.CalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.src"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.fg_offer_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.ChargebackContractNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.fg_offer_note"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.Shipto"
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
        dbText "Name" ="fg_redeem_working.HIST_Specialty"
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
        dbText "Name" ="fg_redeem_working.MajorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.MajorProductClassDesc"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2670"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="fg_redeem_working.Label"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.InvoiceNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.OriginalSalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.BillTo"
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
        dbText "Name" ="fg_redeem_working.status_code_high"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.PricingAdjustmentLine"
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
    Bottom =639
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =77
        Top =57
        Right =783
        Bottom =623
        Top =0
        Name ="fg_redeem_working"
        Name =""
    End
End
