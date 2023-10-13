Operation =1
Option =0
Where ="(((comm_transaction_F555115.FiscalMonth)=202309) AND ((comm_transaction_F555115."
    "ess_code)=\"CCS32\"))"
Begin InputTables
    Name ="comm_transaction_F555115"
    Name ="comm_plan_group_rate"
    Name ="BRS_Customer"
    Name ="BRS_Item"
End
Begin OutputColumns
    Expression ="comm_transaction_F555115.FiscalMonth"
    Expression ="comm_transaction_F555115.fsc_code"
    Expression ="comm_transaction_F555115.fsc_salesperson_key_id"
    Expression ="comm_transaction_F555115.fsc_comm_plan_id"
    Expression ="comm_transaction_F555115.fsc_comm_group_cd"
    Expression ="comm_transaction_F555115.ess_comm_group_cd"
    Expression ="comm_transaction_F555115.fsc_comm_amt"
    Expression ="comm_transaction_F555115.ess_salesperson_key_id"
    Expression ="comm_transaction_F555115.ess_code"
    Expression ="comm_transaction_F555115.ess_comm_plan_id"
    Expression ="comm_transaction_F555115.source_cd"
    Expression ="comm_transaction_F555115.WSSHAN_shipto"
    Expression ="comm_transaction_F555115.[WS$OSC_order_source_code]"
    Expression ="comm_transaction_F555115.WSLITM_item_number"
    Expression ="comm_transaction_F555115.WSDOCO_salesorder_number"
    Expression ="comm_transaction_F555115.WSDCTO_order_type"
    Expression ="comm_transaction_F555115.WSLNID_line_number"
    Expression ="comm_transaction_F555115.WSOGNO_original_line_number"
    Expression ="comm_transaction_F555115.gp_ext_amt"
    Expression ="comm_transaction_F555115.transaction_amt"
    Expression ="comm_transaction_F555115.WSUORG_quantity"
    Expression ="comm_transaction_F555115.WSSRP6_manufacturer"
    Expression ="comm_transaction_F555115.WSDSC1_description"
    Expression ="comm_transaction_F555115.WSDSC2_description_2"
    Expression ="comm_transaction_F555115.WSVR01_reference"
    Expression ="comm_transaction_F555115.WSCYCL_cycle_count_category"
    Expression ="comm_transaction_F555115.WSVR02_reference_2"
    Expression ="comm_transaction_F555115.xfer_ess_code_org"
    Expression ="comm_transaction_F555115.WSSRP1_major_product_class"
    Expression ="comm_transaction_F555115.WSSRP2_sub_major_product_class"
    Expression ="comm_transaction_F555115.WSSRP3_minor_product_class"
    Expression ="comm_transaction_F555115.xfer_key"
    Expression ="comm_transaction_F555115.xfer_fsc_code_org"
    Expression ="comm_transaction_F555115.WSENTB_entered_by"
    Expression ="comm_transaction_F555115.[WS$PMC_promotion_code_price_method]"
    Expression ="comm_transaction_F555115.WSTKBY_order_taken_by"
    Expression ="comm_transaction_F555115.[WS$SPC_supplier_code]"
    Expression ="comm_transaction_F555115.[WS$VCD_vendor_code]"
    Expression ="comm_transaction_F555115.FreeGoodsInvoicedInd"
    Expression ="comm_transaction_F555115.WSPROV_price_override_code"
    Expression ="comm_transaction_F555115.WSASN__adjustment_schedule"
    Expression ="comm_transaction_F555115.ID"
    Expression ="comm_transaction_F555115.fsc_calc_key"
    Expression ="comm_plan_group_rate.disp_comm_group_cd"
    Expression ="BRS_Customer.PracticeName"
    Expression ="BRS_Customer.VPA"
    Expression ="BRS_Customer.CustGrpWrk"
    Expression ="BRS_Customer.comm_status_cd"
    Expression ="BRS_Customer.TerritoryCd"
    Expression ="comm_transaction_F555115.WSORD__equipment_order"
    Expression ="BRS_Item.comm_group_cd"
End
Begin Joins
    LeftTable ="comm_transaction_F555115"
    RightTable ="comm_plan_group_rate"
    Expression ="comm_transaction_F555115.fsc_calc_key = comm_plan_group_rate.calc_key"
    Flag =1
    LeftTable ="comm_transaction_F555115"
    RightTable ="BRS_Customer"
    Expression ="comm_transaction_F555115.WSSHAN_shipto = BRS_Customer.ShipTo"
    Flag =2
    LeftTable ="comm_transaction_F555115"
    RightTable ="BRS_Item"
    Expression ="comm_transaction_F555115.WSLITM_item_number = BRS_Item.Item"
    Flag =2
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="2"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="comm_transaction_F555115.WSVR02_reference_2"
        dbInteger "ColumnWidth" ="5025"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSVR01_reference"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="6915"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.FiscalMonth"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="4155"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSSRP6_manufacturer"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2535"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSDSC2_description_2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSDSC1_description"
        dbInteger "ColumnWidth" ="3045"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSDOCO_salesorder_number"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3195"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSLNID_line_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSOGNO_original_line_number"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3420"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSUORG_quantity"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2145"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.transaction_amt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1920"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.xfer_key"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.xfer_ess_code_org"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.xfer_fsc_code_org"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSSHAN_shipto"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSLITM_item_number"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2535"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.fsc_calc_key"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.fsc_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.fsc_comm_plan_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="4755"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.fsc_comm_group_cd"
        dbInteger "ColumnWidth" ="4920"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.fsc_salesperson_key_id"
        dbInteger "ColumnWidth" ="2700"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.fsc_comm_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.[WS$OSC_order_source_code]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.ess_salesperson_key_id"
        dbInteger "ColumnWidth" ="2880"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.ess_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSSRP1_major_product_class"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSSRP2_sub_major_product_class"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSSRP3_minor_product_class"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSDCTO_order_type"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2370"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.ess_comm_plan_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="4800"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WS$OSC_order_source_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.FreeGoodsInvoicedInd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.[WS$PMC_promotion_code_price_method]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSPROV_price_override_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSASN__adjustment_schedule"
        dbInteger "ColumnWidth" ="3330"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSENTB_entered_by"
        dbInteger "ColumnWidth" ="2385"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WS$PMC_promotion_code_price_method"
        dbInteger "ColumnWidth" ="4305"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSTKBY_order_taken_by"
        dbInteger "ColumnWidth" ="2745"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WS$SPC_supplier_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WS$VCD_vendor_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.[WS$SPC_supplier_code]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.[WS$VCD_vendor_code]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.ess_comm_group_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2355"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSCYCL_cycle_count_category"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3255"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_plan_group_rate.disp_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.PracticeName"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.VPA"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.CustGrpWrk"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.comm_status_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.TerritoryCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSORD__equipment_order"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2985"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="BRS_Item.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =44
    Top =274
    Right =1470
    Bottom =1119
    Left =-1
    Top =-1
    Right =1402
    Bottom =228
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =56
        Top =48
        Right =620
        Bottom =444
        Top =0
        Name ="comm_transaction_F555115"
        Name =""
    End
    Begin
        Left =940
        Top =207
        Right =1179
        Bottom =414
        Top =0
        Name ="comm_plan_group_rate"
        Name =""
    End
    Begin
        Left =757
        Top =18
        Right =901
        Bottom =422
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
    Begin
        Left =964
        Top =18
        Right =1108
        Bottom =162
        Top =0
        Name ="BRS_Item"
        Name =""
    End
End
