﻿Operation =1
Option =0
Where ="(((comm_test_detail.ess_comm_plan_id) Like \"ess*\" Or (comm_test_detail.ess_com"
    "m_plan_id) Like \"ccs*\") AND ((comm_test_detail.ess_salesperson_key_id) Like \""
    "*oak*\"))"
Begin InputTables
    Name ="comm_test_detail"
End
Begin OutputColumns
    Expression ="comm_test_detail.fiscal_yearmo_num"
    Expression ="comm_test_detail.doc_id"
    Expression ="comm_test_detail.dock_key_id"
    Expression ="comm_test_detail.line_id"
    Expression ="comm_test_detail.src"
    Expression ="comm_test_detail.ess_comm_plan_id"
    Expression ="comm_test_detail.ess_salesperson_key_id"
    Expression ="comm_test_detail.ess_code"
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
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbMemo "Filter" ="([RC057-ESS-CommGroup-detail-XXX].[disp_ess_comm_group_cd]=\"DIGOTH\")"
dbMemo "OrderBy" ="[RC057-ESS-CommGroup-detail-XXX].[doc_id], [RC057-ESS-CommGroup-detail-XXX].[lin"
    "e_id], [RC057-ESS-CommGroup-detail-XXX].[src] DESC"
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
End
Begin
    State =0
    Left =88
    Top =146
    Right =1412
    Bottom =816
    Left =-1
    Top =-1
    Right =1300
    Bottom =340
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
