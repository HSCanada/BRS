Operation =1
Option =0
Begin InputTables
    Name ="Integration_F555115_commission_sales_adjustment_Staging"
    Name ="BRS_FSC_Rollup"
    Name ="BRS_FSC_Rollup"
    Alias ="BRS_FSC_Rollup_1"
    Name ="BRS_Customer"
    Name ="BRS_TransactionDW_Ext"
    Name ="BRS_Item"
    Name ="comm_group"
    Name ="comm_group"
    Alias ="comm_group_1"
End
Begin OutputColumns
    Expression ="Integration_F555115_commission_sales_adjustment_Staging.FiscalMonth"
    Expression ="Integration_F555115_commission_sales_adjustment_Staging.fsc_code"
    Alias ="fsc"
    Expression ="BRS_FSC_Rollup.TerritoryCd"
    Expression ="Integration_F555115_commission_sales_adjustment_Staging.ess_code"
    Alias ="ess"
    Expression ="BRS_FSC_Rollup_1.TerritoryCd"
    Expression ="Integration_F555115_commission_sales_adjustment_Staging.WSSHAN_shipto"
    Expression ="BRS_Customer.ShipTo"
    Expression ="Integration_F555115_commission_sales_adjustment_Staging.WSDOCO_salesorder_number"
    Expression ="BRS_TransactionDW_Ext.SalesOrderNumber"
    Expression ="Integration_F555115_commission_sales_adjustment_Staging.WSLITM_item_number"
    Expression ="BRS_Item.Item"
    Expression ="Integration_F555115_commission_sales_adjustment_Staging.fsc_comm_group_cd"
    Alias ="fsc_comm"
    Expression ="comm_group.comm_group_cd"
    Expression ="Integration_F555115_commission_sales_adjustment_Staging.ess_comm_group_cd"
    Alias ="ess_comm"
    Expression ="comm_group_1.comm_group_cd"
End
Begin Joins
    LeftTable ="Integration_F555115_commission_sales_adjustment_Staging"
    RightTable ="BRS_FSC_Rollup"
    Expression ="Integration_F555115_commission_sales_adjustment_Staging.fsc_code = BRS_FSC_Rollu"
        "p.TerritoryCd"
    Flag =2
    LeftTable ="Integration_F555115_commission_sales_adjustment_Staging"
    RightTable ="BRS_FSC_Rollup_1"
    Expression ="Integration_F555115_commission_sales_adjustment_Staging.ess_code = BRS_FSC_Rollu"
        "p_1.TerritoryCd"
    Flag =2
    LeftTable ="Integration_F555115_commission_sales_adjustment_Staging"
    RightTable ="BRS_Customer"
    Expression ="Integration_F555115_commission_sales_adjustment_Staging.WSSHAN_shipto = BRS_Cust"
        "omer.ShipTo"
    Flag =2
    LeftTable ="Integration_F555115_commission_sales_adjustment_Staging"
    RightTable ="BRS_TransactionDW_Ext"
    Expression ="Integration_F555115_commission_sales_adjustment_Staging.WSDOCO_salesorder_number"
        " = BRS_TransactionDW_Ext.SalesOrderNumber"
    Flag =2
    LeftTable ="Integration_F555115_commission_sales_adjustment_Staging"
    RightTable ="BRS_Item"
    Expression ="Integration_F555115_commission_sales_adjustment_Staging.WSLITM_item_number = BRS"
        "_Item.Item"
    Flag =2
    LeftTable ="Integration_F555115_commission_sales_adjustment_Staging"
    RightTable ="comm_group"
    Expression ="Integration_F555115_commission_sales_adjustment_Staging.fsc_comm_group_cd = comm"
        "_group.comm_group_cd"
    Flag =2
    LeftTable ="Integration_F555115_commission_sales_adjustment_Staging"
    RightTable ="comm_group_1"
    Expression ="Integration_F555115_commission_sales_adjustment_Staging.ess_code = comm_group_1."
        "comm_group_cd"
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
        dbText "Name" ="Integration_F555115_commission_sales_adjustment_Staging.ess_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F555115_commission_sales_adjustment_Staging.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F555115_commission_sales_adjustment_Staging.fsc_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F555115_commission_sales_adjustment_Staging.WSSHAN_shipto"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F555115_commission_sales_adjustment_Staging.fsc_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F555115_commission_sales_adjustment_Staging.WSDOCO_salesorder_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F555115_commission_sales_adjustment_Staging.ess_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F555115_commission_sales_adjustment_Staging.WSLITM_item_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fsc"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ess"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.ShipTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW_Ext.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fsc_comm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ess_comm"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1191
    Bottom =817
    Left =-1
    Top =-1
    Right =1167
    Bottom =383
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =23
        Top =-1
        Right =267
        Bottom =271
        Top =0
        Name ="Integration_F555115_commission_sales_adjustment_Staging"
        Name =""
    End
    Begin
        Left =387
        Top =-14
        Right =531
        Bottom =130
        Top =0
        Name ="BRS_FSC_Rollup"
        Name =""
    End
    Begin
        Left =731
        Top =102
        Right =875
        Bottom =246
        Top =0
        Name ="BRS_FSC_Rollup_1"
        Name =""
    End
    Begin
        Left =864
        Top =6
        Right =1008
        Bottom =150
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
    Begin
        Left =755
        Top =-6
        Right =899
        Bottom =138
        Top =0
        Name ="BRS_TransactionDW_Ext"
        Name =""
    End
    Begin
        Left =554
        Top =156
        Right =698
        Bottom =300
        Top =0
        Name ="BRS_Item"
        Name =""
    End
    Begin
        Left =358
        Top =286
        Right =502
        Bottom =430
        Top =0
        Name ="comm_group"
        Name =""
    End
    Begin
        Left =790
        Top =259
        Right =934
        Bottom =403
        Top =0
        Name ="comm_group_1"
        Name =""
    End
End
