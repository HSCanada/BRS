Operation =1
Option =0
Where ="(((comm_ess_statement_export.ESS_comm_plan_id)<>\"ESSGPZZ\"))"
Begin InputTables
    Name ="comm_ess_statement_export"
End
Begin OutputColumns
    Expression ="comm_ess_statement_export.employee_num"
    Expression ="comm_ess_statement_export.ESS_key_id"
    Expression ="comm_ess_statement_export.ESS_nm"
    Expression ="comm_ess_statement_export.ESS_code"
    Expression ="comm_ess_statement_export.FRESEQ_GP_CM_AMT"
    Expression ="comm_ess_statement_export.FRESEQ_COMM_CM_AMT"
    Expression ="comm_ess_statement_export.FRESEQ_GP_YTD_AMT"
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
dbMemo "OrderBy" ="[ESS_Backend_FreeGoods].[ESS_key_id], [ESS_Backend_FreeGoods].[ESS_comm_plan_id]"
Begin
    Begin
        dbText "Name" ="comm_ess_statement_export.ESS_key_id"
        dbInteger "ColumnWidth" ="2805"
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
        dbText "Name" ="comm_ess_statement_export.employee_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ESS_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.FRESEQ_GP_CM_AMT"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2790"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.FRESEQ_COMM_CM_AMT"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2775"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.FRESEQ_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2895"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_ess_statement_export.ESS_comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1534
    Bottom =991
    Left =-1
    Top =-1
    Right =1502
    Bottom =491
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
