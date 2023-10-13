Operation =1
Option =0
Where ="(((comm_transaction_F555115.FiscalMonth) In (202309,202209)) AND ((comm_transact"
    "ion_F555115.isr_salesperson_key_id)<>\"\") AND ((comm_transaction_F555115.isr_co"
    "mm_plan_id)=\"ISRGP03\") AND ((comm_transaction_F555115.isr_comm_rt)<>0) AND ((c"
    "omm_transaction_F555115.item_comm_group_cd)<>\"\" And (comm_transaction_F555115."
    "item_comm_group_cd) Not In (\"ITMPAR\",\"ITMSER\",\"ITMEQ0\")) AND ((comm_transa"
    "ction_F555115.source_cd) In (\"JDE\",\"IMP\") And (comm_transaction_F555115.sour"
    "ce_cd)=\"JDE\"))"
Begin InputTables
    Name ="comm_plan_group_rate"
    Name ="comm_transaction_F555115"
    Name ="BRS_Customer"
    Name ="BRS_Item"
    Name ="BRS_FSC_Rollup"
End
Begin OutputColumns
    Expression ="comm_transaction_F555115.ID"
    Expression ="comm_transaction_F555115.FiscalMonth"
    Expression ="BRS_FSC_Rollup.Branch"
    Expression ="BRS_FSC_Rollup.FSCName"
    Alias ="TS_CategoryCd"
    Expression ="\".\""
    Expression ="comm_transaction_F555115.isr_code"
    Expression ="comm_transaction_F555115.isr_salesperson_key_id"
    Expression ="comm_transaction_F555115.ess_code"
    Expression ="comm_transaction_F555115.WSDOCO_salesorder_number"
    Alias ="TS_Tag"
    Expression ="\".\""
    Expression ="comm_transaction_F555115.ess_salesperson_key_id"
    Expression ="comm_transaction_F555115.[WS$OSC_order_source_code]"
    Expression ="comm_transaction_F555115.WSVR01_reference"
    Expression ="comm_transaction_F555115.fsc_comm_plan_id"
    Expression ="comm_transaction_F555115.isr_comm_plan_id"
    Alias ="isr_comm_group_cd"
    Expression ="comm_plan_group_rate.disp_comm_group_cd"
    Expression ="comm_transaction_F555115.isr_comm_rt"
    Expression ="comm_transaction_F555115.item_comm_group_cd"
    Expression ="comm_transaction_F555115.ess_comm_group_cd"
    Expression ="BRS_Item.MajorProductClass"
    Expression ="comm_transaction_F555115.WSUORG_quantity"
    Expression ="comm_transaction_F555115.transaction_amt"
    Expression ="comm_transaction_F555115.gp_ext_amt"
    Alias ="gp_free_goods_amt"
    Expression ="IIf([WSUORG_quantity]<>0 And [transaction_amt]=0 And [MajorProductClass]<>\"908\""
        " And [MajorProductClass]<>\"Y18\" And [Supplier]<>\"PROCGA\" And [Label]<>\"P\","
        "-[gp_ext_amt],0)"
    Expression ="comm_transaction_F555115.WSDGL__gl_date"
    Alias ="doc_key_id"
    Expression ="\".\""
    Expression ="comm_transaction_F555115.WSLITM_item_number"
    Expression ="comm_transaction_F555115.WSDSC1_description"
    Expression ="comm_transaction_F555115.WSSHAN_shipto"
    Expression ="BRS_Customer.PracticeName"
    Expression ="comm_transaction_F555115.fsc_code"
    Expression ="comm_transaction_F555115.WSDCTO_order_type"
    Expression ="BRS_Customer.SalesDivision"
    Expression ="BRS_Item.SalesCategory"
    Expression ="comm_transaction_F555115.cust_comm_group_cd"
    Expression ="BRS_Customer.MarketClass_New"
    Expression ="comm_transaction_F555115.source_cd"
    Expression ="comm_transaction_F555115.isr_calc_key"
    Expression ="BRS_Item.Supplier"
    Expression ="BRS_Item.Label"
    Expression ="BRS_Customer.CustGrpWrk"
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
    LeftTable ="comm_transaction_F555115"
    RightTable ="BRS_FSC_Rollup"
    Expression ="comm_transaction_F555115.fsc_code = BRS_FSC_Rollup.TerritoryCd"
    Flag =1
    LeftTable ="comm_plan_group_rate"
    RightTable ="comm_transaction_F555115"
    Expression ="comm_plan_group_rate.calc_key = comm_transaction_F555115.isr_calc_key"
    Flag =3
End
Begin OrderBy
    Expression ="comm_transaction_F555115.ID"
    Flag =0
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
        dbText "Name" ="comm_transaction_F555115.ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="TS_CategoryCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="TS_Tag"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="isr_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="gp_free_goods_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="doc_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.CustGrpWrk"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.Branch"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.isr_calc_key"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSUORG_quantity"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.cust_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.isr_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.FSCName"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.ess_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.isr_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSDOCO_salesorder_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.ess_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.[WS$OSC_order_source_code]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSVR01_reference"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.fsc_comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.isr_comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.isr_comm_rt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.item_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Label"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.ess_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.MajorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSDGL__gl_date"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.SalesDivision"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSLITM_item_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.PracticeName"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSDSC1_description"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSSHAN_shipto"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.fsc_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSDCTO_order_type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.SalesCategory"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.MarketClass_New"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Supplier"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1470
    Bottom =938
    Left =-1
    Top =-1
    Right =1446
    Bottom =253
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =192
        Bottom =156
        Top =0
        Name ="comm_plan_group_rate"
        Name =""
    End
    Begin
        Left =240
        Top =12
        Right =384
        Bottom =156
        Top =0
        Name ="comm_transaction_F555115"
        Name =""
    End
    Begin
        Left =432
        Top =12
        Right =576
        Bottom =156
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
    Begin
        Left =624
        Top =12
        Right =768
        Bottom =156
        Top =0
        Name ="BRS_Item"
        Name =""
    End
    Begin
        Left =816
        Top =12
        Right =960
        Bottom =156
        Top =0
        Name ="BRS_FSC_Rollup"
        Name =""
    End
End
