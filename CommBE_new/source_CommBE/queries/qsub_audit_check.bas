Operation =1
Option =0
Where ="(((CDate([WSDGL__gl_date]))=[BRS_SalesDay]![SalesDate]))"
Begin InputTables
    Name ="Integration_F555115_commission_sales_extract_Staging"
    Name ="BRS_SalesDay"
End
Begin OutputColumns
    Expression ="BRS_SalesDay.FiscalMonth"
    Expression ="Integration_F555115_commission_sales_extract_Staging.WSAC10_division_code"
    Alias ="stage_sales_amt"
    Expression ="Sum([WSAEXP_extended_price]-[WS$ODS_order_discount_amount])"
End
Begin Groups
    Expression ="BRS_SalesDay.FiscalMonth"
    GroupLevel =0
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
        dbText "Name" ="stage_sales_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F555115_commission_sales_extract_Staging.WSAC10_division_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_SalesDay.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1121
    Bottom =547
    Left =-1
    Top =-1
    Right =1097
    Bottom =215
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =68
        Top =-10
        Right =400
        Bottom =233
        Top =0
        Name ="Integration_F555115_commission_sales_extract_Staging"
        Name =""
    End
    Begin
        Left =485
        Top =35
        Right =629
        Bottom =179
        Top =0
        Name ="BRS_SalesDay"
        Name =""
    End
End
