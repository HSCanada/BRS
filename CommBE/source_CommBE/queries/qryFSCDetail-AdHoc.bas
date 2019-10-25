Operation =1
Option =0
Where ="(((comm_transaction.fiscal_yearmo_num)=\"201909\") AND ((comm_transaction.salesp"
    "erson_cd)=\"WZ1C2\"))"
Begin InputTables
    Name ="comm_transaction"
    Name ="comm_salesperson_code_map"
    Name ="comm_item_master"
End
Begin OutputColumns
    Expression ="comm_transaction.fiscal_yearmo_num"
    Expression ="comm_salesperson_code_map.branch_cd"
    Expression ="comm_transaction.salesperson_key_id"
    Expression ="comm_transaction.ess_salesperson_key_id"
    Expression ="comm_transaction.ess_comm_plan_id"
    Expression ="comm_transaction.source_cd"
    Expression ="comm_transaction.order_source_cd"
    Expression ="comm_transaction.salesperson_cd"
    Expression ="comm_transaction.ess_salesperson_cd"
    Expression ="comm_transaction.comm_plan_id"
    Expression ="comm_transaction.status_cd"
    Expression ="comm_transaction.transaction_dt"
    Expression ="comm_transaction.item_id"
    Expression ="comm_transaction.doc_key_id"
    Expression ="comm_transaction.doc_id"
    Expression ="comm_transaction.line_id"
    Expression ="comm_transaction.item_comm_group_cd"
    Expression ="comm_transaction.item_comm_rt"
    Expression ="comm_transaction.comm_amt"
    Expression ="comm_transaction.ess_comm_group_cd"
    Expression ="comm_transaction.ess_comm_rt"
    Expression ="comm_transaction.ess_comm_amt"
    Expression ="comm_transaction.shipped_qty"
    Expression ="comm_transaction.transaction_amt"
    Expression ="comm_transaction.gp_ext_amt"
    Expression ="comm_transaction.transaction_txt"
    Expression ="comm_transaction.record_id"
    Expression ="comm_transaction.hsi_shipto_id"
    Expression ="comm_transaction.hsi_billto_id"
    Expression ="comm_transaction.hsi_shipto_div_cd"
    Expression ="comm_transaction.customer_nm"
    Expression ="comm_transaction.manufact_cd"
    Expression ="comm_transaction.IMCLMJ"
    Expression ="comm_transaction.pmts_salesperson_cd"
    Expression ="comm_item_master.comm_group_cd"
    Expression ="comm_item_master.note_txt"
End
Begin Joins
    LeftTable ="comm_transaction"
    RightTable ="comm_salesperson_code_map"
    Expression ="comm_transaction.salesperson_cd = comm_salesperson_code_map.salesperson_cd"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="comm_item_master"
    Expression ="comm_transaction.item_id = comm_item_master.item_id"
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
Begin
    Begin
        dbText "Name" ="comm_transaction.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.salesperson_key_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2355"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.salesperson_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1980"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.comm_plan_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1860"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_amt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1995"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.gp_ext_amt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1560"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.item_comm_group_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2625"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.comm_amt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1545"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.line_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_txt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3030"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.record_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.status_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.item_comm_rt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1845"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.customer_nm"
        dbInteger "ColumnWidth" ="3000"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_dt"
        dbInteger "ColumnWidth" ="2355"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.doc_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_salesperson_cd"
        dbInteger "ColumnWidth" ="2460"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.IMCLMJ"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.pmts_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_comm_group_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2355"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_salesperson_code_map.branch_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.hsi_shipto_div_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2670"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.shipped_qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.note_txt"
        dbInteger "ColumnWidth" ="2880"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.order_source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.manufact_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_comm_rt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_comm_amt"
        dbInteger "ColumnWidth" ="1860"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_salesperson_key_id"
        dbInteger "ColumnWidth" ="2655"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.hsi_billto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.doc_id"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =43
    Top =91
    Right =1445
    Bottom =817
    Left =-1
    Top =-1
    Right =1447
    Bottom =352
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =214
        Top =9
        Right =583
        Bottom =440
        Top =0
        Name ="comm_transaction"
        Name =""
    End
    Begin
        Left =856
        Top =1
        Right =1301
        Bottom =264
        Top =0
        Name ="comm_salesperson_code_map"
        Name =""
    End
    Begin
        Left =1006
        Top =245
        Right =1207
        Bottom =580
        Top =0
        Name ="comm_item_master"
        Name =""
    End
End
