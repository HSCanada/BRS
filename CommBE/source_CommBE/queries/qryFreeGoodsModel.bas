Operation =3
Name ="STAGE_FreeGoodTrans"
Option =0
Where ="(((comm_transaction.fiscal_yearmo_num)=\"201106\") AND ((comm_transaction.source"
    "_cd)=\"JDE\") AND ((comm_transaction.transaction_amt)=0))"
Begin InputTables
    Name ="comm_transaction"
End
Begin OutputColumns
    Name ="fiscal_yearmo_num"
    Expression ="comm_transaction.fiscal_yearmo_num"
    Name ="source_cd"
    Expression ="comm_transaction.source_cd"
    Name ="salesperson_key_id"
    Expression ="comm_transaction.salesperson_key_id"
    Name ="salesperson_cd"
    Expression ="comm_transaction.salesperson_cd"
    Name ="hsi_shipto_id"
    Expression ="comm_transaction.hsi_shipto_id"
    Name ="IMITEM"
    Expression ="comm_transaction.IMITEM"
    Name ="transaction_txt"
    Expression ="comm_transaction.transaction_txt"
    Name ="doc_type_cd"
    Expression ="comm_transaction.doc_type_cd"
    Name ="doc_id"
    Expression ="comm_transaction.doc_id"
    Name ="line_id"
    Expression ="comm_transaction.line_id"
    Name ="sales_category_cd"
    Expression ="comm_transaction.sales_category_cd"
    Name ="manufact_cd"
    Expression ="comm_transaction.manufact_cd"
    Name ="IMCLMJ"
    Expression ="comm_transaction.IMCLMJ"
    Name ="item_label_cd"
    Expression ="comm_transaction.item_label_cd"
    Name ="shipped_qty"
    Expression ="comm_transaction.shipped_qty"
    Name ="transaction_amt"
    Expression ="comm_transaction.transaction_amt"
    Name ="gp_ext_amt"
    Expression ="comm_transaction.gp_ext_amt"
    Name ="file_cost_unit_amt"
    Expression ="comm_transaction.file_cost_unit_amt"
    Name ="avg_cost_unit_amt"
    Expression ="comm_transaction.avg_cost_unit_amt"
    Name ="cost_ext_amt"
    Expression ="comm_transaction.cost_ext_amt"
    Name ="price_method_cd"
    Expression ="comm_transaction.price_method_cd"
    Name ="record_id"
    Expression ="comm_transaction.record_id"
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
dbBoolean "UseTransaction" ="-1"
Begin
    Begin
        dbText "Name" ="comm_transaction.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.shipped_qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.price_method_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.cost_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.IMITEM"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_txt"
        dbInteger "ColumnWidth" ="3315"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.sales_category_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.manufact_cd"
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
        dbText "Name" ="comm_transaction.line_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.doc_type_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.file_cost_unit_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.avg_cost_unit_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.item_label_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.record_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.IMSUPL"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.vpa_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-4
    Top =-23
    Right =1548
    Bottom =1008
    Left =-1
    Top =-1
    Right =1529
    Bottom =678
    Left =0
    Top =0
    ColumnsShown =651
    Begin
        Left =48
        Top =12
        Right =578
        Bottom =501
        Top =0
        Name ="comm_transaction"
        Name =""
    End
End
