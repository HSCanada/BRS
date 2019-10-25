Operation =1
Option =0
Begin InputTables
    Name ="dbo_comm_ess_statement_export02"
End
Begin OutputColumns
    Expression ="dbo_comm_ess_statement_export02.ccs_employee_num"
    Expression ="dbo_comm_ess_statement_export02.ccs_salesperson_key_id"
    Expression ="dbo_comm_ess_statement_export02.ccs_salesperson_nm"
    Expression ="dbo_comm_ess_statement_export02.ccs_salesperson_cd"
    Expression ="dbo_comm_ess_statement_export02.branch_nm"
    Alias ="Branch Mill Mat Current Mth GP"
    Expression ="dbo_comm_ess_statement_export02.BON_DIGMAT_GP_CM_AMT"
    Alias ="Branch Mill Mat YTD GP"
    Expression ="dbo_comm_ess_statement_export02.BON_DIGMAT_GP_YTD_AMT"
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
        dbText "Name" ="dbo_comm_ess_statement_export02.branch_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="dbo_comm_ess_statement_export02.ccs_salesperson_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2220"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="dbo_comm_ess_statement_export02.ccs_employee_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="dbo_comm_ess_statement_export02.ccs_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="dbo_comm_ess_statement_export02.ccs_salesperson_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Branch Mill Mat Current Mth GP"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Branch Mill Mat YTD GP"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =-239
    Top =36
    Right =1322
    Bottom =982
    Left =-1
    Top =-1
    Right =1543
    Bottom =448
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =546
        Top =10
        Right =824
        Bottom =360
        Top =0
        Name ="dbo_comm_ess_statement_export02"
        Name =""
    End
End
