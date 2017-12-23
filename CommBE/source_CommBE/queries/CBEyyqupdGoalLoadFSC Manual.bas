Operation =1
Option =0
Where ="(((comm_salesperson_master.employee_num)=\"4076\") AND ((comm_salesperson_master"
    ".comm_plan_id) Like \"fsc*\"))"
Begin InputTables
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Expression ="comm_salesperson_master.salesperson_key_id"
    Expression ="comm_salesperson_master.employee_num"
    Expression ="comm_salesperson_master.salesperson_nm"
    Expression ="comm_salesperson_master.ITMSND_GOAL_YTD_AMT"
    Expression ="comm_salesperson_master.ITMTEE_GOAL_YTD_AMT"
    Expression ="comm_salesperson_master.ITMCAM_GOAL_YTD_AMT"
    Expression ="comm_salesperson_master.ITMFO3_GOAL_YTD_AMT"
    Expression ="comm_salesperson_master.ITMSOF_GOAL_YTD_AMT"
    Expression ="comm_salesperson_master.ITMISC_GOAL_YTD_AMT"
    Expression ="comm_salesperson_master.ITME4D_GOAL_YTD_AMT"
    Expression ="comm_salesperson_master.ITMCPU_GOAL_YTD_AMT"
    Expression ="comm_salesperson_master.SFFFIN_GOAL_YTD_AMT"
    Expression ="comm_salesperson_master.ITMPAR_GOAL_YTD_AMT"
    Expression ="comm_salesperson_master.ITMSER_GOAL_YTD_AMT"
    Expression ="comm_salesperson_master.ITMEQ0_GOAL_YTD_AMT"
    Expression ="comm_salesperson_master.note_txt"
End
Begin OrderBy
    Expression ="comm_salesperson_master.employee_num"
    Flag =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="comm_salesperson_master.ITMSND_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3060"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.ITMCAM_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.ITMTEE_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2400"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.ITMFO3_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3030"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.ITMISC_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.ITME4D_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3945"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.ITMCPU_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.SFFFIN_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.ITMPAR_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2115"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.ITMSER_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.ITMEQ0_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.note_txt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="7740"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.[ITMCAM_GOAL_YTD_AMT]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.ITMSOF_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.employee_num"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-4
    Top =-23
    Right =1577
    Bottom =1013
    Left =-1
    Top =-1
    Right =1558
    Bottom =289
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =31
        Top =15
        Right =381
        Bottom =257
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
End
