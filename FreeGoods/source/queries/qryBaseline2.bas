Operation =1
Option =0
Where ="(((fg_transaction_F5554240.CalMonthRedeem) Between 201901 And 202202) AND ((BRS_"
    "CurrencyHistory_1.Currency)=\"CAD\"))"
Begin InputTables
    Name ="fg_transaction_F5554240"
    Name ="BRS_FiscalMonth"
    Name ="BRS_CurrencyHistory"
    Name ="BRS_CurrencyHistory"
    Alias ="BRS_CurrencyHistory_1"
    Name ="fg_exempt_code"
End
Begin OutputColumns
    Expression ="BRS_FiscalMonth.YearNum"
    Expression ="BRS_FiscalMonth.QuarterNum"
    Expression ="fg_transaction_F5554240.fg_exempt_cd"
    Alias ="FirstOffg_exempt_desc"
    Expression ="First(fg_exempt_code.fg_exempt_desc)"
    Expression ="fg_transaction_F5554240.CalMonthRedeem"
    Expression ="fg_transaction_F5554240.WKCRCD_currency_code"
    Expression ="fg_transaction_F5554240.Label"
    Expression ="fg_transaction_F5554240.WKDCTO_order_type"
    Expression ="fg_transaction_F5554240.[WK$SPC_supplier_code]"
    Alias ="FirstOfFX_per_USD_pnl_rt"
    Expression ="First(BRS_CurrencyHistory.FX_per_USD_pnl_rt)"
    Alias ="CAD_fx"
    Expression ="First([BRS_CurrencyHistory_1]![FX_per_USD_pnl_rt])"
    Alias ="SumOfWKECST_extended_cost"
    Expression ="Sum(fg_transaction_F5554240.WKECST_extended_cost)"
    Alias ="lines"
    Expression ="Count(fg_transaction_F5554240.ID)"
End
Begin Joins
    LeftTable ="fg_transaction_F5554240"
    RightTable ="BRS_FiscalMonth"
    Expression ="fg_transaction_F5554240.CalMonthRedeem = BRS_FiscalMonth.FiscalMonth"
    Flag =1
    LeftTable ="fg_transaction_F5554240"
    RightTable ="BRS_CurrencyHistory"
    Expression ="fg_transaction_F5554240.CalMonthRedeem = BRS_CurrencyHistory.FiscalMonth"
    Flag =1
    LeftTable ="fg_transaction_F5554240"
    RightTable ="BRS_CurrencyHistory"
    Expression ="fg_transaction_F5554240.WKCRCD_currency_code = BRS_CurrencyHistory.Currency"
    Flag =1
    LeftTable ="BRS_CurrencyHistory_1"
    RightTable ="fg_transaction_F5554240"
    Expression ="BRS_CurrencyHistory_1.FiscalMonth = fg_transaction_F5554240.CalMonthRedeem"
    Flag =1
    LeftTable ="fg_transaction_F5554240"
    RightTable ="fg_exempt_code"
    Expression ="fg_transaction_F5554240.fg_exempt_cd = fg_exempt_code.fg_exempt_cd"
    Flag =1
End
Begin Groups
    Expression ="BRS_FiscalMonth.YearNum"
    GroupLevel =0
    Expression ="BRS_FiscalMonth.QuarterNum"
    GroupLevel =0
    Expression ="fg_transaction_F5554240.fg_exempt_cd"
    GroupLevel =0
    Expression ="fg_transaction_F5554240.CalMonthRedeem"
    GroupLevel =0
    Expression ="fg_transaction_F5554240.WKCRCD_currency_code"
    GroupLevel =0
    Expression ="fg_transaction_F5554240.Label"
    GroupLevel =0
    Expression ="fg_transaction_F5554240.WKDCTO_order_type"
    GroupLevel =0
    Expression ="fg_transaction_F5554240.[WK$SPC_supplier_code]"
    GroupLevel =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="2"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="fg_transaction_F5554240.CalMonthRedeem"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOfWKECST_extended_cost"
        dbInteger "ColumnWidth" ="3285"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.fg_exempt_cd"
        dbInteger "ColumnWidth" ="1740"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FiscalMonth.QuarterNum"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FiscalMonth.YearNum"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKCRCD_currency_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfFX_per_USD_pnl_rt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="CAD_fx"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.Label"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKDCTO_order_type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.[WK$SPC_supplier_code]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOffg_exempt_desc"
        dbInteger "ColumnWidth" ="2805"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lines"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1363
    Bottom =918
    Left =-1
    Top =-1
    Right =1347
    Bottom =557
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =117
        Top =64
        Right =560
        Bottom =431
        Top =0
        Name ="fg_transaction_F5554240"
        Name =""
    End
    Begin
        Left =815
        Top =174
        Right =1093
        Bottom =510
        Top =0
        Name ="BRS_FiscalMonth"
        Name =""
    End
    Begin
        Left =654
        Top =-7
        Right =798
        Bottom =199
        Top =0
        Name ="BRS_CurrencyHistory"
        Name =""
    End
    Begin
        Left =904
        Top =46
        Right =1048
        Bottom =190
        Top =0
        Name ="BRS_CurrencyHistory_1"
        Name =""
    End
    Begin
        Left =650
        Top =245
        Right =794
        Bottom =389
        Top =0
        Name ="fg_exempt_code"
        Name =""
    End
End
