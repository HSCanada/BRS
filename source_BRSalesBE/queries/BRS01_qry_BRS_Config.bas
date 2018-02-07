Operation =1
Option =0
Begin InputTables
    Name ="BRS_DS_Config"
    Name ="BRS_Status"
    Name ="BRS_FiscalMonth"
End
Begin OutputColumns
    Expression ="BRS_DS_Config.SalesDate"
    Expression ="BRS_DS_Config.FiscalMonth"
    Expression ="BRS_DS_Config.PriorFiscalMonth"
    Alias ="PM_StatusCd"
    Expression ="BRS_FiscalMonth.StatusCd"
    Expression ="BRS_DS_Config.ExceptionCd"
    Expression ="BRS_DS_Config.ExceptionNote"
    Expression ="BRS_DS_Config.DayType"
    Expression ="BRS_DS_Config.DayNumber"
    Expression ="BRS_DS_Config.DayComment"
    Expression ="BRS_Status.StatusDescr"
    Expression ="BRS_DS_Config.DayStatusCd"
    Expression ="BRS_DS_Config.OffsetDaySeq_Yoy_Fiscal_SameDay"
End
Begin Joins
    LeftTable ="BRS_DS_Config"
    RightTable ="BRS_Status"
    Expression ="BRS_DS_Config.DayStatusCd = BRS_Status.StatusCd"
    Flag =1
    LeftTable ="BRS_DS_Config"
    RightTable ="BRS_FiscalMonth"
    Expression ="BRS_DS_Config.PriorFiscalMonth = BRS_FiscalMonth.FiscalMonth"
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
        dbText "Name" ="BRS_DS_Config.SalesDate"
        dbInteger "ColumnWidth" ="1275"
        dbBoolean "ColumnHidden" ="0"
        dbText "Format" ="Medium Date"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_DS_Config.FiscalMonth"
        dbInteger "ColumnWidth" ="1545"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_DS_Config.ExceptionCd"
        dbInteger "ColumnWidth" ="900"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_DS_Config.ExceptionNote"
        dbInteger "ColumnWidth" ="1380"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_DS_Config.DayType"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1125"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="BRS_DS_Config.DayNumber"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1455"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="BRS_DS_Config.DayStatusCd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1695"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="BRS_DS_Config.PriorFiscalMonth"
        dbInteger "ColumnWidth" ="1440"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_DS_Config.DayComment"
        dbInteger "ColumnWidth" ="1215"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Status.StatusDescr"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1770"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="PM_StatusCd"
        dbInteger "ColumnWidth" ="855"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_DS_Config.OffsetDaySeq_Yoy_Fiscal_SameDay"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1290"
        dbBoolean "ColumnHidden" ="0"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1170
    Bottom =730
    Left =-1
    Top =-1
    Right =1138
    Bottom =253
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =137
        Top =14
        Right =429
        Bottom =363
        Top =0
        Name ="BRS_DS_Config"
        Name =""
    End
    Begin
        Left =572
        Top =154
        Right =716
        Bottom =298
        Top =0
        Name ="BRS_Status"
        Name =""
    End
    Begin
        Left =515
        Top =10
        Right =800
        Bottom =164
        Top =0
        Name ="BRS_FiscalMonth"
        Name =""
    End
End
