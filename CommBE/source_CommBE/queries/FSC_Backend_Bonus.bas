Operation =1
Option =0
Where ="(((comm_salesperson_master.comm_plan_id)<>\"FSCGPZZ\"))"
Begin InputTables
    Name ="comm_statement_export02"
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Expression ="comm_statement_export02.employee_num"
    Expression ="comm_statement_export02.salesperson_key_id"
    Expression ="comm_statement_export02.salesperson_nm"
    Expression ="comm_statement_export02.hsi_salesperson_cd"
    Alias ="BON10K_GP_YTD_AMT"
    Expression ="\"\""
    Alias ="BON6K_GP_YTD_AMT (MED FSC ONLY)"
    Expression ="\"\""
    Alias ="CEREC & Other Cad/Cam, Digital CM GP$"
    Expression ="comm_statement_export02.BONSCNMIL_GP_CM_AMT"
    Alias ="CEREC & Other Cad/Cam, Digital YTD GP$"
    Expression ="comm_statement_export02.BONSCNMIL_GP_YTD_AMT"
    Alias ="MEDICAL E-BIZ (See Gary ebiz)"
    Expression ="\"\""
    Alias ="PAT#"
    Expression ="\"\""
End
Begin Joins
    LeftTable ="comm_statement_export02"
    RightTable ="comm_salesperson_master"
    Expression ="comm_statement_export02.salesperson_key_id = comm_salesperson_master.salesperson"
        "_key_id"
    Flag =1
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
        dbText "Name" ="comm_statement_export02.employee_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export02.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export02.salesperson_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_export02.hsi_salesperson_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3495"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="BON10K_GP_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BON6K_GP_YTD_AMT (MED FSC ONLY)"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="CEREC & Other Cad/Cam, Digital CM GP$"
        dbInteger "ColumnWidth" ="4110"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="CEREC & Other Cad/Cam, Digital YTD GP$"
        dbInteger "ColumnWidth" ="2880"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="MEDICAL E-BIZ (See Gary ebiz)"
        dbInteger "ColumnWidth" ="3075"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="PAT#"
    End
End
Begin
    State =0
    Left =-63
    Top =40
    Right =1498
    Bottom =986
    Left =-1
    Top =-1
    Right =1537
    Bottom =204
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =121
        Top =38
        Right =521
        Bottom =403
        Top =0
        Name ="comm_statement_export02"
        Name =""
    End
    Begin
        Left =620
        Top =68
        Right =922
        Bottom =290
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
End
