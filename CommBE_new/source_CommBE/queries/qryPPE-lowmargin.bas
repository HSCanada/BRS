Operation =1
Option =0
Where ="(((comm_transaction_F555115.FiscalMonth)=202204) AND ((comm_transaction_F555115."
    "FreeGoodsInvoicedInd)=False) AND ((comm_transaction_F555115.source_cd)=\"JDE\") "
    "AND ((comm_transaction_F555115.WSLITM_item_number) In (\"1382569\",\"9395252\",\""
    "9394866\",\"9394931\",\"9394886\",\"9394861\",\"9394938\",\"9394939\",\"9394940\""
    ")) AND ((comm_transaction_F555115.transaction_amt)>0) AND (([gp_ext_amt]/[transa"
    "ction_amt])<0.1))"
Begin InputTables
    Name ="comm_transaction_F555115"
    Name ="BRS_Customer"
    Name ="BRS_Item"
End
Begin OutputColumns
    Expression ="comm_transaction_F555115.FiscalMonth"
    Expression ="BRS_Customer.VPA"
    Expression ="comm_transaction_F555115.FreeGoodsInvoicedInd"
    Expression ="BRS_Item.SalesCategory"
    Expression ="BRS_Customer.Specialty"
    Expression ="comm_transaction_F555115.fsc_code"
    Expression ="comm_transaction_F555115.fsc_salesperson_key_id"
    Expression ="comm_transaction_F555115.fsc_comm_plan_id"
    Expression ="comm_transaction_F555115.fsc_comm_group_cd"
    Expression ="comm_transaction_F555115.fsc_calc_key"
    Expression ="comm_transaction_F555115.fsc_comm_amt"
    Expression ="comm_transaction_F555115.source_cd"
    Expression ="comm_transaction_F555115.WSSHAN_shipto"
    Expression ="comm_transaction_F555115.[WS$OSC_order_source_code]"
    Expression ="comm_transaction_F555115.WSLITM_item_number"
    Expression ="comm_transaction_F555115.WSDOCO_salesorder_number"
    Expression ="comm_transaction_F555115.WSLNID_line_number"
    Expression ="comm_transaction_F555115.WSOGNO_original_line_number"
    Expression ="comm_transaction_F555115.gp_ext_amt"
    Expression ="comm_transaction_F555115.transaction_amt"
    Alias ="gm"
    Expression ="[gp_ext_amt]/[transaction_amt]"
    Expression ="comm_transaction_F555115.WSUORG_quantity"
    Expression ="comm_transaction_F555115.WSSRP6_manufacturer"
    Expression ="comm_transaction_F555115.WSDSC1_description"
    Expression ="comm_transaction_F555115.WSDSC2_description_2"
    Expression ="comm_transaction_F555115.WSVR01_reference"
    Expression ="comm_transaction_F555115.WSVR02_reference_2"
    Expression ="comm_transaction_F555115.xfer_key"
    Expression ="comm_transaction_F555115.xfer_fsc_code_org"
    Expression ="comm_transaction_F555115.xfer_ess_code_org"
    Expression ="comm_transaction_F555115.ID"
End
Begin Joins
    LeftTable ="comm_transaction_F555115"
    RightTable ="BRS_Customer"
    Expression ="comm_transaction_F555115.WSSHAN_shipto = BRS_Customer.ShipTo"
    Flag =1
    LeftTable ="comm_transaction_F555115"
    RightTable ="BRS_Item"
    Expression ="comm_transaction_F555115.WSLITM_item_number = BRS_Item.Item"
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
Begin
    Begin
        dbText "Name" ="comm_transaction_F555115.WSVR02_reference_2"
        dbInteger "ColumnWidth" ="2655"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSVR01_reference"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2880"
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
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSSRP6_manufacturer"
        dbLong "AggregateType" ="-1"
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
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.fsc_comm_group_cd"
        dbInteger "ColumnWidth" ="2310"
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
        dbInteger "ColumnWidth" ="1815"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.[WS$OSC_order_source_code]"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2715"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="BRS_Customer.VPA"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.FreeGoodsInvoicedInd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.SalesCategory"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.Specialty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="gm"
        dbInteger "ColumnWidth" ="2280"
        dbBoolean "ColumnHidden" ="0"
        dbText "Format" ="Percent"
        dbByte "DecimalPlaces" ="1"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1568
    Bottom =938
    Left =-1
    Top =-1
    Right =1544
    Bottom =601
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =33
        Top =33
        Right =457
        Bottom =379
        Top =0
        Name ="comm_transaction_F555115"
        Name =""
    End
    Begin
        Left =573
        Top =6
        Right =853
        Bottom =320
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
    Begin
        Left =674
        Top =244
        Right =863
        Bottom =452
        Top =0
        Name ="BRS_Item"
        Name =""
    End
End
