Operation =1
Option =0
Where ="(((comm_statement_export.comm_plan_id)<>\"FSCGPZZ\"))"
Begin InputTables
    Name ="comm_statement_export"
End
Begin OutputColumns
    Expression ="comm_statement_export.employee_num"
    Expression ="comm_statement_export.salesperson_key_id"
    Expression ="comm_statement_export.salesperson_nm"
    Expression ="comm_statement_export.comm_plan_id"
    Expression ="comm_statement_export.FRESND_GP_CM_AMT"
    Expression ="comm_statement_export.FRESND_COMM_CM_AMT"
    Expression ="comm_statement_export.FRESND_GP_YTD_AMT"
    Expression ="comm_statement_export.FRESEQ_GP_CM_AMT"
    Expression ="comm_statement_export.FRESEQ_COMM_CM_AMT"
    Expression ="comm_statement_export.FRESEQ_GP_YTD_AMT"
    Expression ="comm_statement_export.FRESND_GP_LYM_AMT"
    Expression ="comm_statement_export.FRESND_GP_LYTD_AMT"
    Expression ="comm_statement_export.FRESEQ_GP_LYM_AMT"
    Expression ="comm_statement_export.FRESEQ_GP_LYTD_AMT"
    Expression ="comm_statement_export.SPMFGS_GP_CM_AMT"
    Expression ="comm_statement_export.SPMFGS_COMM_CM_AMT"
    Expression ="comm_statement_export.SPMFGS_GP_YTD_AMT"
    Expression ="comm_statement_export.SPMFGS_GP_LYM_AMT"
    Expression ="comm_statement_export.SPMFGS_GP_LYTD_AMT"
    Expression ="comm_statement_export.SPMFGE_GP_CM_AMT"
    Expression ="comm_statement_export.SPMFGE_COMM_CM_AMT"
    Expression ="comm_statement_export.SPMFGE_GP_YTD_AMT"
    Expression ="comm_statement_export.SPMFGE_GP_LYM_AMT"
    Expression ="comm_statement_export.SPMFGE_GP_LYTD_AMT"
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
    End
    Begin
        dbText "Name" ="comm_statement_export.FRESND_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.FRESND_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.FRESND_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2880"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_statement_export.FRESEQ_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.FRESEQ_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.FRESEQ_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMFGE_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMFGS_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMFGS_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMFGS_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMFGE_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMFGE_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.FRESND_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMFGE_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.FRESEQ_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMFGE_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMFGS_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.FRESEQ_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.FRESND_GP_LYM_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export.SPMFGS_GP_LYTD_AMT"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-30
    Right =1586
    Bottom =999
    Left =-1
    Top =-1
    Right =1562
    Bottom =648
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =38
        Top =6
        Right =575
        Bottom =577
        Top =0
        Name ="comm_statement_export"
        Name =""
    End
End
