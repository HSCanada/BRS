Operation =1
Option =0
Begin InputTables
    Name ="Integration_F5554240_fg_redeem_Staging"
End
Begin OutputColumns
    Expression ="Integration_F5554240_fg_redeem_Staging.*"
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
dbMemo "OrderBy" ="[FFA20_stage_review].[order_file_name], [FFA20_stage_review].[line_id], [FFA20_s"
    "tage_review].[WKUNCS_unit_cost], [FFA20_stage_review].[WK$SPC_supplier_code]"
Begin
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKNAME_shipto_name"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.line_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.order_file_name"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2865"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKAC10_division_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKDCTO_order_type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKKEY__key"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKDOCO_salesorder_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.status_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKLITM_item_number"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2550"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKDATE_order_date"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WK$SPC_supplier_code"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2610"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKCITM_customersupplier_item_number"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="4320"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKLNTY_line_type"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2175"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKUORG_quantity"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKUOM__um"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKUNCS_unit_cost"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKDL01_promo_description"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3420"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKCRCD_currency_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKECST_extended_cost"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKDSC1_description"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3240"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WK$ODN_free_goods_contract_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKDSC2_pricing_adjustment_line"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKAN8__billto"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKALPH_billto_name"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKSHAN_shipto"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WK$HGS_status_code_high"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKFRGD_from_grade"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKTHGD_thru_grade"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKPSN__invoice_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.fg_exempt_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKPMID_promo_code"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2505"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKLNNO_line_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.ID_source_ref"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKDATE_order_date_text"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.CalMonthOrder"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.CalMonthRedeem"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1587
    Bottom =918
    Left =-1
    Top =-1
    Right =1571
    Bottom =418
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =139
        Top =79
        Right =415
        Bottom =330
        Top =0
        Name ="Integration_F5554240_fg_redeem_Staging"
        Name =""
    End
End
