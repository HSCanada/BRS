Operation =1
Option =0
Where ="(((comm_transaction_F555115.FiscalMonth)=(SELECT PriorFiscalMonth FROM BRS_Confi"
    "g)) AND ((comm_transaction_F555115.isr_salesperson_key_id)<>\"\") AND ((comm_pla"
    "n_group_rate.disp_comm_group_cd)<>\"\" And (comm_plan_group_rate.disp_comm_group"
    "_cd) Not In (\"ITMPAR\",\"ITMSER\",\"ITMEQ0\")) AND ((comm_transaction_F555115.s"
    "ource_cd) In (\"JDE\",\"IMP\") And (comm_transaction_F555115.source_cd)=\"JDE\")"
    ")"
Begin InputTables
    Name ="comm_transaction_F555115"
    Name ="BRS_Customer"
    Name ="BRS_Item"
    Name ="BRS_FSC_Rollup"
    Name ="comm_plan_group_rate"
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
    Alias ="isr_comm_group_cd"
    Expression ="comm_plan_group_rate.disp_comm_group_cd"
    Expression ="comm_transaction_F555115.ess_comm_group_cd"
    Expression ="BRS_Item.MajorProductClass"
    Expression ="comm_transaction_F555115.WSUORG_quantity"
    Expression ="comm_transaction_F555115.transaction_amt"
    Expression ="comm_transaction_F555115.gp_ext_amt"
    Alias ="gp_free_goods_amt"
    Expression ="IIf([WSUORG_quantity]<>0 And [transaction_amt]=0 And [MajorProductClass]<>\"908\""
        " And [MajorProductClass]<>\"Y18\",-[gp_ext_amt],0)"
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
    Expression ="BRS_Customer.MarketClass"
    Expression ="comm_transaction_F555115.source_cd"
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
    LeftTable ="comm_transaction_F555115"
    RightTable ="comm_plan_group_rate"
    Expression ="comm_transaction_F555115.isr_calc_key = comm_plan_group_rate.calc_key"
    Flag =1
End
Begin OrderBy
    Expression ="comm_transaction_F555115.ID"
    Flag =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="2"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbMemo "OrderBy" ="[qryISR_Backend].[ID]"
Begin
    Begin
        dbText "Name" ="BRS_Customer.PracticeName"
        dbInteger "ColumnWidth" ="3435"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSSHAN_shipto"
        dbInteger "ColumnWidth" ="1935"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSDOCO_salesorder_number"
        dbInteger "ColumnWidth" ="3195"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSUORG_quantity"
        dbInteger "ColumnWidth" ="2145"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.transaction_amt"
        dbLong "AggregateType" ="-1"
        dbText "Format" ="Standard"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.gp_ext_amt"
        dbLong "AggregateType" ="-1"
        dbText "Format" ="Standard"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSDGL__gl_date"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.fsc_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.Branch"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSLITM_item_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSDSC1_description"
        dbInteger "ColumnWidth" ="3180"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSDCTO_order_type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.SalesDivision"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.MarketClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSVR01_reference"
        dbInteger "ColumnWidth" ="2895"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.isr_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.isr_salesperson_key_id"
        dbInteger "ColumnWidth" ="2580"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="TS_CategoryCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.ess_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.SalesCategory"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.cust_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="TS_Tag"
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
        dbText "Name" ="comm_transaction_F555115.ess_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.MajorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="doc_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.FSCName"
        dbInteger "ColumnWidth" ="3075"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="gp_free_goods_amt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2265"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="isr_comm_group_cd"
        dbInteger "ColumnWidth" ="2280"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =1657
    Bottom =946
    Left =-1
    Top =-1
    Right =1469
    Bottom =303
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =54
        Top =0
        Right =552
        Bottom =299
        Top =0
        Name ="comm_transaction_F555115"
        Name =""
    End
    Begin
        Left =620
        Top =0
        Right =764
        Bottom =144
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
    Begin
        Left =853
        Top =96
        Right =997
        Bottom =240
        Top =0
        Name ="BRS_Item"
        Name =""
    End
    Begin
        Left =874
        Top =0
        Right =1018
        Bottom =144
        Top =0
        Name ="BRS_FSC_Rollup"
        Name =""
    End
    Begin
        Left =629
        Top =177
        Right =773
        Bottom =321
        Top =0
        Name ="comm_plan_group_rate"
        Name =""
    End
End
