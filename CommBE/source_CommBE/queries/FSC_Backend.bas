Operation =1
Option =0
Where ="(((Trim([comm_plan_id]))<>\"FSCGPZZ\"))"
Begin InputTables
    Name ="comm_statement_export"
End
Begin OutputColumns
    Alias ="employee_num_"
    Expression ="comm_statement_export.employee_num"
    Expression ="comm_statement_export.salesperson_key_id"
    Expression ="comm_statement_export.salesperson_nm"
    Expression ="comm_statement_export.branch_cd"
    Expression ="comm_statement_export.branch_nm"
    Expression ="comm_statement_export.zone_nm"
    Alias ="comm_plan_id_"
    Expression ="Trim([comm_plan_id])"
    Expression ="comm_statement_export.hsi_salesperson_cd"
    Expression ="comm_statement_export.territory_start_dt"
    Expression ="comm_statement_export.ITMSND_SALES_CM_AMT"
    Expression ="comm_statement_export.ITMSND_SALES_LYM_AMT"
    Expression ="comm_statement_export.ITMSND_GP_CM_AMT"
    Expression ="comm_statement_export.ITMSND_COMM_CM_AMT"
    Expression ="comm_statement_export.ITMSND_SALES_YTD_AMT"
    Expression ="comm_statement_export.ITMSND_GP_YTD_AMT"
    Expression ="comm_statement_export.ITMSND_SALES_LYTD_AMT"
    Expression ="comm_statement_export.ITMSND_GOAL_YTD_AMT"
    Expression ="comm_statement_export.REBSND_SALES_CM_AMT"
    Expression ="comm_statement_export.REBSND_SALES_LYM_AMT"
    Expression ="comm_statement_export.REBSND_GP_CM_AMT"
    Expression ="comm_statement_export.REBSND_COMM_CM_AMT"
    Expression ="comm_statement_export.REBSND_SALES_YTD_AMT"
    Expression ="comm_statement_export.REBSND_GP_YTD_AMT"
    Expression ="comm_statement_export.REBSND_SALES_LYTD_AMT"
    Alias ="REBSND_GOAL_YTD_AMT"
    Expression ="0"
    Expression ="comm_statement_export.SPMSND_SALES_CM_AMT"
    Expression ="comm_statement_export.SPMSND_SALES_LYM_AMT"
    Expression ="comm_statement_export.SPMSND_GP_CM_AMT"
    Expression ="comm_statement_export.SPMSND_COMM_CM_AMT"
    Expression ="comm_statement_export.SPMSND_SALES_YTD_AMT"
    Expression ="comm_statement_export.SPMSND_GP_YTD_AMT"
    Expression ="comm_statement_export.SPMSND_SALES_LYTD_AMT"
    Alias ="SPMSND_GOAL_YTD_AMT"
    Expression ="0"
    Expression ="comm_statement_export.ITMTEE_SALES_CM_AMT"
    Expression ="comm_statement_export.ITMTEE_SALES_LYM_AMT"
    Expression ="comm_statement_export.ITMTEE_GP_CM_AMT"
    Expression ="comm_statement_export.ITMTEE_COMM_CM_AMT"
    Expression ="comm_statement_export.ITMTEE_SALES_YTD_AMT"
    Expression ="comm_statement_export.ITMTEE_GP_YTD_AMT"
    Expression ="comm_statement_export.ITMTEE_SALES_LYTD_AMT"
    Expression ="comm_statement_export.ITMTEE_GOAL_YTD_AMT"
    Expression ="comm_statement_export.REBTEE_SALES_CM_AMT"
    Expression ="comm_statement_export.REBTEE_SALES_LYM_AMT"
    Expression ="comm_statement_export.REBTEE_GP_CM_AMT"
    Expression ="comm_statement_export.REBTEE_COMM_CM_AMT"
    Expression ="comm_statement_export.REBTEE_SALES_YTD_AMT"
    Expression ="comm_statement_export.REBTEE_GP_YTD_AMT"
    Expression ="comm_statement_export.REBTEE_SALES_LYTD_AMT"
    Alias ="REBTEE_GOAL_YTD_AMT"
    Expression ="0"
    Expression ="comm_statement_export.ITMFO1_SALES_CM_AMT"
    Expression ="comm_statement_export.ITMFO1_SALES_LYM_AMT"
    Expression ="comm_statement_export.ITMFO1_GP_CM_AMT"
    Expression ="comm_statement_export.ITMFO1_COMM_CM_AMT"
    Expression ="comm_statement_export.ITMFO1_SALES_YTD_AMT"
    Expression ="comm_statement_export.ITMFO1_GP_YTD_AMT"
    Expression ="comm_statement_export.ITMFO1_SALES_LYTD_AMT"
    Expression ="comm_statement_export.ITMFO1_GOAL_YTD_AMT"
    Expression ="comm_statement_export.ITMFO2_SALES_CM_AMT"
    Expression ="comm_statement_export.ITMFO2_SALES_LYM_AMT"
    Expression ="comm_statement_export.ITMFO2_GP_CM_AMT"
    Expression ="comm_statement_export.ITMFO2_COMM_CM_AMT"
    Expression ="comm_statement_export.ITMFO2_SALES_YTD_AMT"
    Expression ="comm_statement_export.ITMFO2_GP_YTD_AMT"
    Expression ="comm_statement_export.ITMFO2_SALES_LYTD_AMT"
    Expression ="comm_statement_export.ITMFO2_GOAL_YTD_AMT"
    Expression ="comm_statement_export.ITMFO3_SALES_CM_AMT"
    Expression ="comm_statement_export.ITMFO3_SALES_LYM_AMT"
    Expression ="comm_statement_export.ITMFO3_GP_CM_AMT"
    Expression ="comm_statement_export.ITMFO3_COMM_CM_AMT"
    Expression ="comm_statement_export.ITMFO3_SALES_YTD_AMT"
    Expression ="comm_statement_export.ITMFO3_GP_YTD_AMT"
    Expression ="comm_statement_export.ITMFO3_SALES_LYTD_AMT"
    Expression ="comm_statement_export.ITMFO3_GOAL_YTD_AMT"
    Expression ="comm_statement_export.ITMFRT_SALES_CM_AMT"
    Expression ="comm_statement_export.ITMFRT_SALES_LYM_AMT"
    Expression ="comm_statement_export.ITMFRT_GP_CM_AMT"
    Expression ="comm_statement_export.ITMFRT_COMM_CM_AMT"
    Expression ="comm_statement_export.ITMFRT_SALES_YTD_AMT"
    Expression ="comm_statement_export.ITMFRT_GP_YTD_AMT"
    Expression ="comm_statement_export.ITMFRT_SALES_LYTD_AMT"
    Expression ="comm_statement_export.ITMFRT_GOAL_YTD_AMT"
    Expression ="comm_statement_export.SPMFO1_SALES_CM_AMT"
    Expression ="comm_statement_export.SPMFO1_SALES_LYM_AMT"
    Expression ="comm_statement_export.SPMFO1_GP_CM_AMT"
    Expression ="comm_statement_export.SPMFO1_COMM_CM_AMT"
    Expression ="comm_statement_export.SPMFO1_SALES_YTD_AMT"
    Expression ="comm_statement_export.SPMFO1_GP_YTD_AMT"
    Expression ="comm_statement_export.SPMFO1_SALES_LYTD_AMT"
    Alias ="SPMFO1_GOAL_YTD_AMT"
    Expression ="0"
    Expression ="comm_statement_export.SPMFO2_SALES_CM_AMT"
    Expression ="comm_statement_export.SPMFO2_SALES_LYM_AMT"
    Expression ="comm_statement_export.SPMFO2_GP_CM_AMT"
    Expression ="comm_statement_export.SPMFO2_COMM_CM_AMT"
    Expression ="comm_statement_export.SPMFO2_SALES_YTD_AMT"
    Expression ="comm_statement_export.SPMFO2_GP_YTD_AMT"
    Expression ="comm_statement_export.SPMFO2_SALES_LYTD_AMT"
    Alias ="SPMFO2_GOAL_YTD_AMT"
    Expression ="0"
    Expression ="comm_statement_export.SPMFO3_SALES_CM_AMT"
    Expression ="comm_statement_export.SPMFO3_SALES_LYM_AMT"
    Expression ="comm_statement_export.SPMFO3_GP_CM_AMT"
    Expression ="comm_statement_export.SPMFO3_COMM_CM_AMT"
    Expression ="comm_statement_export.SPMFO3_SALES_YTD_AMT"
    Expression ="comm_statement_export.SPMFO3_GP_YTD_AMT"
    Expression ="comm_statement_export.SPMFO3_SALES_LYTD_AMT"
    Alias ="SPMFO3_GOAL_YTD_AMT"
    Expression ="0"
    Expression ="comm_statement_export.ITMISC_SALES_CM_AMT"
    Expression ="comm_statement_export.ITMISC_SALES_LYM_AMT"
    Expression ="comm_statement_export.ITMISC_GP_CM_AMT"
    Expression ="comm_statement_export.ITMISC_COMM_CM_AMT"
    Expression ="comm_statement_export.ITMISC_SALES_YTD_AMT"
    Expression ="comm_statement_export.ITMISC_GP_YTD_AMT"
    Expression ="comm_statement_export.ITMISC_SALES_LYTD_AMT"
    Expression ="comm_statement_export.ITMISC_GOAL_YTD_AMT"
    Expression ="comm_statement_export.DIGCCS_SALES_CM_AMT"
    Expression ="comm_statement_export.DIGCCS_SALES_LYM_AMT"
    Expression ="comm_statement_export.DIGCCS_GP_CM_AMT"
    Expression ="comm_statement_export.DIGCCS_COMM_CM_AMT"
    Expression ="comm_statement_export.DIGCCS_SALES_YTD_AMT"
    Expression ="comm_statement_export.DIGCCS_GP_YTD_AMT"
    Expression ="comm_statement_export.DIGCCS_SALES_LYTD_AMT"
    Alias ="DIGCCS_GOAL_YTD_AMT"
    Expression ="0"
    Expression ="comm_statement_export.ITMCPU_SALES_CM_AMT"
    Expression ="comm_statement_export.ITMCPU_SALES_LYM_AMT"
    Expression ="comm_statement_export.ITMCPU_GP_CM_AMT"
    Expression ="comm_statement_export.ITMCPU_COMM_CM_AMT"
    Expression ="comm_statement_export.ITMCPU_SALES_YTD_AMT"
    Expression ="comm_statement_export.ITMCPU_GP_YTD_AMT"
    Expression ="comm_statement_export.ITMCPU_SALES_LYTD_AMT"
    Expression ="comm_statement_export.ITMCPU_GOAL_YTD_AMT"
    Expression ="comm_statement_export.SFFFIN_SALES_CM_AMT"
    Expression ="comm_statement_export.SFFFIN_SALES_LYM_AMT"
    Expression ="comm_statement_export.SFFFIN_GP_CM_AMT"
    Expression ="comm_statement_export.SFFFIN_COMM_CM_AMT"
    Expression ="comm_statement_export.SFFFIN_SALES_YTD_AMT"
    Expression ="comm_statement_export.SFFFIN_GP_YTD_AMT"
    Expression ="comm_statement_export.SFFFIN_SALES_LYTD_AMT"
    Alias ="SFFFIN_GOAL_YTD_AMT"
    Expression ="0"
    Expression ="comm_statement_export.DIGIMP_SALES_CM_AMT"
    Expression ="comm_statement_export.DIGIMP_SALES_LYM_AMT"
    Expression ="comm_statement_export.DIGIMP_GP_CM_AMT"
    Expression ="comm_statement_export.DIGIMP_COMM_CM_AMT"
    Expression ="comm_statement_export.DIGIMP_SALES_YTD_AMT"
    Expression ="comm_statement_export.DIGIMP_GP_YTD_AMT"
    Expression ="comm_statement_export.DIGIMP_SALES_LYTD_AMT"
    Alias ="DIGIMP_GOAL_YTD_AMT"
    Expression ="0"
    Expression ="comm_statement_export.ITMPAR_SALES_CM_AMT"
    Expression ="comm_statement_export.ITMPAR_SALES_LYM_AMT"
    Expression ="comm_statement_export.ITMPAR_GP_CM_AMT"
    Expression ="comm_statement_export.ITMPAR_COMM_CM_AMT"
    Expression ="comm_statement_export.ITMPAR_SALES_YTD_AMT"
    Expression ="comm_statement_export.ITMPAR_GP_YTD_AMT"
    Expression ="comm_statement_export.ITMPAR_SALES_LYTD_AMT"
    Expression ="comm_statement_export.ITMPAR_GOAL_YTD_AMT"
    Expression ="comm_statement_export.ITMSER_SALES_CM_AMT"
    Expression ="comm_statement_export.ITMSER_SALES_LYM_AMT"
    Expression ="comm_statement_export.ITMSER_GP_CM_AMT"
    Expression ="comm_statement_export.ITMSER_COMM_CM_AMT"
    Expression ="comm_statement_export.ITMSER_SALES_YTD_AMT"
    Expression ="comm_statement_export.ITMSER_GP_YTD_AMT"
    Expression ="comm_statement_export.ITMSER_SALES_LYTD_AMT"
    Expression ="comm_statement_export.ITMSER_GOAL_YTD_AMT"
    Expression ="comm_statement_export.ITMEQ0_SALES_CM_AMT"
    Expression ="comm_statement_export.ITMEQ0_SALES_LYM_AMT"
    Expression ="comm_statement_export.ITMEQ0_GP_CM_AMT"
    Expression ="comm_statement_export.ITMEQ0_COMM_CM_AMT"
    Expression ="comm_statement_export.ITMEQ0_SALES_YTD_AMT"
    Expression ="comm_statement_export.ITMEQ0_GP_YTD_AMT"
    Expression ="comm_statement_export.ITMEQ0_SALES_LYTD_AMT"
    Expression ="comm_statement_export.ITMEQ0_GOAL_YTD_AMT"
    Expression ="comm_statement_export.DIGMAT_SALES_CM_AMT"
    Expression ="comm_statement_export.DIGMAT_SALES_LYM_AMT"
    Expression ="comm_statement_export.DIGMAT_GP_CM_AMT"
    Expression ="comm_statement_export.DIGMAT_COMM_CM_AMT"
    Expression ="comm_statement_export.DIGMAT_SALES_YTD_AMT"
    Expression ="comm_statement_export.SALD30_COMM_CM_AMT"
    Expression ="comm_statement_export.STMPBA_COMM_CM_AMT"
    Expression ="comm_statement_export.DIGMAT_GP_YTD_AMT"
    Expression ="comm_statement_export.DIGMAT_SALES_LYTD_AMT"
    Alias ="DIGMAT_GOAL_YTD_AMT"
    Expression ="0"
    Alias ="NOTUSED1"
    Expression ="0"
    Expression ="comm_statement_export.ITMCAM_SALES_CM_AMT"
    Expression ="comm_statement_export.ITMCAM_SALES_LYM_AMT"
    Expression ="comm_statement_export.ITMCAM_GP_CM_AMT"
    Expression ="comm_statement_export.ITMCAM_COMM_CM_AMT"
    Expression ="comm_statement_export.ITMCAM_SALES_YTD_AMT"
    Expression ="comm_statement_export.ITMCAM_GP_YTD_AMT"
    Expression ="comm_statement_export.ITMCAM_SALES_LYTD_AMT"
    Expression ="comm_statement_export.ITMCAM_GOAL_YTD_AMT"
    Expression ="comm_statement_export.ITMSOF_SALES_CM_AMT"
    Expression ="comm_statement_export.ITMSOF_SALES_LYM_AMT"
    Expression ="comm_statement_export.ITMSOF_GP_CM_AMT"
    Expression ="comm_statement_export.ITMSOF_COMM_CM_AMT"
    Expression ="comm_statement_export.ITMSOF_SALES_YTD_AMT"
    Expression ="comm_statement_export.ITMSOF_GP_YTD_AMT"
    Expression ="comm_statement_export.ITMSOF_SALES_LYTD_AMT"
    Expression ="comm_statement_export.ITMSOF_GOAL_YTD_AMT"
    Expression ="comm_statement_export.ITMSND_GP_LYM_AMT"
    Expression ="comm_statement_export.ITMSND_GP_LYTD_AMT"
    Expression ="comm_statement_export.REBSND_GP_LYM_AMT"
    Expression ="comm_statement_export.REBSND_GP_LYTD_AMT"
    Expression ="comm_statement_export.SPMSND_GP_LYM_AMT"
    Expression ="comm_statement_export.SPMSND_GP_LYTD_AMT"
    Expression ="comm_statement_export.ITMTEE_GP_LYM_AMT"
    Expression ="comm_statement_export.ITMTEE_GP_LYTD_AMT"
    Expression ="comm_statement_export.REBTEE_GP_LYM_AMT"
    Expression ="comm_statement_export.REBTEE_GP_LYTD_AMT"
    Expression ="comm_statement_export.ITMFO1_GP_LYM_AMT"
    Expression ="comm_statement_export.ITMFO1_GP_LYTD_AMT"
    Expression ="comm_statement_export.ITMFO2_GP_LYM_AMT"
    Expression ="comm_statement_export.ITMFO2_GP_LYTD_AMT"
    Expression ="comm_statement_export.ITMFO3_GP_LYM_AMT"
    Expression ="comm_statement_export.ITMFO3_GP_LYTD_AMT"
    Expression ="comm_statement_export.ITMFRT_GP_LYM_AMT"
    Expression ="comm_statement_export.ITMFRT_GP_LYTD_AMT"
    Expression ="comm_statement_export.SPMFO1_GP_LYM_AMT"
    Expression ="comm_statement_export.SPMFO1_GP_LYTD_AMT"
    Expression ="comm_statement_export.SPMFO2_GP_LYM_AMT"
    Expression ="comm_statement_export.SPMFO2_GP_LYTD_AMT"
    Expression ="comm_statement_export.SPMFO3_GP_LYM_AMT"
    Expression ="comm_statement_export.SPMFO3_GP_LYTD_AMT"
    Expression ="comm_statement_export.ITMISC_GP_LYM_AMT"
    Expression ="comm_statement_export.ITMISC_GP_LYTD_AMT"
    Expression ="comm_statement_export.DIGCCS_GP_LYM_AMT"
    Expression ="comm_statement_export.DIGCCS_GP_LYTD_AMT"
    Expression ="comm_statement_export.ITMCPU_GP_LYM_AMT"
    Expression ="comm_statement_export.ITMCPU_GP_LYTD_AMT"
    Expression ="comm_statement_export.SFFFIN_GP_LYM_AMT"
    Expression ="comm_statement_export.SFFFIN_GP_LYTD_AMT"
    Expression ="comm_statement_export.DIGIMP_GP_LYM_AMT"
    Expression ="comm_statement_export.DIGIMP_GP_LYTD_AMT"
    Expression ="comm_statement_export.ITMPAR_GP_LYM_AMT"
    Expression ="comm_statement_export.ITMPAR_GP_LYTD_AMT"
    Expression ="comm_statement_export.ITMSER_GP_LYM_AMT"
    Expression ="comm_statement_export.ITMSER_GP_LYTD_AMT"
    Expression ="comm_statement_export.ITMEQ0_GP_LYM_AMT"
    Expression ="comm_statement_export.ITMEQ0_GP_LYTD_AMT"
    Expression ="comm_statement_export.ITMCAM_GP_LYM_AMT"
    Expression ="comm_statement_export.ITMCAM_GP_LYTD_AMT"
    Expression ="comm_statement_export.ITMSOF_GP_LYM_AMT"
    Expression ="comm_statement_export.ITMSOF_GP_LYTD_AMT"
    Expression ="comm_statement_export.DIGMAT_GP_LYM_AMT"
    Expression ="comm_statement_export.DIGMAT_GP_LYTD_AMT"
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
        dbText "Name" ="comm_statement_export.salesperson_key_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2355"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_statement_export.branch_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.zone_nm"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1275"
        dbBoolean "ColumnHidden" ="0"
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
        dbText "Name" ="comm_statement_export.ITMSND_SALES_CM_AMT"
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
        dbText "Name" ="comm_statement_export.REBSND_SALES_CM_AMT"
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
        dbText "Name" ="comm_statement_export.ITMTEE_SALES_CM_AMT"
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
        dbText "Name" ="comm_statement_export.REBTEE_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.REBTEE_SALES_LYM_AMT"
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
        dbText "Name" ="comm_statement_export.ITMFO1_SALES_CM_AMT"
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
        dbText "Name" ="comm_statement_export.ITMFO2_SALES_CM_AMT"
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
        dbText "Name" ="comm_statement_export.ITMFO3_SALES_CM_AMT"
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
        dbText "Name" ="comm_statement_export.ITMFRT_SALES_CM_AMT"
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
        dbText "Name" ="comm_statement_export.ITMFRT_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2760"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFRT_SALES_YTD_AMT"
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
        dbText "Name" ="comm_statement_export.ITMISC_SALES_CM_AMT"
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
        dbText "Name" ="comm_statement_export.ITMCPU_SALES_CM_AMT"
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
        dbText "Name" ="comm_statement_export.SFFFIN_SALES_CM_AMT"
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
        dbText "Name" ="comm_statement_export.ITMPAR_SALES_CM_AMT"
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
        dbText "Name" ="comm_statement_export.ITMSER_SALES_CM_AMT"
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
        dbText "Name" ="comm_statement_export.ITMEQ0_SALES_CM_AMT"
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
        dbText "Name" ="comm_statement_export.SALD30_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.STMPBA_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMCAM_SALES_CM_AMT"
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
        dbText "Name" ="comm_statement_export.ITMSOF_SALES_CM_AMT"
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
        dbText "Name" ="employee_num_"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_plan_id_"
        dbInteger "ColumnWidth" ="1890"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMSND_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMSND_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMSND_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMSND_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMSND_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMSND_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMSND_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMFO2_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMFO2_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMFO2_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMFO1_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2760"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMFO1_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2835"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMFO2_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMFO2_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMFO2_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMFO2_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMFO3_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMFO3_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMFO3_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMFO3_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMFO3_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMFO3_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMFO3_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.DIGCCS_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.DIGCCS_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.DIGCCS_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2385"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_statement_export.DIGCCS_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2760"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMFO1_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2895"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_statement_export.DIGCCS_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMFO1_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMFO1_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMFO1_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMFO1_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.DIGCCS_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.DIGCCS_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.DIGMAT_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.DIGMAT_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.DIGMAT_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.DIGIMP_SALES_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.DIGIMP_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.DIGIMP_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.DIGIMP_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.DIGIMP_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.DIGIMP_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.DIGIMP_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.DIGMAT_SALES_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.DIGMAT_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.DIGMAT_SALES_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.DIGMAT_SALES_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.branch_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="REBSND_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SPMSND_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="REBTEE_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SPMFO1_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SPMFO2_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="DIGMAT_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SPMFO3_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="DIGCCS_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SFFFIN_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="DIGIMP_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="NOTUSED1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMTEE_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFO1_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMSND_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.REBTEE_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.REBTEE_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFO2_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFO1_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMTEE_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMISC_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMPAR_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.REBSND_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMCAM_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.DIGIMP_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMSND_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMFO1_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMCPU_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMISC_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.DIGMAT_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMSND_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.DIGMAT_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.REBSND_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMCAM_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMSND_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMSER_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFO2_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMSOF_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFO3_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMSOF_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFO3_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFRT_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMFRT_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMFO1_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMFO2_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMFO2_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMFO3_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMFO3_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.DIGCCS_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.DIGCCS_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMCPU_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SFFFIN_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SFFFIN_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.DIGIMP_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMPAR_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMSER_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMEQ0_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.ITMEQ0_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1560
    Bottom =991
    Left =-1
    Top =-1
    Right =1528
    Bottom =669
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
