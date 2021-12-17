Operation =1
Option =0
Where ="(((comm_transaction_F555115.FiscalMonth)=(SELECT PriorFiscalMonth FROM BRS_Confi"
    "g)) AND ((comm_transaction_F555115.cps_comm_group_cd)<>\"\") AND ((comm_transact"
    "ion_F555115.cps_salesperson_key_id)<>\"\"))"
Begin InputTables
    Name ="comm_transaction_F555115"
    Name ="BRS_Customer"
    Name ="BRS_Item"
    Name ="BRS_FSC_Rollup"
End
Begin OutputColumns
    Expression ="comm_transaction_F555115.FiscalMonth"
    Expression ="comm_transaction_F555115.cps_code"
    Expression ="comm_transaction_F555115.cps_comm_group_cd"
    Expression ="comm_transaction_F555115.WSSHAN_shipto"
    Expression ="BRS_Customer.PracticeName"
    Expression ="comm_transaction_F555115.WSLITM_item_number"
    Expression ="comm_transaction_F555115.WSDSC1_description"
    Expression ="comm_transaction_F555115.WSDOCO_salesorder_number"
    Expression ="comm_transaction_F555115.WSUORG_quantity"
    Expression ="comm_transaction_F555115.transaction_amt"
    Expression ="comm_transaction_F555115.gp_ext_amt"
    Expression ="comm_transaction_F555115.WSDGL__gl_date"
    Expression ="BRS_Item.MinorProductClass"
    Expression ="comm_transaction_F555115.fsc_salesperson_key_id"
    Expression ="comm_transaction_F555115.WSCAG__cagess_code"
    Expression ="comm_transaction_F555115.ess_code"
    Expression ="BRS_FSC_Rollup.Branch"
    Alias ="PC1"
    Expression ="Left([PostalCode],1)"
    Alias ="PC3"
    Expression ="Left([PostalCode],3)"
    Expression ="comm_transaction_F555115.item_comm_group_cd"
    Expression ="BRS_Item.MajorProductClass"
    Expression ="comm_transaction_F555115.ID"
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
        dbText "Name" ="comm_transaction_F555115.cps_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.PracticeName"
        dbInteger "ColumnWidth" ="3435"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.cps_code"
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
        dbText "Name" ="PC3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.item_comm_group_cd"
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
        dbText "Name" ="comm_transaction_F555115.ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.MinorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.fsc_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.Branch"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="PC1"
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
        dbText "Name" ="BRS_Item.MajorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSCAG__cagess_code"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2475"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.ess_code"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =1519
    Bottom =946
    Left =-1
    Top =-1
    Right =1424
    Bottom =408
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =54
        Top =56
        Right =552
        Bottom =355
        Top =0
        Name ="comm_transaction_F555115"
        Name =""
    End
    Begin
        Left =620
        Top =65
        Right =764
        Bottom =209
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
    Begin
        Left =715
        Top =251
        Right =859
        Bottom =388
        Top =0
        Name ="BRS_Item"
        Name =""
    End
    Begin
        Left =874
        Top =80
        Right =1018
        Bottom =224
        Top =0
        Name ="BRS_FSC_Rollup"
        Name =""
    End
End
