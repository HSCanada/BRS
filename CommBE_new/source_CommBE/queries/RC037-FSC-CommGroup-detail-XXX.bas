Operation =1
Option =0
Where ="(((comm_test_detail.doc_id)=12877596) AND ((comm_test_detail.fsc_comm_plan_id) L"
    "ike \"fsc*\") AND ((comm_test_detail.fsc_salesperson_key_id)<>\"Internal\"))"
Begin InputTables
    Name ="comm_test_detail"
End
Begin OutputColumns
    Expression ="comm_test_detail.fiscal_yearmo_num"
    Expression ="comm_test_detail.ID_legacy"
    Expression ="comm_test_detail.doc_id"
    Expression ="comm_test_detail.dock_key_id"
    Expression ="comm_test_detail.line_id"
    Expression ="comm_test_detail.source_cd"
    Expression ="comm_test_detail.owner_cd"
    Expression ="comm_test_detail.src"
    Expression ="comm_test_detail.hsi_shipto_id"
    Expression ="comm_test_detail.item_id"
    Expression ="comm_test_detail.fsc_comm_plan_id"
    Expression ="comm_test_detail.fsc_salesperson_key_id"
    Expression ="comm_test_detail.fsc_code"
    Expression ="comm_test_detail.disp_fsc_comm_group_cd"
    Expression ="comm_test_detail.fsc_comm_group_cd"
    Expression ="comm_test_detail.shipped_qty"
    Expression ="comm_test_detail.transaction_amt"
    Expression ="comm_test_detail.gp_ext_amt"
    Expression ="comm_test_detail.fsc_comm_amt"
    Expression ="comm_test_detail.fsc_calc_key"
    Expression ="comm_test_detail.cust_comm_group_cd"
    Expression ="comm_test_detail.item_comm_group_cd"
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
        dbText "Name" ="comm_test_detail.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_test_detail.disp_fsc_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_test_detail.fsc_salesperson_key_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2610"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_test_detail.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_test_detail.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_test_detail.fsc_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_test_detail.fsc_comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_test_detail.fsc_comm_group_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2310"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_test_detail.ID_legacy"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_test_detail.shipped_qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_test_detail.gp_ext_amt"
        dbLong "AggregateType" ="-1"
        dbByte "DecimalPlaces" ="4"
    End
    Begin
        dbText "Name" ="comm_test_detail.transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_test_detail.fsc_comm_amt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1815"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_test_detail.src"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_test_detail.fsc_calc_key"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_test_detail.line_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_test_detail.doc_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_test_detail.dock_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_test_detail.owner_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_test_detail.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_test_detail.item_comm_group_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2490"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_test_detail.cust_comm_group_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2430"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Expr1005"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =176
    Top =252
    Right =1172
    Bottom =787
    Left =-1
    Top =-1
    Right =1174
    Bottom =450
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =83
        Top =18
        Right =455
        Bottom =320
        Top =0
        Name ="comm_test_detail"
        Name =""
    End
End
