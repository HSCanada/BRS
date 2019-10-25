Operation =2
Name ="OUTPUT_TS_Transactions"
Option =0
Where ="(((comm_transaction_ts.FiscalMonth)=[Enter Fiscal]) AND ((BRS_Customer.TsTerrito"
    "ryCd) Not In (\"ZZSPL\",\"DZZ\",\"     \",\"**\",\"DINB\")) AND ((comm_transacti"
    "on_ts.item_comm_group_cd) Not In (\"ITMSER\",\"ITMPAR\",\"ITMEQ0\")) AND ((comm_"
    "transaction_ts.salesperson_key_id)<>\"Internal\"))"
Begin InputTables
    Name ="comm_transaction_ts"
    Name ="BRS_TransactionDW_Ext"
    Name ="BRS_FSC_Rollup"
    Name ="BRS_Customer"
    Name ="comm_configure"
    Name ="BRS_FSC_Rollup"
    Alias ="BRS_FSC_Rollup_1"
End
Begin OutputColumns
    Expression ="comm_transaction_ts.record_id"
    Expression ="comm_transaction_ts.FiscalMonth"
    Expression ="BRS_FSC_Rollup.Branch"
    Expression ="BRS_FSC_Rollup.FSCName"
    Expression ="BRS_FSC_Rollup.TS_CategoryCd"
    Expression ="BRS_Customer.TsTerritoryCd"
    Alias ="ISRName"
    Expression ="BRS_FSC_Rollup_1.FSCName"
    Expression ="comm_transaction_ts.ess_salesperson_cd"
    Expression ="comm_transaction_ts.SalesOrderNumber"
    Alias ="TS_Tag"
    Expression ="BRS_TransactionDW_Ext.TsTerritoryCd"
    Expression ="comm_transaction_ts.ess_salesperson_key_id"
    Expression ="comm_transaction_ts.order_source_cd"
    Expression ="comm_transaction_ts.reference_order_txt"
    Expression ="comm_transaction_ts.item_comm_group_cd"
    Expression ="comm_transaction_ts.ess_comm_group_cd"
    Expression ="comm_transaction_ts.IMCLMJ"
    Expression ="comm_transaction_ts.shipped_qty"
    Expression ="comm_transaction_ts.transaction_amt"
    Expression ="comm_transaction_ts.gp_ext_amt"
    Alias ="gp_free_goods_amt"
    Expression ="IIf([shipped_qty]<>0 And [transaction_amt]=0 And [IMCLMJ]<>\"908\" And [IMCLMJ]<"
        ">\"Y18\",-[gp_ext_amt],0)"
    Expression ="comm_transaction_ts.transaction_dt"
    Expression ="comm_transaction_ts.doc_key_id"
    Expression ="comm_transaction_ts.item_id"
    Expression ="comm_transaction_ts.transaction_txt"
    Expression ="comm_transaction_ts.hsi_shipto_id"
    Expression ="comm_transaction_ts.customer_nm"
    Expression ="comm_transaction_ts.salesperson_cd"
    Expression ="comm_transaction_ts.doc_type_cd"
    Expression ="comm_transaction_ts.hsi_shipto_div_cd"
End
Begin Joins
    LeftTable ="comm_transaction_ts"
    RightTable ="BRS_TransactionDW_Ext"
    Expression ="comm_transaction_ts.SalesOrderNumber = BRS_TransactionDW_Ext.SalesOrderNumber"
    Flag =1
    LeftTable ="comm_transaction_ts"
    RightTable ="BRS_Customer"
    Expression ="comm_transaction_ts.hsi_shipto_id = BRS_Customer.ShipTo"
    Flag =1
    LeftTable ="BRS_Customer"
    RightTable ="BRS_FSC_Rollup"
    Expression ="BRS_Customer.TerritoryCd = BRS_FSC_Rollup.TerritoryCd"
    Flag =1
    LeftTable ="comm_transaction_ts"
    RightTable ="comm_configure"
    Expression ="comm_transaction_ts.fiscal_yearmo_num = comm_configure.current_fiscal_yearmo_num"
    Flag =1
    LeftTable ="BRS_Customer"
    RightTable ="BRS_FSC_Rollup_1"
    Expression ="BRS_Customer.TsTerritoryCd = BRS_FSC_Rollup_1.TerritoryCd"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="0"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbBoolean "UseTransaction" ="0"
