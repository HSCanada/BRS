Operation =1
Option =0
Where ="(((Integration_F555115_commission_sales_extract_Staging.WSAC10_division_code)<>\""
    "AZA\"))"
Having ="(((Integration_F555115_commission_sales_extract_Staging.[WS$OSC_order_source_cod"
    "e]) In (\"A\",\"L\")))"
Begin InputTables
    Name ="Integration_F555115_commission_sales_extract_Staging"
End
Begin OutputColumns
    Expression ="Integration_F555115_commission_sales_extract_Staging.[WS$OSC_order_source_code]"
    Alias ="SumOfWSAEXP_extended_price"
    Expression ="Sum(Integration_F555115_commission_sales_extract_Staging.WSAEXP_extended_price)"
    Alias ="CountOfID"
    Expression ="Count(Integration_F555115_commission_sales_extract_Staging.ID)"
End
Begin Groups
    Expression ="Integration_F555115_commission_sales_extract_Staging.[WS$OSC_order_source_code]"
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
        dbText "Name" ="SumOfWSAEXP_extended_price"
        dbText "Format" ="$#,##0.00;($#,##0.00)"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3120"
        dbBoolean "ColumnHidden" ="0"
    End
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
        dbText "Name" ="Integration_F555115_commission_sales_extract_Staging.[WS$OSC_order_source_code]"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1191
    Bottom =817
    Left =-1
    Top =-1
    Right =1167
    Bottom =264
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =182
        Top =20
        Right =594
        Bottom =310
        Top =0
        Name ="Integration_F555115_commission_sales_extract_Staging"
        Name =""
    End
End
