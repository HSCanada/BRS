Operation =1
Option =0
Where ="(((OUTPUT_TS_Transactions.ess_salesperson_cd)=\"DSS01\")) OR (((OUTPUT_TS_Transa"
    "ctions.item_comm_group_cd)=\"DIGMAT\")) OR (((OUTPUT_TS_Transactions.TsTerritory"
    "Cd)=\"ZTSAB\") AND ((OUTPUT_TS_Transactions.item_comm_group_cd) Not In (\"ITMSER"
    "\",\"ITMPAR\",\"ITMEQ0\")))"
Begin InputTables
    Name ="OUTPUT_TS_Transactions"
End
Begin OutputColumns
    Expression ="OUTPUT_TS_Transactions.record_id"
    Expression ="OUTPUT_TS_Transactions.FiscalMonth"
    Expression ="OUTPUT_TS_Transactions.Branch"
    Expression ="OUTPUT_TS_Transactions.FSCName"
    Expression ="OUTPUT_TS_Transactions.TS_CategoryCd"
    Expression ="OUTPUT_TS_Transactions.TsTerritoryCd"
    Expression ="OUTPUT_TS_Transactions.TsName"
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
        dbText "Name" ="OUTPUT_TS_Transactions.hsi_shipto_div_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.record_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.TS_CategoryCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.FSCName"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.TsTerritoryCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.ess_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.gp_free_goods_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.Branch"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.TsName"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.TS_Tag"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.ess_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.reference_order_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.shipped_qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.order_source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.item_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.doc_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.transaction_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.doc_type_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.ess_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.transaction_dt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.IMCLMJ"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.customer_nm"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-30
    Right =1589
    Bottom =999
    Left =-1
    Top =-1
    Right =1565
    Bottom =566
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =148
        Top =68
        Right =937
        Bottom =546
        Top =0
        Name ="OUTPUT_TS_Transactions"
        Name =""
    End
End
