Operation =1
Option =0
Begin InputTables
    Name ="BRS_FiscalMonth"
    Name ="BRS_Config"
End
Begin OutputColumns
    Expression ="BRS_Config.id"
    Expression ="BRS_Config.PriorFiscalMonth"
    Expression ="BRS_FiscalMonth.me_status_cd"
    Expression ="BRS_FiscalMonth.comm_status_cd"
End
Begin Joins
    LeftTable ="BRS_Config"
    RightTable ="BRS_FiscalMonth"
    Expression ="BRS_Config.PriorFiscalMonth = BRS_FiscalMonth.FiscalMonth"
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
        dbText "Name" ="BRS_FiscalMonth.comm_status_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1965"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="BRS_FiscalMonth.me_status_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1695"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="BRS_Config.PriorFiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Config.id"
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
    Bottom =525
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =545
        Top =45
        Right =797
        Bottom =271
        Top =0
        Name ="BRS_FiscalMonth"
        Name =""
    End
    Begin
        Left =113
        Top =359
        Right =257
        Bottom =503
        Top =0
        Name ="BRS_Config"
        Name =""
    End
End
