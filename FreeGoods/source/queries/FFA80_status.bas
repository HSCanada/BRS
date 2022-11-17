Operation =1
Option =0
Where ="(((BRS_FiscalMonth.FiscalMonth)=(SELECT PriorFiscalMonth FROM BRS_Config)))"
Begin InputTables
    Name ="BRS_FiscalMonth"
End
Begin OutputColumns
    Expression ="BRS_FiscalMonth.FiscalMonth"
    Expression ="BRS_FiscalMonth.me_status_cd"
    Expression ="BRS_FiscalMonth.fg_status_cd"
    Expression ="BRS_FiscalMonth.fg_cost_date"
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
        dbText "Name" ="BRS_FiscalMonth.fg_status_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1845"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="BRS_FiscalMonth.me_status_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FiscalMonth.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FiscalMonth.fg_cost_date"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1605"
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
    Bottom =421
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =70
        Top =63
        Right =395
        Bottom =357
        Top =0
        Name ="BRS_FiscalMonth"
        Name =""
    End
End
