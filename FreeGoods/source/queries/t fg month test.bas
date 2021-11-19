Operation =1
Option =0
Where ="(((Integration_F5554240_fg_redeem_Staging.WKDL01_promo_description)<>[PromotionD"
    "escription]))"
Begin InputTables
    Name ="Integration_F5554240_fg_redeem_Staging"
    Name ="BRS_TransactionDW"
    Name ="BRS_Promotion"
End
Begin OutputColumns
    Expression ="Integration_F5554240_fg_redeem_Staging.order_file_name"
    Expression ="Integration_F5554240_fg_redeem_Staging.line_id"
    Expression ="Integration_F5554240_fg_redeem_Staging.WKPMID_promo_code"
    Expression ="Integration_F5554240_fg_redeem_Staging.WKDL01_promo_description"
    Expression ="BRS_TransactionDW.PromotionCode"
    Expression ="BRS_Promotion.PromotionDescription"
End
Begin Joins
    LeftTable ="Integration_F5554240_fg_redeem_Staging"
    RightTable ="BRS_TransactionDW"
    Expression ="Integration_F5554240_fg_redeem_Staging.WKDOCO_salesorder_number = BRS_Transactio"
        "nDW.SalesOrderNumber"
    Flag =1
    LeftTable ="Integration_F5554240_fg_redeem_Staging"
    RightTable ="BRS_TransactionDW"
    Expression ="Integration_F5554240_fg_redeem_Staging.WKDCTO_order_type = BRS_TransactionDW.Doc"
        "Type"
    Flag =1
    LeftTable ="Integration_F5554240_fg_redeem_Staging"
    RightTable ="BRS_TransactionDW"
    Expression ="Integration_F5554240_fg_redeem_Staging.WKLNNO_line_number = BRS_TransactionDW.Li"
        "neNumber"
    Flag =1
    LeftTable ="BRS_TransactionDW"
    RightTable ="BRS_Promotion"
    Expression ="BRS_TransactionDW.PromotionCode = BRS_Promotion.PromotionCode"
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
dbMemo "OrderBy" ="[t fg month test].[WKDL01_promo_description]"
Begin
    Begin
        dbText "Name" ="BRS_TransactionDW.CalMonth"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1320"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.line_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.order_file_name"
        dbInteger "ColumnWidth" ="2550"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.OrderFirstShipDate"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.Date"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKDATE_order_date"
        dbInteger "ColumnWidth" ="2355"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.BackorderInd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.CalMonthOrder"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1860"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKPMID_promo_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.fg_exempt_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKCITM_customersupplier_item_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKDL01_promo_description"
        dbInteger "ColumnWidth" ="3405"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKDSC2_pricing_adjustment_line"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKLITM_item_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.Shipto"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKECST_extended_cost"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WK$SPC_supplier_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKAN8__billto"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKCRCD_currency_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKAC10_division_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.status_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKDCTO_order_type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKUNCS_unit_cost"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKKEY__key"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKUOM__um"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKNAME_shipto_name"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.CalMonth"
        dbInteger "ColumnWidth" ="5265"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKUORG_quantity"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="CountOfSalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.LineTypeOrder"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKLNTY_line_type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKDSC1_description"
        dbInteger "ColumnWidth" ="2685"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKPSN__invoice_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKALPH_billto_name"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WK$ODN_free_goods_contract_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKSHAN_shipto"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKLNNO_line_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKDOCO_salesorder_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WK$HGS_status_code_high"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1"
        dbInteger "ColumnWidth" ="2355"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKFRGD_from_grade"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1003"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKTHGD_thru_grade"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.PromotionCode"
        dbInteger "ColumnWidth" ="1890"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.CalMonthRedeem"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Promotion.PromotionDescription"
        dbInteger "ColumnWidth" ="3405"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1360
    Bottom =918
    Left =-1
    Top =-1
    Right =1344
    Bottom =656
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =182
        Top =21
        Right =541
        Bottom =631
        Top =0
        Name ="Integration_F5554240_fg_redeem_Staging"
        Name =""
    End
    Begin
        Left =632
        Top =72
        Right =840
        Bottom =526
        Top =0
        Name ="BRS_TransactionDW"
        Name =""
    End
    Begin
        Left =1026
        Top =108
        Right =1170
        Bottom =252
        Top =0
        Name ="BRS_Promotion"
        Name =""
    End
End
