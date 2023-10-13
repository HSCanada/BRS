Operation =3
Name ="Integration_F5554240_fg_redeem_Staging"
Option =0
Begin InputTables
    Name ="lnk_F5554240_LOAD"
End
Begin OutputColumns
    Name ="order_file_name"
    Expression ="lnk_F5554240_LOAD.FILE_NAME"
    Name ="line_id"
    Expression ="lnk_F5554240_LOAD.FILE_LINE"
    Name ="WKKEY__key"
    Expression ="lnk_F5554240_LOAD.[Key  ----------]"
    Name ="WKAC10_division_code"
    Expression ="lnk_F5554240_LOAD.[Cat Cde ---]"
    Name ="WK$SPC_supplier_code"
    Expression ="lnk_F5554240_LOAD.[Sppl Cde ------]"
    Name ="WKLITM_item_number"
    Expression ="lnk_F5554240_LOAD.[2nd Item Number --------------------]"
    Name ="WKCITM_customersupplier_item_number"
    Expression ="lnk_F5554240_LOAD.[Customer/Supplier Item Number --------------------]"
    Name ="WKUORG_quantity"
    Expression ="lnk_F5554240_LOAD.[Quantity Ordered ---------------]"
    Name ="WKUOM__um"
    Expression ="lnk_F5554240_LOAD.[UM  --]"
    Name ="WKUNCS_unit_cost"
    Expression ="lnk_F5554240_LOAD.[Unit Cost ---------------]"
    Name ="WKCRCD_currency_code"
    Expression ="lnk_F5554240_LOAD.[Cur Cod ---]"
    Name ="WKECST_extended_cost"
    Expression ="lnk_F5554240_LOAD.[Extended Cost --------------------]"
    Name ="WKDSC1_description"
    Expression ="lnk_F5554240_LOAD.[Description  --------------------]"
    Name ="WKDSC2_pricing_adjustment_line"
    Expression ="lnk_F5554240_LOAD.[Description Line 2 --------------------]"
    Name ="WKAN8__billto"
    Expression ="lnk_F5554240_LOAD.[BILLTO NUMBER   ]"
    Name ="WKALPH_billto_name"
    Expression ="lnk_F5554240_LOAD.[BILLTO NAME    ]"
    Name ="WKSHAN_shipto"
    Expression ="lnk_F5554240_LOAD.[Ship To Number --------]"
    Name ="WKNAME_shipto_name"
    Expression ="lnk_F5554240_LOAD.[SHIPTO NAME    ]"
    Name ="WKDOCO_salesorder_number"
    Expression ="lnk_F5554240_LOAD.[Order Number --------]"
    Name ="WKDCTO_order_type"
    Expression ="lnk_F5554240_LOAD.[Or Ty --]"
    Name ="WK$HGS_status_code_high"
    Expression ="lnk_F5554240_LOAD.[High Sts ----]"
    Name ="WKDATE_order_date_text"
    Expression ="lnk_F5554240_LOAD.[ORDER DATE     ]"
    Name ="WKFRGD_from_grade"
    Expression ="lnk_F5554240_LOAD.[Frm Grd ---]"
    Name ="WKTHGD_thru_grade"
    Expression ="lnk_F5554240_LOAD.[Thr Grd ---]"
    Name ="WKLNTY_line_type"
    Expression ="lnk_F5554240_LOAD.[Ln Ty --]"
    Name ="WKPSN__invoice_number"
    Expression ="lnk_F5554240_LOAD.[Invoice Number]"
    Name ="WK$ODN_free_goods_contract_number"
    Expression ="lnk_F5554240_LOAD.[Free Goods Contract Number]"
    Name ="WKDL01_promo_description"
    Expression ="lnk_F5554240_LOAD.[PROMO DESCRIPTION]"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbByte "Orientation" ="0"
Begin
    Begin
        dbText "Name" ="lnk_F5554240_LOAD.[PROMO DESCRIPTION]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnk_F5554240_LOAD.FILE_NAME"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnk_F5554240_LOAD.[Cat Cde ---]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnk_F5554240_LOAD.[SHIPTO NAME    ]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnk_F5554240_LOAD.[Key  ----------]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnk_F5554240_LOAD.FILE_LINE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnk_F5554240_LOAD.[2nd Item Number --------------------]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnk_F5554240_LOAD.[Free Goods Contract Number]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnk_F5554240_LOAD.[Sppl Cde ------]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnk_F5554240_LOAD.[ORDER DATE     ]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnk_F5554240_LOAD.[Customer/Supplier Item Number --------------------]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnk_F5554240_LOAD.[Quantity Ordered ---------------]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnk_F5554240_LOAD.[UM  --]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnk_F5554240_LOAD.[Unit Cost ---------------]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnk_F5554240_LOAD.[Cur Cod ---]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnk_F5554240_LOAD.[Extended Cost --------------------]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnk_F5554240_LOAD.[Description  --------------------]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnk_F5554240_LOAD.[Description Line 2 --------------------]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnk_F5554240_LOAD.[BILLTO NUMBER   ]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnk_F5554240_LOAD.[BILLTO NAME    ]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnk_F5554240_LOAD.[Ship To Number --------]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnk_F5554240_LOAD.[Invoice Number]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnk_F5554240_LOAD.[Order Number --------]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnk_F5554240_LOAD.[Or Ty --]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnk_F5554240_LOAD.[High Sts ----]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnk_F5554240_LOAD.[Frm Grd ---]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnk_F5554240_LOAD.[Thr Grd ---]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnk_F5554240_LOAD.[Ln Ty --]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="calmonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1"
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
    Bottom =622
    Left =0
    Top =0
    ColumnsShown =651
    Begin
        Left =80
        Top =41
        Right =434
        Bottom =318
        Top =0
        Name ="lnk_F5554240_LOAD"
        Name =""
    End
End
