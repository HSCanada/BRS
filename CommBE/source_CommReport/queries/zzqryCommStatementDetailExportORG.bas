Operation =1
Option =0
Where ="(((comm_statement_detail.salesperson_key_id)=GetCurrentFSC()))"
Begin InputTables
    Name ="comm_statement_detail"
End
Begin OutputColumns
    Expression ="comm_statement_detail.salesperson_key_id"
    Expression ="comm_statement_detail.salesperson_cd"
    Expression ="comm_statement_detail.transaction_dt"
    Expression ="comm_statement_detail.transaction_amt"
    Expression ="comm_statement_detail.gp_ext_amt"
    Expression ="comm_statement_detail.item_comm_group_cd"
    Expression ="comm_statement_detail.comm_rt"
    Expression ="comm_statement_detail.comm_amt"
    Expression ="comm_statement_detail.report_group_txt"
    Expression ="comm_statement_detail.hsi_item_id"
    Expression ="comm_statement_detail.doc_key_id"
    Expression ="comm_statement_detail.hsi_shipto_id"
    Expression ="comm_statement_detail.transaction_txt"
    Expression ="comm_statement_detail.fiscal_yearmo_num"
    Expression ="comm_statement_detail.item_label_cd"
    Expression ="comm_statement_detail.shipped_qty"
    Expression ="comm_statement_detail.comm_cost_unit_amt"
    Expression ="comm_statement_detail.ess_salesperson_cd"
    Expression ="comm_statement_detail.ess_salesperson_key_id"
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
        dbText "Name" ="comm_statement_detail.report_group_txt"
        dbInteger "ColumnWidth" ="2685"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.doc_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.transaction_txt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3225"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_statement_detail.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.transaction_dt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.transaction_amt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1995"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_statement_detail.comm_rt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.comm_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.hsi_item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1695"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_statement_detail.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.item_comm_group_cd"
        dbInteger "ColumnWidth" ="2625"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.comm_cost_unit_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.item_label_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.ess_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.ess_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.shipped_qty"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1391
    Bottom =977
    Left =-1
    Top =-1
    Right =1375
    Bottom =401
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =38
        Top =6
        Right =624
        Bottom =444
        Top =0
        Name ="comm_statement_detail"
        Name =""
    End
End
