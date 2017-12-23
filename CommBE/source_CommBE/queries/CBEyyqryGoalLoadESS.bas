Operation =4
Option =0
Where ="(((comm_salesperson_master.comm_plan_id) Like \"ess*\"))"
Begin InputTables
    Name ="comm_salesperson_master"
    Name ="comm_salesperson_master_goal"
End
Begin OutputColumns
    Name ="comm_salesperson_master.ITMSND_GOAL_YTD_AMT"
    Expression ="[new_ITMSND_GOAL_YTD_AMT]"
    Name ="comm_salesperson_master.REBSND_GOAL_YTD_AMT"
    Expression ="[new_REBSND_GOAL_YTD_AMT]"
    Name ="comm_salesperson_master.CUSINS_GOAL_YTD_AMT"
    Expression ="[new_CUSINS_GOAL_YTD_AMT]"
    Name ="comm_salesperson_master.ITMTEE_GOAL_YTD_AMT"
    Expression ="[new_ITMTEE_GOAL_YTD_AMT]"
    Name ="comm_salesperson_master.REBTEE_GOAL_YTD_AMT"
    Expression ="[new_REBTEE_GOAL_YTD_AMT]"
    Name ="comm_salesperson_master.ITMFO1_GOAL_YTD_AMT"
    Expression ="[new_ITMFO1_GOAL_YTD_AMT]"
    Name ="comm_salesperson_master.ITMFO2_GOAL_YTD_AMT"
    Expression ="[new_ITMFO2_GOAL_YTD_AMT]"
    Name ="comm_salesperson_master.ITMFO3_GOAL_YTD_AMT"
    Expression ="[new_ITMFO3_GOAL_YTD_AMT]"
    Name ="comm_salesperson_master.ITMFRT_GOAL_YTD_AMT"
    Expression ="[new_ITMFRT_GOAL_YTD_AMT]"
    Name ="comm_salesperson_master.ITMCNX_GOAL_YTD_AMT"
    Expression ="[new_ITMCNX_GOAL_YTD_AMT]"
    Name ="comm_salesperson_master.ITMDET_GOAL_YTD_AMT"
    Expression ="[new_ITMDET_GOAL_YTD_AMT]"
    Name ="comm_salesperson_master.ITMBTI_GOAL_YTD_AMT"
    Expression ="[new_ITMBTI_GOAL_YTD_AMT]"
    Name ="comm_salesperson_master.ITMISC_GOAL_YTD_AMT"
    Expression ="[new_ITMISC_GOAL_YTD_AMT]"
    Name ="comm_salesperson_master.ITME4D_GOAL_YTD_AMT"
    Expression ="[new_ITME4D_GOAL_YTD_AMT]"
    Name ="comm_salesperson_master.ITMCPU_GOAL_YTD_AMT"
    Expression ="[new_ITMCPU_GOAL_YTD_AMT]"
    Name ="comm_salesperson_master.SFFFIN_GOAL_YTD_AMT"
    Expression ="[new_SFFFIN_GOAL_YTD_AMT]"
    Name ="comm_salesperson_master.PMANEW_GOAL_YTD_AMT"
    Expression ="[new_PMANEW_GOAL_YTD_AMT]"
    Name ="comm_salesperson_master.ITMPAR_GOAL_YTD_AMT"
    Expression ="[new_ITMPAR_GOAL_YTD_AMT]"
    Name ="comm_salesperson_master.ITMSER_GOAL_YTD_AMT"
    Expression ="[new_ITMSER_GOAL_YTD_AMT]"
    Name ="comm_salesperson_master.ITMEQ0_GOAL_YTD_AMT"
    Expression ="[new_ITMEQ0_GOAL_YTD_AMT]"
    Name ="comm_salesperson_master.note_txt"
    Expression ="[new_note_txt]"
    Name ="comm_salesperson_master.ITMCAM_GOAL_YTD_AMT"
    Expression ="[new_ITMCAM_GOAL_YTD_AMT]"
    Name ="comm_salesperson_master.ITMSOF_GOAL_YTD_AMT"
    Expression ="[new_ITMSOF_GOAL_YTD_AMT]"
    Name ="comm_salesperson_master.BON001_GOAL_YTD_AMT"
    Expression ="[new_BON001_GOAL_YTD_AMT]"
    Name ="comm_salesperson_master.BON002_GOAL_YTD_AMT"
    Expression ="[new_BON002_GOAL_YTD_AMT]"
    Name ="comm_salesperson_master.BON003_GOAL_YTD_AMT"
    Expression ="[new_BON003_GOAL_YTD_AMT]"
    Name ="comm_salesperson_master.BON004_GOAL_YTD_AMT"
    Expression ="[new_BON004_GOAL_YTD_AMT]"
End
Begin Joins
    LeftTable ="comm_salesperson_master"
    RightTable ="comm_salesperson_master_goal"
    Expression ="comm_salesperson_master.employee_num = comm_salesperson_master_goal.employee_num"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
Begin
    Begin
        dbText "Name" ="comm_salesperson_master_goal.new_REBSND_GOAL_YTD_AMT"
        dbInteger "ColumnWidth" ="3075"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master_goal.new_CUSINS_GOAL_YTD_AMT"
        dbInteger "ColumnWidth" ="2985"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.ITMSND_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master_goal.new_ITMCAM_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master_goal.new_ITMSOF_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.ITMCAM_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.ITMSOF_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.REBSND_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.CUSINS_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.ITMTEE_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.REBTEE_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.ITMFO1_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.ITMFO2_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.ITMFO3_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.ITMFRT_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.ITMCNX_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.ITMDET_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.ITMBTI_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.ITMISC_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.ITME4D_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
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
        dbText "Name" ="comm_salesperson_master.PMANEW_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.ITMPAR_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
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
    End
    Begin
        dbText "Name" ="comm_salesperson_master.BON001_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.BON002_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.BON003_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.BON004_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master_goal.new_BON001_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master_goal.new_note_txt"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1493
    Bottom =1004
    Left =-1
    Top =-1
    Right =1470
    Bottom =458
    Left =0
    Top =0
    ColumnsShown =579
    Begin
        Left =31
        Top =15
        Right =427
        Bottom =491
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
    Begin
        Left =505
        Top =5
        Right =844
        Bottom =217
        Top =0
        Name ="comm_salesperson_master_goal"
        Name =""
    End
End
