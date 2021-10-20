Operation =1
Option =0
Where ="(((BRS_TransactionDW_Ext.SalesOrderNumber) Is Null))"
Begin InputTables
    Name ="Integration_F5554240_fg_redeem_Staging"
    Name ="BRS_TransactionDW_Ext"
End
Begin OutputColumns
    Expression ="Integration_F5554240_fg_redeem_Staging.*"
    Expression ="BRS_TransactionDW_Ext.SalesOrderNumber"
End
Begin Joins
    LeftTable ="Integration_F5554240_fg_redeem_Staging"
    RightTable ="BRS_TransactionDW_Ext"
    Expression ="Integration_F5554240_fg_redeem_Staging.WKDOCO_salesorder_number = BRS_Transactio"
        "nDW_Ext.SalesOrderNumber"
    Flag =2
    LeftTable ="Integration_F5554240_fg_redeem_Staging"
    RightTable ="BRS_TransactionDW_Ext"
    Expression ="Integration_F5554240_fg_redeem_Staging.WKDCTO_order_type = BRS_TransactionDW_Ext"
        ".DocType"
    Flag =2
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
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKAC10_division_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW_Ext.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.line_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.order_file_name"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKALPH_billto_name"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.status_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.CalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKDSC__um_description"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKKEY__key"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKDCTO_order_type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WK$SPC_supplier_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKLITM_item_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKDL01_promo_description"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKDATE_order_date"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKCITM_customersupplier_item_number"
        dbLong "AggregateType" ="-1"
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
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKLNTY_line_type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKUNCS_unit_cost"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKTHGD_thru_grade"
        dbLong "AggregateType" ="-1"
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
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKSHAN_shipto"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKNAME_shipto_name"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKDOCO_salesorder_number"
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
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKPSN__invoice_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WK$ODN_free_goods_contract_number"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1705
    Bottom =918
    Left =-1
    Top =-1
    Right =866
    Bottom =656
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =119
        Top =78
        Right =484
        Bottom =603
        Top =0
        Name ="Integration_F5554240_fg_redeem_Staging"
        Name =""
    End
    Begin
        Left =617
        Top =104
        Right =972
        Bottom =356
        Top =0
        Name ="BRS_TransactionDW_Ext"
        Name =""
    End
End
