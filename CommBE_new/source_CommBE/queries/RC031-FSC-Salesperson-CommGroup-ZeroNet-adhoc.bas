﻿Operation =1
Option =0
Where ="(((comm_test_detail.hsi_shipto_id)=1670033) AND ((comm_test_detail.fsc_salespers"
    "on_key_id)<>\"Internal\") AND ((comm_test_detail.fsc_comm_plan_id) Like \"fsc*\""
    ")) OR (((comm_test_detail.hsi_shipto_id)=1670033) AND ((comm_test_detail.fsc_sal"
    "esperson_key_id)<>\"Internal\") AND ((comm_test_detail.fsc_comm_plan_id) Like \""
    "fsc*\")) OR (((comm_test_detail.hsi_shipto_id)=1670033) AND ((comm_test_detail.f"
    "sc_salesperson_key_id)<>\"Internal\") AND ((comm_test_detail.fsc_comm_plan_id) L"
    "ike \"fsc*\"))"
Having ="(((comm_test_detail.fsc_salesperson_key_id)=\"tmchugh\") AND ((Sum(comm_test_det"
    "ail.transaction_amt)) Not Between -0.01 And 0.01)) OR (((comm_test_detail.fsc_sa"
    "lesperson_key_id)=\"tmchugh\") AND ((Sum(comm_test_detail.gp_ext_amt)) Not Betwe"
    "en -0.01 And 0.01)) OR (((comm_test_detail.fsc_salesperson_key_id)=\"tmchugh\") "
    "AND ((Sum(comm_test_detail.fsc_comm_amt)) Not Between -0.01 And 0.01))"
Begin InputTables
    Name ="comm_test_detail"
End
Begin OutputColumns
    Expression ="comm_test_detail.fiscal_yearmo_num"
    Expression ="comm_test_detail.fsc_salesperson_key_id"
    Expression ="comm_test_detail.disp_fsc_comm_group_cd"
    Alias ="SumOfshipped_qty"
    Expression ="Sum(comm_test_detail.shipped_qty)"
    Alias ="SumOftransaction_amt"
    Expression ="Sum(comm_test_detail.transaction_amt)"
    Alias ="SumOfgp_ext_amt"
    Expression ="Sum(comm_test_detail.gp_ext_amt)"
    Alias ="SumOffsc_comm_amt"
    Expression ="Sum(comm_test_detail.fsc_comm_amt)"
    Alias ="MinOfID_legacy"
    Expression ="Min(comm_test_detail.ID_legacy)"
    Alias ="MaxOfID_legacy"
    Expression ="Max(comm_test_detail.ID_legacy)"
    Alias ="MaxOfitem_comm_group_cd"
    Expression ="Max(comm_test_detail.item_comm_group_cd)"
End
Begin OrderBy
    Expression ="Sum(comm_test_detail.gp_ext_amt)"
    Flag =1
End
Begin Groups
    Expression ="comm_test_detail.fiscal_yearmo_num"
    GroupLevel =0
    Expression ="comm_test_detail.fsc_salesperson_key_id"
    GroupLevel =0
    Expression ="comm_test_detail.disp_fsc_comm_group_cd"
    GroupLevel =0
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
Begin
    Begin
        dbText "Name" ="SumOftransaction_amt"
        dbInteger "ColumnWidth" ="2550"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOfgp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOffsc_comm_amt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2445"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="SumOfshipped_qty"
        dbInteger "ColumnWidth" ="2205"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_test_detail.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_test_detail.disp_fsc_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="MinOfID_legacy"
        dbInteger "ColumnWidth" ="1890"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="MaxOfID_legacy"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1920"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_test_detail.fsc_salesperson_key_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2670"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="MaxOfitem_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1493
    Bottom =938
    Left =-1
    Top =-1
    Right =1469
    Bottom =205
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =95
        Top =0
        Right =467
        Bottom =302
        Top =0
        Name ="comm_test_detail"
        Name =""
    End
End
