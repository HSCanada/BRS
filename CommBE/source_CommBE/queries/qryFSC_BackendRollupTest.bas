Operation =1
Option =0
Where ="(((comm_statement_export.comm_plan_id)<>\"FSCDPZZ\"))"
Begin InputTables
    Name ="comm_statement_export"
End
Begin OutputColumns
    Expression ="comm_statement_export.employee_num"
    Expression ="comm_statement_export.salesperson_key_id"
    Expression ="comm_statement_export.salesperson_nm"
    Expression ="comm_statement_export.comm_plan_id"
    Expression ="comm_statement_export.REBSND_SALES_CM_AMT"
    Expression ="comm_statement_export.REBTEE_SALES_CM_AMT"
    Expression ="comm_statement_export.ITMSND_SALES_CM_AMT"
    Expression ="comm_statement_export.CUSINS_SALES_CM_AMT"
    Expression ="comm_statement_export.ITMTEE_SALES_CM_AMT"
    Expression ="comm_statement_export.ITMFO1_SALES_CM_AMT"
    Expression ="comm_statement_export.ITMFO2_SALES_CM_AMT"
    Expression ="comm_statement_export.ITMFO3_SALES_CM_AMT"
    Expression ="comm_statement_export.ITMFRT_SALES_CM_AMT"
    Expression ="comm_statement_export.ITMCNX_SALES_CM_AMT"
    Expression ="comm_statement_export.ITMDET_SALES_CM_AMT"
    Expression ="comm_statement_export.ITMBTI_SALES_CM_AMT"
    Expression ="comm_statement_export.ITMISC_SALES_CM_AMT"
    Expression ="comm_statement_export.ITME4D_SALES_CM_AMT"
    Expression ="comm_statement_export.ITMCPU_SALES_CM_AMT"
    Expression ="comm_statement_export.ITMPAR_SALES_CM_AMT"
    Expression ="comm_statement_export.ITMSER_SALES_CM_AMT"
    Expression ="comm_statement_export.ITMEQ0_SALES_CM_AMT"
    Expression ="comm_statement_export.ITMCAM_SALES_CM_AMT"
    Expression ="comm_statement_export.ITMSOF_SALES_CM_AMT"
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
        dbText "Name" ="comm_statement_export.salesperson_nm"
        dbInteger "ColumnWidth" ="2895"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.employee_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.salesperson_key_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2355"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_statement_export.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMSND_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.REBSND_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.CUSINS_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMTEE_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.REBTEE_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFO1_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFO2_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFO3_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFRT_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMCNX_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMDET_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMBTI_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMISC_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITME4D_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMCPU_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SFFFIN_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.PMANEW_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMPAR_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMSER_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMEQ0_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMCAM_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMSOF_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMEQ0_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMEQ0_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMEQ0_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMEQ0_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMEQ0_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMEQ0_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMEQ0_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SFFVEN_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ADJEBU_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMCAM_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMCAM_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMCAM_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMCAM_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMCAM_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMSOF_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMSOF_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMSOF_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMSOF_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMSOF_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMSOF_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMSOF_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SFFFIN_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.PMANEW_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.PMANEW_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.PMANEW_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.PMANEW_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.PMANEW_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.PMANEW_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.PMANEW_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMPAR_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMPAR_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMPAR_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMPAR_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMPAR_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMPAR_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMPAR_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMSER_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMSER_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMSER_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMSER_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMSER_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMSER_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMSER_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ADJOTH_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ADJARP_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ADJARB_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SALD30_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.STMPBA_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.master_division_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.master_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.fsc_comm_merch_rt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.fsc_comm_teeth_rt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMCAM_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMCAM_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.salesperson_territory_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.branch_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.zone_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.hsi_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.territory_start_dt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMSND_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMSND_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMSND_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMSND_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMSND_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMSND_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMSND_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.REBSND_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.REBSND_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.REBSND_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.REBSND_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.REBSND_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.REBSND_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.REBSND_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.CUSINS_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.CUSINS_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.CUSINS_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.CUSINS_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.CUSINS_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.CUSINS_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.CUSINS_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMTEE_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMTEE_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMTEE_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMTEE_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMTEE_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMTEE_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMTEE_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.REBTEE_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFRT_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFRT_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMDET_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMDET_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMDET_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMDET_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMDET_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMDET_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMDET_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMBTI_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMBTI_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMBTI_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMBTI_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMBTI_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMBTI_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMBTI_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMISC_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMISC_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMISC_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMISC_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMISC_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMISC_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMISC_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITME4D_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITME4D_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITME4D_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITME4D_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITME4D_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITME4D_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITME4D_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMCPU_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMCPU_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMCPU_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMCPU_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMCPU_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMCPU_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMCPU_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SFFFIN_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SFFFIN_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SFFFIN_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SFFFIN_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SFFFIN_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SFFFIN_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.REBTEE_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.REBTEE_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.REBTEE_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.REBTEE_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.REBTEE_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.REBTEE_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFO1_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFO1_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFO1_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFO1_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFO1_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFO1_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFO1_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFO2_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFO2_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFO2_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFO2_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFO2_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFO2_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFO2_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFO3_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFO3_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFO3_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFO3_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFO3_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFO3_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFO3_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFRT_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFRT_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFRT_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFRT_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFRT_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMCNX_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMCNX_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMCNX_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMCNX_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMCNX_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMCNX_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMCNX_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =6
    Top =38
    Right =1540
    Bottom =991
    Left =-1
    Top =-1
    Right =1511
    Bottom =316
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =38
        Top =6
        Right =436
        Bottom =461
        Top =0
        Name ="comm_statement_export"
        Name =""
    End
End
