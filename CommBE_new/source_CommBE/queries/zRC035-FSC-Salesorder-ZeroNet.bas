﻿Operation =1
Option =0
Where ="(((comm_test_detail.fsc_salesperson_key_id)<>\"Internal\") AND ((comm_test_detai"
    "l.fsc_comm_plan_id) Like \"fsc*\") AND ((comm_test_detail.IMCLMJ)=\"856\")) OR ("
    "((comm_test_detail.fsc_salesperson_key_id)<>\"Internal\") AND ((comm_test_detail"
    ".fsc_comm_plan_id) Like \"fsc*\") AND ((comm_test_detail.IMCLMJ)=\"856\")) OR (("
    "(comm_test_detail.fsc_salesperson_key_id)<>\"Internal\") AND ((comm_test_detail."
    "fsc_comm_plan_id) Like \"fsc*\") AND ((comm_test_detail.IMCLMJ)=\"856\"))"
Having ="(((Sum(comm_test_detail.transaction_amt)) Not Between -0.01 And 0.01)) OR (((Sum"
    "(comm_test_detail.gp_ext_amt)) Not Between -0.01 And 0.01)) OR (((Sum(comm_test_"
    "detail.fsc_comm_amt)) Not Between -0.01 And 0.01))"
Begin InputTables
    Name ="comm_test_detail"
End
Begin OutputColumns
    Expression ="comm_test_detail.fiscal_yearmo_num"
    Expression ="comm_test_detail.doc_id"
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
    Expression ="comm_test_detail.doc_id"
    GroupLevel =0
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
        dbText "Name" ="MinOfID_legacy"
        dbInteger "ColumnWidth" ="2610"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="MaxOfID_legacy"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1710"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_test_detail.doc_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1035"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="MaxOfitem_comm_group_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2070"
        dbBoolean "ColumnHidden" ="0"
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
    Right =1465
    Bottom =437
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =141
        Top =19
        Right =513
        Bottom =321
        Top =0
        Name ="comm_test_detail"
        Name =""
    End
End
