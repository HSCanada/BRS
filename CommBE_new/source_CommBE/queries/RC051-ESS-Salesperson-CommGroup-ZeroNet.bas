Operation =1
Option =0
Where ="(((comm_test_detail.fsc_salesperson_key_id)<>\"Internal\") AND ((comm_test_detai"
    "l.ess_comm_plan_id) Like \"ess*\")) OR (((comm_test_detail.fsc_salesperson_key_i"
    "d)<>\"Internal\") AND ((comm_test_detail.ess_comm_plan_id) Like \"ess*\")) OR (("
    "(comm_test_detail.fsc_salesperson_key_id)<>\"Internal\") AND ((comm_test_detail."
    "ess_comm_plan_id) Like \"ess*\"))"
Having ="(((Sum(comm_test_detail.transaction_amt)) Not Between -0.01 And 0.01)) OR (((Sum"
    "(comm_test_detail.gp_ext_amt)) Not Between -0.01 And 0.01)) OR (((Sum(comm_test_"
    "detail.ess_comm_amt)) Not Between -0.01 And 0.01))"
Begin InputTables
    Name ="comm_test_detail"
End
Begin OutputColumns
    Expression ="comm_test_detail.fiscal_yearmo_num"
    Expression ="comm_test_detail.ess_salesperson_key_id"
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
    Alias ="MaxOfitem_comm_group_cd"
    Expression ="Max(comm_test_detail.item_comm_group_cd)"
End
Begin Groups
    Expression ="comm_test_detail.fiscal_yearmo_num"
    GroupLevel =0
    Expression ="comm_test_detail.ess_salesperson_key_id"
    GroupLevel =0
    Expression ="comm_test_detail.disp_ess_comm_group_cd"
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
dbMemo "Filter" ="([RC051-ESS-Salesperson-CommGroup-ZeroNet].[ess_salesperson_key_id]=\"jheckbert "
    "                    \")"
dbMemo "OrderBy" ="[RC051-ESS-Salesperson-CommGroup-ZeroNet].[SumOftransaction_amt] DESC"
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
        dbText "Name" ="MinOfID_legacy"
        dbInteger "ColumnWidth" ="2610"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="MaxOfID_legacy"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_test_detail.disp_ess_comm_group_cd"
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
        dbInteger "ColumnWidth" ="2895"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="MaxOfitem_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =-62
    Top =172
    Right =1471
    Bottom =1069
    Left =-1
    Top =-1
    Right =1509
    Bottom =172
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =66
        Top =47
        Right =438
        Bottom =349
        Top =0
        Name ="comm_test_detail"
        Name =""
    End
End
