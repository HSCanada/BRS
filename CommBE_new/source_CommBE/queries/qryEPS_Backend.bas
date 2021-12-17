Operation =1
Option =0
Where ="(((comm_transaction_F555115.FiscalMonth)=(SELECT PriorFiscalMonth FROM BRS_Confi"
    "g)) AND ((comm_transaction_F555115.eps_comm_group_cd)<>\"\") AND ((comm_transact"
    "ion_F555115.source_cd)=\"JDE\") AND ((comm_transaction_F555115.eps_salesperson_k"
    "ey_id)<>\"\"))"
Begin InputTables
    Name ="comm_transaction_F555115"
    Name ="BRS_Customer"
    Name ="BRS_Item"
    Name ="BRS_FSC_Rollup"
    Name ="comm_group"
End
Begin OutputColumns
    Expression ="comm_transaction_F555115.FiscalMonth"
    Expression ="comm_transaction_F555115.eps_code"
    Expression ="BRS_Customer.SalesDivision"
    Expression ="BRS_Customer.MarketClass"
    Expression ="BRS_Customer.SegCd"
    Expression ="BRS_Customer.Specialty"
    Expression ="BRS_FSC_Rollup.Branch"
    Expression ="comm_transaction_F555115.eps_comm_group_cd"
    Expression ="comm_group.comm_group_desc"
    Expression ="comm_transaction_F555115.fsc_code"
    Expression ="comm_transaction_F555115.WSLITM_item_number"
    Expression ="comm_transaction_F555115.WSDSC1_description"
    Expression ="comm_transaction_F555115.item_comm_group_cd"
    Expression ="comm_transaction_F555115.WSUORG_quantity"
    Expression ="comm_transaction_F555115.transaction_amt"
    Expression ="comm_transaction_F555115.gp_ext_amt"
    Expression ="comm_transaction_F555115.WSDGL__gl_date"
    Expression ="comm_transaction_F555115.WSSHAN_shipto"
    Expression ="BRS_Customer.PracticeName"
    Expression ="comm_transaction_F555115.WSDOCO_salesorder_number"
    Expression ="comm_transaction_F555115.WSLNID_line_number"
    Expression ="comm_transaction_F555115.source_cd"
    Expression ="comm_transaction_F555115.WSVR01_reference"
    Expression ="comm_transaction_F555115.ID"
    Expression ="comm_transaction_F555115.WSDCTO_order_type"
    Expression ="BRS_Item.Supplier"
    Expression ="BRS_Item.MinorProductClass"
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
    RightTable ="comm_group"
    Expression ="comm_transaction_F555115.eps_comm_group_cd = comm_group.comm_group_cd"
    Flag =1
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
        dbText "Name" ="comm_transaction_F555115.item_comm_group_cd"
        dbLong "AggregateType" ="-1"
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
        dbText "Name" ="BRS_Item.MinorProductClass"
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
        dbText "Name" ="comm_transaction_F555115.eps_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.eps_code"
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
        dbText "Name" ="BRS_Customer.Specialty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.SegCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.MarketClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_group.comm_group_desc"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2775"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSLNID_line_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSVR01_reference"
        dbInteger "ColumnWidth" ="2895"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Supplier"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =-337
    Top =66
    Right =1156
    Bottom =947
    Left =-1
    Top =-1
    Right =1469
    Bottom =211
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
        Left =627
        Top =151
        Right =771
        Bottom =295
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
        Left =878
        Top =130
        Right =1022
        Bottom =274
        Top =0
        Name ="comm_group"
        Name =""
    End
End
