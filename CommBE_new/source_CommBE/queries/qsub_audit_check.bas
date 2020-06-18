Operation =1
Option =0
Begin InputTables
    Name ="Integration_F555115_commission_sales_extract_Staging"
End
Begin OutputColumns
    Expression ="Integration_F555115_commission_sales_extract_Staging.WSAC10_division_code"
    Alias ="stage_sales_amt"
    Expression ="Sum(Integration_F555115_commission_sales_extract_Staging.WSAEXP_extended_price)"
    Alias ="CountOfID"
    Expression ="Count(Integration_F555115_commission_sales_extract_Staging.ID)"
    Alias ="MaxOfWSDGL__gl_date"
    Expression ="Max(Integration_F555115_commission_sales_extract_Staging.WSDGL__gl_date)"
End
Begin OrderBy
    Expression ="Integration_F555115_commission_sales_extract_Staging.WSAC10_division_code"
    Flag =0
End
Begin Groups
    Expression ="Integration_F555115_commission_sales_extract_Staging.WSAC10_division_code"
    GroupLevel =0
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
        dbText "Name" ="Integration_F555115_commission_sales_extract_Staging.WSAC10_division_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="CountOfID"
        dbText "Format" ="General Number"
        dbByte "DecimalPlaces" ="255"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="stage_sales_amt"
        dbInteger "ColumnWidth" ="3120"
        dbBoolean "ColumnHidden" ="0"
        dbText "Format" ="$#,##0.00;($#,##0.00)"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_SalesDay.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="MaxOfWSDGL__gl_date"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F555115_commission_sales_extract_Staging.WSDGL__gl_date"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1412
    Bottom =817
    Left =-1
    Top =-1
    Right =1388
    Bottom =276
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =276
        Top =21
        Right =688
        Bottom =311
        Top =0
        Name ="Integration_F555115_commission_sales_extract_Staging"
        Name =""
    End
End
