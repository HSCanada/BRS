Operation =1
Option =0
Where ="(((comm_transaction_F555115.FiscalMonth)=202101) AND ((comm_transaction_F555115."
    "WSLITM_item_number) In (\"5837912\",\"5831069\",\"5831451\",\"5834943\",\"583754"
    "5\",\"5833107\",\"5834937\",\"5844099\",\"9398060\",\"9399459\",\"9393267\",\"93"
    "92430\",\"9396203\")))"
Begin InputTables
    Name ="comm_transaction_F555115"
    Name ="BRS_Customer"
    Name ="BRS_Item"
    Name ="BRS_FSC_Rollup"
End
Begin OutputColumns
    Expression ="comm_transaction_F555115.FiscalMonth"
    Expression ="comm_transaction_F555115.fsc_salesperson_key_id"
    Expression ="comm_transaction_F555115.WSDGL__gl_date"
    Expression ="comm_transaction_F555115.WSUORG_quantity"
    Alias ="FreeGoods_Ind"
    Expression ="IIf([transaction_amt]=0,\"Y\",\"N\")"
    Expression ="comm_transaction_F555115.transaction_amt"
    Expression ="comm_transaction_F555115.gp_ext_amt"
    Expression ="comm_transaction_F555115.source_cd"
    Expression ="comm_transaction_F555115.item_comm_group_cd"
    Expression ="comm_transaction_F555115.WSLITM_item_number"
    Expression ="comm_transaction_F555115.WSDOCO_salesorder_number"
    Expression ="comm_transaction_F555115.WSSHAN_shipto"
    Expression ="BRS_Customer.PracticeName"
    Expression ="comm_transaction_F555115.WSDSC1_description"
    Expression ="BRS_Item.MajorProductClass"
    Expression ="BRS_Item.Supplier"
    Expression ="BRS_FSC_Rollup.Branch"
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
        dbText "Name" ="comm_transaction_F555115.fsc_code"
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
    End
    Begin
        dbText "Name" ="BRS_Item.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1013"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FreeGoods_Ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.fsc_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1001"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1005"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1015"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1016"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1466
    Bottom =524
    Left =-1
    Top =-1
    Right =1442
    Bottom =296
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
        Left =607
        Top =2
        Right =751
        Bottom =146
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
    Begin
        Left =692
        Top =113
        Right =836
        Bottom =257
        Top =0
        Name ="BRS_Item"
        Name =""
    End
    Begin
        Left =866
        Top =72
        Right =1010
        Bottom =216
        Top =0
        Name ="BRS_FSC_Rollup"
        Name =""
    End
End
