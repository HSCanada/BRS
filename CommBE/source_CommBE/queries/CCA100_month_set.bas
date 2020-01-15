Operation =1
Option =0
Begin InputTables
    Name ="comm_config"
    Name ="BRS_FiscalMonth"
End
Begin OutputColumns
    Expression ="comm_config.id"
    Expression ="comm_config.PriorFiscalMonth"
    Expression ="comm_config.comm_LastWeekly"
    Expression ="BRS_FiscalMonth.LastWorkingDt"
    Expression ="BRS_FiscalMonth.comm_status_cd"
End
Begin Joins
    LeftTable ="comm_config"
    RightTable ="BRS_FiscalMonth"
    Expression ="comm_config.PriorFiscalMonth = BRS_FiscalMonth.FiscalMonth"
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
        dbText "Name" ="comm_config.PriorFiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_config.id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_config.comm_LastWeekly"
        dbInteger "ColumnWidth" ="2160"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FiscalMonth.comm_status_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FiscalMonth.LastWorkingDt"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1164
    Bottom =916
    Left =-1
    Top =-1
    Right =1140
    Bottom =627
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =89
        Top =42
        Right =416
        Bottom =318
        Top =0
        Name ="comm_config"
        Name =""
    End
    Begin
        Left =545
        Top =45
        Right =797
        Bottom =271
        Top =0
        Name ="BRS_FiscalMonth"
        Name =""
    End
End
