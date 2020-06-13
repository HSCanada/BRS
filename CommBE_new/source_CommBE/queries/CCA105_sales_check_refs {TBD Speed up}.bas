Operation =1
Option =0
Where ="(((BRS_Item.Item) Is Null)) OR (((BRS_Customer.ShipTo) Is Null)) OR (((Integrati"
    "on_F555115_commission_sales_extract_Staging.WSAC10_division_code)<\"AZA\") AND ("
    "(BRS_TransactionDW_Ext.SalesOrderNumber) Is Null)) OR (((BRS_FSC_Rollup.Territor"
    "yCd) Is Null)) OR (((BRS_FSC_Rollup_1.TerritoryCd) Is Null))"
Begin InputTables
    Name ="Integration_F555115_commission_sales_extract_Staging"
    Name ="BRS_Item"
    Name ="BRS_Customer"
    Name ="BRS_TransactionDW_Ext"
    Name ="BRS_FSC_Rollup"
    Name ="BRS_FSC_Rollup"
    Alias ="BRS_FSC_Rollup_1"
End
Begin OutputColumns
    Expression ="Integration_F555115_commission_sales_extract_Staging.ID"
    Expression ="Integration_F555115_commission_sales_extract_Staging.WSAC10_division_code"
    Expression ="Integration_F555115_commission_sales_extract_Staging.WSLITM_item_number"
    Expression ="BRS_Item.Item"
    Expression ="Integration_F555115_commission_sales_extract_Staging.WSSHAN_shipto"
    Expression ="BRS_Customer.ShipTo"
    Expression ="Integration_F555115_commission_sales_extract_Staging.WSDOCO_salesorder_number"
    Expression ="Integration_F555115_commission_sales_extract_Staging.WSDCTO_order_type"
    Expression ="BRS_TransactionDW_Ext.SalesOrderNumber"
    Expression ="Integration_F555115_commission_sales_extract_Staging.[WS$ESS_equipment_specialis"
        "t_code]"
    Alias ="ESS"
    Expression ="BRS_FSC_Rollup.TerritoryCd"
    Expression ="Integration_F555115_commission_sales_extract_Staging.WSCAG__cagess_code"
    Alias ="CPS"
    Expression ="BRS_FSC_Rollup_1.TerritoryCd"
End
Begin Joins
    LeftTable ="Integration_F555115_commission_sales_extract_Staging"
    RightTable ="BRS_Item"
    Expression ="Integration_F555115_commission_sales_extract_Staging.WSLITM_item_number = BRS_It"
        "em.Item"
    Flag =2
    LeftTable ="Integration_F555115_commission_sales_extract_Staging"
    RightTable ="BRS_Customer"
    Expression ="Integration_F555115_commission_sales_extract_Staging.WSSHAN_shipto = BRS_Custome"
        "r.ShipTo"
    Flag =2
    LeftTable ="Integration_F555115_commission_sales_extract_Staging"
    RightTable ="BRS_TransactionDW_Ext"
    Expression ="Integration_F555115_commission_sales_extract_Staging.WSDOCO_salesorder_number = "
        "BRS_TransactionDW_Ext.SalesOrderNumber"
    Flag =2
    LeftTable ="Integration_F555115_commission_sales_extract_Staging"
    RightTable ="BRS_TransactionDW_Ext"
    Expression ="Integration_F555115_commission_sales_extract_Staging.WSDCTO_order_type = BRS_Tra"
        "nsactionDW_Ext.DocType"
    Flag =2
    LeftTable ="Integration_F555115_commission_sales_extract_Staging"
    RightTable ="BRS_FSC_Rollup"
    Expression ="Integration_F555115_commission_sales_extract_Staging.[WS$ESS_equipment_specialis"
        "t_code] = BRS_FSC_Rollup.TerritoryCd"
    Flag =2
    LeftTable ="Integration_F555115_commission_sales_extract_Staging"
    RightTable ="BRS_FSC_Rollup_1"
    Expression ="Integration_F555115_commission_sales_extract_Staging.WSCAG__cagess_code = BRS_FS"
        "C_Rollup_1.TerritoryCd"
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
        dbText "Name" ="Integration_F555115_commission_sales_extract_Staging.WSSHAN_shipto"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F555115_commission_sales_extract_Staging.WSLITM_item_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F555115_commission_sales_extract_Staging.ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F555115_commission_sales_extract_Staging.WSDCTO_order_type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F555115_commission_sales_extract_Staging.WSDOCO_salesorder_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F555115_commission_sales_extract_Staging.[WS$ESS_equipment_specialis"
            "t_code]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F555115_commission_sales_extract_Staging.WSCAG__cagess_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ESS"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="CPS"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Item"
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
        dbText "Name" ="Integration_F555115_commission_sales_extract_Staging.WSAC10_division_code"
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
    Bottom =481
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =531
        Bottom =303
        Top =0
        Name ="Integration_F555115_commission_sales_extract_Staging"
        Name =""
    End
    Begin
        Left =616
        Top =9
        Right =760
        Bottom =153
        Top =0
        Name ="BRS_Item"
        Name =""
    End
    Begin
        Left =663
        Top =174
        Right =807
        Bottom =318
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
    Begin
        Left =681
        Top =332
        Right =825
        Bottom =476
        Top =0
        Name ="BRS_TransactionDW_Ext"
        Name =""
    End
    Begin
        Left =925
        Top =103
        Right =1069
        Bottom =247
        Top =0
        Name ="BRS_FSC_Rollup"
        Name =""
    End
    Begin
        Left =929
        Top =305
        Right =1073
        Bottom =449
        Top =0
        Name ="BRS_FSC_Rollup_1"
        Name =""
    End
End
