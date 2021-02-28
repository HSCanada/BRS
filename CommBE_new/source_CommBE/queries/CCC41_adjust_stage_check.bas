Operation =1
Option =0
Where ="(((Integration_comm_adjustment_Staging.fsc_code)<>\".\") AND ((BRS_FSC_Rollup.Te"
    "rritoryCd) Is Null)) OR (((Integration_comm_adjustment_Staging.ess_code)<>\".\")"
    " AND ((BRS_FSC_Rollup_1.TerritoryCd) Is Null)) OR (((Integration_comm_adjustment"
    "_Staging.WSSHAN_shipto)>0) AND ((BRS_Customer.ShipTo) Is Null)) OR (((Integratio"
    "n_comm_adjustment_Staging.WSDOC__document_number)>0) AND ((BRS_TransactionDW_Ext"
    ".SalesOrderNumber) Is Null)) OR (((Integration_comm_adjustment_Staging.WSLITM_it"
    "em_number)<>\".\") AND ((BRS_Item.Item) Is Null)) OR (((comm_group.comm_group_cd"
    ") Is Null)) OR (((Integration_comm_adjustment_Staging.status_code)<>0))"
Begin InputTables
    Name ="Integration_comm_adjustment_Staging"
    Name ="BRS_FSC_Rollup"
    Name ="BRS_FSC_Rollup"
    Alias ="BRS_FSC_Rollup_1"
    Name ="BRS_Customer"
    Name ="BRS_TransactionDW_Ext"
    Name ="BRS_Item"
    Name ="comm_group"
End
Begin OutputColumns
    Expression ="Integration_comm_adjustment_Staging.FiscalMonth"
    Expression ="Integration_comm_adjustment_Staging.WSOGNO_original_line_number"
    Alias ="Owner"
    Expression ="Integration_comm_adjustment_Staging.WSVR01_reference"
    Alias ="Adj Type Actual"
    Expression ="Integration_comm_adjustment_Staging.WSSRP6_manufacturer"
    Expression ="Integration_comm_adjustment_Staging.fsc_code"
    Alias ="fsc"
    Expression ="BRS_FSC_Rollup.TerritoryCd"
    Expression ="Integration_comm_adjustment_Staging.ess_code"
    Alias ="ess"
    Expression ="BRS_FSC_Rollup_1.TerritoryCd"
    Alias ="Shipto"
    Expression ="Integration_comm_adjustment_Staging.WSSHAN_shipto"
    Alias ="st"
    Expression ="BRS_Customer.ShipTo"
    Alias ="customer_nm"
    Expression ="Integration_comm_adjustment_Staging.WSVR02_reference_2"
    Alias ="Sales order"
    Expression ="Integration_comm_adjustment_Staging.WSDOC__document_number"
    Expression ="Integration_comm_adjustment_Staging.WSDOCO_salesorder_number"
    Alias ="so"
    Expression ="BRS_TransactionDW_Ext.SalesOrderNumber"
    Alias ="item_id"
    Expression ="Integration_comm_adjustment_Staging.WSLITM_item_number"
    Expression ="BRS_Item.Item"
    Alias ="Additional_Notes"
    Expression ="Integration_comm_adjustment_Staging.WSDSC1_description"
    Expression ="Integration_comm_adjustment_Staging.transaction_amt"
    Expression ="Integration_comm_adjustment_Staging.fsc_comm_group_cd"
    Expression ="comm_group.comm_group_cd"
    Expression ="Integration_comm_adjustment_Staging.status_code"
End
Begin Joins
    LeftTable ="Integration_comm_adjustment_Staging"
    RightTable ="BRS_FSC_Rollup"
    Expression ="Integration_comm_adjustment_Staging.fsc_code = BRS_FSC_Rollup.TerritoryCd"
    Flag =2
    LeftTable ="Integration_comm_adjustment_Staging"
    RightTable ="BRS_FSC_Rollup_1"
    Expression ="Integration_comm_adjustment_Staging.ess_code = BRS_FSC_Rollup_1.TerritoryCd"
    Flag =2
    LeftTable ="Integration_comm_adjustment_Staging"
    RightTable ="BRS_Customer"
    Expression ="Integration_comm_adjustment_Staging.WSSHAN_shipto = BRS_Customer.ShipTo"
    Flag =2
    LeftTable ="Integration_comm_adjustment_Staging"
    RightTable ="BRS_TransactionDW_Ext"
    Expression ="Integration_comm_adjustment_Staging.WSDOC__document_number = BRS_TransactionDW_E"
        "xt.SalesOrderNumber"
    Flag =2
    LeftTable ="Integration_comm_adjustment_Staging"
    RightTable ="BRS_TransactionDW_Ext"
    Expression ="Integration_comm_adjustment_Staging.WSDCTO_order_type = BRS_TransactionDW_Ext.Do"
        "cType"
    Flag =2
    LeftTable ="Integration_comm_adjustment_Staging"
    RightTable ="BRS_Item"
    Expression ="Integration_comm_adjustment_Staging.WSLITM_item_number = BRS_Item.Item"
    Flag =2
    LeftTable ="Integration_comm_adjustment_Staging"
    RightTable ="comm_group"
    Expression ="Integration_comm_adjustment_Staging.fsc_comm_group_cd = comm_group.comm_group_cd"
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
        dbText "Name" ="Integration_comm_adjustment_Staging.ess_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.fsc_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.fsc_comm_group_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2310"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.WSOGNO_original_line_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Owner"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Shipto"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="customer_nm"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2565"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Sales order"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Adj Type Actual"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.transaction_amt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1920"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Additional_Notes"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fsc"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.WSDOCO_salesorder_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ess"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="st"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="so"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_group.comm_group_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1950"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.status_code"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =1280
    Bottom =946
    Left =-1
    Top =-1
    Right =1256
    Bottom =430
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =114
        Top =42
        Right =429
        Bottom =278
        Top =0
        Name ="Integration_comm_adjustment_Staging"
        Name =""
    End
    Begin
        Left =510
        Top =64
        Right =654
        Bottom =208
        Top =0
        Name ="BRS_FSC_Rollup"
        Name =""
    End
    Begin
        Left =516
        Top =245
        Right =660
        Bottom =389
        Top =0
        Name ="BRS_FSC_Rollup_1"
        Name =""
    End
    Begin
        Left =734
        Top =107
        Right =878
        Bottom =251
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
    Begin
        Left =715
        Top =286
        Right =859
        Bottom =430
        Top =0
        Name ="BRS_TransactionDW_Ext"
        Name =""
    End
    Begin
        Left =786
        Top =19
        Right =930
        Bottom =163
        Top =0
        Name ="BRS_Item"
        Name =""
    End
    Begin
        Left =409
        Top =378
        Right =553
        Bottom =522
        Top =0
        Name ="comm_group"
        Name =""
    End
End
