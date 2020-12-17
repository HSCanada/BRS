Operation =1
Option =0
Where ="(((comm_test_detail.fsc_salesperson_key_id)<>\"Internal\") AND ((comm_test_detai"
    "l.ess_comm_plan_id) Like \"ess*\" Or (comm_test_detail.ess_comm_plan_id) Like \""
    "ccs*\")) OR (((comm_test_detail.fsc_salesperson_key_id)<>\"Internal\") AND ((com"
    "m_test_detail.ess_comm_plan_id) Like \"ess*\" Or (comm_test_detail.ess_comm_plan"
    "_id) Like \"ccs*\")) OR (((comm_test_detail.fsc_salesperson_key_id)<>\"Internal\""
    ") AND ((comm_test_detail.ess_comm_plan_id) Like \"ess*\" Or (comm_test_detail.es"
    "s_comm_plan_id) Like \"ccs*\"))"
Having ="(((Sum(comm_test_detail.transaction_amt)) Not Between -0.01 And 0.01)) OR (((Sum"
    "(comm_test_detail.gp_ext_amt)) Not Between -0.01 And 0.01)) OR (((Sum(comm_test_"
    "detail.ess_comm_amt)) Not Between -0.01 And 0.01))"
Begin InputTables
    Name ="comm_test_detail"
End
Begin OutputColumns
    Expression ="comm_test_detail.fiscal_yearmo_num"
    Expression ="comm_test_detail.disp_ess_comm_group_cd"
    Alias ="SumOfshipped_qty"
    Expression ="Sum(comm_test_detail.shipped_qty)"
    Alias ="SumOftransaction_amt"
    Expression ="Sum(comm_test_detail.transaction_amt)"
    Alias ="SumOfgp_ext_amt"
    Expression ="Sum(comm_test_detail.gp_ext_amt)"
    Alias ="SumOfess_comm_amt"
    Expression ="Sum(comm_test_detail.ess_comm_amt)"
    Alias ="MinOfID_legacy"
    Expression ="Min(comm_test_detail.ID_legacy)"
    Alias ="MaxOfID_legacy"
    Expression ="Max(comm_test_detail.ID_legacy)"
    Expression ="comm_test_detail.ess_salesperson_key_id"
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
    Expression ="comm_test_detail.disp_ess_comm_group_cd"
    GroupLevel =0
    Expression ="comm_test_detail.ess_salesperson_key_id"
    GroupLevel =0
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
        dbText "Name" ="MaxOfID_legacy"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="MinOfID_legacy"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_test_detail.disp_ess_comm_group_cd"
        dbInteger "ColumnWidth" ="2310"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOfess_comm_amt"
        dbInteger "ColumnWidth" ="2445"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_test_detail.ess_salesperson_key_id"
        dbLong "AggregateType" ="-1"
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
    Right =1533
    Bottom =937
    Left =-1
    Top =-1
    Right =1509
    Bottom =240
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =86
        Top =24
        Right =458
        Bottom =326
        Top =0
        Name ="comm_test_detail"
        Name =""
    End
End
