Operation =1
Option =0
Where ="(((fg_transaction_F5554240.CalMonthRedeem)>=202201) AND ((fg_transaction_F555424"
    "0.[WK$SPC_supplier_code])=\"SOUDEN\") AND ((fg_transaction_F5554240.WKLITM_item_"
    "number)=\"9396715\"))"
Begin InputTables
    Name ="fg_transaction_F5554240"
    Name ="BRS_Customer"
    Name ="BRS_FSC_Rollup"
End
Begin OutputColumns
    Expression ="BRS_FSC_Rollup.FSCName"
    Alias ="FirstOfWKCRCD_currency_code"
    Expression ="First(fg_transaction_F5554240.WKCRCD_currency_code)"
    Alias ="SumOfWKECST_extended_cost"
    Expression ="Sum(fg_transaction_F5554240.WKECST_extended_cost)"
End
Begin Joins
    LeftTable ="fg_transaction_F5554240"
    RightTable ="BRS_Customer"
    Expression ="fg_transaction_F5554240.WKSHAN_shipto = BRS_Customer.ShipTo"
    Flag =1
    LeftTable ="BRS_Customer"
    RightTable ="BRS_FSC_Rollup"
    Expression ="BRS_Customer.TerritoryCd = BRS_FSC_Rollup.TerritoryCd"
    Flag =1
End
Begin Groups
    Expression ="BRS_FSC_Rollup.FSCName"
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
        dbText "Name" ="fg_transaction_F5554240.CalMonthRedeem"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKLITM_item_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.[WK$SPC_supplier_code]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.fg_exempt_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKECST_extended_cost"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.FSCName"
        dbInteger "ColumnWidth" ="3045"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKCRCD_currency_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOfWKECST_extended_cost"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfWKCRCD_currency_code"
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
    Bottom =673
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =60
        Top =63
        Right =812
        Bottom =577
        Top =0
        Name ="fg_transaction_F5554240"
        Name =""
    End
    Begin
        Left =800
        Top =61
        Right =1177
        Bottom =432
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
    Begin
        Left =1140
        Top =66
        Right =1284
        Bottom =210
        Top =0
        Name ="BRS_FSC_Rollup"
        Name =""
    End
End
