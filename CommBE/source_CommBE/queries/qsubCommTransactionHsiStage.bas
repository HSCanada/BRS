Operation =1
Option =0
Begin InputTables
    Name ="comm_transaction_hsi_stage"
    Name ="comm_configure"
End
Begin OutputColumns
    Expression ="comm_transaction_hsi_stage.key_id"
    Alias ="fiscal_yearmo_num"
    Expression ="comm_configure.current_fiscal_yearmo_num"
    Alias ="salesperson_cd"
    Expression ="IIf([WKAC11] In (\"AZA\",\"AZE\"),\"AZAZZ\",[WK$L04])"
    Alias ="source_cd"
    Expression ="\"JDE\""
    Alias ="transaction_dt"
    Expression ="DateSerial(Mid([WKDATE],1,2),Mid([WKDATE],4,2),Mid([WKDATE],7,2))"
    Alias ="transaction_amt"
    Expression ="comm_transaction_hsi_stage.WKAEXP"
    Alias ="doc_key_id"
    Expression ="[WKDCTO] & Right(Space(7) & [WKDOCO],7)"
    Alias ="line_id"
    Expression ="CLng([WKLNID]*1000)"
    Alias ="doc_id"
    Expression ="comm_transaction_hsi_stage.WKDOCO"
    Alias ="order_id"
    Expression ="comm_transaction_hsi_stage.WKDOCO"
    Alias ="reference_order_txt"
    Expression ="Left([WKVR01],16)"
    Alias ="order_source_cd"
    Expression ="comm_transaction_hsi_stage.[WK$OSC]"
    Alias ="customer_nm"
    Expression ="comm_transaction_hsi_stage.WKALPH"
    Alias ="item_id"
    Expression ="Nz([WKLITM],\"\")"
    Alias ="shipped_qty"
    Expression ="comm_transaction_hsi_stage.WKSOQS"
    Alias ="price_override_ind"
    Expression ="IIf([WKPROV]=\"1\",1,0)"
    Alias ="transaction_txt"
    Expression ="comm_transaction_hsi_stage.WKDSC1"
    Alias ="unit_price_cd"
    Expression ="comm_transaction_hsi_stage.WKUOM1"
    Alias ="comm_amt"
    Expression ="0"
    Alias ="cost_unit_amt"
    Expression ="comm_transaction_hsi_stage.[WK$UNC]"
    Alias ="item_label_cd"
    Expression ="comm_transaction_hsi_stage.WKCYCL"
    Alias ="cost_ext_amt"
    Expression ="[WK$UNC]*[WKSOQS]"
    Alias ="gp_ext_amt"
    Expression ="comm_transaction_hsi_stage.[WK$G01]"
    Alias ="tax_pst_amt"
    Expression ="comm_transaction_hsi_stage.[WK$G02]"
    Alias ="contact_nm"
    Expression ="\"\""
    Alias ="ship_via_txt"
    Expression ="\"\""
    Alias ="doc_type_cd"
    Expression ="comm_transaction_hsi_stage.WKDCTO"
    Alias ="hsi_shipto_id"
    Expression ="comm_transaction_hsi_stage.WKSHAN"
    Alias ="IMCLMJ"
    Expression ="comm_transaction_hsi_stage.WKSRP1"
    Alias ="IMCLSJ"
    Expression ="comm_transaction_hsi_stage.WKSRP2"
    Alias ="IMCLMC"
    Expression ="comm_transaction_hsi_stage.WKSRP3"
    Alias ="IMCLSM"
    Expression ="comm_transaction_hsi_stage.WKSRP4"
    Alias ="file_cost_ext_amt"
    Expression ="[WK$FCS]*[WKSOQS]"
    Alias ="ess_salesperson_cd"
    Expression ="comm_transaction_hsi_stage.WKTKBY"
    Alias ="pmts_salesperson_cd"
    Expression ="comm_transaction_hsi_stage.WKPMTS"
    Alias ="hsi_billto_id"
    Expression ="comm_transaction_hsi_stage.WKAN8"
    Alias ="hsi_billto_nm"
    Expression ="comm_transaction_hsi_stage.WKALPH"
    Alias ="hsi_billto_div_cd"
    Expression ="comm_transaction_hsi_stage.WKAC10"
    Alias ="hsi_shipto_div_cd"
    Expression ="comm_transaction_hsi_stage.WKAC11"
    Alias ="hsi_shipto_nm"
    Expression ="comm_transaction_hsi_stage.WKNAME"
    Alias ="vpa_cd"
    Expression ="comm_transaction_hsi_stage.WKASN"
    Alias ="vpa_desc"
    Expression ="comm_transaction_hsi_stage.WKDESC"
    Alias ="manufact_cd"
    Expression ="comm_transaction_hsi_stage.WKSRP6"
    Alias ="sales_category_cd"
    Expression ="comm_transaction_hsi_stage.[WK$SLC]"
    Alias ="privileges_cd"
    Expression ="comm_transaction_hsi_stage.[WK$PVC]"
    Alias ="price_method_cd"
    Expression ="comm_transaction_hsi_stage.[WK$PMC]"
    Alias ="customer_po_num"
    Expression ="comm_transaction_hsi_stage.WKVR01"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbText "Description" ="Updated 24 June 09 to include AIN internal code"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="line_id"
        dbInteger "ColumnWidth" ="735"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="customer_nm"
        dbInteger "ColumnWidth" ="2610"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="reference_order_txt"
        dbInteger "ColumnWidth" ="1845"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="transaction_dt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="cost_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="doc_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="price_override_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="doc_id"
        dbInteger "ColumnWidth" ="810"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="order_id"
        dbInteger "ColumnWidth" ="870"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="order_source_cd"
        dbInteger "ColumnWidth" ="1620"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="salesperson_cd"
        dbInteger "ColumnWidth" ="1545"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="contact_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ship_via_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="file_cost_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_hsi_stage.key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="shipped_qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="transaction_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="unit_price_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="cost_unit_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="item_label_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="tax_pst_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="doc_type_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="IMCLMJ"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="IMCLSJ"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="IMCLMC"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="IMCLSM"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ess_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="pmts_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="hsi_billto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="hsi_billto_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="hsi_billto_div_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="hsi_shipto_div_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="hsi_shipto_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="vpa_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="vpa_desc"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="manufact_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="sales_category_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="privileges_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="price_method_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="customer_po_num"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-30
    Right =1378
    Bottom =999
    Left =-1
    Top =-1
    Right =1354
    Bottom =312
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =38
        Top =6
        Right =359
        Bottom =233
        Top =0
        Name ="comm_transaction_hsi_stage"
        Name =""
    End
    Begin
        Left =404
        Top =15
        Right =588
        Bottom =122
        Top =0
        Name ="comm_configure"
        Name =""
    End
End
