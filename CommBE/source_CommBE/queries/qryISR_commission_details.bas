Operation =1
Option =0
Begin InputTables
    Name ="OUTPUT_TS_Transactions"
    Name ="comm_customer_master"
    Name ="BRS_Item"
End
Begin OutputColumns
    Expression ="OUTPUT_TS_Transactions.record_id"
    Expression ="OUTPUT_TS_Transactions.FiscalMonth"
    Expression ="OUTPUT_TS_Transactions.Branch"
    Expression ="OUTPUT_TS_Transactions.FSCName"
    Expression ="OUTPUT_TS_Transactions.TS_CategoryCd"
    Expression ="OUTPUT_TS_Transactions.TsTerritoryCd"
    Expression ="OUTPUT_TS_Transactions.ISRName"
    Expression ="OUTPUT_TS_Transactions.ess_salesperson_cd"
    Expression ="OUTPUT_TS_Transactions.SalesOrderNumber"
    Expression ="OUTPUT_TS_Transactions.TS_Tag"
    Expression ="OUTPUT_TS_Transactions.ess_salesperson_key_id"
    Expression ="OUTPUT_TS_Transactions.order_source_cd"
    Expression ="OUTPUT_TS_Transactions.reference_order_txt"
    Expression ="OUTPUT_TS_Transactions.item_comm_group_cd"
    Expression ="OUTPUT_TS_Transactions.ess_comm_group_cd"
    Expression ="OUTPUT_TS_Transactions.IMCLMJ"
    Expression ="OUTPUT_TS_Transactions.shipped_qty"
    Expression ="OUTPUT_TS_Transactions.transaction_amt"
    Expression ="OUTPUT_TS_Transactions.gp_ext_amt"
    Expression ="OUTPUT_TS_Transactions.gp_free_goods_amt"
    Expression ="OUTPUT_TS_Transactions.transaction_dt"
    Expression ="OUTPUT_TS_Transactions.doc_key_id"
    Expression ="OUTPUT_TS_Transactions.item_id"
    Expression ="OUTPUT_TS_Transactions.transaction_txt"
    Expression ="OUTPUT_TS_Transactions.hsi_shipto_id"
    Expression ="OUTPUT_TS_Transactions.customer_nm"
    Expression ="OUTPUT_TS_Transactions.salesperson_cd"
    Expression ="OUTPUT_TS_Transactions.doc_type_cd"
    Expression ="OUTPUT_TS_Transactions.hsi_shipto_div_cd"
    Expression ="BRS_Item.SalesCategory"
    Expression ="comm_customer_master.SPM_StatusCd"
    Expression ="comm_customer_master.SPM_EQOptOut"
    Expression ="comm_customer_master.SPM_ReasonTxt"
End
Begin Joins
    LeftTable ="OUTPUT_TS_Transactions"
    RightTable ="comm_customer_master"
    Expression ="OUTPUT_TS_Transactions.hsi_shipto_id = comm_customer_master.hsi_shipto_id"
    Flag =1
    LeftTable ="OUTPUT_TS_Transactions"
    RightTable ="BRS_Item"
    Expression ="OUTPUT_TS_Transactions.item_id = BRS_Item.Item"
    Flag =1
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
        dbText "Name" ="OUTPUT_TS_Transactions.IMCLMJ"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.hsi_shipto_div_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.record_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.FSCName"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.doc_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.Branch"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.ISRName"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.TsTerritoryCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.TS_CategoryCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.ess_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.TS_Tag"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.ess_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.SalesCategory"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.order_source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.reference_order_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.item_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.ess_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.shipped_qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.SPM_StatusCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.gp_free_goods_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.transaction_dt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.transaction_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.customer_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.doc_type_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.SPM_EQOptOut"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.SPM_ReasonTxt"
        dbInteger "ColumnWidth" ="2160"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1508
    Bottom =857
    Left =-1
    Top =-1
    Right =1484
    Bottom =592
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =82
        Top =58
        Right =526
        Bottom =435
        Top =0
        Name ="OUTPUT_TS_Transactions"
        Name =""
    End
    Begin
        Left =669
        Top =121
        Right =977
        Bottom =398
        Top =0
        Name ="comm_customer_master"
        Name =""
    End
    Begin
        Left =623
        Top =55
        Right =767
        Bottom =199
        Top =0
        Name ="BRS_Item"
        Name =""
    End
End