Begin
    Begin
        dbText "Name" ="gp_free_goods_amt"
        dbInteger "ColumnWidth" ="2370"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_ts.gp_ext_amt"
        dbInteger "ColumnWidth" ="1560"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_ts.transaction_txt"
        dbInteger "ColumnWidth" ="3675"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_ts.IMCLMJ"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_ts.ess_salesperson_key_id"
        dbInteger "ColumnWidth" ="2985"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_ts.item_comm_group_cd"
        dbInteger "ColumnWidth" ="2625"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_ts.transaction_dt"
        dbInteger "ColumnWidth" ="1800"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_ts.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_ts.doc_type_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_ts.order_source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_ts.shipped_qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_ts.doc_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_ts.hsi_shipto_div_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_ts.reference_order_txt"
        dbInteger "ColumnWidth" ="2325"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_ts.transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_ts.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_ts.salesperson_cd"
        dbInteger "ColumnWidth" ="2445"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_ts.customer_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TS_Rollup.TsName"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_ts.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_ts.record_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="TS_Tag"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.Branch"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.TS_CategoryCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.FSCName"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_ts.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.TsTerritoryCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_ts.ess_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_ts.ess_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.branch_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.hsi_shipto_div_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_ts.salesperson_key_id"
        dbInteger "ColumnWidth" ="2970"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.reference_order_txt"
        dbInteger "ColumnWidth" ="2325"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.order_source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.doc_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_ts.doc_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_ts.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW_Ext.TsTerritoryCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.salesperson_cd"
        dbInteger "ColumnWidth" ="2445"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.gp_ext_amt"
        dbInteger "ColumnWidth" ="1560"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_CustomerFSC_History.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_dt"
        dbInteger "ColumnWidth" ="1800"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_CustomerFSC_History.HIST_TsTerritoryCd"
        dbInteger "ColumnWidth" ="2175"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.IMCLMJ"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.doc_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.salesperson_key_id"
        dbInteger "ColumnWidth" ="2970"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.hsi_shipto_nm"
        dbInteger "ColumnWidth" ="2925"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_txt"
        dbInteger "ColumnWidth" ="3675"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="TS Tag"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TS_Rollup.StatusCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_ts.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_ts.hsi_shipto_nm"
        dbInteger "ColumnWidth" ="2925"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.doc_type_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.item_comm_group_cd"
        dbInteger "ColumnWidth" ="2625"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Active_FSC"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_salesperson_key_id"
        dbInteger "ColumnWidth" ="2985"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.shipped_qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup_1.FSCName"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ISRName"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1432
    Bottom =977
    Left =-1
    Top =-1
    Right =1414
    Bottom =574
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =78
        Top =40
        Right =311
        Bottom =374
        Top =0
        Name ="comm_transaction_ts"
        Name =""
    End
    Begin
        Left =356
        Top =281
        Right =579
        Bottom =467
        Top =0
        Name ="BRS_TransactionDW_Ext"
        Name =""
    End
    Begin
        Left =1011
        Top =19
        Right =1385
        Bottom =364
        Top =0
        Name ="BRS_FSC_Rollup"
        Name =""
    End
    Begin
        Left =590
        Top =7
        Right =909
        Bottom =428
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
    Begin
        Left =376
        Top =25
        Right =520
        Bottom =169
        Top =0
        Name ="comm_configure"
        Name =""
    End
    Begin
        Left =952
        Top =436
        Right =1096
        Bottom =580
        Top =0
        Name ="BRS_FSC_Rollup_1"
        Name =""
    End
End
