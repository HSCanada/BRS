Operation =4
Option =0
Where ="(((BRS_CustomerFSC_History_1.HIST_isr_salesperson_key_id)<>BRS_CustomerFSC_Histo"
    "ry!HIST_isr_salesperson_key_id) And ((BRS_CustomerFSC_History.FiscalMonth)=20230"
    "7) And ((BRS_CustomerFSC_History_1.FiscalMonth)=202209)) Or (((BRS_CustomerFSC_H"
    "istory_1.HIST_isr_comm_plan_id)<>BRS_CustomerFSC_History!HIST_isr_comm_plan_id) "
    "And ((BRS_CustomerFSC_History.FiscalMonth)=202307) And ((BRS_CustomerFSC_History"
    "_1.FiscalMonth)=202209)) Or (((BRS_CustomerFSC_History_1.HIST_TsTerritoryCd)<>BR"
    "S_CustomerFSC_History!HIST_TsTerritoryCd) And ((BRS_CustomerFSC_History.FiscalMo"
    "nth)=202307) And ((BRS_CustomerFSC_History_1.FiscalMonth)=202209))"
Begin InputTables
    Name ="BRS_CustomerFSC_History"
    Name ="BRS_CustomerFSC_History"
    Alias ="BRS_CustomerFSC_History_1"
End
Begin OutputColumns
    Name ="BRS_CustomerFSC_History_1.HIST_isr_salesperson_key_id"
    Expression ="[BRS_CustomerFSC_History]![HIST_isr_salesperson_key_id]"
    Name ="BRS_CustomerFSC_History_1.HIST_isr_comm_plan_id"
    Expression ="[BRS_CustomerFSC_History]![HIST_isr_comm_plan_id]"
    Name ="BRS_CustomerFSC_History_1.HIST_TsTerritoryCd"
    Expression ="[BRS_CustomerFSC_History]![HIST_TsTerritoryCd]"
End
Begin Joins
    LeftTable ="BRS_CustomerFSC_History"
    RightTable ="BRS_CustomerFSC_History_1"
    Expression ="BRS_CustomerFSC_History.Shipto = BRS_CustomerFSC_History_1.Shipto"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
dbByte "Orientation" ="0"
Begin
    Begin
        dbText "Name" ="BRS_CustomerFSC_History.HIST_isr_comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_CustomerFSC_History.HIST_isr_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_CustomerFSC_History.HIST_TsTerritoryCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_CustomerFSC_History.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_CustomerFSC_History.Shipto"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_CustomerFSC_History_1.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_CustomerFSC_History_1.HIST_isr_salesperson_key_id"
        dbInteger "ColumnWidth" ="5805"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_CustomerFSC_History_1.HIST_TsTerritoryCd"
        dbInteger "ColumnWidth" ="4890"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_CustomerFSC_History_1.HIST_isr_comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1470
    Bottom =938
    Left =-1
    Top =-1
    Right =1446
    Bottom =332
    Left =0
    Top =0
    ColumnsShown =579
    Begin
        Left =43
        Top =44
        Right =297
        Bottom =335
        Top =0
        Name ="BRS_CustomerFSC_History"
        Name =""
    End
    Begin
        Left =492
        Top =54
        Right =806
        Bottom =280
        Top =0
        Name ="BRS_CustomerFSC_History_1"
        Name =""
    End
End
