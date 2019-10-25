Operation =1
Option =0
Where ="(((OUTPUT_TS_Transactions.TsTerritoryCd)=\"MTSSJ\")) OR (((OUTPUT_TS_Transaction"
    "s.TS_Tag)=\"MTSSJ\"))"
Begin InputTables
    Name ="OUTPUT_TS_Transactions"
End
Begin OutputColumns
    Expression ="OUTPUT_TS_Transactions.*"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbMemo "OrderBy" ="[Query1].[TS_Tag] DESC, [Query1].[TsTerritoryCd]"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.TsName"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.TsTerritoryCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.Branch"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.TS_CategoryCd"
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
        dbText "Name" ="OUTPUT_TS_Transactions.gp_ext_amt"
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
        dbText "Name" ="OUTPUT_TS_Transactions.doc_type_cd"
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
        dbText "Name" ="OUTPUT_TS_Transactions.TS_Tag"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.gp_free_goods_amt"
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
        dbText "Name" ="OUTPUT_TS_Transactions.IMCLMJ"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.hsi_shipto_div_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.FiscalMonth"
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
        dbText "Name" ="OUTPUT_TS_Transactions.transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.customer_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OUTPUT_TS_Transactions.SalesOrderNumber"
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
End
Begin
    State =0
    Left =0
    Top =40
    Right =1604
    Bottom =991
    Left =-1
    Top =-1
    Right =1572
    Bottom =668
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =118
        Top =112
        Right =919
        Bottom =543
        Top =0
        Name ="OUTPUT_TS_Transactions"
        Name =""
    End
End
