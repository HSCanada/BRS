Operation =1
Option =0
Where ="(((comm_test_detail.doc_id)=13796657))"
Begin InputTables
    Name ="comm_test_detail"
End
Begin OutputColumns
    Expression ="comm_test_detail.fiscal_yearmo_num"
    Expression ="comm_test_detail.doc_id"
    Expression ="comm_test_detail.hsi_shipto_div_cd"
    Expression ="comm_test_detail.dock_key_id"
    Expression ="comm_test_detail.line_id"
    Expression ="comm_test_detail.src"
    Expression ="comm_test_detail.ess_comm_plan_id"
    Expression ="comm_test_detail.ess_salesperson_key_id"
    Expression ="comm_test_detail.ess_code"
    Expression ="comm_test_detail.fsc_salesperson_key_id"
    Expression ="comm_test_detail.source_cd"
    Expression ="comm_test_detail.hsi_shipto_id"
    Expression ="comm_test_detail.disp_ess_comm_group_cd"
    Expression ="comm_test_detail.ess_comm_group_cd"
    Expression ="comm_test_detail.shipped_qty"
    Expression ="comm_test_detail.transaction_amt"
    Expression ="comm_test_detail.gp_ext_amt"
    Expression ="comm_test_detail.ess_comm_amt"
    Expression ="comm_test_detail.ID_legacy"
    Expression ="comm_test_detail.ess_calc_key"
    Expression ="comm_test_detail.xfer_key"
    Expression ="comm_test_detail.xfer_fsc_code_org"
    Expression ="comm_test_detail.xfer_ess_code_org"
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
        dbText "Name" ="comm_test_detail.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_test_detail.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
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
    End
    Begin
        dbText "Name" ="comm_test_detail.transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_test_detail.src"
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
        dbText "Name" ="comm_test_detail.ess_comm_amt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2160"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_test_detail.ess_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_test_detail.disp_ess_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_test_detail.ess_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_test_detail.ess_salesperson_key_id"
        dbInteger "ColumnWidth" ="2610"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_test_detail.ess_comm_plan_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2190"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_test_detail.ess_calc_key"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_test_detail.xfer_fsc_code_org"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_test_detail.xfer_key"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_test_detail.xfer_ess_code_org"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_test_detail.fsc_salesperson_key_id"
        dbInteger "ColumnWidth" ="2610"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_test_detail.hsi_shipto_div_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =1559
    Bottom =945
    Left =-1
    Top =-1
    Right =1535
    Bottom =175
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
