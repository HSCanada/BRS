Operation =1
Option =0
Where ="(((comm_ess_statement_export.ESS_comm_plan_id) Like \"CCS*\"))"
Begin InputTables
    Name ="comm_ess_statement_export"
End
Begin OutputColumns
    Expression ="comm_ess_statement_export.employee_num"
    Alias ="CCS_key_id"
    Expression ="comm_ess_statement_export.ESS_key_id"
    Alias ="CCS_nm"
    Expression ="comm_ess_statement_export.ESS_nm"
    Expression ="comm_ess_statement_export.branch_nm"
    Expression ="comm_ess_statement_export.zone_nm"
    Alias ="CCS_code"
    Expression ="comm_ess_statement_export.ESS_code"
    Expression ="comm_ess_statement_export.start_dt"
    Expression ="comm_ess_statement_export.ITMFRT_SALES_CM_AMT"
    Expression ="comm_ess_statement_export.ITMFRT_SALES_LYM_AMT"
    Expression ="comm_ess_statement_export.ITMFRT_GP_CM_AMT"
    Expression ="comm_ess_statement_export.ITMFRT_SALES_YTD_AMT"
    Expression ="comm_ess_statement_export.ITMFRT_GP_YTD_AMT"
    Expression ="comm_ess_statement_export.ITMFRT_SALES_LYTD_AMT"
    Alias ="ITMFRT_GOAL_YTD_AMT"
    Expression ="0"
    Expression ="comm_ess_statement_export.ITMFRT_GP_LYM_AMT"
    Expression ="comm_ess_statement_export.ITMFRT_GP_LYTD_AMT"
    Expression ="comm_ess_statement_export.DIGOTH_SALES_CM_AMT"
    Expression ="comm_ess_statement_export.DIGOTH_SALES_LYM_AMT"
    Expression ="comm_ess_statement_export.DIGOTH_GP_CM_AMT"
    Expression ="comm_ess_statement_export.DIGOTH_SALES_YTD_AMT"
    Expression ="comm_ess_statement_export.DIGOTH_GP_YTD_AMT"
    Expression ="comm_ess_statement_export.DIGOTH_SALES_LYTD_AMT"
    Alias ="DIGOTH_GOAL_YTD_AMT"
    Expression ="0"
    Expression ="comm_ess_statement_export.DIGOTH_GP_LYM_AMT"
    Expression ="comm_ess_statement_export.DIGOTH_GP_LYTD_AMT"
    Expression ="comm_ess_statement_export.DIGCCC_SALES_CM_AMT"
    Expression ="comm_ess_statement_export.DIGCCC_SALES_LYM_AMT"
    Expression ="comm_ess_statement_export.DIGCCC_GP_CM_AMT"
    Expression ="comm_ess_statement_export.DIGCCC_SALES_YTD_AMT"
    Expression ="comm_ess_statement_export.DIGCCC_GP_YTD_AMT"
    Expression ="comm_ess_statement_export.DIGCCC_SALES_LYTD_AMT"
    Alias ="DIGCCC_GOAL_YTD_AMT"
    Expression ="0"
    Expression ="comm_ess_statement_export.DIGCCC_GP_LYM_AMT"
    Expression ="comm_ess_statement_export.DIGCCC_GP_LYTD_AMT"
    Expression ="comm_ess_statement_export.SFFFIN_SALES_CM_AMT"
    Expression ="comm_ess_statement_export.SFFFIN_SALES_YTD_AMT"
    Expression ="comm_ess_statement_export.SFFFIN_GP_CM_AMT"
    Expression ="comm_ess_statement_export.SFFFIN_GP_YTD_AMT"
    Expression ="comm_ess_statement_export.ESS_comm_plan_id"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbText "Description" ="test"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbMemo "OrderBy" ="[CCS_Backend].[CCS_code]"
Begin
    Begin
        dbText "Name" ="comm_ess_statement_export.employee_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMFRT_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMFRT_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMFRT_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2385"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMFRT_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMFRT_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2430"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMFRT_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ESS_comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMFRT_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMFRT_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.branch_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.start_dt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.zone_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="CCS_key_id"
        dbInteger "ColumnWidth" ="2805"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="CCS_nm"
        dbInteger "ColumnWidth" ="2505"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="CCS_code"
        dbInteger "ColumnWidth" ="1290"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.SFFFIN_SALES_YTD_AMT"
        dbInteger "ColumnWidth" ="2670"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.SFFFIN_SALES_CM_AMT"
        dbInteger "ColumnWidth" ="2625"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.SFFFIN_GP_CM_AMT"
        dbInteger "ColumnWidth" ="2340"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.SFFFIN_GP_YTD_AMT"
        dbInteger "ColumnWidth" ="2385"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.DIGCCC_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.DIGCCC_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="DIGCCC_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.DIGCCC_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.DIGCCC_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.DIGCCC_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.DIGCCC_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.DIGCCC_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.DIGCCC_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ITMFRT_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="DIGOTH_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.DIGOTH_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.DIGOTH_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.DIGOTH_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.[DIGOTH_GP_CM_AMT]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.DIGOTH_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.DIGOTH_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.DIGOTH_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.DIGOTH_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.DIGOTH_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1432
    Bottom =977
    Left =-1
    Top =-1
    Right =1414
    Bottom =292
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =172
        Top =6
        Right =651
        Bottom =356
        Top =0
        Name ="comm_ess_statement_export"
        Name =""
    End
End
