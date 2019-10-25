Operation =1
Option =0
Where ="(((comm_ess_statement_export.ESS_comm_plan_id)<>\"ESSGPZZ\" And (comm_ess_statem"
    "ent_export.ESS_comm_plan_id) Like \"ESS*\"))"
Begin InputTables
    Name ="comm_ess_statement_export"
End
Begin OutputColumns
    Expression ="comm_ess_statement_export.employee_num"
    Expression ="comm_ess_statement_export.ESS_key_id"
    Expression ="comm_ess_statement_export.ESS_nm"
    Expression ="comm_ess_statement_export.branch_nm"
    Expression ="comm_ess_statement_export.zone_nm"
    Expression ="comm_ess_statement_export.ESS_code"
    Expression ="comm_ess_statement_export.start_dt"
    Expression ="comm_ess_statement_export.ITMFO1_SALES_CM_AMT"
    Expression ="comm_ess_statement_export.ITMFO1_SALES_LYM_AMT"
    Expression ="comm_ess_statement_export.ITMFO1_GP_CM_AMT"
    Expression ="comm_ess_statement_export.ITMFO1_SALES_YTD_AMT"
    Expression ="comm_ess_statement_export.ITMFO1_GP_YTD_AMT"
    Expression ="comm_ess_statement_export.ITMFO1_SALES_LYTD_AMT"
    Alias ="ITMFO1_GOAL_YTD_AMT"
    Expression ="0"
    Expression ="comm_ess_statement_export.ITMFO2_SALES_CM_AMT"
    Expression ="comm_ess_statement_export.ITMFO2_SALES_LYM_AMT"
    Expression ="comm_ess_statement_export.ITMFO2_GP_CM_AMT"
    Expression ="comm_ess_statement_export.ITMFO2_SALES_YTD_AMT"
    Expression ="comm_ess_statement_export.ITMFO2_GP_YTD_AMT"
    Expression ="comm_ess_statement_export.ITMFO2_SALES_LYTD_AMT"
    Alias ="ITMFO2_GOAL_YTD_AMT"
    Expression ="0"
    Expression ="comm_ess_statement_export.ITMFO3_SALES_CM_AMT"
    Expression ="comm_ess_statement_export.ITMFO3_SALES_LYM_AMT"
    Expression ="comm_ess_statement_export.ITMFO3_GP_CM_AMT"
    Expression ="comm_ess_statement_export.ITMFO3_SALES_YTD_AMT"
    Expression ="comm_ess_statement_export.ITMFO3_GP_YTD_AMT"
    Expression ="comm_ess_statement_export.ITMFO3_SALES_LYTD_AMT"
    Alias ="ITMFO3_GOAL_YTD_AMT"
    Expression ="0"
    Expression ="comm_ess_statement_export.ITMFRT_SALES_CM_AMT"
    Expression ="comm_ess_statement_export.ITMFRT_SALES_LYM_AMT"
    Expression ="comm_ess_statement_export.ITMFRT_GP_CM_AMT"
    Expression ="comm_ess_statement_export.ITMFRT_SALES_YTD_AMT"
    Expression ="comm_ess_statement_export.ITMFRT_GP_YTD_AMT"
    Expression ="comm_ess_statement_export.ITMFRT_SALES_LYTD_AMT"
    Alias ="ITMFRT_GOAL_YTD_AMT"
    Expression ="0"
    Expression ="comm_ess_statement_export.DIGOTH_SALES_CM_AMT"
    Expression ="comm_ess_statement_export.DIGOTH_SALES_LYM_AMT"
    Expression ="comm_ess_statement_export.DIGOTH_GP_CM_AMT"
    Expression ="comm_ess_statement_export.DIGOTH_SALES_YTD_AMT"
    Expression ="comm_ess_statement_export.DIGOTH_GP_YTD_AMT"
    Expression ="comm_ess_statement_export.DIGOTH_SALES_LYTD_AMT"
    Alias ="DIGOTH_GOAL_YTD_AMT"
    Expression ="0"
    Expression ="comm_ess_statement_export.ITMFO1_GP_LYM_AMT"
    Expression ="comm_ess_statement_export.ITMFO1_GP_LYTD_AMT"
    Expression ="comm_ess_statement_export.ITMFO2_GP_LYM_AMT"
    Expression ="comm_ess_statement_export.ITMFO2_GP_LYTD_AMT"
    Expression ="comm_ess_statement_export.ITMFO3_GP_LYM_AMT"
    Expression ="comm_ess_statement_export.ITMFO3_GP_LYTD_AMT"
    Expression ="comm_ess_statement_export.ITMFRT_GP_LYM_AMT"
    Expression ="comm_ess_statement_export.ITMFRT_GP_LYTD_AMT"
    Expression ="comm_ess_statement_export.ITMISC_GP_LYM_AMT"
    Expression ="comm_ess_statement_export.ITMISC_GP_LYTD_AMT"
    Expression ="comm_ess_statement_export.DIGCCC_GP_LYM_AMT"
    Expression ="comm_ess_statement_export.DIGCCC_GP_LYTD_AMT"
    Expression ="comm_ess_statement_export.ITMCPU_GP_LYM_AMT"
    Expression ="comm_ess_statement_export.ITMCPU_GP_LYTD_AMT"
    Expression ="comm_ess_statement_export.ITMISC_SALES_CM_AMT"
    Expression ="comm_ess_statement_export.ITMISC_SALES_LYM_AMT"
    Expression ="comm_ess_statement_export.ITMISC_GP_CM_AMT"
    Expression ="comm_ess_statement_export.ITMISC_SALES_YTD_AMT"
    Expression ="comm_ess_statement_export.ITMISC_GP_YTD_AMT"
    Expression ="comm_ess_statement_export.ITMISC_SALES_LYTD_AMT"
    Alias ="ITMISC_GOAL_YTD_AMT"
    Expression ="0"
    Expression ="comm_ess_statement_export.DIGCCC_SALES_CM_AMT"
    Expression ="comm_ess_statement_export.DIGCCC_SALES_LYM_AMT"
    Expression ="comm_ess_statement_export.DIGCCC_GP_CM_AMT"
    Expression ="comm_ess_statement_export.DIGCCC_SALES_YTD_AMT"
    Expression ="comm_ess_statement_export.DIGCCC_GP_YTD_AMT"
    Expression ="comm_ess_statement_export.DIGCCC_SALES_LYTD_AMT"
    Alias ="DIGCCC_GOAL_YTD_AMT"
    Expression ="0"
    Expression ="comm_ess_statement_export.ITMCPU_SALES_CM_AMT"
    Expression ="comm_ess_statement_export.ITMCPU_SALES_LYM_AMT"
    Expression ="comm_ess_statement_export.ITMCPU_GP_CM_AMT"
    Expression ="comm_ess_statement_export.ITMCPU_SALES_YTD_AMT"
    Expression ="comm_ess_statement_export.ITMCPU_GP_YTD_AMT"
    Expression ="comm_ess_statement_export.ITMCPU_SALES_LYTD_AMT"
    Alias ="ITMCPU_GOAL_YTD_AMT"
    Expression ="0"
    Expression ="comm_ess_statement_export.ITMSOF_SALES_CM_AMT"
    Expression ="comm_ess_statement_export.ITMSOF_SALES_LYM_AMT"
    Expression ="comm_ess_statement_export.ITMSOF_GP_CM_AMT"
    Expression ="comm_ess_statement_export.ITMSOF_COMM_CM_AMT"
    Expression ="comm_ess_statement_export.ITMSOF_SALES_YTD_AMT"
    Expression ="comm_ess_statement_export.ITMSOF_GP_YTD_AMT"
    Expression ="comm_ess_statement_export.ITMSOF_SALES_LYTD_AMT"
    Alias ="ITMSOF_GOAL_YTD_AMT"
    Expression ="0"
    Expression ="comm_ess_statement_export.ITMSOF_GP_LYM_AMT"
    Expression ="comm_ess_statement_export.ITMSOF_GP_LYTD_AMT"
    Expression ="comm_ess_statement_export.SFFFIN_SALES_CM_AMT"
    Expression ="comm_ess_statement_export.SFFFIN_SALES_YTD_AMT"
    Expression ="comm_ess_statement_export.SFFFIN_GP_CM_AMT"
    Expression ="comm_ess_statement_export.SFFFIN_GP_YTD_AMT"
    Expression ="comm_ess_statement_export.ESS_comm_plan_id"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbText "Description" ="test"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="comm_ess_statement_export.ESS_key_id"
        dbInteger "ColumnWidth" ="2805"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMFO1_SALES_CM_AMT"
        dbInteger "ColumnWidth" ="2700"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMFO1_SALES_YTD_AMT"
        dbInteger "ColumnWidth" ="2610"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ESS_nm"
        dbInteger "ColumnWidth" ="2505"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMFO2_SALES_CM_AMT"
        dbInteger "ColumnWidth" ="2700"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMFO1_SALES_LYM_AMT"
        dbInteger "ColumnWidth" ="2640"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.employee_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.branch_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ESS_code"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1290"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.start_dt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMFO1_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2415"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMFO1_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMFO1_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3255"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMFO2_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMFO2_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2415"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMFO2_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMFO2_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMFO2_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMFO3_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMFO3_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMFO3_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2415"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMFO3_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMFO3_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMFO3_SALES_LYTD_AMT"
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
        dbText "Name" ="comm_ess_statement_export.ITMISC_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMISC_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMISC_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMISC_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMISC_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMISC_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMCPU_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMCPU_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMCPU_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMCPU_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMCPU_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMCPU_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.SFFFIN_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2340"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.SFFFIN_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2670"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.SFFFIN_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2385"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMSOF_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMSOF_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMSOF_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2415"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMSOF_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2790"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMSOF_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2745"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMSOF_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2460"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMSOF_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2250"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ESS_comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.zone_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMFO3_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMFRT_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMISC_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMCPU_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMFO1_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMFRT_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMFO1_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMFO2_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMFO2_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMFO3_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMISC_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMCPU_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMSOF_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ITMSOF_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.SFFFIN_SALES_CM_AMT"
        dbInteger "ColumnWidth" ="2625"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.DIGCCC_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.DIGOTH_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.DIGCCC_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.DIGCCC_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ITMISC_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ITMFO2_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.DIGCCC_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.DIGCCC_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.DIGCCC_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.DIGOTH_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.DIGCCC_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ITMFO1_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ITMFO3_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ITMFRT_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ITMCPU_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ITMSOF_GOAL_YTD_AMT"
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
        dbText "Name" ="comm_ess_statement_export.DIGOTH_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.DIGOTH_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.DIGCCC_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="DIGOTH_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="DIGCCC_GOAL_YTD_AMT"
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
    Bottom =535
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =172
        Top =6
        Right =651
        Bottom =576
        Top =0
        Name ="comm_ess_statement_export"
        Name =""
    End
End
