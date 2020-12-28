dbMemo "SQL" ="SELECT\015\012\011d.FiscalMonth\015\012\011, s.WSAC10_division_code SalesDivisio"
    "n\015\012\011, FORMAT(SUM(s.WSAEXP_extended_price - s.WS$ODS_order_discount_amou"
    "nt), 'C', 'en-us') AS stage_sales_amt\015\012FROM\015\012\011Integration.F555115"
    "_commission_sales_extract_Staging AS s \015\012\015\012\011INNER JOIN BRS_SalesD"
    "ay AS d \015\012\011ON s.WSDGL__gl_date = d.SalesDate\015\012WHERE\015\012\011d."
    "FiscalMonth = (Select [PriorFiscalMonth] from [comm].[config])\015\012\015\012GR"
    "OUP BY\015\012\011d.FiscalMonth, \015\012\011s.WSAC10_division_code"
dbMemo "Connect" ="ODBC;DSN=DEV_BRSales;Description=cahsionnlsql1;UID=TCrowley;Trusted_Connection=Y"
    "es;DATABASE=DEV_BRSales;Network=DBMSSOCN"
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbBoolean "LogMessages" ="0"
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
    Begin
        dbText "Name" ="1.SalesDivision"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="1.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="1.stage_sales_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsub_audit_check.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsub_audit_check.SalesDivision"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsub_audit_check.stage_sales_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SalesDivision"
        dbLong "AggregateType" ="-1"
    End
End
