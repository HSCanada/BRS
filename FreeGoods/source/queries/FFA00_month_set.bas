Operation =1
Option =0
Begin InputTables
    Name ="BRS_Config"
End
Begin OutputColumns
    Expression ="BRS_Config.id"
    Expression ="BRS_Config.SalesDateLastWeekly"
    Expression ="BRS_Config.PriorFiscalMonth"
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
        dbText "Name" ="BRS_Config.PriorFiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Config.id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Config.SalesDateLastWeekly"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2400"
        dbBoolean "ColumnHidden" ="0"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1526
    Bottom =918
    Left =-1
    Top =-1
    Right =1510
    Bottom =557
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =44
        Top =39
        Right =360
        Bottom =444
        Top =0
        Name ="BRS_Config"
        Name =""
    End
End
